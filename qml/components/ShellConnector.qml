/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 - 2015 Jens Klingen

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

import QtQuick 2.0
import harbour.space.inspector.shell 1.0
import "../js/IoTranslator.js" as IoTranslator
import "../js/Memory.js" as Memory
import "../js/Util.js" as Util

Item {

    property int subDirsMemoId: -1
    property int subNodesMemoId: -1

    Shell {
        id:subNodesShell
        command:IoTranslator.SubDirsWithSize.getCommand(nodeModel.dir)
        executeImmediately:true
        onExecuted: {
            var subNodes = IoTranslator.SubDirsWithSize.parseResult(response);
            // the response contains summarized information for the current directory, too. let's update our model with it.
            for(var i=0; i<subNodes.length; i++) {
                if(subNodes[i].dir === nodeModel.dir) {
                    nodeModel = subNodes.splice(i,1)[0];
                    break;
                }
            }
            subNodesMemoId = Memory.store(subNodes);
            onSubNodeInfoReceived();
        }
    }

    Shell {
        id:subDirsShell
        command:IoTranslator.SubDirs.getCommand(nodeModel.dir)
        executeImmediately:true
        onExecuted: {
            var subDirs = IoTranslator.SubDirs.parseResult(response);
            subDirsMemoId = Memory.store(subDirs);
            onSubNodeInfoReceived();
        }
    }

    function onSubNodeInfoReceived() {
        if(subDirsMemoId > -1 &&  subNodesMemoId > -1) {
            var subNodesWithSize = Memory.get(subNodesMemoId);
            var subDirs = Memory.get(subDirsMemoId);
            for(var i=0; i<subNodesWithSize.length; i++) {
                subNodesWithSize[i].isDir = (subDirs.indexOf(subNodesWithSize[i].dir) !== -1);
            }

            displayDirectoryList(subNodesWithSize);

            Memory.clear(subDirsMemoId);
            Memory.clear(subNodesMemoId);
            subDirsMemoId = -1;
            subNodesMemoId = -1;
        }
    }

    function refresh() {
        subNodesShell.execute();
        subDirsShell.execute();

    }
}
