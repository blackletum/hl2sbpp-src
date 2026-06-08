project(vtf)

set(SOURCES
    "convert_x360.cpp"
    "vtf.cpp"
)
set(HEADERS
    "cvtf.h"
)
set(PUBLIC_HEADERS
    "${SRC_DIR}/public/vtf/vtf.h"
)

source_group("Source Files" FILES
    convert_x360.cpp
    vtf.cpp
)

if(IS_WINDOWS)
    list(APPEND SOURCES
        "s3tc_decode.cpp"
    )

    list(APPEND PUBLIC_HEADERS
        "s3tc_decode.h"
    )
endif()

if(IS_X360)
    list(APPEND SOURCES
        "vtf_x360.cpp"
    )
endif()

source_group("Public Header Files" FILES ${PUBLIC_HEADERS})
source_group("Source Files" FILES ${SOURCES})
source_group("Header Files" FILES ${HEADERS})

add_public_library(vtf ${SOURCES} ${HEADERS} ${PUBLIC_HEADERS})

target_compile_definitions(vtf PRIVATE
    fopen=dont_use_fopen
)

target_include_directories(vtf PRIVATE
    ${SRC_DIR}/common
    ${SRC_DIR}/public
    ${SRC_DIR}/public/tier0
    ${SRC_DIR}/public/tier1
    $<$<BOOL:${IS_WINDOWS}>:${SRC_DIR}/dx9sdk/include>
)