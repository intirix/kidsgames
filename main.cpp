#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>

#include "qrccache.h"

void load_file(QQmlApplicationEngine &engine, const char *filename, const char *prop)
{
    QFile mFile(filename);

    if(!mFile.open(QFile::ReadOnly | QFile::Text)){
        qDebug() << "could not open file for read";
        return;
    }

    QTextStream in(&mFile);
    QString mText = in.readAll();

    //qDebug() << mText;

    mFile.close();
    engine.rootContext()->setContextProperty(prop,mText);

}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    qmlRegisterType<QrcCache>("KidGames", 1, 0, "QrcCache");

    app.setWindowIcon(QIcon("qrc:/images/app.png"));

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("privacy_policy_md","[Link to the Privacy Policy](https://github.com/intirix/kidsgames/blob/master/privacy-policy.md)");
    load_file(engine, ":/images.txt", "credits_images");
    load_file(engine, ":/sounds.txt", "credits_sounds");
    load_file(engine, ":/privacy-policy.md", "privacy_policy_md");
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
