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

   QFile mFile2(":/sounds.txt");

    if(!mFile2.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "could not open file for read";
        return 0;
    }

    QTextStream in2(&mFile2);
    QString mText2 = in2.readAll();

    //qDebug() << mText;

    mFile2.close();


    qmlRegisterType<QrcCache>("KidGames", 1, 0, "QrcCache");

    app.setWindowIcon(QIcon("qrc:/images/app.png"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("credits_images",mText);
    engine.rootContext()->setContextProperty("credits_sounds",mText2);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
