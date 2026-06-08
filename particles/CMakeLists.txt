project(particles)

set(PARTICLES_SOURCES
	builtin_constraints.cpp
	builtin_initializers.cpp
	builtin_particle_emitters.cpp
	builtin_particle_forces.cpp
	addbuiltin_ops.cpp
	builtin_particle_ops.cpp
	builtin_particle_render_ops.cpp
	particle_sort.cpp		
	particles.cpp
	psheet.cpp
)

set(PARTICLES_HEADERS
	${SRC_DIR}/public/particles/particles.h
	particles_internal.h
	psheet.h
	random_floats.h
)

source_group("Source Files" FILES ${PARTICLES_SOURCES})
source_group("Header Files" FILES ${PARTICLES_HEADERS})

add_public_library(particles ${PARTICLES_SOURCES} ${PARTICLES_HEADERS})

target_include_directories(particles PRIVATE
	${SRC_DIR}/public
	${SRC_DIR}/public/particles
	${SRC_DIR}/public/tier0
	${SRC_DIR}/public/tier1
)