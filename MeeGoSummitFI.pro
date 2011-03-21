# Add more folders to ship with the application, here
folder_01.source = qml/MeeGoSummitFI
folder_01.target = qml
DEPLOYMENTFOLDERS = folder_01

QT += core gui declarative network xml

# Additional import path used to resolve QML modules in Creator's code model
QML_IMPORT_PATH =

# Avoid auto screen rotation
#DEFINES += ORIENTATIONLOCK

# Needs to be defined for Symbian
DEFINES += NETWORKACCESS

symbian:TARGET.UID3 = 0xE7361F56

# Define QMLJSDEBUGGER to allow debugging of QML in debug builds
# (This might significantly increase build time)
# DEFINES += QMLJSDEBUGGER

# If your application uses the Qt Mobility libraries, uncomment
# the following lines and add the respective components to the 
# MOBILITY variable. 
# CONFIG += mobility
# MOBILITY +=

# The .cpp file which was generated for your project. Feel free to hack it.
SOURCES += main.cpp \
    xmlparser.cpp \
    listmodel.cpp \
    summititems.cpp

# Please do not modify the following two lines. Required for deployment.
include(qmlapplicationviewer/qmlapplicationviewer.pri)
qtcAddDeployment()

HEADERS += \
    xmlparser.h \
    listmodel.h \
    summititems.h \
    OrientationFilter.h

CONFIG      += mobility
MOBILITY    += sensors

OTHER_FILES +=

RESOURCES += \
    meegosummitfi.qrc
