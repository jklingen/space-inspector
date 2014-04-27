/*
    From Kari's excellent File Browser, which has been released into the public domain.
    See https://github.com/karip/harbour-file-browser
*/

#ifndef GLOBALS_H
#define GLOBALS_H

#include <QString>
#include <QDateTime>
#include <QDir>
#include "statfileinfo.h"

// Global functions

QString suffixToIconName(QString suffix);
QString permissionsToString(QFile::Permissions permissions);
QString filesizeToString(qint64 filesize);
QString datetimeToString(QDateTime datetime);

QString infoToIconName(const StatFileInfo &info);

int access(QString filename, int how);

QString execute(QString command, QStringList arguments, bool mergeErrorStream);

#endif // GLOBALS_H
