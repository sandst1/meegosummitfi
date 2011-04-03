/*
 * MeeGoSummitFI - Timetable application for MeeGo Summit Finland
 * Copyright (C) 2011 Topi Santakivi <topi.santakivi@gmail.com>
 * Copyright (C) 2011 Mikko Rosten <mikko.rosten@iki.fi>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import Qt 4.7

Dialog {
    id: container

    function showResult(message) {
        container.setText(message)
        resultTimer.start()        
    }

    Timer {
        id: resultTimer
        interval: 1500; running: false; repeat: false
        onTriggered: {
            container.hide()
            updateXMLBtn.visible = true
        }
    }

    Connections {
        target: XMLParser
        onDataAvailable: container.showResult("Program updated")
        onDataUpdateFailed: container.showResult("Program download failed")
    }

}
