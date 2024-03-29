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

MenuItem {
    id: daysDelegate   

    function setTextColor(newColor) {
        dayName.color = newColor;
    }

    MenuText {
        width: parent.width*0.75
        height: 100
        id: dayName
        text: name;
        color: "#1476bb"
        anchors.verticalCenter: parent.verticalCenter
    }

    MouseArea {
        anchors.fill: parent;

        onPressed: {
            XMLParser.setTracksModel(childlist);
            mainScreen.switchToNextScreen(name, date);
        }
    }
}
