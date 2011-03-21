import Qt 4.7

// Thanks to Kunal Parmar for providing an example
// about screen switching with QML in his blog:
//
// http://kunalmaemo.blogspot.com/2010/12/simple-view-switching-animation-with-qt.html

Item {
    id: screen
    width: parent.width
    height: parent.height
    opacity: 1

    signal openPrevScreen()
    signal openNextScreen()

    function hide() {
        console.log("Screen.hide");
        screen.state = 'hide';
    }

    function show() {
        console.log("Screen.show");
        screen.state = 'show';
    }

    function switchToNextScreen () {
        console.log("Screen switchToNextScreen")
        screen.openNextScreen()
    }

    function switchToPrevScreen () {
        console.log("Screen switchToPrevScreen")
        screen.openPrevScreen()
    }

    states : [
        State {
            name: "show"
            PropertyChanges {
                target: screen
                x: 0
                opacity: 1
            }
        },
        State {
            name: "hide"
            PropertyChanges {
                target: screen
                x: -100
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
                properties: "x"
                duration: 200
            }
        }
    ]
}
