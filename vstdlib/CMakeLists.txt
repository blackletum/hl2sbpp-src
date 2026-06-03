project(vstdlib)

set(VSTDLIB_SOURCES
    cvar.cpp
    jobthread.cpp
    KeyValuesSystem.cpp
    random.cpp
    vcover.cpp
    #${SRC_DIR}/public/tier0/memoverride.cpp
)

set(VSTDLIB_HEADERS
    ${SRC_DIR}/public/vstdlib/cvar.h
    ${SRC_DIR}/public/vstdlib/jobthread.h
    ${SRC_DIR}/public/vstdlib/IKeyValuesSystem.h
    ${SRC_DIR}/public/vstdlib/iprocessutils.h
    ${SRC_DIR}/public/vstdlib/random.h
    ${SRC_DIR}/public/vstdlib/vcover.h
    ${SRC_DIR}/public/vstdlib/vstdlib.h
)

if(WIN32)
    list(APPEND VSTDLIB_SOURCES
        processutils.cpp
    )

    if (PLATFORM_64BITS)
        list(APPEND VSTDLIB_SOURCES
            coroutine_win64.masm
            GetStackPtr64.masm
        )
    endif()
endif()

if (X360 AND NOT APPLE)
    list(APPEND VSTDLIB_SOURCES
        coroutine.cpp
    )
endif()

add_engine_shared_library(vstdlib
    ${VSTDLIB_SOURCES}
    ${VSTDLIB_HEADERS}
)

target_include_directories(vstdlib
    PUBLIC
        ${SRC_DIR}/public
        ${SRC_DIR}/public/tier0
        ${SRC_DIR}/public/tier1
        ${SRC_DIR}/public/vstdlib
        ${SRC_DIR}/vstdlib
)

target_compile_definitions(vstdlib
    PRIVATE
        VSTDLIB_DLL_EXPORT
)

target_link_libraries(vstdlib
    PRIVATE
        tier0
        tier1
)

if(MSVC)
    target_compile_options(vstdlib
        PRIVATE
            $<$<CONFIG:Release>:/GS->
    )
endif()

source_group("Source Files" FILES ${VSTDLIB_SOURCES})
source_group("Public Header Files" FILES ${VSTDLIB_HEADERS})