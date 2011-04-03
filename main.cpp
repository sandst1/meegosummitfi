/*
 * MeeGoSummitFI - Timetable application for MeeGo Summit Finland
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */
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

    viewer.showExpanded();

    return app.exec();
}
