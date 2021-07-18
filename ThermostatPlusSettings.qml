import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0
import BxtClient 1.0

Screen {
    id: root
    
    property bool selectReadmeLanguage
    property bool selectControlMode
    property bool selectLayout
    property int  setupMode

    property variant    selectControlModeLng: ["App Mode", "App Mode", "App Modus"]
//    property variant    selectLayoutLng     : ["6 Apps <=> 4 Apps + Grote App", "6 Apps <=> 4 Apps + Large App", "6 Apps <=> 4 Apps + Große App"]
    property variant    selectLayoutLng     : ["6 Tiles <=> 4 Tiles + Grote Thermostaat", "6 Tiles <=> 4 Tiles + Large Thermostat", "6 Tiles <=> 4 Tiles + Große Thermostat"]
    property variant    selectReadmeLng     : ["Info", "Info", "Info"]

    property variant    appModeLng          : [
             "............Standard..........\nKachel aan deze Toon"
        +"\n\n............Mirror............\nKachel aan andere Toon"   +"\nStel in vanaf allebei"                                  +"\nAndere : Standard/Local"
        +"\n\n............Master............\nKachel aan andere Toon"   +"\nStel in vanaf deze Toon"                                +"\nAndere : Standard"
        +"\n\n............Local.............\nKachel aan andere Toon"   +"\nlijkt aan deze Toon"    +"\nStel in vanaf deze Toon"    +"\nAndere : Standard/Mirror"
    ,
             "............Standard..........\nHeating on this Toon"
        +"\n\n............Mirror............\nHeating on other Toon"    +"\nControl from both"                                      +"\nOther : Standard/Local"
        +"\n\n............Master............\nHeating on other Toon"    +"\nControl from this Toon"                                 +"\nOther : Standard"
        +"\n\n............Local.............\nHeating on other Toon"    +"\nseems on this Toon"     +"\nControl from this Toon"     +"\nOther : Standard/Mirror"
    ,
             "............Standard..........\nHeizung diesem Toon"
        +"\n\n............Mirror............\nHeizung andere Toon"     +"\nKontrolle von beiden"                                    +"\nAndere : Standard/Local"
        +"\n\n............Master............\nHeizung andere Toon"     +"\nKontrolle von diesem"                                    +"\nAndere : Standard"
        +"\n\n............Local.............\nHeizung andere Toon"     +"\nscheint mit diesem Toon"  +"\nKontrolle von diesem"      +"\nAndere : Standard/Mirror"
    ]

    property variant toonScreenLayoutTitleLng   : ["Kies een scherm layout en 'Apply'" , "Select a screen layout and 'Apply'" , "Wählen Sie ein Layout und 'Apply'"]
    property variant toonScreenLayoutTextLng    : [

            "..........De volgorde waarin de tiles verschuiven.........."
        + "\n"
        + "\n             1     2     3                     1     2   Grote"
        + "\n                                    <=>"
        + "\n             4     5     6                     3     4   Thermostaat"
        + "\n"
        + "\n..........Verbergen en terugkomen van tiles.........."
        + "\n"
        + "\nIn de onderste layout is de Grote Thermostaat weg."
        + "\n"
        + "\nAls je de onderste layout hebt en apps zet op de lege"
        + "\nposities ( tiles 5 & 6 gemarkeerd met '+' ) en je kiest"
        + "\ndan de bovenste layout met de Grote Thermostaat"
        + "\ndan worden de tiles 5 en 6 verborgen."
        + "\n"
        + "\nWat verborgen is komt terug als je de vorige layout weer kiest."
      ,
            "..........The order in which the tiles move.........."
        + "\n"
        + "\n             1     2     3                     1     2   Large"
        + "\n                                    <=>"
        + "\n             4     5     6                     3     4   Thermostat"
        + "\n"
        + "\n..........Hiding and unhiding of tiles.........."
        + "\n"
        + "\nIn the lower layout, the Large Thermostat is hidden."
        + "\n"
        + "\nWhen you put apps in the empty positions in the lower"
        + "\nlayout ( tiles 5 & 6 marked with '+' ) and you"
        + "\nselect the upper layout with the Large Thermostat"
        + "\nthe tiles 5 and 6 will hide."
        + "\n"
        + "\nWhat hides unhides when you select the previous layout."
      ,
            "..........Die Reihenfolge, in der sich die Tiles verschieben.........."
        + "\n"
        + "\n             1     2     3                     1     2   Große"
        + "\n                                    <=>"
        + "\n             4     5     6                     3     4   Thermostat"
        + "\n"
        + "\n..........Ausblenden und Einblenden von Tiles.........."
        + "\n"
        + "\nIm unteren Layout ist die Große Thermostat weg."
        + "\n"
        + "\nWenn Sie das untere Layout haben und Apps auf die leeren"
        + "\nPositionen legen ( Tiles 5 & 6 mit '+' markiert ) und "
        + "\nSie wählen das obere Layout mit die Große Thermostat"
        + "\nwerden Tiles 5 und 6 ausgeblendet."
        + "\n"
        + "\nWas ausgeblendet ist, wird wieder angezeigt,"
        + "\nwenn Sie das vorherige Layout erneut auswählen."
    ]

//    property variant    toonReadMeTitleLng  : ["Deze Toon met of zonder kachel & Scherm layout" , "Read me" , "Lese mich"]
    property variant    textReadMeLng       : [
            "De mode voor deze Toon zonder / met kachel :"
        + "\nzonder\t- Mirror : Regel de temperatuur bij een Toon met kachel ook vanaf deze Toon."
        + "\n\t- Master : 'Ben de baas' over een andere Toon met een kachel."
        + "\n\t- Local   : Regel de temperatuur bij deze Toon. (Radiatoren hier open en bij Toon met kachel dicht)"
        + "\nmet\t- Standard : Gebruik deze app voor je kachel."
        + "\n\t- Mirror     : Grote thermostaat voor eigen kachel en regel de temperatuur bij een andere Toon."
        + "\n\t- Master     : Grote thermostaat voor eigen kachel en 'ben de baas' over een andere Toon met kachel."
        + "\nElke Toon een eigen kachel ?"
        + "\n\t- Standard : Gebruik deze app voor je kachel."
        + "\n\t- Mirror     : Grote thermostaat voor eigen kachel en regel de temperatuur bij een andere Toon."
        + "\n\t- Master     : Grote thermostaat voor eigen kachel en 'ben de baas' over een andere Toon met kachel."
        + "\n"
        + "\nDe scherm layout van je Toon :"
        + "\nHeb je de grote thermostaat niet nodig dan kun je deze vervangen door 2 vrije tiles."
        + "\nJe hebt dan 6 gelijke tiles en je kunt later altijd terug naar 4 tiles met grote thermostaat."
        + "\nOm de layout wijziging door te voeren klik je op een 'Apply' knop en je Toon zal herstarten."
      ,
            "The mode for this Toon without / with heating :"
        + "\nwithout\t- Mirror : Control the temperature at an other Toon from this Toon too."
        + "\n\t- Master : 'Be boss' of an other Toon with heating."
        + "\n\t- Local   : Control the temperature at this Toon. (Radiators here open, closed at Toon with heating)"
        + "\nwith\t- Standard : Use this app for your heating."
        + "\n\t- Mirror     : Large thermostat for own heating and control the temperature at an other Toon."
        + "\n\t- Master     : Large thermostat for own heating and 'be boss' of an other Toon with heating."
        + "\nEach Toon an own heating ?"
        + "\n\t- Standard : Use this app for your heating."
        + "\n\t- Mirror     : Large thermostat for own heating and control the temperature at an other Toon."
        + "\n\t- Master     : Large thermostat for own heating and 'be boss' of an other Toon with heating."
        + "\n"
        + "\nThe screen layout of your Toon :"
        + "\nWhen you do not need the large thermostat you can replace it with 2 free tiles."
        + "\nThis way you have 6 equal tiles and you always can revert back to 4 tiles with large thermostat."
        + "\nYou need to click on an 'Apply' button to activate the change after which your Toon restarts."
      ,
            "Der Modus dieses Toons ohne / mit Heizung :"
        + "\nohne\t- Mirror : Steuern Sie die Temperatur eines Toons mit Heizung auch von diesem Toon."
        + "\n\t- Master : 'Bin der Boss' von einem anderen Toon."
        + "\n\t- Local   : Steuern Sie die Temperatur bei diesem Toon. (Radiatoren hier geöffnet, andere geschlossen )"
        + "\nmit\t- Standard : Verwenden Sie diese App für eigene Heizung."
        + "\n\t- Mirror     : Große Thermostat für eigene Heizung und steuern Sie die Temperatur bei einem anderen Toon."
        + "\n\t- Master     : Große Thermostat für eigene Heizung und 'bin der Boss' von einem anderen Toon."
        + "\nJeder Toon hat seinen eigenen Heizung ?"
        + "\n\t- Standard :  Verwenden Sie diese App für Ihre Heizung."
        + "\n\t- Mirror     : Große Thermostat für eigene Heizung und steuern Sie die Temperatur bei einem anderen Toon."
        + "\n\t- Master     : Große Thermostat für eigene Heizung und 'bin der Boss' von einem anderen Toon."
        + "\n"
        + "\nDas Bildschirmlayout Ihres Toon  :"
        + "\nWenn Sie die große Thermostat nicht benötigen, können Sie die Große durch 2 freie Plätze für andere Apps ersetzen. "
        + "\nSie haben dann 6 gleiche Tiles und können die Änderung später rückgängig machen."
        + "\nUm diese Layoutänderung zu übernehmen, klicke auf 'Apply' und Toon wird neu gestartet. "
    ]

    property int screenWidth  : parent.width - 20
    property int screenHeight : isNxt ? 460 : 370

    property string    activeColor: "lightgrey"
    property string    hoverColor: "lightgrey"
    property string    selectedColor : "lime"

    property int modeHeight     : isNxt ? 35 : 28
    property int modeWidth      : isNxt ? 170 : 136
    property int modeMargin     : isNxt ? 20 : 16

    property int bootedMode : 0
    property int selectedMode

    property string configFile : "file:///qmf/config/config_happ_scsync.xml"

	property string configMsgUuid : ""

    property bool editting
// ------------------------------------------------------------- Startup

    onVisibleChanged: {
        if (visible) {
            if (app.toonIP == 'IP other Toon') {
                setupMode = 3
            } else {
                setupMode = 1
            }
            editting = false
            getScreenMode()
            refreshScreen()
        } else {
            if  (! editting ) {
            app.getStatus("All") }
            if (app.guiMode == 'Settings' ) { app.guiMode = 'BackToControl' }
        }
    }

// ------------------------------------------------------- refreshScreen

    function refreshScreen() {
        
// which screen is selected

        selectControlMode       = setupMode == 1
        selectLayout            = setupMode == 2
        selectReadmeLanguage    = setupMode == 3

// setup screen select buttons

        showtoonControlMode.buttonText  = selectControlModeLng[app.currentLng]
        showtoonControlMode.selected    = selectControlMode
        showtoonScreenLayout.buttonText = selectLayoutLng[app.currentLng]
        showtoonScreenLayout.selected   = selectLayout
        showReadme.buttonText           = selectReadmeLng[app.currentLng]
        showReadme.selected             = selectReadmeLanguage

// app mode screen

        appMode.text = appModeLng[app.currentLng]

        modeStandardPicture.selected = app.mode == 'Standard'
        modeMirrorPicture.selected   = app.mode == 'Mirror'
        modeMasterPicture.selected   = app.mode == 'Master'
        modeLocalPicture.selected    = app.mode == 'Local'

// toon 4/6 mode screen

        toonScreenLayoutTitle.text  = toonScreenLayoutTitleLng[app.currentLng]
        toonScreenLayoutText.text   = toonScreenLayoutTextLng[app.currentLng]

        buttonMode4.selected = selectedMode == 4
        buttonMode6.selected = selectedMode == 6

// readme screen with language buttons

        lngDutch.buttonText = app.languages[0]
        lngDutch.selected = app.currentLng == 0
        lngEnglish.buttonText = app.languages[1]
        lngEnglish.selected = app.currentLng == 1
        lngGerman.buttonText = app.languages[2]
        lngGerman.selected = app.currentLng == 2

//        toonReadMeTitle.text = toonReadMeTitleLng[app.currentLng]
        toonReadMeTitle.text = "'"+selectControlModeLng[app.currentLng] +"' & '"+selectLayoutLng[app.currentLng]+"'"
        textReadMe.text = textReadMeLng[app.currentLng]

    }

// ---------------------------------------------------- reboot functions

	function rebootToon() {
		var restartToonMessage = bxtFactory.newBxtMessage(BxtMessage.ACTION_INVOKE, configMsgUuid, "specific1", "RequestReboot");
		bxtClient.sendMsg(restartToonMessage);
	}

	BxtDiscoveryHandler {
		id: configDiscoHandler
		deviceType: "hcb_config"
		onDiscoReceived: {
			configMsgUuid = deviceUuid
		}
	}

// ------------------------------------------------------- getScreenMode

    function getScreenMode() {

  		var configFileOld = new XMLHttpRequest();

        configFileOld.onreadystatechange = function() {

            if (configFileOld.readyState == XMLHttpRequest.DONE) {

                if (configFileOld.responseText.indexOf("<feature>noHeating</feature>") === -1)  {
                    if (bootedMode == 0) bootedMode = 4
                    selectedMode = 4
                } else {
                    if (bootedMode == 0) bootedMode = 6
                    selectedMode = 6
                }
			}
		}
        configFileOld.open("GET", configFile, true);
        configFileOld.send();
	}

// ---------------------------------------------------- switchScreenMode

    function switchScreenMode(mode) {

  		var configFileOld = new XMLHttpRequest();

        configFileOld.onreadystatechange = function() {

            if (configFileOld.readyState == XMLHttpRequest.DONE) {

                if (mode == 6) {

                    if (configFileOld.responseText.indexOf("<feature>noHeating</feature>") === -1)  {

                        app.log("setup config file for 6 tiles")

                        var newContent
                        newContent = configFileOld.responseText
                        newContent = newContent.replace('<features>','<features><feature>noHeating</feature>')
                        var configNew = new XMLHttpRequest();
					    configNew.open("PUT", configFile);
                        configNew.send(newContent);
					    configNew.close;

                    } else {
                        app.log("config already fine for 6 tiles, no change needed! ")
                    }
                }

                if (mode == 4) {

                    if (configFileOld.responseText.indexOf("<feature>noHeating</feature>") != -1)  {

                        app.log("setup config file for 4 tiles + large heater")

                        var newContent
                        newContent = configFileOld.responseText
                        newContent = newContent.replace('<feature>noHeating</feature>','')
                        var configNew = new XMLHttpRequest();
					    configNew.open("PUT", configFile);
                        configNew.send(newContent);
					    configNew.close;

                    } else {
                        app.log("config already fine for 4 tiles + large heater tile, no change needed! ")
                    }
                }
			}
		}
        configFileOld.open("GET", configFile, true);
        configFileOld.send();
	}

// ----------------------------------------------------- Save IP Address

	function saveipAddress(text) {
        if (text) {
            if ( ( text.trim() == "" ) || (/^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/.test(text.trim()) ) ) {
                toonIP.buttonText = text.trim();
                app.toonIP = text.trim();
                app.saveSettings()
            }
        }
	}

// ------------------------------------------------- Select Setup Screen

    YaLabel {
        id                      : showtoonControlMode
        buttonText              : ""
        height                  : modeHeight
        width                   : modeWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            bottom              : showtoonScreenLayout.bottom
            right               : showtoonScreenLayout.left
            rightMargin         : modeMargin
        }
        onClicked: {
            setupMode = 1
            refreshScreen()
        }
    }

    YaLabel {
        id                      : showtoonScreenLayout
        buttonText              : ""
        height                  : modeHeight
        width                   : modeWidth * 2.5
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            bottom              : parent.bottom
            bottomMargin        : 5
            horizontalCenter    : parent.horizontalCenter
        }
        onClicked: {
            setupMode = 2
            refreshScreen()
        }
    }

    YaLabel {
        id                      : showReadme
        buttonText              : ""
        height                  : modeHeight
        width                   : modeWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            bottom              : showtoonScreenLayout.bottom
            left                : showtoonScreenLayout.right
            leftMargin          : modeMargin
        }
        onClicked: {
            setupMode = 3
            refreshScreen()
        }
    }

// ---------------------------------------------------- toonAppMode

    Rectangle {
        id                      : toonAppMode
        visible                 : selectControlMode
        width                   : screenWidth
        height                  : screenHeight
        border {
            width: 2
            color: "black"
        }
        radius : 5
        anchors {
            horizontalCenter    : parent.horizontalCenter
            top                 : parent.top
        }
        color                   : "white"

// ------------------------------------------------------ toonAppModes

        Text {
            id                  : appMode
            text                : ""
            anchors {
                left            : parent.left
                top             : parent.top
                topMargin       : modeMargin / 2
                leftMargin      : isNxt ? modeMargin * 3 : modeMargin
            }
            font {
                pixelSize       : isNxt ? 17 : 12
            }
            color               : "black"
        }

        YaLabel {
            id                  : toonIP
            buttonText          : app.toonIP
            height              : modeHeight
            width               : modeWidth
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            selected            : true
            enabled             : true
            textColor           : "black"
            anchors {
                bottom          : parent.bottom
                left            : parent.left
                leftMargin      : isNxt ? modeMargin * 3 : modeMargin
                bottomMargin    : modeMargin
            }
            onClicked: {
                editting = true
                qkeyboard.open("The IP address of the main Toon", toonIP.buttonText, saveipAddress)
            }
            visible             : (app.mode != 'Standard')
        }

// ---- rectangles that go with modes

        YaLabel {
            id                      : modeStandardPicture
            buttonText              : "...."
            width                   : modeMirrorPicture.width
            height                  : modeMirrorPicture.height
            buttonActiveColor       : activeColor
            buttonHoverColor        : hoverColor
            buttonSelectedColor     : selectedColor
            hoveringEnabled         : isNxt
            enabled                 : true
            textColor               : "black"
            anchors {
                    top             : modeMirrorPicture.top
                    right           : modeMirrorPicture.left
                    rightMargin     : 10
            }
            onClicked: {
                app.mode = 'Standard'
                refreshScreen()
                app.saveSettings()
            }
            Image {
                id                  : imgStandardMode
                source              : "file:///qmf/qml/apps/thermostatPlus/drawables/StandardMode.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }

        YaLabel {
            id                      : modeMirrorPicture
            buttonText              : "...."
            width                   : isNxt ? 345 : 295
            height                  : isNxt ? 215 : 170
            buttonActiveColor       : activeColor
            buttonHoverColor        : hoverColor
            buttonSelectedColor     : selectedColor
            hoveringEnabled         : isNxt
            enabled                 : true
            textColor               : "black"
            anchors {
                    top             : parent.top
                    right           : parent.right
                    topMargin       : 10
                    rightMargin     : 10
            }
            onClicked: {
                app.mode = 'Mirror'
                refreshScreen()
                app.saveSettings()
            }
            Image {
                id                  : imgMirrorMode
                source              : "file:///qmf/qml/apps/thermostatPlus/drawables/MirrorMode.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }

        YaLabel {
            id                      : modeMasterPicture
            buttonText              : "...."
            width                   : modeMirrorPicture.width
            height                  : modeMirrorPicture.height
            buttonActiveColor       : activeColor
            buttonHoverColor        : hoverColor
            buttonSelectedColor     : selectedColor
            hoveringEnabled         : isNxt
            enabled                 : true
            textColor               : "black"
            anchors {
                    top             : modeLocalPicture.top
                    right           : modeLocalPicture.left
                    rightMargin     : 10
            }
            onClicked: {
                app.mode = 'Master'
                refreshScreen()
                app.saveSettings()
            }
            Image {
                id                  : imgMasterMode
                source              : "file:///qmf/qml/apps/thermostatPlus/drawables/MasterMode.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }

        YaLabel {
            id                      : modeLocalPicture
            buttonText              : "...."
            width                   : modeMirrorPicture.width
            height                  : modeMirrorPicture.height
            buttonActiveColor       : activeColor
            buttonHoverColor        : hoverColor
            buttonSelectedColor     : selectedColor
            hoveringEnabled         : isNxt
            enabled                 : true
            textColor               : "black"
            anchors {
                    bottom          : parent.bottom
                    right           : parent.right
                    bottomMargin    : 10
                    rightMargin     : 10
            }
            onClicked: {
                app.mode = 'Local'
                refreshScreen()
                app.saveSettings()
            }
            Image {
                id                  : imgLocalMode
                source              : "file:///qmf/qml/apps/thermostatPlus/drawables/LocalMode.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

// ---------------------------------------------------- toonScreenLayout

    Rectangle {
        id                      : toonScreenLayout
        visible                 : selectLayout
        width                   : screenWidth
        height                  : screenHeight
        border {
            width               : 2
            color               : "black"
        }
        radius                  : 5
        anchors {
            horizontalCenter    : parent.horizontalCenter
            top                 : parent.top
        }
        color                   : "white"

// --------------------------------------------------- Text

        Text {
            id                  : toonScreenLayoutTitle
            text                : ""
            width               : parent.width / 2
            anchors {
                top             : parent.top
                left            : parent.left
                topMargin       : isNxt ? 10 : 8
                leftMargin      : isNxt ? 30 : 24
            }
            font {
                pixelSize       : isNxt ? 25 : 20
            }
            color               : "black"
        }

        Text {
            id                  : toonScreenLayoutText
            text                : ""
            height              : parent.height - ( isNxt ? 60 : 48 )
            width               : parent.width / 2.1
            anchors {
                left            : parent.left
                top             : toonScreenLayoutTitle.bottom
                topMargin       : isNxt ? 10 : 8
                leftMargin      : isNxt ? 30 : 24
            }
            font {
                pixelSize       : isNxt ? 18 : 13
            }
            color               : "black"
        }

// --------------------------------------------------- Reboot / Exit

        YaLabel {
            id                  : buttonReboot
            buttonText          :  "Apply"
            height              : modeHeight
            width               : modeWidth / 2
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            enabled             : true
            selected            : false
            textColor           : "black"
            anchors {
                right           : buttonMode6.left
                verticalCenter  : parent.verticalCenter
                rightMargin     : modeMargin
            }
            onClicked: {

                if ( selectedMode != bootedMode ) { switchScreenMode(selectedMode) ; rebootToon() }

                hide();
            }
        }

// --------------------------------------------------- Pictures

        YaLabel {
            id                  : buttonMode4
            buttonText          :  ""
            width               : isNxt ? 355 : 315
            height              : isNxt ? 215 : 170
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            enabled             : true
            textColor           : "black"
            anchors {
                top             : parent.top
                right           : parent.right
                topMargin       : isNxt ? 10 : 8
                rightMargin     : isNxt ? 10 : 8
            }
            Image {
                id              : imgGui4
                source          : "file:///qmf/qml/apps/thermostatPlus/drawables/gui4.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
            onClicked: {
                selectedMode = 4
                refreshScreen()
            }
        }

        YaLabel {
            id                  : buttonMode6
            buttonText          :  ""
            height              : buttonMode4.height
            width               : buttonMode4.width
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            enabled             : true
            textColor           : "black"
            anchors {
                bottom          : parent.bottom
                right           : parent.right
                rightMargin     : isNxt ? 10 : 8
                bottomMargin    : isNxt ? 10 : 8
            }
            onClicked: {
                selectedMode = 6
                refreshScreen()
            }

            Image {
                id              : imgGui6
                source          : "file:///qmf/qml/apps/thermostatPlus/drawables/gui6.png"
                anchors {
                    verticalCenter  : parent.verticalCenter
                    horizontalCenter: parent.horizontalCenter
                }
            }
        }
    }

// ---------------------------------------------------- toonReadme

    Rectangle {
        id                      : toonReadMe
        visible                 : selectReadmeLanguage
        width                   : screenWidth
        height                  : screenHeight
        border {
            width: 2
            color: "black"
        }
        radius : 5
        anchors {
            horizontalCenter    : parent.horizontalCenter
            top                 : parent.top
        }
        color                   : "white"

// --------------------------------------------------- Text

        Text {
            id                  : toonReadMeTitle
            text                : ""
            width               : parent.width
            horizontalAlignment : Text.AlignHCenter
            anchors {
                top             : parent.top
                horizontalCenter: parent.horizontalCenter
            }
            font {
                pixelSize       : isNxt ? 25 : 20
            }
            color               : "black"
        }

        Text {
            id                  : textReadMe
            text                : ""
            width               : parent.width
            anchors {
                left            : parent.left
                top             : toonReadMeTitle.bottom
//                topMargin       : modeMargin
                leftMargin      : modeMargin
            }
            font {
                pixelSize       : isNxt ? 17 : 12
            }
            color               : "black"
        }

// ---- language buttons

        YaLabel {
            id                  : lngDutch
            buttonText          : ""
            height              : modeHeight
            width               : modeWidth
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            enabled             : true
            textColor           : "black"
            anchors {
                bottom          : lngEnglish.bottom
                right           : lngEnglish.left
                rightMargin     : modeMargin
            }
            onClicked: {
                app.currentLng      = 0
                refreshScreen()
                app.saveSettings()
            }
        }

        YaLabel {
            id                  : lngEnglish
            buttonText          : ""
            height              : modeHeight
            width               : modeWidth
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            enabled             : true
            textColor           : "black"
            anchors {
                bottom          : parent.bottom
                horizontalCenter: parent.horizontalCenter
                bottomMargin    : modeMargin
            }
            onClicked: {
                app.currentLng      = 1
                refreshScreen()
                app.saveSettings()
            }
        }

        YaLabel {
            id                  : lngGerman
            buttonText          : ""
            height              : modeHeight
            width               : modeWidth
            buttonActiveColor   : activeColor
            buttonHoverColor    : hoverColor
            buttonSelectedColor : selectedColor
            hoveringEnabled     : isNxt
            enabled             : true
            textColor           : "black"
            anchors {
                bottom          : lngEnglish.bottom
                left            : lngEnglish.right
                leftMargin      : modeMargin
            }
            onClicked: {
                app.currentLng      = 2
                refreshScreen()
                app.saveSettings()
            }
        }
    }
}
