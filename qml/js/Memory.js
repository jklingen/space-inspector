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
 * Temporary storage for holding complex JavaScript objects for QML components.
 * Avoids serialization and deserialization for each read/write access, as well
 * as the problem of the represention of a complex JavaScript object in a QML
 * property is immutable.
 */
var nextId = 0;
var dataHolder = [];

/**
 * Stores a piece of data
 * @param data the data to store
 * @return memo ID which can be used to retrieve (or delete) the data later on
 */
function store(data) {
    dataHolder[nextId] = data;
    return nextId++;
}

/**
 * Retrieves a stored piece of data
 * @param id the memo ID returned by the initial call to `store`
 * @return stored data
 */
function get(id) {
    return dataHolder[id];
}

/**
 * Overwrites a stored piece of data
 * @param id the memo ID returned by the initial call to `store`
 * @param data the data to store
 */
function update(id, data) {
    dataHolder[id] = data;
}

/**
 * Deletes a stored piece of data
 * @param id the memo ID returned by the initial call to `store`
 */
function clear(id) {
    dataHolder[id] = null;
}
