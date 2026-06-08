//========== Copyright (C) 2026, The Aridity Team, All rights reserved. ===========//
//
// Purpose:
//
//===========================================================================//

#ifndef WEBMANAGER_H
#define WEBMANAGER_H
#ifdef _WIN32
#pragma once
#endif // _WIN32

#include <httplib.h>
#include <functional>
#include <memory>

typedef enum WebError_e
{
	WEB_OK = 0,
	WEB_ERR_INIT_FAILED,
	WEB_ERR_CURL_FAILED,
	WEB_ERR_HTTPLIB_FAILED = WEB_ERR_CURL_FAILED,
	WEB_ERR_HTTP_STATUS,
	WEB_ERR_FILE_OPEN_FAILED,
	WEB_ERR_INVALID_URL,
} WebError_t;

typedef struct WebResult_s
{
	bool		success;
	WebError_t	error;
	long		httpCode;
	const char *errorMessage;
	const char *body;
} WebResult_t;

typedef struct ParsedUrl_s
{
	const char *scheme;
	const char *host;
	int			port = 0;
	const char *path;
} ParsedUrl_t;

typedef std::function< void( const WebResult_t & ) > RequestCallback;
typedef std::function< void( bool success, const char *localPath ) > WebDownloadCallback;

class CWebManager
{
public:
	CWebManager();
	~CWebManager();

	bool Init();
	void Shutdown();

	bool Get( const char *url, RequestCallback callback );
	bool Post( const char *url, const char *jsonBody, RequestCallback callback );
	bool DownloadToFile( const char *url, const char *filePath );

	bool DownloadToFileAsync( const char *url, const char *localPath, WebDownloadCallback cb );

	static std::unique_ptr< httplib::Client > CreateClient( const char *url );

private:
	static WebResult_t BuildResult( const httplib::Result &res );

	bool		LoadCACertBlob( httplib::Client *client );
};

#endif // WEBMANAGER_H