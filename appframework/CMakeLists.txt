project(appframework)

set(SOURCES
	"AppSystemGroup.cpp"
	"${SRC_DIR}/public/filesystem_init.cpp"
)

set(HEADERS
	"${SRC_DIR}/public/appframework/AppFramework.h"
	"${SRC_DIR}/public/appframework/IAppSystem.h"
	"${SRC_DIR}/public/appframework/IAppSystemGroup.h"
	"${SRC_DIR}/public/appframework/ilaunchermgr.h"
	"${SRC_DIR}/public/appframework/tier2app.h"
	"${SRC_DIR}/public/appframework/tier3app.h"
)

if(WIN32)
	list(APPEND SOURCES "VguiMatSysApp.cpp")
	list(APPEND SOURCES "WinApp.cpp")
	list(APPEND HEADERS "${SRC_DIR}/public/appframework/VguiMatSysApp.h")
endif(WIN32)

if(LINUX)
	list(APPEND SOURCES "linuxapp.cpp")
endif()

if (SDL2_ENABLED)
	list(APPEND SOURCES "sdlmgr.cpp")
endif()

source_group("Source Files" FILES ${SOURCES})
source_group("Header Files" FILES ${HEADERS})

add_public_library(appframework ${SOURCES} ${HEADERS})

target_include_directories(appframework PRIVATE
	"${SRC_DIR}/public/appframework"
	"${SRC_DIR}/public/tier0"
	"${SRC_DIR}/public/tier1"
	"${SRC_DIR}/public/tier2"
	"${SRC_DIR}/public/tier3"
)

target_link_libraries(appframework PRIVATE
	tier0
	tier1
	tier2
	tier3
	vstdlib
)