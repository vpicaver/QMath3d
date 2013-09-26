#-------------------------------------------------
#
# Project created by QtCreator 2013-09-19T22:55:28
#
#-------------------------------------------------

TARGET = QMath3d
TEMPLATE = lib

CONFIG += debug_and_release build_all

DEFINES += Q_MATH_3D

SOURCES +=

HEADERS += smallqt3d_global.h

include(math3d.pri)

CONFIG(debug, debug|release) {
    mac {
        TARGET = QMath3d_debug

    } else {
        TARGET = QMath3dd
    }
} else {
    TARGET = QMath3d
}

mac {
    QMAKE_LFLAGS_SONAME  = -Wl,-install_name,$${PWD}/
}
unix:!symbian {
    maemo5 {
        target.path = /opt/usr/lib
    } else {
        target.path = /usr/lib
    }
    INSTALLS += target
}

cache()
