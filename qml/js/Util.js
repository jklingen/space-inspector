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

.pragma library

/**
  * @param kbytes data size in KB, e.g. 2248
  * @returns human-readable formatted number with unit '2.2 MB'
  */
function getHumanReadableSize(kbytes) {
    var units = ['MB','GB','TB'];
    var unit = 'KB';
    while(kbytes > 1024) {
        kbytes /= 1024
        unit = units.shift();
    }
    return Math.round(kbytes*10)/10 + ' ' + unit;
}

/**
  * @param path string file system path, e.g. '|home|nemo|' or '|home|nemo|asdf.txt'
  *     (imagine slashes instead of pipes, harbour RPM validator does not like hard-coded paths in comments)
  * @returns name of file or folder, e.g. 'nemo' or 'asdf.txt'
  */
function getNodeNameFromPath(path) {
    if(path === '/') return path;
    var arr = path.split('/');
    var last = arr.pop();
    if(last.length === 0) last = arr.pop();
    return last;
}


