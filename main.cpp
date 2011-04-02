#include <QDeclarativeContext>
#include <QtGui/QApplication>
#include <QGraphicsObject>
#include <qmlapplicationviewer.h>

#ifdef Q_WS_MAEMO_5
#include <QOrientationSensor>
#include "OrientationFilter.h"
QTM_USE_NAMESPACE
#endif

#include "listmodel.h"
#include "summititems.h"
#include "xmlparser.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);   

    QmlApplicationViewer viewer;
    QDeclarativeContext *context = new QDeclarativeContext(viewer.rootContext());

    if ( context->parentContext() )
    {
        context = context->parentContext();
    }

    XMLParser xmlparser(context);

    context->setContextProperty("XMLParser", &xmlparser);

    context->setContextProperty("daysModel", xmlparser.getDaysModel());

    context->setContextProperty("tracksModel", NULL);
    context->setContextProperty("sessionsModel", NULL);

    viewer.setResizeMode(QDeclarativeView::SizeRootObjectToView);
    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setSource(QUrl("qrc:/qml/MeeGoSummitFI/main.qml"));

/*
#ifdef Q_WS_MAEMO_5

    QOrientationSensor sensor;
    OrientationFilter filter;
    sensor.addFilter(&filter);

    // Connect the Qt signal to QML function
    QObject::connect(&filter, SIGNAL(orientationChanged(const QVariant&)), viewer.rootObject(), SLOT(orientationChanged(const QVariant&)));

    sensor.start();
#endif
*/

    viewer.showExpanded();

    return app.exec();
}
