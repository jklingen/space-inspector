/*
    From Kari's excellent File Browser, which has been released into the public domain.
    See https://github.com/karip/harbour-file-browser
*/

#ifndef ENGINE_H
#define ENGINE_H

#include <QDir>
#include <QVariant>

class FileWorker;

/**
 * @brief Engine to handle file operations, settings and other generic functionality.
 */
class Engine : public QObject
{
    Q_OBJECT

public:
    explicit Engine(QObject *parent = 0);
    ~Engine();

    // methods accessible from QML

    // asynch methods send signals when done or error occurs
    Q_INVOKABLE void deleteFiles(QStringList filenames);

    // file paths
    Q_INVOKABLE QString homeFolder() const;
    Q_INVOKABLE QString sdcardPath() const;
    Q_INVOKABLE QString androidSdcardPath() const;

    // synchronous methods
    Q_INVOKABLE bool exists(QString filename);
    Q_INVOKABLE QStringList diskSpace(QString path);

    // access settings
    Q_INVOKABLE QString readSetting(QString key, QString defaultValue = QString());
    Q_INVOKABLE void writeSetting(QString key, QString value);

signals:
    void workerDone();

    void workerErrorOccurred(QString message, QString filename);
    void fileDeleted(QString fullname);

    void settingsChanged();

private:
    QStringList mountPoints() const;

    FileWorker *m_fileWorker;
};

#endif // ENGINE_H
