/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 Jens Klingen

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#ifndef SHELL_H
#define SHELL_H
#include <QObject>
#include <QProcess>
#include <QQmlParserStatus>
class Shell : public QObject, public QQmlParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QQmlParserStatus)
    Q_PROPERTY(QString command READ command WRITE setCommand)
public:
    Shell(QObject *parent = 0);

    QString command() const;
    void setCommand(const QString &);

    virtual void componentComplete()
    {
        execute(m_command);
    }
    virtual void classBegin()
    {
    }

private:
    QProcess *m_process;
    QString m_command;
    void execute(QString command);
signals:
    QString executed(const QString &response);
private slots:
     void processFinishedHandler(int signum);

};

#endif
