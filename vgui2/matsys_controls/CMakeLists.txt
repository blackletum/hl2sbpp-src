project(matsys_controls)

set(MATSYS_CONTROLS_SOURCES
	assetpicker.cpp
	baseassetpicker.cpp
	colorpickerpanel.cpp
	curveeditorpanel.cpp
	gamefiletreeview.cpp
	manipulator.cpp
	matsyscontrols.cpp
	mdlpanel.cpp
	mdlpicker.cpp
	mdlsequencepicker.cpp
	picker.cpp
	potterywheelpanel.cpp
	proceduraltexturepanel.cpp
	QCGenerator.cpp
	sequencepicker.cpp
	tgapreviewpanel.cpp
	vmtpicker.cpp
	vmtpreviewpanel.cpp
	vtfpicker.cpp
	vmtpreviewpanel.cpp
	vtfpicker.cpp
	vtfpreviewpanel.cpp
	vmtpanel.cpp
)

set(MATSYS_CONTROLS_HEADERS
	${SRC_DIR}/public/matsys_controls/assetpicker.h
	${SRC_DIR}/public/matsys_controls/baseassetpicker.h
	${SRC_DIR}/public/matsys_controls/colorpickerpanel.h
	${SRC_DIR}/public/matsys_controls/curveeditorpanel.h
	${SRC_DIR}/public/matsys_controls/gamefiletreeview.h
	${SRC_DIR}/public/matsys_controls/manipulator.h
	${SRC_DIR}/public/matsys_controls/matsyscontrols.h
	${SRC_DIR}/public/matsys_controls/mdlpanel.h
	${SRC_DIR}/public/matsys_controls/mdlpicker.h
	${SRC_DIR}/public/matsys_controls/mdlsequencepicker.h
	${SRC_DIR}/public/matsys_controls/picker.h
	${SRC_DIR}/public/matsys_controls/potterywheelpanel.h
	${SRC_DIR}/public/matsys_controls/proceduraltexturepanel.h
	${SRC_DIR}/public/matsys_controls/QCGenerator.h
	${SRC_DIR}/public/matsys_controls/sequencepicker.h
	${SRC_DIR}/public/matsys_controls/tgapreviewpanel.h
	${SRC_DIR}/public/matsys_controls/vmtpicker.h
	${SRC_DIR}/public/matsys_controls/vmtpreviewpanel.h
	${SRC_DIR}/public/matsys_controls/vtfpicker.h
	${SRC_DIR}/public/matsys_controls/vmtpreviewpanel.h
	${SRC_DIR}/public/matsys_controls/vtfpicker.h
	${SRC_DIR}/public/matsys_controls/vtfpreviewpanel.h
	${SRC_DIR}/public/matsys_controls/vmtpanel.h
)

source_group("Source Files" FILES ${MATSYS_CONTROLS_SOURCES})
source_group("Header Files" FILES ${MATSYS_CONTROLS_HEADERS})

add_public_library(matsys_controls ${MATSYS_CONTROLS_SOURCES} ${MATSYS_CONTROLS_HEADERS})

target_include_directories(matsys_controls
	PRIVATE
		${SRC_DIR}/public
		${SRC_DIR}/public/tier0
		${SRC_DIR}/public/tier1
)
