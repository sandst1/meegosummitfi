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
 *
 * This file incorporates work covered by the following copyright and
 * permission notice:
 *
 * ***************************************************************************
 * **
 * ** Copyright (C) 2010 Nokia Corporation and/or its subsidiary(-ies).
 * ** All rights reserved.
 * ** Contact: Nokia Corporation (qt-info@nokia.com)
 * **
 * ** This file is part of the examples of the Qt Toolkit.
 * **
 * ** $QT_BEGIN_LICENSE:BSD$
 * ** You may use this file under the terms of the BSD license as follows:
 * **
 * ** "Redistribution and use in source and binary forms, with or without
 * ** modification, are permitted provided that the following conditions are
 * ** met:
 * **   * Redistributions of source code must retain the above copyright
 * **     notice, this list of conditions and the following disclaimer.
 * **   * Redistributions in binary form must reproduce the above copyright
 * **     notice, this list of conditions and the following disclaimer in
 * **     the documentation and/or other materials provided with the
 * **     distribution.
 * **   * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
 * **     the names of its contributors may be used to endorse or promote
 * **     products derived from this software without specific prior written
 * **     permission.
 * **
 * ** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * ** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * ** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * ** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * ** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * ** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
 * ** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * ** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * ** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * ** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * ** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
 * ** $QT_END_LICENSE$
 * **
 * ****************************************************************************
 */
import Qt 4.7

Rectangle {
    id: container

    property alias text: label.text
    signal clicked

    color: "#AFAFAF"
    width: label.width + 50
    height: label.height + 15
    radius: 10

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        onClicked: { container.clicked() }
    }

    StyledText {
        id: label
        color: "black"
        anchors.centerIn: parent
    }

    states: State {
        name: "pressed"
        when: mouseArea.pressed
    }
}

