import Qt 4.7

// Thanks to Kunal Parmar for providing an example
// about screen switching with QML in his blog:
//
// http://kunalmaemo.blogspot.com/2010/12/simple-view-switching-animation-with-qt.html

Rectangle {
    id: screenSwitcher
    width: 480
    height: 800
    color: "#3A3A3C"

    property int curScreen: 0
    property int prevScreen: 0

    function loadScreen(screenNumber) {
        prevScreen = curScreen;
        curScreen = screenNumber;

        console.log("main.qml::loadScreen, prev screen: " + prevScreen + ", curScreen: " + curScreen);

        screens[prevScreen].hide();
        screens[curScreen].show();        
    }

    property list<Item> screens: [
        MainScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(1);
            }
        },
        DayScreen {
            parent: screenSwitcher
            onOpenNextScreen:  {
                screenSwitcher.loadScreen(2);
            }
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(0);
            }
        },
        TrackScreen {
            parent: screenSwitcher
            onOpenPrevScreen: {
                screenSwitcher.loadScreen(1);
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
