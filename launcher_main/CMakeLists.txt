project(launcher_main)

set(LAUNCHER_MAIN_SOURCES
	main.cpp
)

if(WIN32)
	list(APPEND LAUNCHER_MAIN_SOURCES
		launcher_main.rc
		resource.h
	)
endif()

add_engine_executable(launcher_main ${LAUNCHER_MAIN_SOURCES})

set_target_properties(
	launcher_main PROPERTIES
	OUTPUT_NAME "hl2sbpp_launcher"
)

target_include_directories(launcher_main PRIVATE
	${SRC_DIR}/public
)

target_compile_definitions(launcher_main PRIVATE
	fopen=dont_use_fopen
)

if(WIN32)
	target_link_libraries(launcher_main PRIVATE
		user32
		shell32
	)
else()
	target_link_libraries(launcher_main PRIVATE
		dl
		log
	)
endif()

if(WIN32)
    set_target_properties(
        launcher_main PROPERTIES
        WIN32_EXECUTABLE TRUE
    )

	target_link_options(launcher_main PRIVATE /largeaddressaware /fixed:no)

	enable_language(RC)
endif()