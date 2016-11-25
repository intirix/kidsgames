#include "qrccache.h"
#include <QStandardPaths>
#include <QtDebug>
#include <QDir>
#include <QFileInfo>

QrcCache::QrcCache(QQuickItem *parent)
    : QQuickItem(parent) {
    m_cacheDir = QStandardPaths::writableLocation(QStandardPaths::StandardLocation::CacheLocation);
    m_cacheDir.append("/qrc");
}

void QrcCache::setSource(const QString &source) {
    m_source = source;

    QString qrcFileName(m_cacheDir);
    qrcFileName.append(source.right(source.size()-1));
    QFile qrcDestFile(qrcFileName);
    QFileInfo destFileInfo(qrcDestFile);

    QDir parentDir = destFileInfo.dir();

    if ( !parentDir.exists() ) {
        qInfo() << "Cache dir " << parentDir.path() << " does not exist, creating it";
        parentDir.mkpath(".");
    }

    if ( !qrcDestFile.exists() )
    {
        qInfo() << "Cache file " << qrcFileName << " does not exist, creating it";
        if ( QFile(source).copy(qrcFileName) )
        {
            qInfo() << "Cache file " << qrcFileName << " has been created";
            m_path = qrcFileName;
            emit pathChanged();
        }
        else
        {
            qInfo() << "Cache file " << qrcFileName << " creation failed";
        }
    } else {
        m_path = qrcFileName;
        emit pathChanged();
    }


}

QString QrcCache::source() const {
    return m_source;
}

QString QrcCache::path() const {
    qInfo() << "path() = "<<m_path;
    return m_path;
}
