project(client LANGUAGES C CXX)

list(APPEND CMAKE_MODULE_PATH
	${SRC_DIR}/game/client
	${SRC_DIR}/game/shared
)

include(client_base)

if ("hl2sbpp" IN_LIST GAMES)
	include(client_sbpp)
else()
	message(FATAL_ERROR "No games selected.")
endif()