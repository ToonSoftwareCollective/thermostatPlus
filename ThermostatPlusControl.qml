import QtQuick 2.1
import qb.components 1.0

Screen {
    id                              : thermostatPlusFulControll

// ---------------------------------------------------------------------

    property bool activeMe          : false

    property int buttonWidth        : isNxt ? 160 : 128
    property int buttonHeight       : isNxt ? 50 : 40

    property int tempWidth          : isNxt ? 80 : 64
    property int tempHeight         : isNxt ? 80 : 64

    property int fireHeightBig      : isNxt ? 100 : 80
    property int fireHeightSmall    : fireHeightBig / 2

    property int fireHeight1        : fireHeightSmall
    property int fireWidth1         : isNxt ? 135 : 108

    property int fireHeight2        : fireHeightBig
    property int fireWidth2         : isNxt ? 135 : 108

    property int fireHeight3        : fireHeightSmall
    property int fireWidth3         : isNxt ? 135 : 108

    property string activeColor     : "lightgrey"
    property string hoverColor      : "lightgrey"
    property string selectedColor   : "green"
    property string halfselectedColor   : "lime" // for program button when programState == 2

    property string tempStr
    property string programOnStr
    property string programOffStr

// ----------------------------------------------- only run when visible

    onVisibleChanged: {
        if (visible) {
            app.setscheduleIndex()
            app.guiMode = 'Control'
            activeMe = true
        } else {
            app.saveSettings()
            activeMe = false
        }
    }

// --------------------------------------------------------------- Timer

    Timer {
        id                      : controlTimer
        interval                : 5000
        running                 : activeMe
        repeat                  : true
        triggeredOnStart        : true
        onTriggered             : {
            if (dimState) (hide())

            app.runProgram()

            refreshScreen()
        }
    }

    Timer {
        id                      : fireTimer
        interval                : 1000
        running                 : ( activeMe && app.burnerInfo )
        repeat                  : true
        onTriggered             : {
            if (imgFire1.source == app.fireSmallControl ) {
                imgFire1.source = app.fireBigControl
                imgFire2.source = app.fireSmallControl
                imgFire3.source = app.fireBigControl
            } else {
                imgFire1.source = app.fireSmallControl
                imgFire2.source = app.fireBigControl
                imgFire3.source = app.fireSmallControl
            }
        }
    }

// ------------------------------------------------------- refreshScreen

    function refreshScreen() {

        if ( (app.mode == 'Mirror' ) || (app.mode == 'Master' ) ) {
            homeTemp.text               = '.'+app.currentTemp+'°.'
        } else {
            homeTemp.text               = app.currentTemp+'°'
        }

        targetTemp.text             = app.currentSetpoint + "°"

        tempStr                     = app.temporaryLng[app.currentLng]

        programMessage1.text        = (app.programState == 2 && app.burnerInfo) ? tempStr + " " + app.currentSetpoint + "°" : (app.nextState > -1 ) ? app.nextStateStr + " (" + app.nextSetpoint  + "°) " + app.nextTime : ""

        modeMessage.text            = app.mode

        programComfort.buttonText   = app.statesLng[app.currentLng][0]
        programComfort.selected     = app.activeState == 0
        programHome.buttonText      = app.statesLng[app.currentLng][1]
        programHome.selected        = app.activeState == 1
        programSleep.buttonText     = app.statesLng[app.currentLng][2]
        programSleep.selected       = app.activeState == 2

        programAway.buttonText      = app.statesLng[app.currentLng][3]
        programAway.selected        = app.activeState == 3

        programOnStr                = app.programOnOffLng[app.currentLng][0]
        programOffStr               = app.programOnOffLng[app.currentLng][1]

        programOnOff.buttonText     = (app.programState > 0) ? programOnStr : programOffStr
        programOnOff.selected       = app.programState > 0

        temp6.selected              = ( ( app.currentSetpointInt >= (  550 ) ) && ( app.currentSetpointInt < (  650 ) ) )
        temp7.selected              = ( ( app.currentSetpointInt >= (  650 ) ) && ( app.currentSetpointInt < (  750 ) ) )
        temp8.selected              = ( ( app.currentSetpointInt >= (  750 ) ) && ( app.currentSetpointInt < (  850 ) ) )
        temp9.selected              = ( ( app.currentSetpointInt >= (  850 ) ) && ( app.currentSetpointInt < (  950 ) ) )
        temp10.selected             = ( ( app.currentSetpointInt >= (  950 ) ) && ( app.currentSetpointInt < ( 1050 ) ) )
        temp11.selected             = ( ( app.currentSetpointInt >= ( 1050 ) ) && ( app.currentSetpointInt < ( 1150 ) ) )
        temp12.selected             = ( ( app.currentSetpointInt >= ( 1150 ) ) && ( app.currentSetpointInt < ( 1250 ) ) )
        temp13.selected             = ( ( app.currentSetpointInt >= ( 1250 ) ) && ( app.currentSetpointInt < ( 1350 ) ) )
        temp14.selected             = ( ( app.currentSetpointInt >= ( 1350 ) ) && ( app.currentSetpointInt < ( 1450 ) ) )
        temp15.selected             = ( ( app.currentSetpointInt >= ( 1450 ) ) && ( app.currentSetpointInt < ( 1550 ) ) )
        temp16.selected             = ( ( app.currentSetpointInt >= ( 1550 ) ) && ( app.currentSetpointInt < ( 1650 ) ) )
        temp17.selected             = ( ( app.currentSetpointInt >= ( 1650 ) ) && ( app.currentSetpointInt < ( 1750 ) ) )
        temp18.selected             = ( ( app.currentSetpointInt >= ( 1750 ) ) && ( app.currentSetpointInt < ( 1850 ) ) )
        temp19.selected             = ( ( app.currentSetpointInt >= ( 1850 ) ) && ( app.currentSetpointInt < ( 1950 ) ) )
        temp20.selected             = ( ( app.currentSetpointInt >= ( 1950 ) ) && ( app.currentSetpointInt < ( 2050 ) ) )
        temp21.selected             = ( ( app.currentSetpointInt >= ( 2050 ) ) && ( app.currentSetpointInt < ( 2150 ) ) )
        temp22.selected             = ( ( app.currentSetpointInt >= ( 2150 ) ) && ( app.currentSetpointInt < ( 2250 ) ) )
        temp23.selected             = ( ( app.currentSetpointInt >= ( 2250 ) ) && ( app.currentSetpointInt < ( 2350 ) ) )
        temp24.selected             = ( ( app.currentSetpointInt >= ( 2350 ) ) && ( app.currentSetpointInt < ( 2450 ) ) )
        temp25.selected             = ( ( app.currentSetpointInt >= ( 2450 ) ) && ( app.currentSetpointInt < ( 2550 ) ) )
        temp26.selected             = ( ( app.currentSetpointInt >= ( 2550 ) ) && ( app.currentSetpointInt < ( 2650 ) ) )
        temp27.selected             = ( ( app.currentSetpointInt >= ( 2650 ) ) && ( app.currentSetpointInt < ( 2750 ) ) )
        temp28.selected             = ( ( app.currentSetpointInt >= ( 2750 ) ) && ( app.currentSetpointInt < ( 2850 ) ) )
        temp29.selected             = ( ( app.currentSetpointInt >= ( 2850 ) ) && ( app.currentSetpointInt < ( 2950 ) ) )
        temp30.selected             = ( ( app.currentSetpointInt >= ( 2950 ) ) && ( app.currentSetpointInt < ( 3050 ) ) )

    }

// ----------------------------------------------------- Program buttons

    YaLabel {
        id                      : programComfort
        buttonText              :  ""
        height                  : buttonHeight
        width                   : buttonWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        selected                : false
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            top                 : temp26.top
            left                : parent.left
            leftMargin          : tempWidth
            topMargin           : isNxt ? 10 : 8
        }
        onClicked: {
            app.setStatus("ProgramButton","Comfort")
            app.getStatus("All")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : programHome
        buttonText              :  ""
        height                  : buttonHeight
        width                   : buttonWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        selected                : false
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            top                 : programComfort.bottom
            horizontalCenter    : programComfort.horizontalCenter
            topMargin           : isNxt ? 10 : 8
        }
        onClicked: {
            app.setStatus("ProgramButton","Home")
            app.getStatus("All")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : programSleep
        buttonText              :  ""
        height                  : buttonHeight
        width                   : buttonWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        selected                : false
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            top                 : programHome.bottom
            horizontalCenter    : programComfort.horizontalCenter
            topMargin           : isNxt ? 10 : 8
        }
        onClicked: {
            app.setStatus("ProgramButton","Sleep")
            app.getStatus("All")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : programAway
        buttonText              :  ""
        height                  : buttonHeight
        width                   : buttonWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        selected                : false
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            top                 : programSleep.bottom
            horizontalCenter    : programComfort.horizontalCenter
            topMargin           : isNxt ? 10 : 8
        }
        onClicked: {
            app.setStatus("ProgramButton","Away")
            app.getStatus("All")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : programOnOff
        buttonText              : ""
        height                  : buttonHeight
        width                   : buttonWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : ( app.programState == 1 ) ? selectedColor : halfselectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        selected                : false
        textColor               : "black"
        anchors {
            top                 : programAway.bottom
            horizontalCenter    : programComfort.horizontalCenter
            topMargin           : isNxt ? 20 : 16
        }
        onClicked: {
            if (app.programState == 1) {
                app.programState = 0
            } else {
                app.programState = 1
                app.programStateOverruleCounter = 0
                app.setStatus("Program", app.activeStateText )
            }
            app.saveSettings()
            app.runProgram()
            refreshScreen()
        }
    }

// -------------------------------------------------------- Fire picture

    Image {
        id: imgFire1
        anchors {
            bottom              : imgFire2.bottom
            right               : imgFire2.left
            rightMargin         : isNxt ? -10 : -8
        }
        source                  : app.fireSmallControl
        visible                 : app.burnerInfo
    }

    Image {
        id: imgFire2
        anchors {
            horizontalCenter    : homeTemp.horizontalCenter
            bottom              : homeTemp.top
        }
        source                  : app.fireBigControl
        visible                 : app.burnerInfo
    }

    Image {
        id: imgFire3
        anchors {
            bottom              : imgFire2.bottom
            left                : imgFire2.right
            leftMargin          : isNxt ? -10 : -8
        }
        source                  : app.fireSmallControl
        visible                 : app.burnerInfo
    }

// ---------------------------------------------------- Room temperature

    Text {
        id                      : homeTemp
        text                    : ""
        color                   : "grey"
        anchors {
            left                : programSleep.right
            bottom              : programSleep.bottom
            leftMargin          : isNxt ? 30 : 24
        }
        font.pixelSize          : isNxt ? 100 : 80
        font.family             : qfont.italic.name
        font.bold               : true
    }

// --------------------------------------------------- Next Program text

// some text ;  degree symbol ; more text

    Text {
        id                      : programMessage1
        text                    : ""
        anchors {
            left                : programComfort.right
            leftMargin          : isNxt ? 30 : 24
            verticalCenter      : programOnOff.verticalCenter
        }
        font {
            pixelSize           : isNxt ? 20 : 16
            family              : qfont.italic.name
            bold                : true
        }
        color                   : "red"
    }

// ------------------------------------------------------------- Up Down

    YaLabel {
        id                      : tempDown
        buttonText              :  ""
        height                  : tempHeight * 0.7
        width                   : tempWidth  * 0.7
        buttonBorderWidth       : 0
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        selected                : false
        enabled                 : true
        textColor               : "black"
        anchors {
            bottom              : temp6.bottom
            left                : programComfort.right
            leftMargin          : isNxt ? 30 : 24
        }
        Image {
            id                  : imgDown
            source              : app.downImg
            anchors {
                top             : parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }
        onClicked: {
            app.setStatus("Setpoint","down")
            app.getStatus("Control")
            refreshScreen()
        }
    }

    Text {
        id                      : targetTemp
        text                    : ""
        color                   : "black"
        anchors {
            verticalCenter      : tempDown.verticalCenter
            left                : tempDown.right
            leftMargin          : isNxt ? 5 : 4
        }
        font.pixelSize          : isNxt ? 50 : 40
        font.family             : qfont.italic.name
        font.bold               : true
    }

    YaLabel {
        id                      : tempUp
        buttonText              :  ""
        height                  : tempHeight * 0.7
        width                   : tempWidth  * 0.7
        buttonBorderWidth       : 0
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        selected                : false
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            verticalCenter      : tempDown.verticalCenter
            left                : targetTemp.right
        }
        Image {
            id                  : imgUp
            source              : app.upImg
            anchors {
                top             : parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }
        onClicked: {
            app.setStatus("Setpoint","up")
            app.getStatus("Control")
            refreshScreen()
        }
    }

// ------------------------------------------------------------ Settings

    YaLabel {
        id                      : settingsButton
        buttonText              : ""
        buttonBorderWidth       : 0
        height                  : buttonHeight
        width                   : buttonHeight
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        anchors {
            top                 : programOnOff.bottom
            left                : programOnOff.left
            topMargin           : buttonHeight
        }
        onClicked: {
            app.guiMode = 'Settings'
            hide()
        }

        Image {
            id                  : imgSettings
            source              : "file:///qmf/qml/apps/thermostatPlus/drawables/settings.png"
            anchors {
                top             : parent.top
                horizontalCenter: parent.horizontalCenter
            }
        }

    }

// ----------------------------------------- Temperature 26..30

    YaLabel {
        id                      : temp26
        buttonText              :  "26"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp21.top
            left                : temp21.left
        }
        onClicked: {
            app.setStatus("Setpoint",2600)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp27
        buttonText              :  "27"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp26.bottom
            left                : temp26.right
        }
        onClicked: {
            app.setStatus("Setpoint",2700)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp28
        buttonText              :  "28"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp27.bottom
            left                : temp27.right
        }
        onClicked: {
            app.setStatus("Setpoint",2800)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp29
        buttonText              :  "29"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp28.bottom
            left                : temp28.right
        }
        onClicked: {
            app.setStatus("Setpoint",2900)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp30
        buttonText              :  "30"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp29.bottom
            left                : temp29.right
        }
        onClicked: {
            app.setStatus("Setpoint",3000)
            app.getStatus("Control")
            refreshScreen()
        }
    }

// ----------------------------------------- Temperature 21..25

    YaLabel {
        id                      : temp21
        buttonText              :  "21"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp16.top
            left                : temp16.left
        }
        onClicked: {
            app.setStatus("Setpoint",2100)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp22
        buttonText              :  "22"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp21.bottom
            left                : temp21.right
        }
        onClicked: {
            app.setStatus("Setpoint",2200)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp23
        buttonText              :  "23"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp22.bottom
            left                : temp22.right
        }
        onClicked: {
            app.setStatus("Setpoint",2300)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp24
        buttonText              :  "24"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp23.bottom
            left                : temp23.right
        }
        onClicked: {
            app.setStatus("Setpoint",2400)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp25
        buttonText              :  "25"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp24.bottom
            left                : temp24.right
        }
        onClicked: {
            app.setStatus("Setpoint",2500)
            app.getStatus("Control")
            refreshScreen()
        }
    }

// ----------------------------------------- Temperature 16..20

    YaLabel {
        id                      : temp16
        buttonText              :  "16"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp11.top
            left                : temp11.left
        }
        onClicked: {
            app.setStatus("Setpoint",1600)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp17
        buttonText              :  "17"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp16.bottom
            left                : temp16.right
        }
        onClicked: {
            app.setStatus("Setpoint",1700)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp18
        buttonText              :  "18"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp17.bottom
            left                : temp17.right
        }
        onClicked: {
            app.setStatus("Setpoint",1800)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp19
        buttonText              :  "19"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp18.bottom
            left                : temp18.right
        }
        onClicked: {
            app.setStatus("Setpoint",1900)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp20
        buttonText              :  "20"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp19.bottom
            left                : temp19.right
        }
        onClicked: {
            app.setStatus("Setpoint",2000)
            app.getStatus("Control")
            refreshScreen()
        }
    }

// ----------------------------------------- Temperature 11..15

    YaLabel {
        id                      : temp11
        buttonText              :  "11"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp6.top
            left                : temp6.left
        }
        onClicked: {
            app.setStatus("Setpoint",1100)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp12
        buttonText              :  "12"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp11.bottom
            left                : temp11.right
        }
        onClicked: {
            app.setStatus("Setpoint",1200)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp13
        buttonText              :  "13"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp12.bottom
            left                : temp12.right
        }
        onClicked: {
            app.setStatus("Setpoint",1300)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp14
        buttonText              :  "14"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp13.bottom
            left                : temp13.right
        }
        onClicked: {
            app.setStatus("Setpoint",1400)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp15
        buttonText              :  "15"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp14.bottom
            left                : temp14.right
        }
        onClicked: {
            app.setStatus("Setpoint",1500)
            app.getStatus("Control")
            refreshScreen()
        }
    }

// ----------------------------------------- Temperature 6..10

    YaLabel {
        id                      : temp6
        buttonText              :  "6"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp7.bottom
            right               : temp7.left
        }
        onClicked: {
            app.setStatus("Setpoint",600)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp7
        buttonText              :  "7"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp8.bottom
            right               : temp8.left
        }
        onClicked: {
            app.setStatus("Setpoint",700)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp8
        buttonText              :  "8"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp9.bottom
            right               : temp9.left
        }
        onClicked: {
            app.setStatus("Setpoint",800)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp9
        buttonText              :  "9"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : temp10.bottom
            right               : temp10.left
        }
        onClicked: {
            app.setStatus("Setpoint",900)
            app.getStatus("Control")
            refreshScreen()
        }
    }

    YaLabel {
        id                      : temp10
        buttonText              :  "10"
        height                  : tempHeight
        width                   : tempWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        enabled                 : true
        hoveringEnabled         : isNxt
        textColor               : "black"
        anchors {
            bottom              : parent.bottom
            right               : parent.right
            rightMargin         : tempWidth
            bottomMargin        : tempHeight
      }
        onClicked: {
            app.setStatus("Setpoint",1000)
            app.getStatus("Control")
            refreshScreen()
        }
    }

// -------------------------------------------------------- mode message

    Text {
        id                      : modeMessage
        text                    : app.mode
        anchors {
            right               : parent.right
            bottom              : parent.bottom
            rightMargin         : tempWidth
        }
        font {
            pixelSize           : isNxt ? 20 : 16
            family              : qfont.italic.name
            bold                : true
        }
        color                   : "black"
    }

// ---------------------------------------------------------------------

}
