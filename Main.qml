import QtQuick
import org.kde.plasma.core
import QtQuick.Controls
import org.kde.plasma.plasma5support as Plasma5Support

// MAME arcade game launcher

ApplicationWindow {
    id:root
    visible: true
    color:"black"
    width: 880
    height:900
    title: "Wizard Arcade"
    ///flags: Qt.FramelessWindowHint

    Shortcut {
        sequence: "Esc"
        onActivated: root.close()
    }

    FontLoader {
        id: appFontStyle
        source: "KomikaTitle.ttf"
    }

    readonly property string mameBin:"/usr/bin/mame "
    readonly property string romPath:"/home/data/Games/mame/"
    readonly property string gameIconsPath:"/home/data/Games/mame/game_icons/"

    readonly property var gameTitles:
    ["Pacman","Ms. Pacman","Donkey Kong","Donkey Kong Jr.","Frogger","DigDug","Kangaroo","Burger Time","Bowling","Tapper","Joust","Millipede","Robotron","Track & Field","Hyper Sports","Galaga","Gravitar","Asteroids","Lunar Lander","Stargate","Moon Patrol","Spy Hunter","Super Sprint","Pole Position II","Ridge Racer"]

    readonly property var gameRoms:
    ["pacman.zip","mspacman.7z","dkong.7z","dkongjr.7z","frogger.7z","digdug.7z","kangaroo.7z","btime.7z","wcbowl.7z","tapper.7z","joust.7z","milliped.7z","robotron.7z","trackfld.7z","hyperspt.7z","galaga.7z","gravitar.zip","asteroid.7z","llander.zip","stargate.7z","mpatrol.7z","spyhunt.7z","ssprint.7z","polepos2","ridgerac.7z"]

    readonly property var gameIcons: ["pacman.png","mspacman.png","dkong.png","dkongjr.png","frogger.png","digdug.png","kangaroo.jpeg","burgertime SD.png","wcbowl140.png","tapper.png","joust.jpg","milllipede.jpg","robotron0001.png","track _field.png","hpolym84.png","galaga.png","gravitar.png","astroids.jpg","lunar lander.png","stargate.png","moon-patrol.png","spy-hunter-mame-cover-340x483.jpg","super sprint SD 2.png","pole position II SD.png","ridgeRacer.jpg"]


    Image {
        id:rootBackground
        anchors.fill:parent
        source:"grill.jpg"
        smooth:true
        opacity:.55
        //fillMode : Image.Fit
    }

        Text {
            id:title
            anchors.horizontalCenter:rootBackground.horizontalCenter
            anchors.top:rootBackground.top
            anchors.topMargin:15
            text:"Wizard Arcade"
            font.pointSize:28
            font.family:"Komika Title";
            color:"white"
            antialiasing:true
        }

        GridView {
            id:l1
            anchors.top:title.bottom
            anchors.left:rootBackground.left
            anchors.topMargin:20
            anchors.leftMargin:60
            width:root.width
            height:root.height-title.height
            cellWidth: 160; cellHeight: 160
            focus: true
            model:gameRoms.length
            delegate:

            Rectangle {
                width:124
                height:124
                color:"transparent"
                border.color:"lightgray"
                border.width:2
                radius:8
                smooth:true
                antialiasing:true

                Image {
                    source:gameIconsPath+gameIcons[index]
                    anchors.centerIn:parent
                    width:112
                    height:112
                    smooth:true
                    antialiasing:true
                }

                MouseArea {
                    id:ma
                    anchors.fill: parent
                    cursorShape:  Qt.PointingHandCursor
                    acceptedButtons: Qt.LeftButton | Qt.MiddleButton
                    hoverEnabled:true
                    onEntered:{
                        parent.border.color="#0087c5"
                        gameT1.color="orange" }
                    onExited: {
                        parent.border.color="lightgray"
                        gameT1.color="white" }
                    onClicked: {
                         //cursorShape=Qt.BlankCursor
                         executable.exec(mameBin+romPath+gameRoms[index])

                    }
                }

                Text{
                    id:gameT1
                    text:gameTitles[index]
                    color:"white"
                    //font.family:"Noto Sans";
                    font.pointSize:12
                    font.bold:true
                    anchors.top:parent.bottom
                    anchors.horizontalCenter:parent.horizontalCenter
                    anchors.topMargin:5
                    antialiasing:true

                }
            }
        }

        Plasma5Support.DataSource {
            id: executable
            engine: "executable"
            connectedSources: []
            onNewData: {
                let exitCode = data["exit code"]
                let exitStatus = data["exit status"]
                let stdout = data["stdout"]
                let stderr = data["stderr"]
                exited(exitCode, exitStatus, stdout, stderr)
                disconnectSource(sourceName) // cmd finished
            }
            function exec(cmd) {
                connectSource(cmd)
            }
            signal exited(int exitCode, int exitStatus, string stdout, string stderr)
        }
}
