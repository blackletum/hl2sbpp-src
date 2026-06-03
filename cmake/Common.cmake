##########################################################################
# 
# Copyright (c) 2026 The Aridity Team, all rights reserved.
#
# Common.cmake: Common functions used for creating targets with pre-
#				defined configurations
#
##########################################################################

function(add_public_library target)
    add_library(${target} STATIC ${ARGN})

    add_custom_command(
        TARGET ${target}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND} -E make_directory
                "${SRC_DIR}/lib/public"
        COMMAND ${CMAKE_COMMAND} -E copy
                "$<TARGET_FILE:${target}>"
                "${SRC_DIR}/lib/public/"
		COMMENT "Copying '$<TARGET_FILE:${target}>' to '${SRC_DIR}/lib/public/'..."
    )
endfunction()

function(add_engine_shared_library target)
    add_library(${target} SHARED ${ARGN})

    install(
        TARGETS ${target}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION bin
        ARCHIVE DESTINATION bin
    )

    if(MSVC)
        install(
            FILES "$<TARGET_PDB_FILE:${target}>"
            DESTINATION bin
            OPTIONAL
        )
    endif()
endfunction()

function(add_game_library target game_name)
    add_library(${target} MODULE ${ARGN})

    install(
        TARGETS ${target}
        RUNTIME DESTINATION ${game_name}/bin
        LIBRARY DESTINATION ${game_name}/bin
        ARCHIVE DESTINATION ${game_name}/bin
    )

    if(MSVC)
        install(
            FILES "$<TARGET_PDB_FILE:${target}>"
            DESTINATION ${game_name}/bin
            OPTIONAL
        )
    endif()
endfunction()

function(add_engine_executable target)
	if (WIN32)
    	add_executable(${target} WIN32 ${ARGN})
	else()
		add_executable(${target} ${ARGN})
	endif()

    install(
        TARGETS ${target}
        RUNTIME DESTINATION .
        LIBRARY DESTINATION .
        ARCHIVE DESTINATION .
    )

    if(MSVC)
		target_link_options(${target} PUBLIC /subsystem:windows)

        install(
            FILES "$<TARGET_PDB_FILE:${target}>"
            DESTINATION .
            OPTIONAL
        )
    endif()
endfunction()

function(add_engine_utility_executable target)
    add_executable(${target} ${ARGN})

    install(
        TARGETS ${target}
        RUNTIME DESTINATION bin
        LIBRARY DESTINATION bin
        ARCHIVE DESTINATION bin
    )

    if(MSVC)
        install(
            FILES "$<TARGET_PDB_FILE:${target}>"
            DESTINATION bin
            OPTIONAL
        )
    endif()
endfunction()