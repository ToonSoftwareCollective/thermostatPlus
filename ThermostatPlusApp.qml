import QtQuick 2.1
import qb.components 1.0
import qb.base 1.0;
import FileIO 1.0

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

    property string mode
    property string toonIP
    property int currentLng

    property variant xmlhttpGetStatus
    property variant xmlhttpSetStatus
    property variant toonStatusData

    property bool xmlhttpGetStatusAsyncMode

    property int currentTempInt
    property string currentTemp     : ""

    property int currentSetpointInt : 0
    property string currentSetpoint : ""
    property int programState       : 0
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

    property string settingsFile    : "file:///mnt/data/tsc/thermostatPlusSettings.json"

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
            mode            = userSettingsJSON['mode'];
            toonIP          = userSettingsJSON['toonIP'];
            currentLng      = languages.indexOf(userSettingsJSON['language'])
// Master mode needs something to start with in case the 'Slave' is not reached during first getStatus call
            if (mode == 'Master') { currentSetpointInt = 1500 }
        } catch(e) {
            log('Startup : '+e)
            mode            = 'Standard';
            toonIP          = 'IP other Toon';
            currentLng      = 1
            saveSettings()
        }
        guiMode         = 'Control'
        getStatus("All")
    }

// ---------------------------------------------------------------------

    function saveSettings(){

        var tmpUserSettingsJSON = {
            "mode"      :   mode,
            "language"  :   languages[currentLng],
            "toonIP"    :   toonIP
        }

        var settings = new XMLHttpRequest();
        settings.open("PUT", settingsFile);
        settings.send(JSON.stringify(tmpUserSettingsJSON));
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

    function getStatus(calledBy)  {

// calledBy : Timer / Control / All

//        log('getStatus '+calledBy)

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

// in Master mode we only want the remote setpoint when called by All

                    if ( ( mode != 'Master')  || (calledBy == 'All' ) ) {

                        currentSetpointInt = toonStatusData['currentSetpoint']

                    }

                    currentSetpoint = String(Math.round(currentSetpointInt / 10 ))

                    currentSetpoint = currentSetpoint.slice(0,-1) + "," + currentSetpoint.slice(-1)

                    burnerInfo = toonStatusData['burnerInfo'] == 1

                    currentTempInt = toonStatusData['currentTemp']

                    currentTemp = String(Math.round(currentTempInt / 10 ))

                    currentTemp = currentTemp.slice(0,-1) + "," + currentTemp.slice(-1)

                    programState = toonStatusData['programState']

                    activeState = toonStatusData['activeState']

                    if (activeState > -1) {
                        activeStateText = statesLng[currentLng][activeState]
                    } else {
                        activeStateText =  ""
                    }

                    nextState = toonStatusData['nextState']

                    if (nextState > -1) {
                        nextStateStr = statesLng[currentLng][nextState]

                        nextSetpoint = toonStatusData['nextSetpoint'].slice(0,-2) + "," + Math.round(toonStatusData['nextSetpoint'].slice(-2) / 10 )
                        var date = new Date(toonStatusData['nextTime']*1000)
                        nextTime = ("00"+date.getHours()).slice(-2)+":"+("00"+date.getMinutes()).slice(-2)
                    }

                    xmlhttpGetStatusAsyncMode = false

                } else {

                    xmlhttpGetStatusAsyncMode = true

                    currentTemp = "...."

                    currentSetpoint = "......"

                    programState = 0

                    activeState = -1

                    activeStateText =  ""

                    nextState = -1

                    burnerInfo = false

                    log("getStatus got error " + hostaddress + '  ' +xmlhttpGetStatus.status)

                }
            }
        }

//        log('getStatus start send')

        xmlhttpGetStatus.send();

//        log('getStatus end')
    }

// ---------------------------------------------------------------------

    function setStatus(what,value)  {

//        log('setStatus '+what+'   '+value)

        if (currentSetpoint == "......") {
            log('setStatus can not '+what+'   '+value)
        } else {

            if (typeof xmlhttpSetStatus != "undefined") { xmlhttpSetStatus.abort() }

            var hostaddress = "localhost"

            if ( ( mode == 'Mirror' ) || ( mode == 'Master' ) ) { hostaddress = toonIP }

// Next 2 are for Local mode where we need to control settings of other Toon

            if ( ( what == 'RemoteSetpoint' ) || ( what == 'RemoteProgramOnOff' ) ) { hostaddress = toonIP }

            var action = "http://"+hostaddress+"/happ_thermstat?action="

            switch(what) {
            case "ProgramOnOff":
            case "RemoteProgramOnOff":
                if (value == "on") {
                    action = action + "changeSchemeState&state=1"
                } else {
                    action = action + "changeSchemeState&state=0"
                }
                break;
            case "Program":
                switch(value) {
                case "Comfort":
                    action = action + "changeSchemeState&state=2&temperatureState=0"
                    break;
                case "Home":
                    action = action + "changeSchemeState&state=2&temperatureState=1"
                    break;
                case "Sleep":
                    action = action + "changeSchemeState&state=2&temperatureState=2"
                    break;
                case "Away":
                    action = action + "changeSchemeState&state=2&temperatureState=3"
                    break;
                }
                break;
            case "Setpoint":
                switch(value) {
                case "up"   : if (currentSetpointInt < 3000 ) currentSetpointInt = currentSetpointInt + 10 ; break
                case "down" : if (currentSetpointInt >  600 ) currentSetpointInt = currentSetpointInt - 10 ; break
                default     : if (value < 6) { value = 6 };  if (value > 30) { value = 30 } ; currentSetpointInt = value * 100 ; break
                }
                action = action + "setSetpoint&Setpoint="+currentSetpointInt
                break;
            case "RemoteSetpoint":
                              if (value < 6) { value = 6 };  if (value > 30) { value = 30 } ; var switchTo = value * 100 ;
                action = action + "setSetpoint&Setpoint="+switchTo
                break;
            }

//            log("setStatus action "+what+"  "+value+"  "+action)

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

//        log('setStatus end')

    }

}
