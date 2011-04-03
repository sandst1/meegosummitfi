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

Component {
    id: listDelegate
    Item {
        id: wrapper; width: wrapper.ListView.view.width; height: if(txt.height + user.height > 60){txt.height+user.height+10}else{60} //50+5+5
        function handleLink(link){
            if(link.slice(0,3) == 'app'){
                screen.setUser(link.slice(7));
            }else if(link.slice(0,4) == 'http'){
                Qt.openUrlExternally(link);
            }
        }
        function addTags(str){
            var ret = str.replace(/@[a-zA-Z0-9_]+/g, '<a href="app://$&">$&</a>');//click to jump to user?
            var ret2 = ret.replace(/http:\/\/[^ \n\t]+/g, '<a href="$&">$&</a>');//surrounds http links with html link tags
            return ret2;
        }

        // Strip away paranthesis
        function userName(str) {
            var user = str.replace(/\([\S|\s]*\)/gi, "");
            return user.trim();
        }

        function userDisplay(str){
            if (str.length>25){
                return userName(str);
            }
            else{
                return str;
            }
        }

        function displayTime(str){
            var tmp = str.replace(/T/," ")
            var tmp2 = tmp.replace(/Z/,"")
            var m_time = new Date(tmp2.replace(/-/g,"/"));
            //console.log(tmp2.replace(/-/g,"/"))

            //console.log(Qt.formatDateTime(m_time, "dd.MM.yy HH:mm"))

            return Qt.formatDateTime(m_time, "dd.MM.yy HH:mm")

        }

        Item {
            id: moveMe; height: parent.height
            Rectangle {
                id: blackRect
                color: "#181818"; opacity: wrapper.ListView.index % 2 ? 0.2 : 0.3; height: wrapper.height-2; width: wrapper.width; y: 1
            }
            Item {
                id: image; x: 6; width: 48; height: 48; smooth: true
//                anchors.verticalCenter: parent.verticalCenter
                anchors.top: parent.top
                Image {
                    x: 1; y: 1; width: 48; height: 48; visible: realImage.status != Image.Ready
                    id: loading; source: "../../images/loading.png"
                    NumberAnimation on rotation {
                        from: 0; to: 360; running: loading.visible == true; loops: Animation.Infinite; duration: 900
                    }
                }
                //Loading { x: 1; y: 1; width: 48; height: 48; visible: realImage.status != Image.Ready }
                Image {
                    id: realImage;
                    source: userImage; x: 1; y: 1;
                    width:48; height:48; opacity:0 ;
                    onStatusChanged: {
                        if(status==Image.Ready)
                            image.state="loaded"
                    }
                }
                states: State {
                    name: "loaded";
                    PropertyChanges { target: realImage ; opacity:1 }
                }
                transitions: Transition { NumberAnimation { target: realImage; property: "opacity"; duration: 200 } }

            }
            StyledText { id:txt; y:4; x: 56
                text: '<html><style type="text/css">a:link {color:"#552987"}; a:visited {color:"#57585b"}</style>'
                        + "<b>" + statusText + "</b></html>";
                textFormat: Qt.RichText
                color: "#cccccc"; style: Text.Raised; styleColor: "black"; wrapMode: Text.WordWrap
                anchors.left: image.right; anchors.right: blackRect.right; anchors.leftMargin: 6; anchors.rightMargin: 6
                onLinkActivated: wrapper.handleLink(link)
            }
            StyledText{
                id: user
                text: userDisplay(name)
                anchors.bottom: blackRect.bottom
                anchors.left: blackRect.left
                color:  "#57585b"
            }
            StyledText{
                id: time
                text: displayTime( timestamp)
                anchors.bottom: blackRect.bottom
                anchors.right: blackRect.right
                color:  "#57585b"
            }
        }
    }
}
