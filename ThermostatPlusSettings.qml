import QtQuick 2.1
import qb.components 1.0
import BasicUIControls 1.0
import BxtClient 1.0

Screen {
    id: root
    
    property bool selectControlMode
    property bool selectLayout
    property bool selectProgram
    property bool selectReadmeLanguage

    property int  setupMode

    property variant    selectControlModeLng: ["App Mode", "App Mode", "App Modus"]
    property variant    selectLayoutLng     : ["6 Tiles <=> 4 Tiles", "6 Tiles <=> 4 Tiles", "6 Tiles <=> 4 Tiles"]
    property variant    selectProgramLng    : ["Programma", "Program", "Programm"]
    property variant    selectReadmeLng     : ["Info", "Info", "Info"]

    property variant    dayLng     : ["Dagen", "Days", "Tage"]

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

    property variant    textReadMeLng       : [
            "'App Mode' voor deze Toon met / zonder kachel :"
        + "\nmet\t- Standard : Gebruik deze app voor je kachel."
        + "\n\t- Mirror     : Grote thermostaat voor eigen kachel en regel de temperatuur bij een andere Toon."
        + "\n\t- Master     : Grote thermostaat voor eigen kachel en 'ben de baas' over een andere Toon met kachel."
        + "\nzonder\t- Mirror : Regel de temperatuur bij een Toon met kachel ook vanaf deze Toon."
        + "\n\t- Master : 'Ben de baas' over een andere Toon met een kachel."
        + "\n\t- Local   : Regel de temperatuur bij deze Toon. (Radiatoren hier open en bij Toon met kachel dicht)"
        + "\nElke Toon een eigen kachel ?"
        + "\n\t- Standard : Gebruik deze app voor je kachel."
        + "\n\t- Mirror     : Grote thermostaat voor eigen kachel en regel de temperatuur bij een andere Toon."
        + "\n\t- Master     : Grote thermostaat voor eigen kachel en 'ben de baas' over een andere Toon met kachel."
        + "\n"
        + "\n'6 Tiles <=> 4 Tiles' :"
        + "\nHeb je de grote thermostaat niet nodig dan kun je deze vervangen door 2 vrije tiles."
        + "\nJe hebt dan 6 gelijke tiles en je kunt later altijd terug naar 4 tiles met grote thermostaat."
        + "\n"
        + "\n'Programma' :"
        + "\nVariabel aantal dagen programma. Start datum past zichzelf aan na voltooide cyclus."
      ,
            "'App Mode' for this Toon with / without heating :"
        + "\nwith\t- Standard : Use this app for your heating."
        + "\n\t- Mirror     : Large thermostat for own heating and control the temperature at an other Toon."
        + "\n\t- Master     : Large thermostat for own heating and 'be boss' of an other Toon with heating."
        + "\nwithout\t- Mirror : Control the temperature at an other Toon from this Toon too."
        + "\n\t- Master : 'Be boss' of an other Toon with heating."
        + "\n\t- Local   : Control the temperature at this Toon. (Radiators here open, closed at Toon with heating)"
        + "\nEach Toon an own heating ?"
        + "\n\t- Standard : Use this app for your heating."
        + "\n\t- Mirror     : Large thermostat for own heating and control the temperature at an other Toon."
        + "\n\t- Master     : Large thermostat for own heating and 'be boss' of an other Toon with heating."
        + "\n"
        + "\n'6 Tiles <=> 4 Tiles' :"
        + "\nWhen you do not need the large thermostat you can replace it with 2 free tiles."
        + "\nThis way you have 6 equal tiles and you always can revert back to 4 tiles with large thermostat."
        + "\n"
        + "\n'Program' :"
        + "\nVariable number of days program. Start date adjusts itself after completed cycle."
      ,
            "'App Modus' dieses Toons mit / ohne Heizung :"
        + "\nmit\t- Standard : Verwenden Sie diese App für eigene Heizung."
        + "\n\t- Mirror     : Große Thermostat für eigene Heizung und steuern Sie die Temperatur bei einem anderen Toon."
        + "\n\t- Master     : Große Thermostat für eigene Heizung und 'bin der Boss' von einem anderen Toon."
        + "\nohne\t- Mirror : Steuern Sie die Temperatur eines Toons mit Heizung auch von diesem Toon."
        + "\n\t- Master : 'Bin der Boss' von einem anderen Toon."
        + "\n\t- Local   : Steuern Sie die Temperatur bei diesem Toon. (Radiatoren hier geöffnet, andere geschlossen )"
        + "\nJeder Toon hat seinen eigenen Heizung ?"
        + "\n\t- Standard :  Verwenden Sie diese App für Ihre Heizung."
        + "\n\t- Mirror     : Große Thermostat für eigene Heizung und steuern Sie die Temperatur bei einem anderen Toon."
        + "\n\t- Master     : Große Thermostat für eigene Heizung und 'bin der Boss' von einem anderen Toon."
        + "\n"
        + "\n'6 Tiles <=> 4 Tiles' :"
        + "\nWenn Sie die große Thermostat nicht benötigen, können Sie die Große durch 2 freie Plätze für andere Apps ersetzen. "
        + "\nSie haben dann 6 gleiche Tiles und können die Änderung später rückgängig machen."
        + "\n"
        + "\n'Programm' :"
        + "\nVariable Anzahl von Tagen Programm. Das Startdatum passt sich nach Abschluss des Zyklus an."
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


// Programma and Temperatuur function settings

    property string thermstatFile    : "file:////mnt/data/qmf/config/config_happ_thermstat.xml"

    property int tempWidth          : isNxt ? 80 : 64
    property int tempHeight         : isNxt ? 80 : 64
    
    property int buttonWidth        : isNxt ? 160 : 128
    property int buttonHeight       : isNxt ? 50 : 40

    property int dayIndexValue
    property int sDay
    property int sPeriod
    
    property int copyDayNumber
    property int pasteDayNumber
    
// ------------------------------------------------------------- Startup

    onVisibleChanged: {
        if (visible) {

            setupMode = app.lastSettingsMode

            if  (! editting ) {
// I do not return from editting IP address but I get here via the Tile from the control screen so I need to init
                copypasteDay.selected = false
                dayIndexValue = 1
                sDay = 0
                sPeriod = 0
                copyDayNumber = 0
            }

            getScreenMode()
                        
            app.correctprogramDate()
            
            refreshScreen()

            editting = false

        } else {
            if  (! editting ) { 
// I do not hide to go to edit the IP address but I go back to the Tile which needs to redirect me to Control
                app.getStatus("All") 
            }
            
            if (app.guiMode == 'Settings' ) { 
                app.correctprogramDate()
                app.guiMode = 'BackToControl' 
            }
            app.saveSettings()
        }
    }

// ------------------------------------------------------- refreshScreen

    function refreshScreen() {

        app.lastSettingsMode = setupMode
        
        if ( ( dayIndexValue + sDay ) > app.programDays ) { sDay = sDay - 1 }
        
// which screen is selected

        selectControlMode       = setupMode == 1
        selectLayout            = setupMode == 2
        selectProgram           = setupMode == 3
        selectReadmeLanguage    = setupMode == 4

// setup screen select buttons

        showtoonControlMode.buttonText  = selectControlModeLng[app.currentLng]
        showtoonControlMode.selected    = selectControlMode

        showtoonScreenLayout.buttonText = selectLayoutLng[app.currentLng]
        showtoonScreenLayout.selected   = selectLayout

        showtoonProgram.buttonText      = selectProgramLng[app.currentLng]
        showtoonProgram.selected        = selectProgram

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

        textReadMe.text = textReadMeLng[app.currentLng]

// program screen
        
        if ( (copyDayNumber == 0) || (copyDayNumber > app.programDays) ) { 
            copypasteDay.selected = false
            copyDayNumber = 0
            pasteDayNumber = 0
        } else {
            copypasteDay.selected = true
            pasteDayNumber = dayIndexValue + sDay
            if (pasteDayNumber > app.programDays) { 
                pasteDayNumber = dayIndexValue
                sDay = 0
                sPeriod = 0
            }
        }

        if ( copypasteDay.selected ) { 
            textcopyDay.text  = copyDayNumber
            textpasteDay.text = dayIndexValue + sDay
            imgCopyPaste.source = app.pasteImg
        } else {
            textcopyDay.text = dayIndexValue + sDay
            imgCopyPaste.source = app.copyImg
        }

        textyearprogramDate.text  = app.programDate.substring(0, 4) 
        textmonthprogramDate.text = app.programDate.substring(5, 7) 
        textdayprogramDate.text   = app.programDate.substring(8, 10) 

        buttonprogramDays.buttonText = dayLng[app.currentLng]

        programComfort.buttonText   = app.statesLng[app.currentLng][0]
        programHome.buttonText      = app.statesLng[app.currentLng][1]
        programSleep.buttonText     = app.statesLng[app.currentLng][2]
        programAway.buttonText      = app.statesLng[app.currentLng][3]

        changeComfort.buttonText    = app.statesLng[app.currentLng][0].slice(0,1)
        changeHome.buttonText       = app.statesLng[app.currentLng][1].slice(0,1)
        changeSleep.buttonText      = app.statesLng[app.currentLng][2].slice(0,1)
        changeAway.buttonText       = app.statesLng[app.currentLng][3].slice(0,1)

        var base = (dayIndexValue - 1) * 6

        s00.selected = ( sDay == 0 && sPeriod == 0 ) ; s00.buttonText = app.scheduleTime[ base +  0 ] ; s00.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
        s01.selected = ( sDay == 0 && sPeriod == 1 ) ; s01.buttonText = app.scheduleTime[ base +  1 ] ; s01.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
        s02.selected = ( sDay == 0 && sPeriod == 2 ) ; s02.buttonText = app.scheduleTime[ base +  2 ] ; s02.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
        s03.selected = ( sDay == 0 && sPeriod == 3 ) ; s03.buttonText = app.scheduleTime[ base +  3 ] ; s03.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
        s04.selected = ( sDay == 0 && sPeriod == 4 ) ; s04.buttonText = app.scheduleTime[ base +  4 ] ; s04.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
        s05.selected = ( sDay == 0 && sPeriod == 5 ) ; s05.buttonText = app.scheduleTime[ base +  5 ] ; s05.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
        if (s00.selected) { sedit.buttonText = s00.buttonText ; sedit.buttonActiveColor = s00.buttonActiveColor } 
        if (s01.selected) { sedit.buttonText = s01.buttonText ; sedit.buttonActiveColor = s01.buttonActiveColor } 
        if (s02.selected) { sedit.buttonText = s02.buttonText ; sedit.buttonActiveColor = s02.buttonActiveColor } 
        if (s03.selected) { sedit.buttonText = s03.buttonText ; sedit.buttonActiveColor = s03.buttonActiveColor } 
        if (s04.selected) { sedit.buttonText = s04.buttonText ; sedit.buttonActiveColor = s04.buttonActiveColor } 
        if (s05.selected) { sedit.buttonText = s05.buttonText ; sedit.buttonActiveColor = s05.buttonActiveColor } 
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s10.selected = ( sDay == 1 && sPeriod == 0 ) ; s10.buttonText = app.scheduleTime[ base +  0 ] ; s10.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s11.selected = ( sDay == 1 && sPeriod == 1 ) ; s11.buttonText = app.scheduleTime[ base +  1 ] ; s11.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s12.selected = ( sDay == 1 && sPeriod == 2 ) ; s12.buttonText = app.scheduleTime[ base +  2 ] ; s12.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s13.selected = ( sDay == 1 && sPeriod == 3 ) ; s13.buttonText = app.scheduleTime[ base +  3 ] ; s13.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s14.selected = ( sDay == 1 && sPeriod == 4 ) ; s14.buttonText = app.scheduleTime[ base +  4 ] ; s14.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s15.selected = ( sDay == 1 && sPeriod == 5 ) ; s15.buttonText = app.scheduleTime[ base +  5 ] ; s15.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s10.selected) { sedit.buttonText = s10.buttonText ; sedit.buttonActiveColor = s10.buttonActiveColor } 
            if (s11.selected) { sedit.buttonText = s11.buttonText ; sedit.buttonActiveColor = s11.buttonActiveColor } 
            if (s12.selected) { sedit.buttonText = s12.buttonText ; sedit.buttonActiveColor = s12.buttonActiveColor } 
            if (s13.selected) { sedit.buttonText = s13.buttonText ; sedit.buttonActiveColor = s13.buttonActiveColor } 
            if (s14.selected) { sedit.buttonText = s14.buttonText ; sedit.buttonActiveColor = s14.buttonActiveColor } 
            if (s15.selected) { sedit.buttonText = s15.buttonText ; sedit.buttonActiveColor = s15.buttonActiveColor } 
        }
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s20.selected = ( sDay == 2 && sPeriod == 0 ) ; s20.buttonText = app.scheduleTime[ base +  0 ] ; s20.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s21.selected = ( sDay == 2 && sPeriod == 1 ) ; s21.buttonText = app.scheduleTime[ base +  1 ] ; s21.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s22.selected = ( sDay == 2 && sPeriod == 2 ) ; s22.buttonText = app.scheduleTime[ base +  2 ] ; s22.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s23.selected = ( sDay == 2 && sPeriod == 3 ) ; s23.buttonText = app.scheduleTime[ base +  3 ] ; s23.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s24.selected = ( sDay == 2 && sPeriod == 4 ) ; s24.buttonText = app.scheduleTime[ base +  4 ] ; s24.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s25.selected = ( sDay == 2 && sPeriod == 5 ) ; s25.buttonText = app.scheduleTime[ base +  5 ] ; s25.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s20.selected) { sedit.buttonText = s20.buttonText ; sedit.buttonActiveColor = s20.buttonActiveColor } 
            if (s21.selected) { sedit.buttonText = s21.buttonText ; sedit.buttonActiveColor = s21.buttonActiveColor } 
            if (s22.selected) { sedit.buttonText = s22.buttonText ; sedit.buttonActiveColor = s22.buttonActiveColor } 
            if (s23.selected) { sedit.buttonText = s23.buttonText ; sedit.buttonActiveColor = s23.buttonActiveColor } 
            if (s24.selected) { sedit.buttonText = s24.buttonText ; sedit.buttonActiveColor = s24.buttonActiveColor } 
            if (s25.selected) { sedit.buttonText = s25.buttonText ; sedit.buttonActiveColor = s25.buttonActiveColor } 
        }
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s30.selected = ( sDay == 3 && sPeriod == 0 ) ; s30.buttonText = app.scheduleTime[ base +  0 ] ; s30.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s31.selected = ( sDay == 3 && sPeriod == 1 ) ; s31.buttonText = app.scheduleTime[ base +  1 ] ; s31.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s32.selected = ( sDay == 3 && sPeriod == 2 ) ; s32.buttonText = app.scheduleTime[ base +  2 ] ; s32.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s33.selected = ( sDay == 3 && sPeriod == 3 ) ; s33.buttonText = app.scheduleTime[ base +  3 ] ; s33.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s34.selected = ( sDay == 3 && sPeriod == 4 ) ; s34.buttonText = app.scheduleTime[ base +  4 ] ; s34.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s35.selected = ( sDay == 3 && sPeriod == 5 ) ; s35.buttonText = app.scheduleTime[ base +  5 ] ; s35.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s30.selected) { sedit.buttonText = s30.buttonText ; sedit.buttonActiveColor = s30.buttonActiveColor } 
            if (s31.selected) { sedit.buttonText = s31.buttonText ; sedit.buttonActiveColor = s31.buttonActiveColor } 
            if (s32.selected) { sedit.buttonText = s32.buttonText ; sedit.buttonActiveColor = s32.buttonActiveColor } 
            if (s33.selected) { sedit.buttonText = s33.buttonText ; sedit.buttonActiveColor = s33.buttonActiveColor } 
            if (s34.selected) { sedit.buttonText = s34.buttonText ; sedit.buttonActiveColor = s34.buttonActiveColor } 
            if (s35.selected) { sedit.buttonText = s35.buttonText ; sedit.buttonActiveColor = s35.buttonActiveColor } 
        }
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s40.selected = ( sDay == 4 && sPeriod == 0 ) ; s40.buttonText = app.scheduleTime[ base +  0 ] ; s40.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s41.selected = ( sDay == 4 && sPeriod == 1 ) ; s41.buttonText = app.scheduleTime[ base +  1 ] ; s41.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s42.selected = ( sDay == 4 && sPeriod == 2 ) ; s42.buttonText = app.scheduleTime[ base +  2 ] ; s42.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s43.selected = ( sDay == 4 && sPeriod == 3 ) ; s43.buttonText = app.scheduleTime[ base +  3 ] ; s43.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s44.selected = ( sDay == 4 && sPeriod == 4 ) ; s44.buttonText = app.scheduleTime[ base +  4 ] ; s44.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s45.selected = ( sDay == 4 && sPeriod == 5 ) ; s45.buttonText = app.scheduleTime[ base +  5 ] ; s45.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s40.selected) { sedit.buttonText = s40.buttonText ; sedit.buttonActiveColor = s40.buttonActiveColor } 
            if (s41.selected) { sedit.buttonText = s41.buttonText ; sedit.buttonActiveColor = s41.buttonActiveColor } 
            if (s42.selected) { sedit.buttonText = s42.buttonText ; sedit.buttonActiveColor = s42.buttonActiveColor } 
            if (s43.selected) { sedit.buttonText = s43.buttonText ; sedit.buttonActiveColor = s43.buttonActiveColor } 
            if (s44.selected) { sedit.buttonText = s44.buttonText ; sedit.buttonActiveColor = s44.buttonActiveColor } 
            if (s45.selected) { sedit.buttonText = s45.buttonText ; sedit.buttonActiveColor = s45.buttonActiveColor } 
        }
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s50.selected = ( sDay == 5 && sPeriod == 0 ) ; s50.buttonText = app.scheduleTime[ base +  0 ] ; s50.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s51.selected = ( sDay == 5 && sPeriod == 1 ) ; s51.buttonText = app.scheduleTime[ base +  1 ] ; s51.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s52.selected = ( sDay == 5 && sPeriod == 2 ) ; s52.buttonText = app.scheduleTime[ base +  2 ] ; s52.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s53.selected = ( sDay == 5 && sPeriod == 3 ) ; s53.buttonText = app.scheduleTime[ base +  3 ] ; s53.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s54.selected = ( sDay == 5 && sPeriod == 4 ) ; s54.buttonText = app.scheduleTime[ base +  4 ] ; s54.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s55.selected = ( sDay == 5 && sPeriod == 5 ) ; s55.buttonText = app.scheduleTime[ base +  5 ] ; s55.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s50.selected) { sedit.buttonText = s50.buttonText ; sedit.buttonActiveColor = s50.buttonActiveColor } 
            if (s51.selected) { sedit.buttonText = s51.buttonText ; sedit.buttonActiveColor = s51.buttonActiveColor } 
            if (s52.selected) { sedit.buttonText = s52.buttonText ; sedit.buttonActiveColor = s52.buttonActiveColor } 
            if (s53.selected) { sedit.buttonText = s53.buttonText ; sedit.buttonActiveColor = s53.buttonActiveColor } 
            if (s54.selected) { sedit.buttonText = s54.buttonText ; sedit.buttonActiveColor = s54.buttonActiveColor } 
            if (s55.selected) { sedit.buttonText = s55.buttonText ; sedit.buttonActiveColor = s55.buttonActiveColor } 
        }
        base = base + 6
        if ( ( base / 6 + 1 ) <=  app.programDays ) {
            s60.selected = ( sDay == 6 && sPeriod == 0 ) ; s60.buttonText = app.scheduleTime[ base +  0 ] ; s60.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  0 ]]
            s61.selected = ( sDay == 6 && sPeriod == 1 ) ; s61.buttonText = app.scheduleTime[ base +  1 ] ; s61.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  1 ]]
            s62.selected = ( sDay == 6 && sPeriod == 2 ) ; s62.buttonText = app.scheduleTime[ base +  2 ] ; s62.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  2 ]]
            s63.selected = ( sDay == 6 && sPeriod == 3 ) ; s63.buttonText = app.scheduleTime[ base +  3 ] ; s63.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  3 ]]
            s64.selected = ( sDay == 6 && sPeriod == 4 ) ; s64.buttonText = app.scheduleTime[ base +  4 ] ; s64.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  4 ]]
            s65.selected = ( sDay == 6 && sPeriod == 5 ) ; s65.buttonText = app.scheduleTime[ base +  5 ] ; s65.buttonActiveColor = app.programColor[app.scheduleProgram[ base +  5 ]]
            if (s60.selected) { sedit.buttonText = s60.buttonText ; sedit.buttonActiveColor = s60.buttonActiveColor } 
            if (s61.selected) { sedit.buttonText = s61.buttonText ; sedit.buttonActiveColor = s61.buttonActiveColor } 
            if (s62.selected) { sedit.buttonText = s62.buttonText ; sedit.buttonActiveColor = s62.buttonActiveColor } 
            if (s63.selected) { sedit.buttonText = s63.buttonText ; sedit.buttonActiveColor = s63.buttonActiveColor } 
            if (s64.selected) { sedit.buttonText = s64.buttonText ; sedit.buttonActiveColor = s64.buttonActiveColor } 
            if (s65.selected) { sedit.buttonText = s65.buttonText ; sedit.buttonActiveColor = s65.buttonActiveColor } 
        }
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
                    if (bootedMode == 0) { bootedMode = 4 }
                        selectedMode = 4
                } else {
                    if (bootedMode == 0) { bootedMode = 6 }
                    selectedMode = 6
                }
			}
		}
        configFileOld.open("GET", configFile, false);
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
                        if (configFileOld.responseText.indexOf("<features>") != -1)  {
                            newContent = newContent.replace('<features>','<features><feature>noHeating</feature>')
                        } else {
                            newContent = newContent.replace('</commissionState>','</commissionState><features><feature>noHeating</feature></features>')
                        }
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
            }
        }
	}

// ----------------------------------------------------- calculate new programDate

    function changeprogramDate(what,how) {

        var year  = 1 * app.programDate.substring(0, 4) 
        var month = 1 * app.programDate.substring(5, 7) 
        var day   = 1 * app.programDate.substring(8, 10) 

        var daymax = 31

        switch(what) {
        case "year":
            if (how == "+") { year = year + 1} else { year = year - 1 }
            if (month == 2) { daymax = 28 }
            if ( (month == 2) && ( year % 4 == 0 ) ) { daymax = 29 }
            day = app.min(daymax, day )
            break;
        case "month":
            if (how == "+") { month = app.min(12, month + 1) } else { month = app.max(1, month - 1) }
            if (month == 2) { daymax = 28 }
            if ( (month == 2) && ( year % 4 == 0 ) ) { daymax = 29 }
            if ([4, 6, 9, 11].indexOf(month) > -1 ) { daymax = 30 }
            day = app.min(daymax, day )
            break;
        case "day":
            if (month == 2) { daymax = 28 }
            if ( (month == 2) && ( year % 4 == 0 ) ) { daymax = 29 }
            if ([4, 6, 9, 11].indexOf(month) > -1 ) { daymax = 30 }
            if (how == "+") { day = app.min(daymax, day + 1) } else { day = app.max(1, day - 1) }
        }

        app.programDate = year + '-' + app.right('0' + month , 2 ) + '-' + app.right('0' + day , 2 )
        
        refreshScreen()
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
        width                   : modeWidth
        buttonActiveColor       : activeColor
        buttonHoverColor        : hoverColor
        buttonSelectedColor     : selectedColor
        hoveringEnabled         : isNxt
        enabled                 : true
        textColor               : "black"
        anchors {
            bottom              : parent.bottom
            bottomMargin        : 5
            right               : parent.horizontalCenter
            rightMargin         : modeMargin / 2
        }
        onClicked: {
            setupMode = 2
            refreshScreen()
        }
    }

    YaLabel {
        id                      : showtoonProgram
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
            bottom              : parent.bottom
            bottomMargin        : 5
            left                : parent.horizontalCenter
            leftMargin          : modeMargin / 2
        }
        onClicked: {
            setupMode = 3
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
            bottom              : showtoonProgram.bottom
            left                : showtoonProgram.right
            leftMargin          : modeMargin
        }
        onClicked: {
            setupMode = 4
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

                if ( selectedMode != bootedMode ) { app.saveSettings() ; switchScreenMode(selectedMode) ; rebootToon() }

//                hide();
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

// ---------------------------------------------------- toonProgram

    Rectangle {
        id                      : toonProgram
        visible                 : showtoonProgram.selected
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

        Rectangle {
            id                      : toonProgramLeft
            width                   : isNxt ? 250 : 180
            height                  : screenHeight - 4
            border {
                width: 0
                color: "black"
            }
            radius : 5
            anchors {
                left                : parent.left
                top                 : parent.top
                topMargin           : 2
                leftMargin          : 2
            }
            color                   : "white"

//------

            Text {
                id                      : textprogramDate
                text                    : "Start"
                color                   : "black"
                anchors {
                    horizontalCenter    : buttonprogramDays.horizontalCenter
                    top                 : parent.top
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : yearprogramDate
                buttonText              : "yyyy"
                height                  : buttonHeight
                width                   : buttonWidth / 2 - 1
                buttonActiveColor       : activeColor
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : textprogramDate.bottom
                    left                : parent.left
                    topMargin           : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected  = true ; monthprogramDate.selected = false ; dayprogramDate.selected  = false ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }


            Text {
                id                      : textyearprogramDate
                text                    : "yyyy"
                color                   : "black"
                anchors {
                    horizontalCenter    : yearprogramDate.horizontalCenter
                    top                 : yearprogramDate.bottom
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : monthprogramDate
                buttonText              : "mm"
                height                  : buttonHeight
                width                   : buttonWidth / 4 - 2
                buttonActiveColor       : activeColor
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : textprogramDate.bottom
                    left                : yearprogramDate.right
                    topMargin           : 2
                    leftMargin          : 2
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = true ; dayprogramDate.selected = false ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : textmonthprogramDate
                text                    : "mm"
                color                   : "black"
                anchors {
                    horizontalCenter    : monthprogramDate.horizontalCenter
                    top                 : monthprogramDate.bottom
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------
            YaLabel {
                id                      : dayprogramDate
                buttonText              : "dd"
                height                  : buttonHeight
                width                   : buttonWidth / 4 - 1
                buttonActiveColor       : activeColor
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : textprogramDate.bottom
                    left                : monthprogramDate.right
                    topMargin           : 2
                    leftMargin          : 2
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = true ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : textdayprogramDate
                text                    : "mm"
                color                   : "black"
                anchors {
                    horizontalCenter    : dayprogramDate.horizontalCenter
                    top                 : dayprogramDate.bottom
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------
//------

            YaLabel {
                id                      : buttonprogramDays
                buttonText              :  ""
                height                  : buttonHeight
                width                   : buttonWidth
                buttonActiveColor       : activeColor
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    bottom              : programComfort.top
                    left                : parent.left
                    bottomMargin        : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = false ; buttonprogramDays.selected = true ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : textprogramDays
                text                    : app.programDays
                color                   : "black"
                anchors {
                    verticalCenter      : buttonprogramDays.verticalCenter
                    left                : buttonprogramDays.right
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }
//------

            YaLabel {
                id                      : programComfort
                buttonText              :  ""
                height                  : buttonHeight
                width                   : buttonWidth
                buttonActiveColor       : app.programColorComfort
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    bottom              : programHome.top
                    left                : parent.left
                    bottomMargin        : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = false ; buttonprogramDays.selected = false ; programComfort.selected = true ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : tempComfort
                text                    : app.programTempComfort.includes('.') ? app.programTempComfort + "°" : app.programTempComfort + ".0°"
                color                   : "black"
                anchors {
                    verticalCenter      : programComfort.verticalCenter
                    left                : programComfort.right
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : programHome
                buttonText              :  ""
                height                  : buttonHeight
                width                   : buttonWidth
                buttonActiveColor       : app.programColorHome
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    bottom              : programSleep.top
                    left                : parent.left
                    bottomMargin        : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = false ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = true ; programSleep.selected = false ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : tempHome
                text                    : app.programTempHome.includes('.') ? app.programTempHome  + "°" : app.programTempHome + ".0°"
                color                   : "black"
                anchors {
                    verticalCenter      : programHome.verticalCenter
                    left                : programHome.right
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : programSleep
                buttonText              :  ""
                height                  : buttonHeight
                width                   : buttonWidth
                buttonActiveColor       : app.programColorSleep
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    bottom              : programAway.top
                    left                : parent.left
                    bottomMargin        : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = false ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = true ; programAway.selected=false
                    refreshScreen()
                }
            }

            Text {
                id                      : tempSleep
                text                    : app.programTempSleep.includes('.') ? app.programTempSleep + "°" : app.programTempSleep + ".0°"
                color                   : "black"
                anchors {
                    verticalCenter      : programSleep.verticalCenter
                    left                : programSleep.right
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : programAway
                buttonText              :  ""
                height                  : buttonHeight
                width                   : buttonWidth
                buttonActiveColor       : app.programColorAway
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : buttonActiveColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    bottom              : valueDown.top
                    left                : parent.left
                    bottomMargin        : 2
                    leftMargin          : isNxt ? 10 : 5
                }
                onClicked: {
                    yearprogramDate.selected = false ; monthprogramDate.selected = false ; dayprogramDate.selected = false ; buttonprogramDays.selected = false ; programComfort.selected = false ; programHome.selected = false ; programSleep.selected = false ; programAway.selected=true
                    refreshScreen()
                }
            }

            Text {
                id                      : tempAway
                text                    : app.programTempAway.includes('.') ? app.programTempAway + "°" : app.programTempAway + ".0°"
                color                   : "black"
                anchors {
                    verticalCenter      : programAway.verticalCenter
                    left                : programAway.right
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

//------

            YaLabel {
                id                      : valueDown
                buttonText              :  ""
                height                  : tempHeight * 0.7
                width                   : tempWidth  * 0.7
                buttonBorderWidth       : 0
                buttonActiveColor       : "white"
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : selectedColor
                hoveringEnabled         : isNxt
                selected                : false
                enabled                 : true
                textColor               : "black"
                anchors {
                    bottom              : parent.bottom
                    left                : programAway.left
                    bottomMargin        : 2
                }
                Image {
                    id                  : imgValueDown
                    source              : app.downImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    if (yearprogramDate.selected )  { changeprogramDate("year","-") }
                    if (monthprogramDate.selected ) { changeprogramDate("month","-") }
                    if (dayprogramDate.selected )   { changeprogramDate("day","-") }
                    if (buttonprogramDays.selected ){ 
                        if (app.programDays > 1) {
                            app.programDays = app.programDays - 1
                            sDay = ( app.programDays -1 ) % 7 + 1
// remove 6 fields from scheduleTime and scheduleProgram
                            for (var i = 1; i <= 6; i++) {
                                app.scheduleTime.splice(app.scheduleTime.length - 1, 1)
                                app.scheduleProgram.splice(app.scheduleProgram.length - 1, 1)
                            }                        
                            dayIndexValue = Math.floor( ( app.programDays - 1)  / 7 ) * 7 + 1
                        }
                    }
                    if (programComfort.selected )   { app.programTempComfort = app.max(6 , app.programTempComfort - 0.5 ) }
                    if (programHome.selected )      { app.programTempHome    = app.max(6 , app.programTempHome    - 0.5 ) }
                    if (programSleep.selected )     { app.programTempSleep   = app.max(6 , app.programTempSleep   - 0.5 ) }
                    if (programAway.selected )      { app.programTempAway    = app.max(6 , app.programTempAway    - 0.5 ) }
                    refreshScreen()
                }
            }

            YaLabel {
                id                      : valueUp
                buttonText              :  ""
                height                  : tempHeight * 0.7
                width                   : tempWidth  * 0.7
                buttonBorderWidth       : 0
                buttonActiveColor       : "white"
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : selectedColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : "black"
                anchors {
                    bottom              : parent.bottom
                    right               : programAway.right
                    bottomMargin        : 2
                }
                Image {
                    id                  : imgValueUp
                    source              : app.upImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                
                    if (yearprogramDate.selected )  { changeprogramDate("year","+") }
                    if (monthprogramDate.selected ) { changeprogramDate("month","+") }
                    if (dayprogramDate.selected )   { changeprogramDate("day","+") }
                    if (buttonprogramDays.selected ){
                    
                        app.programDays        = app.programDays + 1 

                        sDay = 0 
                        sDay = ( app.programDays -1 ) % 7 + 1
                        
                        app.scheduleTime.push('00:00')
                        app.scheduleProgram.push(2)

                        app.scheduleTime.push('07:00')
                        app.scheduleProgram.push(1)

                        app.scheduleTime.push('08:00')
                        app.scheduleProgram.push(3)

                        app.scheduleTime.push('18:00')
                        app.scheduleProgram.push(1)

                        app.scheduleTime.push('20:00')
                        app.scheduleProgram.push(0)

                        app.scheduleTime.push('23:00')
                        app.scheduleProgram.push(2)

                        dayIndexValue = Math.floor( ( app.programDays - 1 ) / 7 ) * 7 + 1

                    }
                    if (programComfort.selected )   { app.programTempComfort = app.min(30 , 1 * app.programTempComfort + 0.5 ) }
                    if (programHome.selected )      { app.programTempHome    = app.min(30 , 1 * app.programTempHome    + 0.5 ) }
                    if (programSleep.selected )     { app.programTempSleep   = app.min(30 , 1 * app.programTempSleep   + 0.5 ) }
                    if (programAway.selected )      { app.programTempAway    = app.min(30 , 1 * app.programTempAway    + 0.5 ) }
                    refreshScreen()
                }
            }
                        
        }

//----------------------------------------------------------------------

        Rectangle {
            id                      : toonProgramRight
            width                   : isNxt ? 190 : 152
            height                  : screenHeight - 4
            border {
                width: 0
                color: "black"
            }
            radius : 5
            anchors {
                right               : parent.right
                top                 : parent.top
                topMargin           : 2
                rightMargin         : 2
            }
            color                   : "white"

            Text {
                id                      : dayEditing
                text                    : dayIndexValue + sDay
                color                   : "black"
                anchors {
                    horizontalCenter    : parent.horizontalCenter
                    top                 : parent.top
                    topMargin           : buttonHeight / 2
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

            YaLabel {
                id                      : sedit
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                pixelsizeoverride       : true
                pixelsizeoverridesize   : isNxt ? 30 : 24
                anchors {
                    top                 : dayEditing.bottom
                    horizontalCenter    : dayEditing.horizontalCenter
                }
            }

            YaLabel {
                id                      : timeDown
                buttonText              :  ""
                height                  : tempHeight * 0.7
                width                   : tempWidth  * 0.7
                buttonBorderWidth       : 0
                buttonActiveColor       : "white"
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : selectedColor
                hoveringEnabled         : isNxt
                selected                : false
                enabled                 : true
                textColor               : "black"
                anchors {
                    top                 : sedit.bottom
                    horizontalCenter    : sedit.left
                    topMargin           : 10
                }
                Image {
                    id                  : imgTimeDown
                    source              : app.downImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    if ( sPeriod > 0 ) {
                        var currentindex = ( dayIndexValue - 1 + sDay ) * 6  +  sPeriod
                        var limit = app.scheduleTime[currentindex - 1] 
                        var hours=1 * app.scheduleTime[currentindex].substring(0,2)
                        var minutes=1 * app.scheduleTime[currentindex].substring(3,5)
                        if ( minutes == 0 ) { minutes = 50 ; hours = hours - 1 } else { minutes = minutes - 10 }
                        var newTime = ( "0" + hours).slice(-2) + ':' + ( "0" + minutes).slice(-2)
                        if (newTime != limit) { app.scheduleTime[currentindex] = newTime}
                        refreshScreen()
                    }
                }
            }

            YaLabel {
                id                      : timeUp
                buttonText              :  ""
                height                  : tempHeight * 0.7
                width                   : tempWidth  * 0.7
                buttonBorderWidth       : 0
                buttonActiveColor       : "white"
                buttonHoverColor        : hoverColor
                buttonSelectedColor     : selectedColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : "black"
                anchors {
                    top                 : sedit.bottom
                    horizontalCenter    : sedit.right
                    topMargin           : 10
                }
                Image {
                    id                  : imgTimeUp
                    source              : app.upImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    if ( sPeriod > 0 ) {
                        var currentindex = ( dayIndexValue - 1 + sDay ) * 6  +  sPeriod
                        if ( sPeriod == 5 ) { 
                            var limit = "24:00"
                        } else {
                            var limit = app.scheduleTime[currentindex + 1] 
                        }
                        var hours=1 * app.scheduleTime[currentindex].substring(0,2)
                        var minutes=1 * app.scheduleTime[currentindex].substring(3,5)
                        if ( minutes == 50 ) { minutes = 0 ; hours = hours + 1 } else { minutes = minutes + 10 }
                        var newTime = ( "0" + hours).slice(-2) + ':' + ( "0" + minutes).slice(-2)
                        if (newTime != limit) { app.scheduleTime[currentindex] = newTime}
                        refreshScreen()
                    }
                }
            }
                        

            YaLabel {
                id                      : changeComfort
                buttonText              :  "c"
                height                  : buttonWidth / 2
                width                   : buttonWidth / 2
                buttonActiveColor       : app.programColor[0]
                buttonHoverColor        : selectedColor
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                textColor               : "black"
                buttonBorderWidth       : 1
                pixelsizeoverride       : true
                pixelsizeoverridesize   : isNxt ? 30 : 24
                anchors {
                    bottom              : changeSleep.top
                    right               : changeSleep.right
                    bottomMargin        : 2
                }
                onClicked: {
                    app.scheduleProgram[( dayIndexValue - 1 + sDay ) * 6 + sPeriod] = 0
                    refreshScreen()
                }
            }

            YaLabel {
                id                      : changeSleep
                buttonText              :  "s"
                height                  : buttonWidth / 2
                width                   : buttonWidth / 2
                buttonActiveColor       : app.programColor[2]
                buttonHoverColor        : selectedColor
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                textColor               : "black"
                buttonBorderWidth       : 1
                pixelsizeoverride       : true
                pixelsizeoverridesize   : isNxt ? 30 : 24
                anchors {
                    bottom              : parent.bottom
                    right               : parent.horizontalCenter
                    bottomMargin        : buttonHeight * 2
                    rightMargin         : 2
                }
                onClicked: {
                    app.scheduleProgram[( dayIndexValue - 1 + sDay ) * 6 + sPeriod] = 2
                    refreshScreen()
                }
            }

            YaLabel {
                id                      : changeHome
                buttonText              :  "h"
                height                  : buttonWidth / 2
                width                   : buttonWidth / 2
                buttonActiveColor       : app.programColor[1]
                buttonHoverColor        : selectedColor
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                textColor               : "black"
                buttonBorderWidth       : 1
                pixelsizeoverride       : true
                pixelsizeoverridesize   : isNxt ? 30 : 24
                anchors {
                    bottom              : changeAway.top
                    right               : changeAway.right
                    bottomMargin        : 2
                }
                onClicked: {
                    app.scheduleProgram[( dayIndexValue - 1 + sDay ) * 6 + sPeriod] = 1
                    refreshScreen()
                }
            }

            YaLabel {
                id                      : changeAway
                buttonText              :  "a"
                height                  : buttonWidth / 2
                width                   : buttonWidth / 2
                buttonActiveColor       : app.programColor[3]
                buttonHoverColor        : selectedColor
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                textColor               : "black"
                buttonBorderWidth       : 1
                pixelsizeoverride       : true
                pixelsizeoverridesize   : isNxt ? 30 : 24
                anchors {
                    bottom              : parent.bottom
                    left                : parent.horizontalCenter
                    bottomMargin        : buttonHeight * 2
                    leftMargin          : 2
                }
                onClicked: {
                    app.scheduleProgram[( dayIndexValue - 1 + sDay ) * 6 + sPeriod] = 3
                    refreshScreen()
                }
            }

        }

//----------------------------------------------------------------------

        Rectangle {
            id                      : toonProgramMiddle
            width                   : isNxt ? 550 : 440
            height                  : screenHeight - 4
            border {
                width: 1
                color: "black"
            }
            radius : 5
            anchors {
                left                : toonProgramLeft.right
                top                 : parent.top
                topMargin           : 2
                leftMargin          : 2
            }
            color                   : activeColor

//------ row 1

            Text {
                id                      : dayIndex1
                text                    : dayIndexValue
                color                   : "black"
                anchors {
                    left                : parent.left
                    verticalCenter      : s00.verticalCenter
                    leftMargin          : 10
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }

            YaLabel {
                id                      : s00
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : parent.top
                    left                : dayIndex1.right
                    topMargin           : 5
                    leftMargin          : 20
                }
                onClicked: { sDay = 0 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s01
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s00.top
                    left                : s00.right
                }
                onClicked: { sDay = 0 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s02
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s01.top
                    left                : s01.right
                }
                onClicked: { sDay = 0 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s03
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s02.top
                    left                : s02.right
                }
                onClicked: { sDay = 0 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s04
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s03.top
                    left                : s03.right
                }
                onClicked: { sDay = 0 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s05
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s04.top
                    left                : s04.right
                }
                onClicked: { sDay = 0 ; sPeriod = 5 ; refreshScreen() }
            }

//------ row 2

            Text {
                id                      : dayIndex2
                text                    : dayIndexValue + 1
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s10.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex2.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s10
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s00.bottom
                    left                : s00.left
                    topMargin           : 2
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s11
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s10.top
                    left                : s10.right
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s12
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s11.top
                    left                : s11.right
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s13
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s12.top
                    left                : s12.right
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s14
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s13.top
                    left                : s13.right
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s15
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s14.top
                    left                : s14.right
                }
                visible                 : (dayIndex2.text <= app.programDays )
                onClicked: { sDay = 1 ; sPeriod = 5 ; refreshScreen() }
            }

//------ row 3

            Text {
                id                      : dayIndex3
                text                    : dayIndexValue + 2
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s20.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex3.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s20
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s10.bottom
                    left                : s10.left
                    topMargin           : 2
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s21
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s20.top
                    left                : s20.right
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s22
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s21.top
                    left                : s21.right
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s23
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s22.top
                    left                : s22.right
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s24
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s23.top
                    left                : s23.right
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s25
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s24.top
                    left                : s24.right
                }
                visible                 : (dayIndex3.text <= app.programDays )
                onClicked: { sDay = 2 ; sPeriod = 5 ; refreshScreen() }
                
            }
            
//------ row 4

            Text {
                id                      : dayIndex4
                text                    : dayIndexValue + 3
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s30.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex4.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s30
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s20.bottom
                    left                : s20.left
                    topMargin           : 2
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s31
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s30.top
                    left                : s30.right
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s32
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s31.top
                    left                : s31.right
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s33
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s32.top
                    left                : s32.right
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s34
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s33.top
                    left                : s33.right
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s35
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s34.top
                    left                : s34.right
                }
                visible                 : (dayIndex4.text <= app.programDays )
                onClicked: { sDay = 3 ; sPeriod = 5 ; refreshScreen() }
            }
            
//------ row 5

            Text {
                id                      : dayIndex5
                text                    : dayIndexValue + 4
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s40.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex5.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s40
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s30.bottom
                    left                : s30.left
                    topMargin           : 2
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s41
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s40.top
                    left                : s40.right
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s42
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s41.top
                    left                : s41.right
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s43
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s42.top
                    left                : s42.right
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s44
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s43.top
                    left                : s43.right
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s45
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s44.top
                    left                : s44.right
                }
                visible                 : (dayIndex5.text <= app.programDays )
                onClicked: { sDay = 4 ; sPeriod = 5 ; refreshScreen() }
            }
            
//------ row 6

            Text {
                id                      : dayIndex6
                text                    : dayIndexValue + 5
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s50.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex6.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s50
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s40.bottom
                    left                : s40.left
                    topMargin           : 2
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s51
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s50.top
                    left                : s50.right
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s52
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s51.top
                    left                : s51.right
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s53
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s52.top
                    left                : s52.right
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s54
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s53.top
                    left                : s53.right
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s55
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s54.top
                    left                : s54.right
                }
                visible                 : (dayIndex6.text <= app.programDays )
                onClicked: { sDay = 5 ; sPeriod = 5 ; refreshScreen() }
            }
//------ row 7

            Text {
                id                      : dayIndex7
                text                    : dayIndexValue + 6
                color                   : "black"
                anchors {
                    left                : dayIndex1.left
                    verticalCenter      : s60.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : (dayIndex7.text <= app.programDays )
            }
        
            YaLabel {
                id                      : s60
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s50.bottom
                    left                : s50.left
                    topMargin           : 2
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 0 ; refreshScreen() }
            }
            YaLabel {
                id                      : s61
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s60.top
                    left                : s60.right
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 1 ; refreshScreen() }
            }
            YaLabel {
                id                      : s62
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s61.top
                    left                : s61.right
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 2 ; refreshScreen() }
            }
            YaLabel {
                id                      : s63
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s62.top
                    left                : s62.right
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 3 ; refreshScreen() }
            }
            YaLabel {
                id                      : s64
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s63.top
                    left                : s63.right
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 4 ; refreshScreen() }
            }
            YaLabel {
                id                      : s65
                height                  : buttonHeight
                width                   : buttonWidth/2
                buttonSelectedColor     : buttonActiveColor
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : selected ? "red" : "black"
                buttonBorderWidth       : selected ? 3 : 1
                anchors {
                    top                 : s64.top
                    left                : s64.right
                }
                visible                 : (dayIndex7.text <= app.programDays )
                onClicked: { sDay = 6 ; sPeriod = 5 ; refreshScreen() }
            }

//------

            YaLabel {
                id                      : weekDown
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
                    bottom              : parent.bottom
                    horizontalCenter    : s00.horizontalCenter
                    bottomMargin        : 5
                }
                Image {
                    id                  : imgWeekDown
                    source              : app.downImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    if (dayIndexValue <= ( app.programDays - 7 ) ) { dayIndexValue = dayIndexValue + 7 ; sDay = 0 ; sPeriod = 0}
                    refreshScreen()
                }
            }

            YaLabel {
                id                      : weekUp
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
                    bottom              : parent.bottom
                    horizontalCenter    : s05.horizontalCenter
                    bottomMargin        : 5
                }
                Image {
                    id                  : imgWeekUp
                    source              : app.upImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                    }
                }
                onClicked: {
                    if(dayIndexValue > 1) { dayIndexValue = dayIndexValue - 7 ; sDay = 0 ; sPeriod = 0}
                    refreshScreen()                
                }
            }
                        
//-------

            YaLabel {
                id                      : copypasteDay
                buttonText              : ""
                height                  : buttonHeight
                width                   : s00.width * 4
                buttonActiveColor       : activeColor
                buttonHoverColor        : selectedColor
                buttonSelectedColor     : selectedColor
                selected                : false
                hoveringEnabled         : isNxt
                enabled                 : true
                textColor               : "black"
                buttonBorderWidth       : 1
                anchors {
                    top                 : s60.bottom
                    left                : s61.left
                    topMargin           : 10
                }
                Image {
                    id                  : imgCopyPaste
                    source              : app.copyImg
                    anchors {
                        top             : parent.top
                        horizontalCenter: parent.horizontalCenter
                        topMargin       : buttonHeight / 10
                    }
                }
                onClicked: {
                    if ( ! selected ) {
// copy
                        imgCopyPaste.source = app.pasteImg
                        copyDayNumber = dayIndexValue  + sDay
                        selected = true
                        refreshScreen()
                    } else {
// paste
                        imgCopyPaste.source = app.copyImg
                        copypasteDay.selected = false
                        if (copyDayNumber > 0) {

                            for (var i = 0; i < 6; i++) {
                                app.scheduleTime[(pasteDayNumber - 1) * 6 + i ]    = app.scheduleTime[(copyDayNumber - 1) * 6 + i ]
                                app.scheduleProgram[(pasteDayNumber - 1) * 6 + i ] = app.scheduleProgram[(copyDayNumber - 1) * 6 + i ]
                            }
                            copyDayNumber = 0
                            refreshScreen()
                        }
                    }
                }

            }

            Text {
                id                      : textcopyDay
                color                   : "black"
                anchors {
                    left                : copypasteDay.left
                    leftMargin          : isNxt ? 50 : 40
                    verticalCenter      : copypasteDay.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
            }


            Text {
                id                      : textpasteDay
                color                   : "black"
                anchors {
                    right               : copypasteDay.right
                    rightMargin         : isNxt ? 50 : 40
                    verticalCenter      : copypasteDay.verticalCenter
                }
                font.pixelSize          : isNxt ? 25 : 20
                font.family             : qfont.italic.name
                font.bold               : true
                visible                 : copypasteDay.selected
            }


        }

    }

// ---------------------------------------------------- toonReadme

    Rectangle {
        id                      : toonReadMe
        visible                 : selectReadmeLanguage
        width                   : screenWidth
            height              : screenHeight
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
            id                  : textReadMe
            text                : ""
            width               : parent.width
            anchors {
                left            : parent.left
                top             : parent.top
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
            }
        }
    }

}
