project(QMath3dTests LANGUAGES CXX)

find_package(Qt6 REQUIRED COMPONENTS Test Gui)

set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_AUTOMOC ON)
enable_testing(true)

aux_source_directory(. SRC_LIST)

qt_add_executable(${PROJECT_NAME})
target_sources(${PROJECT_NAME} PRIVATE
    ${SRC_LIST}
)

add_test(NAME QMath3dTests COMMAND QMath3dTests)

target_link_libraries(${PROJECT_NAME} PRIVATE
    Qt::Test
    Qt::Qml
    Qt::Gui # matrix&quaternions
    QMath3d
)
