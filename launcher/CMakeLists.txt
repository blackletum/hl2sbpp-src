project(launcher)

set(LAUNCHER_SOURCES
	${SRC_DIR}/public/filesystem_init.cpp
	launcher.cpp
	reslistgenerator.cpp
	#${SRC_DIR}/public/tier0/memoverride.cpp
)

set(LAUNCHER_HEADERS
	${SRC_DIR}/public/tier0/basetypes.h
	${SRC_DIR}/public/tier0/commonmacros.h
	${SRC_DIR}/public/tier0/dbg.h
	${SRC_DIR}/common/engine_launcher_api.h
	${SRC_DIR}/public/tier0/fasttimer.h
	${SRC_DIR}/public/appframework/IAppSystem.h
	${SRC_DIR}/public/tier0/icommandline.h
	ifilesystem.h
	${SRC_DIR}/public/vgui/IHTML.h
	${SRC_DIR}/public/vgui/IImage.h
	${SRC_DIR}/public/tier1/interface.h
	${SRC_DIR}/public/vgui/ISurface.h
	${SRC_DIR}/public/vgui/KeyCode.h
	${SRC_DIR}/public/tier0/mem.h
	${SRC_DIR}/public/tier0/memalloc.h
	${SRC_DIR}/public/vgui/MouseCode.h
	${SRC_DIR}/public/tier0/platform.h
	${SRC_DIR}/public/tier0/protected_things.h
	reslistgenerator.h
	${SRC_DIR}/public/string_t.h
	${SRC_DIR}/public/tier1/strtools.h
	${SRC_DIR}/public/tier0/vcr_shared.h
	${SRC_DIR}/public/tier0/vcrmode.h
	${SRC_DIR}/public/mathlib/vector2d.h
	${SRC_DIR}/public/vgui/VGUI.h
	${SRC_DIR}/public/vstdlib/vstdlib.h
)

if (ANDROID)
	list(APPEND LAUNCHER_SOURCES
		android/main.cpp
		android/crashhandler.cpp
	)
endif()

source_group("Source Files" FILES ${LAUNCHER_SOURCES})
source_group("Header Files" FILES ${LAUNCHER_HEADERS})

add_engine_shared_library(launcher ${LAUNCHER_SOURCES} ${LAUNCHER_HEADERS})

target_compile_definitions(launcher PRIVATE
	LAUNCHERONLY=1
	CFLAGS=${CMAKE_CXX_FLAGS}
	LDFLAGS=${CMAKE_SHARED_LINKER_FLAGS}
)

target_include_directories(launcher PRIVATE
	${SRC_DIR}/launcher/android/libunwind
	${SRC_DIR}/public
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
	${SRC_DIR}/common
)

target_link_libraries(launcher PRIVATE
	tier0
	tier1
	tier2
	tier3
	vstdlib
	steam_api
	appframework
)

if (USE_SDL2)
	target_include_directories(launcher PRIVATE
		"${SRC_DIR}/thirdparty/SDL/include"
	)

	target_link_libraries(launcher PRIVATE
		SDL2
	)
endif()

if (WIN32)
	target_link_libraries(launcher PRIVATE
		shlwapi
		winmm
		user32
		ole32
		shell32
		wsock32
		odbc32
		odbccp32
	)

	if (PLATFORM_64BITS)
		target_link_libraries(launcher PRIVATE
			${SRC_DIR}/dx9sdk/lib/amd64/dinput8.lib
			#${SRC_DIR}/dx9sdk/lib/amd64/ddraw.lib
		)
	else()
		target_link_libraries(launcher PRIVATE
			${SRC_DIR}/dx9sdk/lib/x86/dinput8.lib
			${SRC_DIR}/dx9sdk/lib/x86/ddraw.lib
		)
	endif()
endif()
