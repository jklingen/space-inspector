/*
    From Kari's excellent File Browser, which has been released into the public domain.
    See https://github.com/karip/harbour-file-browser
*/

#include "engine.h"
#include <QDateTime>
#include <QTextStream>
#include <QSettings>
#include <QStandardPaths>
#include <unistd.h>
#include "globals.h"
#include "fileworker.h"
#include "statfileinfo.h"

Engine::Engine(QObject *parent) :
    QObject(parent)
{
    m_fileWorker = new FileWorker;
    // pass worker end signals to QML
    connect(m_fileWorker, SIGNAL(done()), this, SIGNAL(workerDone()));
    connect(m_fileWorker, SIGNAL(errorOccurred(QString, QString)),
            this, SIGNAL(workerErrorOccurred(QString, QString)));
    connect(m_fileWorker, SIGNAL(fileDeleted(QString)), this, SIGNAL(fileDeleted(QString)));
}

Engine::~Engine()
{
    // is this the way to force stop the worker thread?
    m_fileWorker->cancel(); // stop possibly running background thread
    m_fileWorker->wait();   // wait until thread stops
    delete m_fileWorker;    // delete it
}

void Engine::deleteFiles(QStringList filenames)
{
    m_fileWorker->startDeleteFiles(filenames);
}

QString Engine::homeFolder() const
{
    return QStandardPaths::writableLocation(QStandardPaths::HomeLocation);
}

QString Engine::sdcardPath() const
{
    // get sdcard dir candidates
    QDir dir("/media/sdcard");
    if (!dir.exists())
        return QString();
    dir.setFilter(QDir::AllDirs | QDir::NoDotAndDotDot);
    QStringList sdcards = dir.entryList();
    if (sdcards.isEmpty())
        return QString();

    // remove all directories which are not mount points
    QStringList mps = mountPoints();
    QMutableStringListIterator i(sdcards);
    while (i.hasNext()) {
        QString dirname = i.next();
        QString abspath = dir.absoluteFilePath(dirname);
        if (!mps.contains(abspath))
            i.remove();
    }

    // none found, return empty string
    if (sdcards.isEmpty())
        return QString();

    // if only one directory, then return it
    if (sdcards.count() == 1)
        return dir.absoluteFilePath(sdcards.first());

    // if multiple directories, then return "/media/sdcard", which is the parent for them
    return "/media/sdcard";
}

QString Engine::androidSdcardPath() const
{
    return QStandardPaths::writableLocation(QStandardPaths::HomeLocation)+"/android_storage";
}


bool Engine::exists(QString filename)
{
    if (filename.isEmpty())
        return false;

    return QFile::exists(filename);
}

QStringList Engine::diskSpace(QString path)
{
    if (path.isEmpty())
        return QStringList();

    // return no disk space for sdcard parent directory
    if (path == "/media/sdcard")
        return QStringList();

    // run df for the given path to get disk space
    QString blockSize = "--block-size=1024";
    QString result = execute("/bin/df", QStringList() << blockSize << path, false);
    if (result.isEmpty())
        return QStringList();

    // split result to lines
    QStringList lines = result.split(QRegExp("[\n\r]"));
    if (lines.count() < 2)
        return QStringList();

    // get first line and its columns
    QString line = lines.at(1);
    QStringList columns = line.split(QRegExp("\\s+"), QString::SkipEmptyParts);
    if (columns.count() < 5)
        return QStringList();

    QString totalString = columns.at(1);
    QString usedString = columns.at(2);
    QString percentageString = columns.at(4);
    qint64 total = totalString.toLongLong() * 1024LL;
    qint64 used = usedString.toLongLong() * 1024LL;

    return QStringList() << percentageString << filesizeToString(used)+"/"+filesizeToString(total);
}

QString Engine::readSetting(QString key, QString defaultValue)
{
    QSettings settings;
    return settings.value(key, defaultValue).toString();
}

void Engine::writeSetting(QString key, QString value)
{
    QSettings settings;

    // do nothing if value didn't change
    if (settings.value(key) == value)
        return;

    settings.setValue(key, value);

    emit settingsChanged();
}

QStringList Engine::mountPoints() const
{
    // read /proc/mounts and return all mount points for the filesystem
    QFile file("/proc/mounts");
    if (!file.open(QFile::ReadOnly | QFile::Text))
        return QStringList();

    QTextStream in(&file);
    QString result = in.readAll();

    // split result to lines
    QStringList lines = result.split(QRegExp("[\n\r]"));

    // get columns
    QStringList dirs;
    foreach (QString line, lines) {
        QStringList columns = line.split(QRegExp("\\s+"), QString::SkipEmptyParts);
        if (columns.count() < 6) // sanity check
            continue;

        QString dir = columns.at(1);
        dirs.append(dir);
    }

    return dirs;
}

