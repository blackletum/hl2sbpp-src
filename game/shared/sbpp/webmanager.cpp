//========== Copyright (C) 2026, The Aridity Team, All rights reserved. ===========//
//
// Purpose:
//
//===========================================================================//

#include "cbase.h"
#include "webmanager.h"
#include "filesystem.h"
#include <thread>

static bool ParseUrl( const std::string &url, ParsedUrl_t &out )
{
	static const std::regex re( R"(^(https?)://([^/:]+)(?::(\d+))?(.*)$)", std::regex::icase );

	std::smatch match;

	if ( !std::regex_match( url, match, re ) )
		return false;

	out.scheme = match[1].str().c_str();
	out.host = match[2].str().c_str();

	if ( match[3].matched )
		out.port = Q_atoi( match[3].str().c_str() );
	else
		out.port = ( !Q_stricmp( out.scheme, "https" ) ) ? 443 : 80;

	out.path = match[4].str().c_str();

	if ( !out.path || out.path[0] == '\0' )
		out.path = "/";

	return true;
}

static const char *GetPathFromUrl( const char *url )
{
	ParsedUrl_t parsed;

	if ( !ParseUrl( url, parsed ) )
		return "/";

	if ( !parsed.path || parsed.path[0] == '\0' )
		return "/";

	return parsed.path;
}

CWebManager::CWebManager()
{
}

CWebManager::~CWebManager()
{
	Shutdown();
}

bool CWebManager::Init()
{
	return true;
}

void CWebManager::Shutdown()
{
}

std::unique_ptr< httplib::Client > CWebManager::CreateClient( const char *url )
{
	ParsedUrl_t parsed;

	if ( !ParseUrl( url, parsed ) )
		return nullptr;

#ifdef CPPHTTPLIB_OPENSSL_SUPPORT

	if ( parsed.scheme == "https" )
	{
		auto client = std::make_unique< httplib::SSLClient >( parsed.host.c_str(), parsed.port );

		client->enable_server_certificate_verification( true );

		client->set_follow_location( true );

		client->set_connection_timeout( 30 );
		client->set_read_timeout( 30 );
		client->set_write_timeout( 30 );

		LoadCACertBlob( client.get() );

		return client;
	}

#endif

	auto client = std::make_unique< httplib::Client >( parsed.host, parsed.port );

	client->set_follow_location( true );

	client->set_connection_timeout( 30 );
	client->set_read_timeout( 30 );
	client->set_write_timeout( 30 );

	client->set_default_headers(
	{
		{ "Accept", "application/json" },
		{ "User-Agent", "HL2SBPP/1.0" },
	} );

	return client;
}

bool CWebManager::DownloadToFileAsync( const char *url, const char *localPath, WebDownloadCallback cb )
{
	if ( !url || !*url || !localPath || !*localPath )
	{
		if ( cb ) cb( false, localPath );
		return false;
	}

	std::thread( [ this, url, localPath, cb ]()
	{
		bool ok = DownloadToFile( url, localPath );
		if ( cb )
			cb( ok, localPath );
	} ).detach();

	return true;
}

bool CWebManager::LoadCACertBlob( httplib::Client *client )
{
	if ( !client )
		return false;

	// TODO -- use CA certificates

	return true;
}

WebResult_t CWebManager::BuildResult( const httplib::Result &res )
{
	WebResult_t result = {};
	result.success = false;
	result.error = WEB_OK;
	result.httpCode = 0;

	if ( !res )
	{
		result.error = WEB_ERR_HTTPLIB_FAILED;
		result.errorMessage = httplib::to_string( res.error() ).c_str();

		Warning( "Request failed: %s\n", result.errorMessage );
		return result;
	}

	result.httpCode = res->status;

	if ( res->status >= 200 && res->status < 300 )
	{
		result.success = true;
	}
	else
	{
		result.error = WEB_ERR_HTTP_STATUS;

		char buf[128];
		V_snprintf( buf, sizeof( buf ), "HTTP status %d", res->status );
		result.errorMessage = buf;

		Warning( "%s\n", buf );
	}

	return result;
}

bool CWebManager::Get( const char *url, RequestCallback callback )
{
	if ( !url || url[0] == '\0' )
	{
		if ( callback )
		{
			WebResult_t r = {};
			r.error = WEB_ERR_INVALID_URL;
			r.errorMessage = "Empty URL";
			callback( r );
		}
		return false;
	}

	auto client = CreateClient( url );
	if ( !client )
	{
		if ( callback )
		{
			WebResult_t r = {};
			r.error = WEB_ERR_INIT_FAILED;
			r.errorMessage = "Failed to create HTTP client";
			callback( r );
		}
		return false;
	}

	client->set_connection_timeout( 30 );
	client->set_read_timeout( 30 );

	auto res = client->Get( GetPathFromUrl( url ) );

	WebResult_t result = BuildResult( res );

	if ( res )
		result.body = res->body.c_str();

	if ( callback )
		callback( result );

	return result.success;
}

bool CWebManager::Post( const char *url, const char *jsonBody, RequestCallback callback )
{
	if ( !url || url[0] == '\0' )
	{
		if ( callback )
		{
			WebResult_t r = {};
			r.error = WEB_ERR_INVALID_URL;
			r.errorMessage = "Empty URL";
			callback( r );
		}
		return false;
	}

	auto client = CreateClient( url );
	if ( !client )
	{
		Warning( "CreateClient failed\n" );
		if ( callback )
		{
			WebResult_t r = {};
			r.error = WEB_ERR_INIT_FAILED;
			r.errorMessage = "CreateClient failed";
			callback( r );
		}
		return false;
	}

	auto res = client->Post( GetPathFromUrl( url ), jsonBody ? jsonBody : "", "application/json" );

	WebResult_t result = BuildResult( res );

	if ( res )
		result.body = res->body.c_str();

	if ( callback )
		callback( result );

	return result.success;
}

bool CWebManager::DownloadToFile( const char *url, const char *filePath )
{
	ParsedUrl_t parsed;

	if ( !ParseUrl( url, parsed ) )
		return false;

	auto client = CreateClient( url );

	if ( !client )
		return false;

	FileHandle_t file = g_pFullFileSystem->Open( filePath, "wb" );

	if ( !file )
		return false;

	auto res = client->Get( parsed.path,
		[&]( const char *data, size_t len )
		{
			int written = g_pFullFileSystem->Write( data, len, file );

			return written == static_cast< int >( len );
		} );

	g_pFullFileSystem->Close( file );

	WebResult_t result = BuildResult( res );

	if ( !result.success )
	{
		g_pFullFileSystem->RemoveFile( filePath );
	}

	return result.success;
}
