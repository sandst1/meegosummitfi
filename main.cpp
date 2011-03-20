#include <QDeclarativeContext>
#include <QtGui/QApplication>
#include <qmlapplicationviewer.h>

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

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    //viewer.setMainQmlFile(QLatin1String("qml/MeeGoSummitFI/main.qml"));
    viewer.setSource(QUrl("qrc:/qml/MeeGoSummitFI/main.qml"));

    viewer.showExpanded();

    return app.exec();
}
