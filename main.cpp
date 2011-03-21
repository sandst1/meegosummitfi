#include <QDeclarativeContext>
#include <QtGui/QApplication>
#include <QGraphicsObject>
#include <qmlapplicationviewer.h>
#include <QOrientationSensor>
#include "OrientationFilter.h"
QTM_USE_NAMESPACE
#include "listmodel.h"
#include "summititems.h"
#include "xmlparser.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    XMLParser xmlparser;    

    QmlApplicationViewer viewer;
    QDeclarativeContext *context = new QDeclarativeContext(viewer.rootContext());

    if ( context->parentContext() )
    {
        context = context->parentContext();
    }

    context->setContextProperty("XMLParser", &xmlparser);

    context->setContextProperty("daysModel", xmlparser.getDaysModel());

    context->setContextProperty("tracksModel", NULL);
    context->setContextProperty("sessionsModel", NULL);

    xmlparser.parse(context);
    viewer.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    //viewer.setMainQmlFile(QLatin1String("qml/MeeGoSummitFI/main.qml"));
    viewer.setSource(QUrl("qrc:/qml/MeeGoSummitFI/main.qml"));

    QOrientationSensor sensor;
    OrientationFilter filter;
    sensor.addFilter(&filter);

    // Connect the Qt signal to QML function
    QObject::connect(&filter, SIGNAL(orientationChanged(const QVariant&)), viewer.rootObject(), SLOT(orientationChanged(const QVariant&)));


    sensor.start();
    viewer.showExpanded();

    return app.exec();
}
