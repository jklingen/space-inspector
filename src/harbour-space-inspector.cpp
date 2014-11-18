/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 Jens Klingen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif
#include <QtQml>
#include <sailfishapp.h>
#include <QScopedPointer>
#include <QQuickView>
#include <QQmlEngine>
#include <QGuiApplication>
#include <QQmlContext>
#include <QtQuick/QQuickPaintedItem>
#include <QTranslator>
#include "shell.h"
#include "io/engine.h"


int main(int argc, char *argv[])
{
    qmlRegisterType<Shell>("harbour.space.inspector.shell", 1, 0, "Shell");

    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));

    QTranslator* translator = new QTranslator;
    if(!translator->load("space-inspector_" + QLocale::system().name(), SailfishApp::pathTo("i18n").toLocalFile())) {
        qDebug() << "Couldn't load translation";
    }
    app->installTranslator(translator);

    QScopedPointer<QQuickView> view(SailfishApp::createView());

    // QML global engine object
    QScopedPointer<Engine> engine(new Engine);
    view->rootContext()->setContextProperty("engine", engine.data());



    // store pointer to engine to access it in any class, to make it a singleton
    QVariant engineVariant = qVariantFromValue(engine.data());
    qApp->setProperty("engine", engineVariant);

    view->setSource(SailfishApp::pathTo("qml/harbour-space-inspector.qml"));
    view->show();

    return app->exec();

    //return SailfishApp::main(argc, argv);
}


