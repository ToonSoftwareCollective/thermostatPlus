import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0
import BxtClient 1.0

App { id : app

    property url thermostatPlusTileUrl      : "ThermostatPlusTile.qml"
    property     ThermostatPlusTile            thermostatPlusTile

    property url thermostatPlusControlUrl   : "ThermostatPlusControl.qml"
    property     ThermostatPlusControl         thermostatPlusControl

    property url thermostatPlusSettingsUrl  : "ThermostatPlusSettings.qml"
    property     ThermostatPlusSettings        thermostatPlusSettings

// fill some language tables

    property variant languages      : ["Nederlands", "English", "Deutsch" ]

    property variant statesLng      : [ ["Comfort", "Thuis", "Slapen","Weg"] , ["Comfort", "Home", "Sleep","Away"] , ["Komfort", "Zuhause", "Schlafen","Unterwegs"] ]
    property variant temporaryLng   : [ "Tijdelijk" , "Temporary " , "Momentan" ]
    property variant programOnOffLng: [ ["Programma Aan", "Programma Uit"] , ["Program On", "Program Off"] , ["Programm An", "Programm Aus"] ]

// guiMode is a trick to avoid the 'TERUG' on the settings screen.
// The settings screens is reached from the Control screen via the Tile.

    property string guiMode

// lastSettingsMode remembers which last settings screen was active
    property int lastSettingsMode

    property string mode            : ""
    property string toonIP          : ""
    property int currentLng         : -1

    property variant xmlhttpGetStatus
    property variant xmlhttpSetStatus
    property variant toonStatusData

    property bool xmlhttpGetStatusAsyncMode

    property int currentTempInt
    property string currentTemp     : ""

    property int currentSetpointInt : 0
    property string currentSetpoint : ""
    property int programState       : 0
    property int toonprogramState   : 0 // retrieved from Toon and used to turn it off when needed
    property int activeState        : -1
    property string activeStateText : ""
    property int nextState          : -1
    property string nextStateStr    : ""
    property string nextSetpoint    : ""
    property string nextTime        : ""
    property bool burnerInfo        : false

    property string fireBigTile     : "file:///qmf/qml/apps/thermostatPlus/drawables/fireBigTile.png"
    property string fireSmallTile   : "file:///qmf/qml/apps/thermostatPlus/drawables/fireSmallTile.png"

    property string fireBigControl  : "file:///qmf/qml/apps/thermostatPlus/drawables/fireBigControl.png"
    property string fireSmallControl: "file:///qmf/qml/apps/thermostatPlus/drawables/fireSmallControl.png"

    property string upImg           : "file:///qmf/qml/apps/thermostatPlus/drawables/Up.png"
    property string downImg         : "file:///qmf/qml/apps/thermostatPlus/drawables/Down.png"

    property string copyImg           : "file:///qmf/qml/apps/thermostatPlus/drawables/copy.png"
    property string pasteImg         : "file:///qmf/qml/apps/thermostatPlus/drawables/paste.png"

    property string settingsFile    : "file:///mnt/data/tsc/thermostatPlusSettings.json"
    property string variablesFile   : "file:///qmf/www/thermostatPlusVariables.html"
    property variant oldVariables : {}

// -------------------------------------- Program and temperature variables

    property string programDate
    property variant nextDateTime
    property variant nextDateTimeInt    : 0

    property int programStateOverruleCounter : 0

    property int programDays
    property string programTempComfort
    property string programTempHome
    property string programTempSleep
    property string programTempAway

// https://www.color-hex.com/
    property string programColorComfort : "#fcb515" // bruin
    property string programColorHome    : "#e4ff78" // geel
    property string programColorSleep   : "#dd6fc8" // paars
    property string programColorAway    : "#6897bb" // blauw

    property variant programColor : [ programColorComfort , programColorHome , programColorSleep , programColorAway ]

    property variant scheduleTime : []
    property variant scheduleProgram : []
    property int     scheduleIndex
    property int     nextscheduleIndex

    property int scheduleSetpointInt

// -------------------------------------- Location of user settings file

    FileIO {
        id                          : userSettingsFile
        source                      : settingsFile
     }

// -------------------------- Structure user settings from settings file

    property variant userSettingsJSON : {}

// -------------------------------------------- Register tile and screen

    function init() {

        const args = {
            thumbCategory       : "general",
            thumbLabel          : "Thermostat +",
            thumbIcon           : "qrc:/tsc/flameSmall.png",
            thumbIconVAlignment : "center",
            thumbWeight         : 30
        }

        registry.registerWidget("tile"  , thermostatPlusTileUrl     , this, "thermostatPlusTile", args);

        registry.registerWidget("screen", thermostatPlusControlUrl  , this, "thermostatPlusControl");

        registry.registerWidget("screen", thermostatPlusSettingsUrl , this, "thermostatPlusSettings");

    }

// ------------------------------------- Actions right after APP startup

    Component.onCompleted: {

// read user settings

        try {
            userSettingsJSON = JSON.parse(userSettingsFile.read());
            log(JSON.stringify(userSettingsJSON))

// When I look with an editor in the file it is handy to see the number of programDate 8=)
// It does not need to be there because programDate == scheduleTime.length and also programDate == scheduleProgram

            mode                = userSettingsJSON['mode'];
            toonIP              = userSettingsJSON['toonIP'];
            currentLng          = languages.indexOf(userSettingsJSON['language'])
            lastSettingsMode    = userSettingsJSON['lastSettingsMode']
            programState        = userSettingsJSON['programState'];
            programDate         = userSettingsJSON['programDate'];
            programDays         = userSettingsJSON['programDays'];
            programTempComfort  = userSettingsJSON['programTempComfort'];
            programTempHome     = userSettingsJSON['programTempHome'];
            programTempSleep    = userSettingsJSON['programTempSleep'];
            programTempAway     = userSettingsJSON['programTempAway'];
            scheduleTime        = userSettingsJSON['scheduleTime'];
            scheduleProgram     = userSettingsJSON['scheduleProgram'];
            programDays         = scheduleTime.length / 6 ;

        } catch(e) {
            log('Startup : '+e)
            initUserSettings()
            saveSettings()
        }
        setscheduleIndex()
        correctprogramDate()
        guiMode         = 'Control'
// Master mode needs something to start with in case the 'Slave' is not reached during first getStatus call
        if (mode == 'Master') { currentSetpointInt = 1500 }
        getStatus("All")

    }

// ---------------------------------------------------------------------

    function initUserSettings() {

// first time of app start there is no data. This creates initial data.

        mode            = 'Standard'
        toonIP          = 'IP other Toon'
        currentLng      = 1

        lastSettingsMode = 5

        var today = new Date();
        var dd = right( '0' + String(today.getDate())      , 2 )
        var mm = right( '0' + String(today.getMonth() + 1) , 2 ) // January is 0!
        var yyyy = today.getFullYear();

        programState        = 0;
        programDate         = yyyy + '-' + mm + '-' + dd;
        programDays         = 7;
        programTempComfort  = 20;
        programTempHome     = 18;
        programTempSleep    = 12;
        programTempAway     = 10;

        scheduleTime        = []
        scheduleProgram     = []

        for (var i = 1; i <= programDays; i++) {

            scheduleTime.push('00:00')
            scheduleProgram.push(2)

            scheduleTime.push('07:00')
            scheduleProgram.push(1)

            scheduleTime.push('08:00')
            scheduleProgram.push(3)

            scheduleTime.push('18:00')
            scheduleProgram.push(1)

            scheduleTime.push('20:00')
            scheduleProgram.push(0)

            scheduleTime.push('23:00')
            scheduleProgram.push(2)
        }
    }

// ---------------------------------------------------------------------

    function saveSettings(){

        programDays         = scheduleTime.length / 6 ;

        if ( programDays > 0 ) {

            var tmpUserSettingsJSON = {
                "mode"                  :   mode,
                "language"              :   languages[currentLng],
                "toonIP"                :   toonIP,
                "lastSettingsMode"      :   lastSettingsMode,
                "programState"          :   programState,
                "programDate"           :   programDate,
                "programDays"           :   programDays,
                "programTempComfort"    :   programTempComfort,
                "programTempHome"       :   programTempHome,
                "programTempSleep"      :   programTempSleep,
                "programTempAway"       :   programTempAway,
                "scheduleTime"          :   scheduleTime,
                "scheduleProgram"       :   scheduleProgram
            }

            var settings = new XMLHttpRequest();
            settings.open("PUT", settingsFile);
            settings.send(JSON.stringify(tmpUserSettingsJSON));
        }
    }

// ---------------------------------------------------------------------

    function saveVariables(){

// write data to http://toon-ip/thermostatPlusVariables.html
// you may use this in other platforms like Domoticz

        var tmpVariablesJSON = {
            "mode"                  :   mode,
            "language"              :   languages[currentLng],
            "toonIP"                :   toonIP,
            "lastSettingsMode"      :   lastSettingsMode,
            "programState"          :   programState,
            "programDate"           :   programDate,
            "programDays"           :   programDays,
            "programTempComfort"    :   programTempComfort,
            "programTempHome"       :   programTempHome,
            "programTempSleep"      :   programTempSleep,
            "programTempAway"       :   programTempAway,
            "scheduleTime"          :   scheduleTime,
            "scheduleProgram"       :   scheduleProgram,
            "programStateOverruleCounter"       :   programStateOverruleCounter,
            "nextTime"              :   nextTime,
            "nextDateTime"          :   nextDateTime.toString(),
            "currentTemp"           :   currentTemp.replace(',','.'),
            "currentTempInt"        :   currentTempInt,
            "currentSetpointInt"    :   currentSetpointInt,
            "scheduleSetpointInt"   :   scheduleSetpointInt,
            "scheduleIndex"         :   scheduleIndex,
            "activeState"           :   activeState,
            "activeStateText"       :   activeStateText,
            "currentSetpoint"       :   currentSetpoint.replace(',','.'),
            "nextscheduleIndex"     :   nextscheduleIndex,
            "nextState"             :   nextState,
            "nextStateStr"          :   nextStateStr,
            "nextSetpoint"          :   nextSetpoint.replace(',','.'),
            "heatingOn"             :   burnerInfo
        }

        if ( JSON.stringify(oldVariables) != JSON.stringify(tmpVariablesJSON) ) {

            oldVariables = {
                "mode"                  :   mode,
                "language"              :   languages[currentLng],
                "toonIP"                :   toonIP,
                "lastSettingsMode"      :   lastSettingsMode,
                "programState"          :   programState,
                "programDate"           :   programDate,
                "programDays"           :   programDays,
                "programTempComfort"    :   programTempComfort,
                "programTempHome"       :   programTempHome,
                "programTempSleep"      :   programTempSleep,
                "programTempAway"       :   programTempAway,
                "scheduleTime"          :   scheduleTime,
                "scheduleProgram"       :   scheduleProgram,
                "programStateOverruleCounter"       :   programStateOverruleCounter,
                "nextTime"              :   nextTime,
                "nextDateTime"          :   nextDateTime.toString(),
                "currentTemp"           :   currentTemp.replace(',','.'),
                "currentTempInt"        :   currentTempInt,
                "currentSetpointInt"    :   currentSetpointInt,
                "scheduleSetpointInt"   :   scheduleSetpointInt,
                "scheduleIndex"         :   scheduleIndex,
                "activeState"           :   activeState,
                "activeStateText"       :   activeStateText,
                "currentSetpoint"       :   currentSetpoint.replace(',','.'),
                "nextscheduleIndex"     :   nextscheduleIndex,
                "nextState"             :   nextState,
                "nextStateStr"          :   nextStateStr,
                "nextSetpoint"          :   nextSetpoint.replace(',','.'),
                "heatingOn"             :   burnerInfo
            }

            var now      = new Date();

            tmpVariablesJSON = {
            "LastUpdate"            :   now.getFullYear() + '-' +
                    ('00'+(now.getMonth() + 1)   ).slice(-2) + '-' +
                    ('00'+ now.getDate()         ).slice(-2) + ' ' +
                    ('00'+ now.getHours()        ).slice(-2) + ":" +
                    ('00'+ now.getMinutes()      ).slice(-2) + ":" +
                    ('00'+ now.getSeconds()      ).slice(-2) + "." +
                    ('000'+now.getMilliseconds() ).slice(-3),
                "mode"                  :   mode,
                "language"              :   languages[currentLng],
                "toonIP"                :   toonIP,
                "lastSettingsMode"      :   lastSettingsMode,
                "programState"          :   programState,
                "programDate"           :   programDate,
                "programDays"           :   programDays,
                "programTempComfort"    :   programTempComfort,
                "programTempHome"       :   programTempHome,
                "programTempSleep"      :   programTempSleep,
                "programTempAway"       :   programTempAway,
                "scheduleTime"          :   scheduleTime,
                "scheduleProgram"       :   scheduleProgram,
                "programStateOverruleCounter"       :   programStateOverruleCounter,
                "nextTime"              :   nextTime,
                "nextDateTime"          :   nextDateTime.toString(),
                "currentTemp"           :   currentTemp.replace(',','.'),
                "currentTempInt"        :   currentTempInt,
                "currentSetpointInt"    :   currentSetpointInt,
                "scheduleSetpointInt"   :   scheduleSetpointInt,
                "scheduleIndex"         :   scheduleIndex,
                "activeState"           :   activeState,
                "activeStateText"       :   activeStateText,
                "currentSetpoint"       :   currentSetpoint.replace(',','.'),
                "nextscheduleIndex"     :   nextscheduleIndex,
                "nextState"             :   nextState,
                "nextStateStr"          :   nextStateStr,
                "nextSetpoint"          :   nextSetpoint.replace(',','.'),
                "heatingOn"             :   burnerInfo
            }

            var settings = new XMLHttpRequest();
            settings.open("PUT", variablesFile);
            settings.send(JSON.stringify(tmpVariablesJSON));
        }
    }

// ---------------------------------------------------------------------

    function log(tolog) {

        var now      = new Date();
        var dateTime = now.getFullYear() + '-' +
                ('00'+(now.getMonth() + 1)   ).slice(-2) + '-' +
                ('00'+ now.getDate()         ).slice(-2) + ' ' +
                ('00'+ now.getHours()        ).slice(-2) + ":" +
                ('00'+ now.getMinutes()      ).slice(-2) + ":" +
                ('00'+ now.getSeconds()      ).slice(-2) + "." +
                ('000'+now.getMilliseconds() ).slice(-3);
        console.log(dateTime+' thermostatPlus : ' + tolog.toString())

    }

// ---------------------------------------------------------------------

    function logall() {
        log('----------------------------------------------------------')
        log('logall mode                : '+mode)
        log('----')
        log('logall programState        : '+programState)
        log('logall OverruleCounter     : '+programStateOverruleCounter)
        log('----')
        log('logall programDate         : '+programDate)
        log('logall programDays         : '+programDays)
        log('logall nextTime            : '+nextTime)
        log('logall nextDateTime        : '+nextDateTime)
        log('logall currentTemp         : '+currentTemp)
        log('logall currentSetpointInt  : '+currentSetpointInt)
        log('logall scheduleSetpointInt : '+scheduleSetpointInt)
        log('----')
        log('logall scheduleIndex       : '+scheduleIndex)
        log('logall activeState         : '+activeState)
        log('logall activeStateText     : '+activeStateText)
        log('logall currentSetpoint     : '+currentSetpoint)
        log('----')
        log('logall nextscheduleIndex   : '+nextscheduleIndex)
        log('logall nextState           : '+nextState)
        log('logall nextStateStr        : '+nextStateStr)
        log('logall nextSetpoint        : '+nextSetpoint)
        log('----')
        log('logall scheduleTime        : '+scheduleTime.length / 6)
        log('logall scheduleProgram     : '+scheduleProgram.length/ 6)
        log('logall burnerInfo          : '+burnerInfo)
    }


// ---------------------------------------------------------------------

    function correctprogramDate() {

// correct programDate to valid date for this schedule
// ( add/substract as many times the the amount of programDays as posible )

        var dt1 = new Date(programDate + " 00:00:00");

// substract now - programDate and devide by 1000ms*60s*60m*24h to get number of days to add/substract

        var Difference_In_Days = Math.floor( ( Date.now() -  dt1 ) / 86400000 )

        var daysToAdd = Math.floor(Difference_In_Days / programDays) * programDays

        if ( daysToAdd != 0 ) {

            log('programDate '+programDate+' daysToAdd : '+daysToAdd)

            dt1.setDate(dt1.getDate() + daysToAdd )

            programDate = dt1.getFullYear() + '-' + right( '0' + String(dt1.getMonth() + 1) , 2 ) + '-' + right( '0' + String(dt1.getDate()) , 2 ) ;

            log('New programdate : '+programDate)

            saveSettings()
        }

    }

// ---------------------------------------------------------------------

    function setscheduleIndex() {

// scheduleIndex is the index in scheduleProgram and scheduleTime of current moment

// substract now - programDate and devide by 1000ms*60s*60m*24h to get number of days to add/substract

        var Difference_In_Days = Math.floor( ( Date.now() -  Date.parse(programDate +" 00:00:00") ) / 86400000 )

        var index = Difference_In_Days * 6

        if (index >= scheduleProgram.length) {
// we leave the current program table and need to shift the complete table to the new period
            correctprogramDate()
            index = 0
        }

// move to right period in de schedule day

        var now   = new Date();

        var scheduleHHMM = Number( scheduleTime[index].replace(':','') )
        var nowHHMM = Number( ( "0" + now.getHours()).slice(-2) + ( "0" + now.getMinutes()).slice(-2) )
        var periodCounter = 0

        while ( ( scheduleHHMM <= nowHHMM ) &&  (periodCounter < 6 ) ) {
            periodCounter = periodCounter + 1
            index = index + 1
            try {
                scheduleHHMM = Number( scheduleTime[index].replace(':','') )
            } catch(e) { // last schedule day, last period
                scheduleHHMM = 2400
            }

        }
        scheduleIndex = index - 1
    }

// ---------------------------------------------------------------------

    function runProgram() {

// Disable Own / Remote internal Toon program if required

        switch(mode) {
        case 'Standard': if (toonprogramState != 0) { setStatus("LocalProgramOnOff","off") } ; break
        case 'Mirror'  : programState = 0                      ; break
        case 'Master'  : setStatus("RemoteProgramOnOff","off") ; break
        case 'Local'   : if (toonprogramState != 0) { setStatus("LocalProgramOnOff","off") }
                         setStatus("RemoteProgramOnOff","off") ; break
        }

// app program actions

        if (programState == 2 ) {
// my setpoint was changed by an other Toon more than 2 times in a row or by a push button. ( Master / Local / Mirror mode or interactive setting change )
// and program was running so I may want to try to reactivate my own program again because the schedule goes to a new period
            if ( Date.now() >= nextDateTimeInt ) {
                log('Try to reactivate own program by forcing programState = 1')
                programState = 1 ; programStateOverruleCounter = 0
                saveSettings()
            }
        }

        setscheduleIndex()

        getStatus("Timer")

        if (programState == 1 ) {
            if ( programStateOverruleCounter > 1 ) {
// my setpoint was changed by an other Toon during more than 2 checks in a row. ( Master / Local / Mirror mode )
                programState = 2
            } else {
                if ( currentSetpointInt != scheduleSetpointInt) {
                    programStateOverruleCounter = programStateOverruleCounter + 1
// Standard sets this Toon and no further action follows
// Mirror   does not get here because program is diabled above 8=), when enabled above it will set other Toon based on program state.
// Master   sets other Toon based on program state, which sets new value for currentSetpointInt which is used below
// Local    sets this Toon and burner info of this Toon is used below to control RemoteSetpoint
                    setStatus("Program", activeState )
                    getStatus("Timer")
                } else {
                    programStateOverruleCounter = 0
                }
            }
        }

// regular Timer actions not needed for Standard and Mirror because these follow buttons and Standard may follow program
// regular Timer is used to force state for Master and Local modes only.

        if (mode == 'Master' ) {
            setStatus("RemoteSetpoint",currentSetpointInt)
        }

        if (mode == 'Local' ) {
            if (burnerInfo) { setStatus("RemoteSetpoint",3000) }
                            else { setStatus("RemoteSetpoint",600) }
        }
    }

// ---------------------------------------------------------------------

    function getStatus(calledBy)  {

// calledBy : Timer / Control / All

        if (typeof xmlhttpGetStatus != "undefined") { xmlhttpGetStatus.abort() }

        var hostaddress = 'localhost'

        if ( (mode == 'Mirror') || (mode == 'Master') ) { hostaddress = toonIP }

        if (calledBy == "All") {xmlhttpGetStatusAsyncMode = false}

        xmlhttpGetStatus = new XMLHttpRequest();

        xmlhttpGetStatus.open('GET', 'http://'+hostaddress+'/happ_thermstat?action=getThermostatInfo', xmlhttpGetStatusAsyncMode);

        xmlhttpGetStatus.onreadystatechange = function() {

            if (xmlhttpGetStatus.readyState == XMLHttpRequest.DONE) {

                if (xmlhttpGetStatus.status === 200) {

                    var returnString = xmlhttpGetStatus.response

                    toonStatusData = JSON.parse(returnString);

                    toonprogramState = toonStatusData['programState']

// in Master mode we only want the remote setpoint when called by All ( exit settings and 5 program buttons)

// Find currentSetpointInt , needed to see if we need to switch to new schedule setting

                    if ( ( mode != 'Master')  || (calledBy == 'All' ) ) {

                        currentSetpointInt = toonStatusData['currentSetpoint']

                    }

// Find currentSetpoint , text for display

                    currentSetpoint = String(Math.round(currentSetpointInt / 10 ))

                    currentSetpoint = currentSetpoint.slice(0,-1) + "," + currentSetpoint.slice(-1)

// Find burnerInfo, currentTempInt, currentTemp all for display

                    currentTempInt = toonStatusData['currentTemp']

                    currentTemp = String(Math.round(currentTempInt / 10 ))

                    currentTemp = currentTemp.slice(0,-1) + "," + currentTemp.slice(-1)

                    burnerInfo = toonStatusData['burnerInfo'] == 1

// Find / Calculate activeState for display

//                    activeState = 1 * toonStatusData['activeState'] <== komt uit programma van Toon zelf en dat staat uit 8=)

// vlak na schakelmoment en voor schakelen klopt dit niet want dan moet het de vorige state zijn....... is dit erg want we gaan toch meteen schakelen

                    if ( programState == 0 ) {
                        activeState = -1
                    } else {
                        activeState = scheduleProgram[scheduleIndex]
                    }

// Calculate wanted scheduleSetpointInt and activeStateText for program switching

                    if ( programState == 0 ) {
                        scheduleSetpointInt = 0
                        activeStateText =  ""
                    } else {
                        switch(scheduleProgram[scheduleIndex]) {
                            case 0: scheduleSetpointInt = programTempComfort * 100 ; activeStateText = statesLng[currentLng][0] ; break
                            case 1: scheduleSetpointInt = programTempHome    * 100 ; activeStateText = statesLng[currentLng][1] ; break
                            case 2: scheduleSetpointInt = programTempSleep   * 100 ; activeStateText = statesLng[currentLng][2] ; break
                            case 3: scheduleSetpointInt = programTempAway    * 100 ; activeStateText = statesLng[currentLng][3] ; break
                        }
                    }

// Calculate nextscheduleIndex which may be some days later when some days have all periods with same temperature

                    nextscheduleIndex = ( scheduleIndex + 1 ) % ( programDays * 6 )

                    var safetyCounter = 0
                    while ( ( safetyCounter < scheduleProgram.length ) &&
                            ( scheduleProgram[scheduleIndex] == scheduleProgram[nextscheduleIndex] ) ) {
                        nextscheduleIndex =  ( nextscheduleIndex + 1 ) % (  programDays * 6 )
                        safetyCounter = safetyCounter + 1
                    }

// Calculate nextState

                    if (programState == 0)
                         { nextState = -1 }
                    else { nextState = scheduleProgram[ nextscheduleIndex] }

// Calculate  nextSetpoint, nextStateStr and nextDateTime

                    nextStateStr = "...."
                    nextSetpoint = "...."
                    nextTime = "...."
                    nextDateTime = "...."
                    nextDateTimeInt = 0

                    if (nextState > -1) {
                        nextStateStr = statesLng[currentLng][nextState]

                        switch(nextState) {
                            case 0: nextSetpoint = programTempComfort ; break
                            case 1: nextSetpoint = programTempHome    ; break
                            case 2: nextSetpoint = programTempSleep   ; break
                            case 3: nextSetpoint = programTempAway    ; break
                        }

                        nextTime = scheduleTime[ nextscheduleIndex ]

                        nextDateTime = new Date(programDate + " " + nextTime)

                        var nextscheduleIndexDay = Math.floor ( nextscheduleIndex / 6 )

                        if ( nextscheduleIndex > scheduleIndex ) {
                            nextDateTime = addDays(nextDateTime , nextscheduleIndexDay)
                        } else {
                            nextDateTime = addDays(nextDateTime , nextscheduleIndexDay + programDays)
                        }
                        nextDateTimeInt = Date.parse(nextDateTime)
                    }

                    xmlhttpGetStatusAsyncMode = false

                } else {

                    xmlhttpGetStatusAsyncMode = true

                    currentTemp = "...."

// note that the value currentSetpoint = "......" blocks the setStatus function so no settings are sent anymore

                    currentSetpoint = "......"

// do not disable the program, this used to bee the Toon program. Now it is in this app

//                    programState = 0

                    activeState = -1

                    activeStateText =  ""

                    nextState = -1

                    burnerInfo = false

                    log("getStatus got error " + hostaddress + '  ' +xmlhttpGetStatus.status)

                }
            }
        }

        xmlhttpGetStatus.send();

    }

// ---------------------------------------------------------------------

    function setStatus(what,value)  {

// ProgramOnOff                         : on | of
// RemoteProgramOnOff                   : on | of
// Program                              : Comfort | Home | Sleep | Away
// Setpoint ( degrees Celcius )         : nn.n
// RemoteSetpoint  ( degrees Celcius )  : nn.n

        if (currentSetpoint == "......") {
            log('setStatus can not '+what+'   '+value)
        } else {

            if (typeof xmlhttpSetStatus != "undefined") { xmlhttpSetStatus.abort() }

            var hostaddress = "localhost"

            if ( ( mode == 'Mirror' ) || ( mode == 'Master' ) ) { hostaddress = toonIP }

            var action = "http://"+hostaddress+"/happ_thermstat?action="

            switch(what) {
            case "LocalProgramOnOff":
                action = "http://localhost/happ_thermstat?action="
                if (value == "on") {
                    action = action + "changeSchemeState&state=1"
                } else {
                    action = action + "changeSchemeState&state=0"
                }
                break;
            case "RemoteProgramOnOff":
                action = "http://"+toonIP+"/happ_thermstat?action="
                if (value == "on") {
                    action = action + "changeSchemeState&state=1"
                } else {
                    action = action + "changeSchemeState&state=0"
                }
                break;
            case "Program":
                switch(value) {
                case 0: currentSetpointInt = Math.round(programTempComfort * 100) ; break;
                case 1: currentSetpointInt = Math.round(programTempHome    * 100) ; break;
                case 2: currentSetpointInt = Math.round(programTempSleep   * 100) ; break;
                case 3: currentSetpointInt = Math.round(programTempAway    * 100) ; break;
                }
                action = action + "setSetpoint&Setpoint="+currentSetpointInt
                break;
            case "ProgramButton":
                switch(value) {
                case "Comfort": currentSetpointInt = Math.round(programTempComfort * 100) ; break;
                case "Home":    currentSetpointInt = Math.round(programTempHome    * 100) ; break;
                case "Sleep":   currentSetpointInt = Math.round(programTempSleep   * 100) ; break;
                case "Away":    currentSetpointInt = Math.round(programTempAway    * 100) ; break;
                }
                if (programState == 1) {programState = 2}
                action = action + "setSetpoint&Setpoint="+currentSetpointInt
                break;
            case "Setpoint":
                switch(value) {
                case "up"   : if (currentSetpointInt < 3000 ) currentSetpointInt = currentSetpointInt + 10 ; break
                case "down" : if (currentSetpointInt >  600 ) currentSetpointInt = currentSetpointInt - 10 ; break
                default     : if (value < 600) { value = 600 };  if (value > 3000) { value = 3000 } ; currentSetpointInt = value; break
                }
                if (programState == 1) {programState = 2}
                action = action + "setSetpoint&Setpoint="+currentSetpointInt
                break;
            case "RemoteSetpoint":
                action = "http://"+toonIP+"/happ_thermstat?action="
                              if (value < 600) { value = 600 };  if (value > 3000) { value = 3000 } ; var switchTo = value ;
                action = action + "setSetpoint&Setpoint="+value
                break;
            }

            xmlhttpSetStatus = new XMLHttpRequest();

            xmlhttpSetStatus.open("GET", action, false);

            xmlhttpSetStatus.onreadystatechange = function() {

                if (xmlhttpSetStatus.readyState == XMLHttpRequest.DONE) {

                    if (xmlhttpSetStatus.status === 200) {

                        var returnString = xmlhttpSetStatus.response

                    } else {

                        log("setStatus got error " + hostaddress + '  ' +xmlhttpSetStatus.status)
                    }
                }
            }

            xmlhttpSetStatus.send();

        }

    }

// ------------------------------------------- some handy functions

    function right(str, chr)
    {
        return str.slice(str.length-chr,str.length);
    }

    function left(str, chr)
    {
        return str.slice(0, chr - str.length);
    }

    function max(max1, max2)
    {
        if (max1 > max2) { var result = max1 } else { var result = max2 }
        return result;
    }

    function min(min1, min2)
    {
        if (min1 < min2) { var result = min1 } else { var result = min2 }
        return result;
    }

    function addDays(date, days) {
      const copy = new Date(Number(date))
      copy.setDate(date.getDate() + days)
      return copy
    }

// ---------------------------------------------------- WebSocket Server

    WSS {
        id:wss
        webPage:"/qmf/qml/apps/thermostatPlus/Thermostat+.html"
        encryption:true
        requestHandler: handleWSSRequest
    }

    function wssWrapper(action,param) {
        var result = "Unsupported action : "+action
        if (action == "enableWSS")          { result = wss.enableWSS() }
        if (action == "disableWSS")         { result = wss.disableWSS() }
        if (action == "getUser" )           { result = wss.user }
        if (action == "getPassword" )       { result = wss.password }
        if (action == "getWSSEnabled" )     { result = wss.listen }
        if (action == "getwssIPAddress" )   { result = wss.wssIPAddress }
        if (action == "getwssPort" )        { result = wss.wssPort }
        if (action == "setwssPort" )        { wss.wssPort = param }
        if (action == "getAccessedUrl" )    { result = wss.accessedUrl }
        return result
    }

    function handleWSSRequest(clientRequest) {       // Receive clientRequest

        var Status = "Error"
        var request = clientRequest.split(":")

        if ((request[0] != "thermostatPlus") || (request[1] != wss.user) || (request[2] != wss.password) ){
            log(">"+clientRequest+"< ERROR")
        } else {

            if (request[3] == "GetStatus") {
                getStatus("All")
                Status = "OK"
            }
            
            if (request[3] == "SetPoint") {
                setStatus("Setpoint",request[4])
                getStatus("Control")
                Status = "OK"
            }
            
            if (request[3] == "ProgramButton") {
                if (request[4] == "Program") { 
                    if (programState == 1) {
                        programState = 0
                    } else {
                        programState = 1
                        programStateOverruleCounter = 0
                        setStatus("Program", activeState )
                    }
                    saveSettings()
                    runProgram()
                } else {
                    setStatus("ProgramButton",request[4])
                    getStatus("All")
                }
                Status = "OK"
            }

        }
        
        var serverResponseJSON = {}

        if (Status == "Error") {
            serverResponseJSON = {"Status":"ERROR","request":clientRequest}
        } else {
            serverResponseJSON = {
                "Status":"OK",
                "txtComfort"        : statesLng[currentLng][0],
                "Comfort"           : (activeState == 0),
                "txtHome"           : statesLng[currentLng][1],
                "Home"              : (activeState == 1),
                "txtSleep"          : statesLng[currentLng][2],
                "Sleep"             : (activeState == 2),
                "txtAway"           : statesLng[currentLng][3],
                "Away"              : (activeState == 3),
                "currentSetpoint"   : currentSetpoint+"°",
                "currentTemp"       : currentTemp+"°",
                "mode"              : mode,
                "burnerInfo"        : burnerInfo,
                "programState"      : programState,
                "programFuture"     :(programState == 2 && burnerInfo) ? temporaryLng[currentLng] + " " + currentSetpoint + "°": (nextState > -1 ) ? nextStateStr + " (" + nextSetpoint  + "°) " + nextTime : "",
                "activeState"       : activeState,
                "program"           : (activeState > -1) ? statesLng[currentLng][activeState] : "",
                "programOnStr"      : programOnOffLng[currentLng][0],
                "programOffStr"     : programOnOffLng[currentLng][1],
                "programOn"         : (programState > 0)
            }
        }

        var serverResponse = JSON.stringify(serverResponseJSON)

        return serverResponse                   // Return serverResponse
    }

}
