/*
    From Kari's excellent File Browser, which has been released into the public domain.
    See https://github.com/karip/harbour-file-browser
*/

#ifndef FILEWORKER_H
#define FILEWORKER_H

#include <QThread>
#include <QDir>

/**
 * @brief FileWorker does delete, copy and move files in the background.
 */
class FileWorker : public QThread
{
    Q_OBJECT

public:
    explicit FileWorker(QObject *parent = 0);
    ~FileWorker();

    // call these to start the thread, returns false if start failed
    void startDeleteFiles(QStringList filenames);

    void cancel();

signals: // signals, can be connected from a thread to another

    // one of these is emitted when thread ends
    void done();
    void errorOccurred(QString message, QString filename);

    void fileDeleted(QString fullname);

protected:
    void run() Q_DECL_OVERRIDE;

private:
    enum Mode {
        DeleteMode
    };
    enum CancelStatus {
        Cancelled = 0, KeepRunning = 1
    };

    bool validateFilenames(const QStringList &filenames);

    QString deleteFile(QString filenames);
    void deleteFiles();

    FileWorker::Mode m_mode;
    QStringList m_filenames;
    QString m_destDirectory;
    QAtomicInt m_cancelled; // atomic so no locks needed

};

#endif // FILEWORKER_H
