import qbs

DynamicLibrary {
    name: "QMath3d"

    //For mac os x we need to build dylib instead of framework bundle. When running
    //macdepolyqt for release, with a framework, an extra "lib" is added to the
    //path which prevents macdeployqt from finding the correct library's location
//    consoleApplication: true
    cpp.cxxLanguageVersion: "c++17"

    readonly property string rpath: buildDirectory

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: [ "core", "gui"] }

    Export {
        Depends { name: "cpp" }
        cpp.includePaths: ["."]
//        cpp.rpaths: product.rpath
        cpp.cxxLanguageVersion: (Qt.core.versionMajor >= 5 && Qt.core.versionMinor >= 7 ? "c++11" : "c++98");
    }

    Group {
        fileTagsFilter: ["dynamiclibrary"]
        condition: qbs.buildVariant == "release"
        qbs.install: qbs.targetOS.contains("windows")
    }

    Group {
        fileTagsFilter: ["bundle.content"]
        qbs.install: bundle.isBundle
        qbs.installSourceBase: product.buildDirectory
        qbs.installDir: "lib"
        qbs.installPrefix: ""
    }

//    cpp.rpaths: [Qt.core.libPath]

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

    Properties {
        condition: qbs.targetOS.contains("macos")
        cpp.sonamePrefix: qbs.installRoot + "/lib"
    }

    Properties {
        condition: qbs.targetOS.contains("windows")
        cpp.defines: ["Q_MATH_3D"]
    }
}
