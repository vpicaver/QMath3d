cmake_minimum_required(VERSION 3.5.0)
project(QMath3d LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)


# Find Qt packages
find_package(Qt6 COMPONENTS Core Qml Gui REQUIRED)

# Add dynamic library
qt_add_library(QMath3d STATIC
    qbox3d.h
    qplane3d.h
    qray3d.h
    qsphere3d.h
    qtriangle3d.h
    qbox3d.cpp
    qplane3d.cpp
    qray3d.cpp
    qsphere3d.cpp
    qtriangle3d.cpp
    smallqt3d_global.h
)

set_target_properties(QMath3d PROPERTIES
    AUTOMOC ON
)

# Add dependencies
target_link_libraries(QMath3d PRIVATE Qt6::Core Qt6::Qml Qt6::Gui)

# Include directories
target_include_directories(QMath3d PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Platform-specific configurations
if(APPLE)
    set_target_properties(QMath3d PROPERTIES INSTALL_RPATH "@loader_path/../lib")
elseif(WIN32)
    target_compile_definitions(QMath3d PRIVATE Q_MATH_3D)
endif()

# Installation settings (assuming you want to install the library)
install(TARGETS QMath3d
    LIBRARY DESTINATION lib
    ARCHIVE DESTINATION lib
    RUNTIME DESTINATION bin
)

option(WITH_TESTS "enable tests" ON)
if (WITH_TESTS)
    add_subdirectory(tests)
endif()
