import Qt 4.7

Component {
    id: listDelegate
    Item {
        id: wrapper; width: wrapper.ListView.view.width; height: if(txt.height > 60){txt.height+10}else{60} //50+5+5
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

        Item {
            id: moveMe; height: parent.height
            Rectangle {
                id: blackRect
                color: "black"; opacity: wrapper.ListView.index % 2 ? 0.2 : 0.3; height: wrapper.height-2; width: wrapper.width; y: 1
            }
            Item {
                id: image; x: 6; width: 48; height: 48; smooth: true
                anchors.verticalCenter: parent.verticalCenter
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
                    + '<a href="app://@'+userName(name)+'"><b>'+userName(name) + "</b></a> from " +source
                    + "<br /><b>" + statusText + "</b></html>";
                textFormat: Qt.RichText
                color: "#cccccc"; style: Text.Raised; styleColor: "black"; wrapMode: Text.WordWrap
                anchors.left: image.right; anchors.right: blackRect.right; anchors.leftMargin: 6; anchors.rightMargin: 6
                onLinkActivated: wrapper.handleLink(link)
            }
        }
    }
}
