/*
    From Kari's excellent File Browser, which has been released into the public domain.
    See https://github.com/karip/harbour-file-browser
*/

#include "fileworker.h"
#include <QDateTime>
#include "globals.h"

FileWorker::FileWorker(QObject *parent) :
    QThread(parent),
    m_mode(DeleteMode),
    m_cancelled(KeepRunning)
{
}

FileWorker::~FileWorker()
{
}

void FileWorker::startDeleteFiles(QStringList filenames)
{
    if (isRunning()) {
        emit errorOccurred(tr("File operation already in progress"), "");
        return;
    }

    if (!validateFilenames(filenames))
        return;

    m_mode = DeleteMode;
    m_filenames = filenames;
    m_cancelled.storeRelease(KeepRunning);
    start();
}

void FileWorker::cancel()
{
    m_cancelled.storeRelease(Cancelled);
}

void FileWorker::run()
{
    switch (m_mode) {
    case DeleteMode:
        deleteFiles();
        break;
    }
}

bool FileWorker::validateFilenames(const QStringList &filenames)
{
    // basic validity check
    foreach (QString filename, filenames) {
        if (filename.isEmpty()) {
            emit errorOccurred(tr("Empty filename"), "");
            return false;
        }
    }
    return true;
}

QString FileWorker::deleteFile(QString filename)
{
    QFileInfo info(filename);
    if (!info.exists() && !info.isSymLink())
        return tr("File not found");

    if (info.isDir() && info.isSymLink()) {
        // only delete the link and do not remove recursively subfolders
        QFile file(info.absoluteFilePath());
        bool ok = file.remove();
        if (!ok)
            return file.errorString();

    } else if (info.isDir()) {
        // this should be custom function to get better error reporting
        bool ok = QDir(info.absoluteFilePath()).removeRecursively();
        if (!ok)
            return tr("Folder delete failed");

    } else {
        QFile file(info.absoluteFilePath());
        bool ok = file.remove();
        if (!ok)
            return file.errorString();
    }
    return QString();
}

void FileWorker::deleteFiles()
{
    int fileIndex = 0;
    int fileCount = m_filenames.count();

    foreach (QString filename, m_filenames) {
        // stop if cancelled
        if (m_cancelled.loadAcquire() == Cancelled) {
            emit errorOccurred(tr("Cancelled"), filename);
            return;
        }

        // delete file and stop if errors
        QString errMsg = deleteFile(filename);
        if (!errMsg.isEmpty()) {
            emit errorOccurred(errMsg, filename);
            return;
        }
        emit fileDeleted(filename);

        fileIndex++;
    }
}

