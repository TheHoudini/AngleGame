#include <QApplication>
#include <QQmlApplicationEngine>
#include "datamanager.h"
#include <QtQml>

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    qmlRegisterType<DataManager>("dev.anglegame",1,0,"AngleData");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));


    return app.exec();
}
