import Qt 4.7

// Thanks to Kunal Parmar for providing an example
// about screen switching with QML in his blog:
//
// http://kunalmaemo.blogspot.com/2010/12/simple-view-switching-animation-with-qt.html

Rectangle {
    function orientationChanged(orientation) {
/*
        console.log("main.qml::orientationChanged " + orientation);
        console.log("main.qml::orientationChanged " + screenSwitcher.width+":"+screenSwitcher.height);
        if (orientation == 1){
            screenSwitcher.width = 800
            screenSwitcher.height = 480
            screens[curScreen].width = screenSwitcher.width
            screens[curScreen].height = screenSwitcher.height
            screens[curScreen].y = 0;
        }
        else if (orientation == 3 ){
            var tmp = screenSwitcher.width;
            screenSwitcher.width = 480
            screenSwitcher.height = 800
            screens[curScreen].width = screenSwitcher.width
            screens[curScreen].height = screenSwitcher.height - 150
            screens[curScreen].y = 150;
        }
        */
    }

    id: screenSwitcher
    width: 480
    height: 800
    color: "#3A3A3C"

    property int curScreen: 0
    property int prevScreen: 0

    Image {
        id: summitLogo
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        source: "../../images/summit_logo.png"
        width: 324
        height: 150
    }

    function loadScreen(goingFwd, screenNumber, screenName, screenDate) {
        prevScreen = curScreen;
        curScreen = screenNumber;

        console.log("main.qml::loadScreen, prev screen: " + prevScreen + ", curScreen: " + curScreen);

        screens[prevScreen].hide();
        screens[curScreen].show();
        if ( goingFwd ) {
            screens[curScreen].setNameDate(screenName, screenDate)
        }
    }

    property list<Item> screens: [
        MainScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(true, 1, screenName, screenDate);
            }
        },
        DayScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(true, 2, screenName, screenDate);
            }
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 0);
            }
        },
        TrackScreen {
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(false, 1);
            }
        }
        //SessionScreen {}
    ]

    Component.onCompleted: {
        console.log("ScreenSwitcher ready");
        screenSwitcher.curScreen = 0;
        screenSwitcher.prevScreen = 0;
        for (var i = 0; i < 3; i++ ) {
            screens[i].hide();
        }

        screens[0].show();
    }
}
