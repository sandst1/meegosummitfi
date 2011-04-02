import Qt 4.7

// Thanks to Kunal Parmar for providing an example
// about screen switching with QML in his blog:
//
// http://kunalmaemo.blogspot.com/2010/12/simple-view-switching-animation-with-qt.html

Item {
    function isPortrait() {
        if ( parent.width < 500 ) {
            return true;
        }
        return false;
    }

    id: screen
    width: isPortrait() ? parent.width : parent.width * 0.55
    height: isPortrait() ? parent.height - 210 : parent.height
    x: isPortrait() ? -300 : 340
    y: isPortrait() ? 150 : -300
    opacity: 1
    property string name: ""
    property string date: ""

    signal openPrevScreen()
    signal openNextScreen(string screenName, string screenDate)

    function hide() {
        console.log("Screen.hide");
        screen.state = 'hide';
    }

    function show() {
        console.log("Screen.show");
        screen.state = 'show';
    }

    function switchToNextScreen (screenName, screenDate) {
        console.log("Screen switchToNextScreen")
        screen.openNextScreen(screenName, screenDate)
    }

    function switchToPrevScreen () {
        console.log("Screen switchToPrevScreen")
        screen.openPrevScreen()
    }    

    function setNameDate(name, date) {
        console.log("Screen SET NAME TO " + name + ", DATE TO " + date)
        screen.name = name
        screen.date = date
    }

    states : [
        State {
            name: "show"
            PropertyChanges {
                target: screen
                x: isPortrait() ? 0 : 340
                y: isPortrait() ? 150 : 0
                opacity: 1
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: screen
                x: isPortrait() ? -300 : x
                y: isPortrait() ? y : -300
                opacity: 0
            }
        }
    ]

    transitions: [
        Transition {
            from: "hide"
            to: "show"
            reversible: true
            NumberAnimation {
                properties: isPortrait() ? "x" : "y"
                duration: 200
            }
        },
        Transition {
            from: "show"
            to: "hide"
            reversible: true
            NumberAnimation {
                properties: isPortrait() ? "x" : "y"
                duration: 200
            }
        }
    ]
}
