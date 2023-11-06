//////  yaLabel :: Yet Anoter Label by JackV
//////  Based on : 'newTextLabel.qml' MODIFIED BUTTON BY OEPI-LOEPI for TOON
//////  So many thanks to OEPIE-LOEPI for 'newTextLabel.qml'
/*


JackV changes :
added 
     string buttonText2         : ""
     bool buttonText2Stack      : false // default is buttonText and buttonText2 next to each other 
     bool buttonText2Active     : false // default is buttonText active
     bool buttonText2Swap       : false // default is that buttonText and buttonText2 do not swap place
     fixed in code : buttonText2 size = 0.75 * buttonText size
        Reason :
            Support a toggle button with 2 text values
            Example in the app life in LifeScreen.qml

    real lineHeightSize         : 1.0
        Reason : line spacing for text containing "\n" characters
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
    property real lineHeightSize        : 1.0
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
    
    property int buttonBorderRadius     : 5

    property string buttonText2         : ""
    property bool buttonText2Stack      : false
    property bool buttonText2Active     : false
    property bool buttonText2Swap       : false

    onButtonText2ActiveChanged: {
        selected = buttonText2Active
    }
        //                pixelSize: ( (!buttonText2Active || buttonText2Swap) ? 1 : 0.75) * ( yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16 )
    
    signal clicked()

    function doClick(){
        if (buttonText2 != "") { buttonText2Active =! buttonText2Active}
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
            visible: (buttonText2 == "")
            anchors {
                verticalCenter: parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            font {
                family: qfont.semiBold.name
                //pixelSize: qfont.titleText
                pixelSize:  yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16
            }
            text: buttonText
            lineHeight : yaLabel.lineHeightSize
            color: yaLabel.enabled? textColor: textDisabledColor
        }

        Text {
            id: labelTitleHorizontal
            visible: (!buttonText2Stack && (buttonText2 != ""))
            anchors {
                right           : parent.horizontalCenter
                verticalCenter  : parent.verticalCenter
            }
            font {
                family: qfont.semiBold.name
                //pixelSize: qfont.titleText
                pixelSize: ( (!buttonText2Active || buttonText2Swap) ? 1 : 0.75) * ( yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16 )
            }
            text: (buttonText2Active && buttonText2Swap) ? buttonText2 : buttonText
            lineHeight : yaLabel.lineHeightSize
            color: yaLabel.enabled? textColor: textDisabledColor
        }

        Text {
            id: labelTitleVertical
            visible: (buttonText2Stack && (buttonText2 != ""))
            anchors {
                horizontalCenter: parent.horizontalCenter
                bottom: parent.verticalCenter
            }
            font {
                family: qfont.semiBold.name
                //pixelSize: qfont.titleText
                pixelSize: ( (!buttonText2Active || buttonText2Swap) ? 1 : 0.75) * ( yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16 )
            }
            text: (buttonText2Active && buttonText2Swap) ? buttonText2 : buttonText
            lineHeight : yaLabel.lineHeightSize
            color: yaLabel.enabled? textColor: textDisabledColor
        }

        Text {
            id: labelTitle2Vertical
            visible: (buttonText2Stack && (buttonText2 != ""))
            anchors {
                top             : parent.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }
            font {
                family: labelFontFamily
                //pixelSize: qfont.titleText
                pixelSize: ( (buttonText2Active && ! buttonText2Swap) ? 1 : 0.75) * ( yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16 )
            }
            text: (buttonText2Active && buttonText2Swap) ? buttonText : buttonText2
            lineHeight : yaLabel.lineHeightSize
            color: yaLabel.enabled? textColor: textDisabledColor
        }

        Text {
            id: labelTitle2Horizontal
            visible: (!buttonText2Stack && (buttonText2 != ""))
            anchors {
                left            : parent.horizontalCenter
                verticalCenter  : parent.verticalCenter
            }
            font {
                family: labelFontFamily
                //pixelSize: qfont.titleText
                pixelSize: ( (buttonText2Active && ! buttonText2Swap) ? 1 : 0.75) * ( yaLabel.pixelsizeoverride ? yaLabel.pixelsizeoverridesize : isNxt ? 20 : 16 )
            }
            text: (buttonText2Active && buttonText2Swap) ? buttonText : buttonText2
            lineHeight : yaLabel.lineHeightSize
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
