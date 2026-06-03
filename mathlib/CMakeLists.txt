project(mathlib)

set(MATHLIB_SOURCES
	3dnow.cpp
	almostequal.cpp
	anorms.cpp
	bumpvects.cpp
	color_conversion.cpp
	halton.cpp
	IceKey.cpp
	imagequant.cpp
	lightdesc.cpp
	mathlib_base.cpp
	powsse.cpp
	polyhedron.cpp
	quantize.cpp
	randsse.cpp
	simdvectormatrix.cpp
	sparse_convolution_noise.cpp
	spherical.cpp
	sse.cpp
	sseconst.cpp
	ssenoise.cpp
	vector.cpp
	vmatrix.cpp
)

set(MATHLIB_HEADERS
	3dnow.h
	${SRC_DIR}/public/mathlib/amd3dx.h
	${SRC_DIR}/public/mathlib/anorms.h
	${SRC_DIR}/public/mathlib/bumpvects.h
	${SRC_DIR}/public/mathlib/compressed_3d_unitvec.h
	${SRC_DIR}/public/mathlib/compressed_light_cube.h
	${SRC_DIR}/public/mathlib/compressed_vector.h
	${SRC_DIR}/public/mathlib/halton.h
	${SRC_DIR}/public/mathlib/IceKey.H
	${SRC_DIR}/public/mathlib/lightdesc.h
	${SRC_DIR}/public/mathlib/math_pfns.h
	${SRC_DIR}/public/mathlib/mathlib.h
	${SRC_DIR}/public/mathlib/noise.h
	noisedata.h
	${SRC_DIR}/public/mathlib/polyhedron.h
	${SRC_DIR}/public/mathlib/quantize.h
	${SRC_DIR}/public/mathlib/simdvectormatrix.h
	${SRC_DIR}/public/mathlib/spherical_geometry.h
	sse.h
	${SRC_DIR}/public/mathlib/ssemath.h
	${SRC_DIR}/public/mathlib/ssequaternion.h
	${SRC_DIR}/public/mathlib/vector.h
	${SRC_DIR}/public/mathlib/vector2d.h
	${SRC_DIR}/public/mathlib/vector4d.h
	${SRC_DIR}/public/mathlib/vmatrix.h
	${SRC_DIR}/public/mathlib/vplane.h
)

source_group("Source Files" FILES ${MATHLIB_SOURCES})
source_group("Header Files" FILES ${MATHLIB_HEADERS})

add_public_library(mathlib ${MATHLIB_SOURCES} ${MATHLIB_HEADERS})

target_compile_definitions(mathlib PRIVATE
	MATHLIB_LIB=1
)

target_include_directories(mathlib PRIVATE
	${SRC_DIR}/public/mathlib
	${SRC_DIR}/public/tier0
)