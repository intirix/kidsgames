#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "qrccache.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QrcCache>("KidGames", 1, 0, "QrcCache");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
