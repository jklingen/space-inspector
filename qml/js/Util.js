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
    if(!path) throw "Path may not be null";
    if(path === '/') return path;
    var arr = path.split('/');
    var last = arr.pop();
    if(last.length === 0) last = arr.pop();
    return last;
}

/**
 * Decides whether we can assume that the file will be handled by the operating system, depending solely on file extension.
 */
function canHandleFile(path) {
    if(!path) throw "Path may not be null";
    var supported = ['mp3','mp4','jpeg','jpg','pdf','html'];
    var ext = getFileExtension(path);
    if(ext && ext.length < 5) {
        ext = ext.toLowerCase();
        for(var i=0;i<supported.length; i++) {
            if(supported[i] === ext) return true;
        }
    }
    return false;
}

/**
 * Extracts file extension from path.
 * The portion after the last "." in the filename is considered to be an extension,
 * (ecxept when the last dot is the first character of the filename.
 * Returns null if the file does not have an extension.
 */
function getFileExtension(path) {
    var nodeName = getNodeNameFromPath(path);
    var dotIdx = nodeName.lastIndexOf(".");
    return dotIdx>0 ? nodeName.substring(dotIdx + 1) : null;
}

/**
 * Hashes a string to a number where 0 <= ret < 1
 */
function getNormalizedHash(str) {
    var ret = 0;
    if(str) {
      str = str.toLowerCase();

      for (var i = 0; i < str.length; i++) {
            var c = str.charCodeAt(i);
            if(c>=97 && c<123) c -= 97; //a-z will be 0-25
            else if(c>=48 && c<58) c-= 18; // 0-9 will be 26-35
            //console.log("should be between 0 and 35: "+c)
            c = c/35*0.9 // normalize each to be between 0 and 0.9
            //console.log("should be between 0 and 0.9: "+c)
            c /= Math.pow(10,i) // 1st letter has more influence than 2nd
            //console.log(c);
            ret += c
        }
      }
      //console.log(str+"--->"+ret)
      return ret
}



