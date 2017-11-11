#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>

#include "qrccache.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QFile mFile(":/images.txt");

    if(!mFile.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "could not open file for read";
        return 0;
    }

    QTextStream in(&mFile);
    QString mText = in.readAll();

    //qDebug() << mText;

    mFile.close();

    qmlRegisterType<QrcCache>("KidGames", 1, 0, "QrcCache");

    app.setWindowIcon(QIcon("qrc:/images/app.png"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("credits",mText);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
