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