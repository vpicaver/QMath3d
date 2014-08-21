import qbs.base 1.0

DynamicLibrary {
    name: "QMath3d"
    Depends { name: "Qt"; submodules: [ "core", "gui"] }

    files: [
        "qbox3d.h",
        "qplane3d.h",
        "qray3d.h",
        "qsphere3d.h",
        "qtriangle3d.h",
        "qbox3d.cpp",
        "qplane3d.cpp",
        "qray3d.cpp",
        "qsphere3d.cpp",
        "qtriangle3d.cpp",
        "smallqt3d_global.h"
    ]

    cpp.includePaths: [
        "."
    ]
}
