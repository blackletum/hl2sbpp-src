cmake_minimum_required(VERSION 3.16)
project(hl2sbpp)

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
	add_compile_options(/W4)
	add_compile_definitions(COMPILER_MSVC=1)
	add_compile_definitions(MSVC=1)

	if (CMAKE_CXX_COMPILER_ID STREQUAL "Clang")
		add_compile_definitions(COMPILER_CLANG=1)
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

# global options start here

# end global options

if(WIN32)
    	message(STATUS "Building for Windows")
elseif(APPLE)
    	message(STATUS "Building for macOS")
elseif(UNIX)
    	message(STATUS "Building for Linux")
endif()

include_directories(
    ${GLOBAL_INC_DIR}
)

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

if(CMAKE_SIZEOF_VOID_P EQUAL 8)
	add_compile_definitions(__x86_64__=1)
	set(PLATFORM_64BITS true)

	if (WIN32)
		add_compile_definitions(WIN64=1)
		add_compile_definitions(_WIN64=1)
		add_compile_definitions(COMPILER_MSVC64=1)
	endif()
else()
	if (WIN32)
		add_compile_definitions(COMPILER_MSVC32=1)
	endif()
endif()

find_package(Doxygen OPTIONAL_COMPONENTS dot)

if(DOXYGEN_FOUND)
    set(DOXYGEN_USE_MDFILE_AS_MAINPAGE "${ROOT_DIR}/README.md")

    doxygen_add_docs(doc ${SRC_DIR})
endif()   

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

add_subdirectory(${SRC_DIR}/appframework)

message("Install Prefix is set to ${CMAKE_INSTALL_PREFIX}.")