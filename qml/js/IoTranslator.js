/*
    Space Inspector - a filesystem structure visualization for SailfishOS
    Copyright (C) 2014 - 2018 Jens Klingen

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

.pragma library

var SubDirsWithSize = {
    getCommand: function(path) {
        var command = 'du -a -B 1024 --max-depth=1 "' + path + '"';
        //console.debug(command);
        return command;
    },
    parseResult: function(response) {
        //console.debug(response);
        var ret = [];
        var dirlines = response.split('\n');
        for(var i=0; i<dirlines.length-1; i++) {
            var line = dirlines[i];
            var dirInfo = this._parseLine(line);
            if(dirInfo !== null) {
                ret.push(dirInfo);
            }
        }
        if(ret.length > 0) {
            ret.sort(function(a,b){return b.size - a.size})
        }
        return ret;
    },
    /**
     * @param line a single line of 'du' output
     * @returns object containg directory/file name and size, e.g. {'dir':'nemo', 'size':52347}
     */
    _parseLine: function(line) {
        var ret = null;
        var warn = false;
        if(line.match(/^[0-9]+\s+/)) {
            var firstSpaceIdx = line.search(/\s/);
            var dir = line.slice(firstSpaceIdx).trim();
            var size = parseInt(line.slice(0,firstSpaceIdx));
            ret = {'dir':dir, 'size':size};
        }
        return ret;
    }
};

var SubDirs = {
    getCommand: function(path) {
        var command = 'find  "' + path + '" -maxdepth 1 -type d';
        //console.debug(command);
        return command;
    },
    parseResult: function(response) {
        //console.debug(response);
        return response.split('\n');
    }
};

var DirSize = {
    getCommand: function(path) {
        var command = 'du -s -B 1024 "' + path + '"';
        //console.debug(command);
        return command;
    },
    parseResult: function(response) {
        return parseInt(res.substring(0,res.search(/\s/)-1));
    }
};

var FileSysInfo = {
    getCommand: function() {
        var command = 'df -B 1024 -h /';
        //console.debug(command);
        return command;
    },
    parseResult: function(response) {
        //console.debug(response);
        var ret = {};
        var lines = response.split('\n');
        var headers = lines[0].split(/\s+/);
        var values = lines[1].split(/\s+/);
        for(var i=0; i < headers.length; i++) {
            ret[headers[i]] = values[i];
        }
        return ret;
    }
};
