#ifndef QRCCACHE_H
#define QRCCACHE_H

#include <qquickitem.h>

class QrcCache : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QString source READ source WRITE setSource)
    Q_PROPERTY(QString path READ path NOTIFY pathChanged)

public:
    QrcCache(QQuickItem *parent = 0);

    QString source() const;
    void setSource(const QString &source);
    QString path() const;

signals:
    void pathChanged();

private:
    QString m_source;
    QString m_path;
    QString m_cacheDir;
};

#endif // QRCCACHE_H
