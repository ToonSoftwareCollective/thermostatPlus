//////  yaLabel :: Yet Anoter Label by JackV
//////  Based on : 'newTextLabel.qml' MODIFIED BUTTON BY OEPI-LOEPI for TOON
//////  So many thanks to OEPIE-LOEPI for 'newTextLabel.qml'
/*
JackV changes :
added 
    state selected + string buttonSelectedColor
        Reason :
            To highlight all selected options on a screen like on my daikin Controls.
            There I have up to 4 airco's with different modes, fan speeds etc.
            ( default: false and when true "yellow" )
            use with a variable to detect if button is selected like :
                buttonSelectedColor : "red"
                selected : ( ad == "3") ? true : false
    bool pixelsizeoverride + int pixelsizeoverridesize
        Reason :
            pixelSize was fixed, now supports different sizes of text on the buttons
            ( defaults: false and when true 20 )
    int buttonBorderWidth + string buttonBorderColor
        Reason :
            To give each button a configurable border
            ( defaults: 1 and "black" )
            
    bool hoveringEnabled
        Reason :
            hovering on Toon 1 leaves button hovered after touching and setting selected false.
            now when you use 'hoveringEnabled : isNxt' hovering will only work on Toon 2
            I use this in toonSmallHeating, daikin and other apps
            
    int buttonBorderRadius
        Reason :
            make it configurable so you can make nice rounded corners
            
removed
    fixed margins from anchors in buttonRect
        Reason : lef, right, top and bottom were fixed 5, now variable
*/

import QtQuick 2.1
import BasicUIControls 1.0

Item {
    id: yaLabel

    width                               : 430
    height                              : defaultHeight
    property int defaultHeight          : 36

    property string buttonText
    property alias  labelFontFamily     : labelTitle.font.family
    property alias  labelFontSize       : labelTitle.font.pixelSize
    property string buttonActiveColor   : "grey"
    property string buttonHoverColor    : "blue"
    property string buttonSelectedColor : "yellow"
    property string buttonDisabledColor : "lightgrey"
    property string textColor           : "black"
    property string textDisabledColor   : "grey"

    property bool selected              : false
    property bool pixelsizeoverride     : false
    property int pixelsizeoverridesize  : isNxt ? 20 : 16
    property bool hoveringEnabled       : true

    property string buttonBorderColor   : "black"
    property int buttonBorderWidth      : 1
    
    property int buttonBorderRadius : 5

    signal clicked()

    function doClick(){

        clicked();
    }

    Rectangle {
        id: buttonRect
        border {
            width: buttonBorderWidth
            color: buttonBorderColor
        }
        anchors {
            fill: parent
        }
        color: buttonActiveColor
        radius: buttonBorderRadius

        Text {
            id: labelTitle
            anchors {
                verticalCenter  : parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            font {
                family: qfont.semiBold.name
                //pixelSize: qfont.titleText
                pixelSize: yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16
            }
            text: buttonText
            color: yaLabel.enabled? textColor: textDisabledColor
        }

        state: yaLabel.enabled ? "active" : "disabled"

        Component.onCompleted: state = state

        states: [
            State {
                name: "hover"
                when: buttonArea.containsMouse || yaLabel.focus
                    PropertyChanges {
                        target  : buttonRect
                        color   : buttonHoverColor
                }
            },
            State {
                name: "active"
                when: yaLabel.enabled && !yaLabel.selected
                    PropertyChanges {
                        target  : buttonRect
                        color   : buttonActiveColor
                }
            },
            State {
                name: "selected"
                when: yaLabel.enabled && yaLabel.selected
                    PropertyChanges {
                        target  : buttonRect
                        color   : buttonSelectedColor
                }
            },
            State {
                name: "disabled"
                when: !yaLabel.enabled
                    PropertyChanges {
                        target  : buttonRect
                        color   : buttonDisabledColor
                }
            }
        ]
    }

    MouseArea {
        id              : buttonArea
        anchors.fill    : parent
        hoverEnabled    : hoveringEnabled
        onClicked       : doClick()
        cursorShape     : Qt.PointingHandCursor
    }

}
