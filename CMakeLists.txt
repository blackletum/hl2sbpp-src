cmake_minimum_required(VERSION 3.16)
project(hl2sbpp LANGUAGES C CXX ASM_MASM)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)

set(ROOT_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(SRC_DIR ${ROOT_DIR})

set(GLOBAL_INC_DIR 
	${SRC_DIR}/common
	${SRC_DIR}/public
)
set(GLOBAL_LIB_DIR ${SRC_DIR}/lib)
set(THIRDPARTY_DIR ${SRC_DIR}/thirdparty)

list(APPEND CMAKE_MODULE_PATH "${SRC_DIR}/cmake")

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_INSTALL_PREFIX "${ROOT_DIR}/../game")

if(NOT CMAKE_CONFIGURATION_TYPES AND NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Release CACHE STRING "Build type" FORCE)

	set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
		Debug
		Release
		RelWithDebInfo
		MinSizeRel
	)
endif()

if(MSVC)
	add_compile_options(
		$<$<COMPILE_LANGUAGE:C,CXX>:/W4>
	)
	
	# https://github.com/ValveSoftware/source-sdk-2013/blob/c98767b329f07c086281d787cc0e1c4d9a6b1410/src/vpc_scripts/source_win32_base.vpc#L52-L64
	add_compile_options(
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd4316>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd5033>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd5054>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd5055>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd4577>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd4091>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd4355>
		$<$<COMPILE_LANGUAGE:C,CXX>:/wd4101>
	)
	
	# https://github.com/ValveSoftware/source-sdk-2013/blob/c98767b329f07c086281d787cc0e1c4d9a6b1410/src/vpc_scripts/source_win32_base.vpc#L81-L93
	add_compile_options(
		$<$<COMPILE_LANGUAGE:C,CXX>:/Gw>
		$<$<COMPILE_LANGUAGE:C,CXX>:/Zc:inline>
		$<$<COMPILE_LANGUAGE:C,CXX>:/Zc:threadSafeInit->
		$<$<COMPILE_LANGUAGE:C,CXX>:/Wv:18>
	)
	
	add_compile_definitions(
		$<$<COMPILE_LANGUAGE:C,CXX>:COMPILER_MSVC=1>
		$<$<COMPILE_LANGUAGE:C,CXX>:MSVC=1>
	)

	if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
		add_compile_options(/clang:-Wno-character-conversion /clang:-Wno-error=character-conversion)
	else()
	endif()
else()
	set(CMAKE_THREAD_LIBS_INIT "-lpthread")
	set(CMAKE_HAVE_THREADS_LIBRARY 1)
	set(CMAKE_USE_WIN32_THREADS_INIT 0)
	set(CMAKE_USE_PTHREADS_INIT 1)
	set(THREADS_PREFER_PTHREAD_FLAG ON)
	add_compile_options(-Wall -Wextra -Wpedantic)
	if (WIN32)
		add_compile_options(-Wno-character-conversion -Wno-error=character-conversion)
	else()
		add_compile_options(-Wno-narrowing)
	endif()
endif()

if(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
	add_compile_definitions(COMPILER_GCC=1)
	add_compile_definitions(GNUC=1)
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
	add_compile_definitions(COMPILER_CLANG=1)
	add_compile_definitions(CLANG=1)
endif()

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	add_compile_definitions(__x86_64__=1)
	add_compile_definitions(PLATFORM_64BITS=1)
	set(PLATFORM_64BITS 1)

	if (WIN32)
		add_compile_definitions(WIN64=1)
		add_compile_definitions(_WIN64=1)
		
		if (MSVC)
			add_compile_definitions($<$<COMPILE_LANGUAGE:C,CXX>:COMPILER_MSVC64=1>)
			
			# C4267: 'var' : conversion from 'size_t' to 'type', possible loss of data
			add_compile_options($<$<COMPILE_LANGUAGE:C,CXX>:/wd4267>)
		endif()
	endif()
else()
	if (WIN32 and MSVC)
		add_compile_definitions(COMPILER_MSVC32=1)
	endif()
endif()

set(GAMES)

# global options start here

if(WIN32)
    set(USE_SDL2_DEFAULT ON)
elseif(APPLE)
    set(USE_SDL2_DEFAULT OFF)
elseif(UNIX)
    set(USE_SDL2_DEFAULT ON)
else()
    set(USE_SDL2_DEFAULT OFF)
endif()

option(HL2SBPP "Enables HL2:SB++-related projects" ON)
option(USE_SDL2 "Makes use of SDL2 for the windowing and audio interface." ${USE_SDL2_DEFAULT})
option(ENABLE_REPLAY "Enables Source Replay" OFF)

# end global options

if (HL2SBPP)
list(APPEND GAMES "hl2sbpp")
endif()

if (USE_SDL2)
add_compile_definitions(USE_SDL=1)
endif(USE_SDL2)

set(BUILD_REPLAY 0)
if (ENABLE_REPLAY)
	set(BUILD_REPLAY 1)
endif(ENABLE_REPLAY)

set(IS_WINDOWS 0)
set(IS_UNIX 0)
set(IS_POSIX 0)
set(IS_MACOS 0)
set(IS_LINUX 0)
set(IS_ANDROID 0)
set(IS_X360 0)

if(WIN32)
	set(IS_WINDOWS 1)
    message(STATUS "Building for Windows")

	if (BUILD_X360)
		set(IS_X360 1)
		add_compile_definitions(_X360=1)
	else()
		set(IS_X360 0)
		add_compile_definitions(NO_X360_XDK=1)
	endif()
elseif(UNIX)
	set(IS_UNIX 1)
	set(IS_POSIX 1)

	if (APPLE)
		set(IS_MACOS 1)
    	message(STATUS "Building for macOS")
	elseif(LINUX)
		set(IS_LINUX 1)

		if (ANDROID)
			set(IS_ANDROID 1)
    		message(STATUS "Building for Linux (Android)")
		else()
    		message(STATUS "Building for Linux")
		endif()
	endif()
endif()

include_directories(
    ${GLOBAL_INC_DIR}
)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)
find_package(Doxygen OPTIONAL_COMPONENTS dot)

if(DOXYGEN_FOUND)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${ROOT_DIR}/README.md")

    doxygen_add_docs(doc ${SRC_DIR})
endif()   

add_compile_definitions(
	MOON=1
	CURL_STATICLIB=1
)

set(HTTPLIB_SHARED 1)

include(Common)

# end global configuration here

# STL projects always goes first!
#add_subdirectory(${SRC_DIR}/raytrace)
add_subdirectory(${SRC_DIR}/mathlib)
add_subdirectory(${SRC_DIR}/tier0)
add_subdirectory(${SRC_DIR}/tier1)
add_subdirectory(${SRC_DIR}/tier2)
add_subdirectory(${SRC_DIR}/tier3)
add_subdirectory(${SRC_DIR}/vstdlib)

# third-party projects
add_subdirectory(${SRC_DIR}/thirdparty/cpp-httplib)
add_subdirectory(${SRC_DIR}/thirdparty/SDL)

add_subdirectory(${SRC_DIR}/appframework)
add_subdirectory(${SRC_DIR}/bitmap)
add_subdirectory(${SRC_DIR}/choreoobjects)
add_subdirectory(${SRC_DIR}/dmxloader)
add_subdirectory(${SRC_DIR}/lua)
add_subdirectory(${SRC_DIR}/particles)
add_subdirectory(${SRC_DIR}/stub_steam)
add_subdirectory(${SRC_DIR}/vgui2)
add_subdirectory(${SRC_DIR}/vpklib)
add_subdirectory(${SRC_DIR}/vtf)

add_subdirectory(${SRC_DIR}/launcher)
add_subdirectory(${SRC_DIR}/launcher_main)

add_subdirectory(${SRC_DIR}/game)

message("Install Prefix is set to ${CMAKE_INSTALL_PREFIX}.")
