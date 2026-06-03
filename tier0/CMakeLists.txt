project(tier0)

set(TIER0_SOURCES
	assert_dialog.cpp
	commandline.cpp
	cpu.cpp
	cpu_usage.cpp
	dbg.cpp
	dynfunction.cpp
	fasttimer.cpp
	mem.cpp
	mem_helpers.cpp
	memdbg.cpp
	memstd.cpp
	#${SRC_DIR}/public/tier0/memoverride.cpp
	memvalidate.cpp
	minidump.cpp
	pch_tier0.cpp
	platform.cpp
	PMELib.cpp
	progressbar.cpp
	security.cpp
	systeminformation.cpp
	stacktools.cpp
	thread.cpp
	threadtools.cpp
	tier0_strtools.cpp
	tslist.cpp
	vprof.cpp
)

set(TIER0_HEADERS
	${SRC_DIR}/public/tier0/basetypes.h
	${SRC_DIR}/public/tier0/commonmacros.h
	${SRC_DIR}/public/tier0/cpumonitoring.h
	${SRC_DIR}/public/tier0/dbg.h
	${SRC_DIR}/public/tier0/dbgflag.h
	${SRC_DIR}/public/tier0/EventMasks.h
	${SRC_DIR}/public/tier0/EventModes.h
	${SRC_DIR}/public/tier0/fasttimer.h
	${SRC_DIR}/public/tier0/ia32detect.h
	${SRC_DIR}/public/tier0/icommandline.h
	${SRC_DIR}/public/tier0/IOCTLCodes.h
	${SRC_DIR}/public/tier0/K8PerformanceCounters.h
	${SRC_DIR}/public/tier0/l2cache.h
	${SRC_DIR}/public/tier0/mem.h
	${SRC_DIR}/public/tier0/memalloc.h
	${SRC_DIR}/public/tier0/memdbgoff.h
	${SRC_DIR}/public/tier0/memdbgon.h
	${SRC_DIR}/public/tier0/minidump.h
	${SRC_DIR}/public/tier0/P4PerformanceCounters.h
	${SRC_DIR}/public/tier0/P5P6PerformanceCounters.h
	pch_tier0.h
	${SRC_DIR}/public/tier0/platform.h
	${SRC_DIR}/public/tier0/PMELib.h
	${SRC_DIR}/public/tier0/progressbar.h
	${SRC_DIR}/public/tier0/protected_things.h
	resource.h
	${SRC_DIR}/public/tier0/systeminformation.h
	${SRC_DIR}/public/tier0/stacktools.h
	${SRC_DIR}/public/tier0/threadtools.h
	tier0_strtools.h
	${SRC_DIR}/public/tier0/tslist.h
	${SRC_DIR}/public/tier0/validator.h
	${SRC_DIR}/public/tier0/valobject.h
	${SRC_DIR}/public/tier0/valve_off.h
	${SRC_DIR}/public/tier0/valve_on.h
	${SRC_DIR}/public/tier0/vcr_shared.h
	${SRC_DIR}/public/tier0/vcrmode.h
	${SRC_DIR}/public/tier0/vprof.h
	${SRC_DIR}/public/tier0/wchartypes.h
	${SRC_DIR}/public/tier0/xbox_codeline_defines.h
	mem_helpers.h
)

if(WIN32)
	list(APPEND TIER0_SOURCES
		assert_dialog.rc
		pme.cpp
		platform.cpp
		vcrmode.cpp
		win32consoleio.cpp
	)

	if (PLATFORM_64BITS)
		list(APPEND TIER0_SOURCES
			InterlockedCompareExchange128.masm
		)
	endif()
elseif(UNIX AND NOT APPLE)
	list(APPEND TIER0_SOURCES
		cpu_posix.cpp
		platform_posix.cpp
		pme_posix.cpp
		vcrmode_posix.cpp
	)
endif()

add_engine_shared_library(tier0 ${TIER0_SOURCES} ${TIER0_HEADERS})

source_group("Source Files" FILES ${TIER0_SOURCES})
source_group("Header Files" FILES ${TIER0_HEADERS})

target_include_directories(tier0
	PUBLIC
		${SRC_DIR}/public
		${SRC_DIR}/public/tier0
		${SRC_DIR}/tier0
)

target_compile_definitions(tier0
	PRIVATE
		TIER0_DLL_EXPORT
)

target_precompile_headers(tier0
	PRIVATE
		pch_tier0.h
)

set_source_files_properties(
	minidump.cpp
	PROPERTIES
		SKIP_PRECOMPILE_HEADERS ON
)

set_source_files_properties(
	PMELib.cpp
	PROPERTIES
		SKIP_PRECOMPILE_HEADERS ON
)

if(MSVC)
	set_source_files_properties(
		minidump.cpp
		PROPERTIES
			COMPILE_OPTIONS "/EHa"
	)

	set_source_files_properties(
		threadtools.cpp
		PROPERTIES
			COMPILE_OPTIONS "/wd4652"
	)
endif()

if(WIN32)
	target_link_libraries(tier0
		PRIVATE
			advapi32
			ws2_32
	)
elseif(UNIX)
	target_link_libraries(tier0
		PRIVATE
			dl
			m
			log
	)
endif()

if(WIN32)
	enable_language(RC)
endif()