import QtQuick 2.1
import qb.components 1.0

Tile {
    id                              : thermostatPlusTile

// ---------------------------------------------------------------------

    property bool activeMe          : false
    property int buttonWidth        : isNxt ? 150 : 120
    property int buttonHeight       : isNxt ? 30 : 24

    property string activeColor     : "lightgrey"
    property string hoverColor      : "lightgrey"
    property string selectedColor   : "green"

    property int fireHeightBig      : isNxt ? 50 : 40
    property int fireHeightSmall    : fireHeightBig / 2

    property int fireHeight1        : fireHeightSmall
    property int fireWidth1         : isNxt ? 100 : 80

    property int fireHeight2        : fireHeightBig
    property int fireWidth2         : isNxt ? 100 : 80

    property int fireHeight3        : fireHeightSmall
    property int fireWidth3         : isNxt ? 100 : 80

    property string tempStr

// ----------------------------------------------- only run when visible

    onVisibleChanged: {
        if (visible) {
            switch(app.guiMode) {
                case 'Settings'         : { stage.openFullscreen(app.thermostatPlusSettingsUrl) ; break }
                case 'BackToControl'    : { stage.openFullscreen(app.thermostatPlusControlUrl)  ; break }
                default                 : { activeMe = true ; break }
            }
        } else {
            activeMe = false
        }
    }

// ------------------------------------------------------------- Control

    onClicked: {
        stage.openFullscreen(app.thermostatPlusControlUrl);
    }

// --------------------------------------------------------------- Timer

    Timer {
        id                      : controlTimer
        interval                : (app.mode == 'Master' ) ? 5000 : 10000
        running                 : activeMe
        repeat                  : true
        triggeredOnStart        : true
        onTriggered             : {

            app.getStatus("Timer")

            if (app.mode == 'Master' ) {
                app.setStatus("ProgramOnOff","off" )
                app.setStatus("Setpoint",app.currentSetpointInt/100)
            }

            if (app.mode == 'Local' ) {
                app.setStatus("RemoteProgramOnOff","off" )
                if (app.burnerInfo) { app.setStatus("RemoteSetpoint",30) }
                                else { app.setStatus("RemoteSetpoint",6) }
            }

            refreshScreen()
        }
    }

// ---------------------------------------------------------------- Fire

    Timer {
        id                      : fireTimer
        interval                : 5000
        running                 : ( activeMe && app.burnerInfo )
        repeat                  : true
        onTriggered             : {
            if (imgFire1.source == app.fireSmallTile ) {
                imgFire1.source = app.fireBigTile
                imgFire2.source = app.fireSmallTile
                imgFire3.source = app.fireBigTile
            } else {
                imgFire1.source = app.fireSmallTile
                imgFire2.source = app.fireBigTile
                imgFire3.source = app.fireSmallTile
            }
        }
    }

// ---------------------------------------------------------------------

    function refreshScreen() {

        if ( (app.mode == 'Mirror' ) || (app.mode == 'Master' ) ) {
            homeTemp.text           = '.'+app.currentTemp+'.'
        } else {
            homeTemp.text           = app.currentTemp
        }

        targetTemp.text             = app.currentSetpoint

        tempStr                     = app.temporaryLng[app.currentLng]

        programMessage1.text        = (app.programState == 2 && app.burnerInfo) ? tempStr + app.currentSetpoint : (app.nextState > -1 ) ? app.nextStateStr + " (" + app.nextSetpoint  : ""
        programMessageDegree.text   = ( (app.programState == 2 && app.burnerInfo) || (app.nextState > -1 ) ) ? "o" : ""
        programMessage2.text        = (app.programState == 2 && app.burnerInfo) ? " " : (app.nextState > -1 ) ? ") " + app.nextTime : ""

    }

// -------------------------------------------------------- Fire picture

    Image {
        id                      : imgFire1
        anchors {
            bottom              : imgFire2.bottom
            right               : imgFire2.left
            rightMargin         : -5
        }
        source                  : app.fireSmallTile
        visible                 : app.burnerInfo
    }

    Image {
        id                      : imgFire2
        anchors {
            bottom              : homeTemp.top
            horizontalCenter    : parent.horizontalCenter
            bottomMargin        : isNxt ? -25 : -20
        }
        source                  : app.fireBigTile
        visible                 : app.burnerInfo
    }

    Image {
        id                      : imgFire3
        anchors {
            bottom              : imgFire2.bottom
            left                : imgFire2.right
            leftMargin          : -5
        }
        source                  : app.fireSmallTile
        visible                 : app.burnerInfo
    }

// ---------------------------------------------------- Room temperature

    Text {
        id                      : homeTemp
        text                    : ""
        color                   : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
        anchors {
            horizontalCenter    : parent.horizontalCenter
            bottom              : currentSetpoint.top
            bottomMargin        : isNxt ? -10 : -8
        }
        font.pixelSize          : isNxt ? 100 : 80
        font.family             : qfont.italic.name
        font.bold               : true
    }

    Text {
        id                      : degree1
        text                    : "o"
        color                   : (typeof dimmableColors !== 'undefined') ? dimmableColors.clockTileColor : colors.clockTileColor
        anchors {
            top                 : homeTemp.top
            left                : homeTemp.right
            topMargin           : isNxt ? -5 : -4
            leftMargin          : isNxt ? 5 : 4
        }
        font.pixelSize          : isNxt ? 45 : 36
        font.family             : qfont.italic.name
        font.bold               : true
    }

// ----------------------------------------------------- currentSetpoint

    Rectangle {
        id                      : currentSetpoint
        height                  : buttonHeight
        width                   : buttonWidth
        anchors {
            bottom              : programMessage1.top
            horizontalCenter    : parent.horizontalCenter
        }
        border {
            width               : 1
            color               : "black"
        }
        radius                  : 5
        color                   : (app.programState > 0) ? selectedColor : activeColor

        Text {
            id                  : targetTemp
            text                : ""
            color               : (app.programState > 0) ? "white" : "black"
            anchors {
                verticalCenter  : parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            font.family         : qfont.italic.name
        }
    }

// --------------------------------------------------- Next Program text

// some text ;  degree symbol ; more text

    Text {
        id                      : programMessage1
        text                    : ""
        anchors {
            bottom              : parent.bottom
            left                : currentSetpoint.left
        }
        font {
            pixelSize           : isNxt ? 20 : 16
            family              : qfont.italic.name
            bold                : true
        }
        color                   : dimState ? "white" : "red"
    }

    Text {
        id                      : programMessageDegree
        text                    : ""
        anchors {
            bottom              : parent.bottom
            bottomMargin        : isNxt ? 10 : 8
            left                : programMessage1.right
            leftMargin          : isNxt ? 5 : 4
        }
        font {
            pixelSize           : isNxt ? 15 : 12
            family              : qfont.italic.name
            bold                : true
        }
        color                   : dimState ? "white" : "red"
    }

    Text {
        id                      : programMessage2
        text                    : ""
        anchors {
            bottom              : parent.bottom
            left                : programMessageDegree.right
        }
        font {
            pixelSize           : isNxt ? 20 : 16
            family              : qfont.italic.name
            bold                : true
        }
        color                   : dimState ? "white" : "red"
    }

// ---------------------------------------------------------------------

}
