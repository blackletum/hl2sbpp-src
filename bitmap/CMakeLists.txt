project(bitmap)

set(BITMAP_SOURCES
	etc2lib/etc_android.cpp
	etc2lib/etc_rg_etc1.cpp
	etc2lib/etc2_encoder.cpp
	etc2lib/etc.cpp
	ImageByteSwap.cpp
	colorconversion.cpp
	float_bm.cpp
	float_bm2.cpp
	float_bm3.cpp
	float_bm_bilateral_filter.cpp
	float_cube.cpp
	imageformat.cpp
	psd.cpp
	resample.cpp
	tgaloader.cpp
	tgawriter.cpp
	bitmap.cpp
)

set(BITMAP_HEADERS
	${SRC_DIR}/public/bitmap/bitmap.h
	${SRC_DIR}/public/bitmap/float_bm.h
	${SRC_DIR}/public/bitmap/imageformat.h
	${SRC_DIR}/public/bitmap/psd.h
	${SRC_DIR}/public/bitmap/tgaloader.h
	${SRC_DIR}/public/bitmap/tgawriter.h
	${SRC_DIR}/thirdparty/stb/stb_dxt.h
)

if (IS_WINDOWS)
	list(APPEND BITMAP_SOURCES float_bm4.cpp)
endif()

source_group("Source Files" FILES ${BITMAP_SOURCES})
source_group("Header Files" FILES ${BITMAP_HEADERS})

add_public_library(bitmap ${BITMAP_SOURCES} ${BITMAP_HEADERS})

target_include_directories(bitmap PRIVATE
	${SRC_DIR}/public
	${SRC_DIR}/public/bitmap
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
	${SRC_DIR}/thirdparty/stb
)