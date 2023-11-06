/*
   
This file implements a websocket server and :
        - has some properties but only 2 are required :
            - the filename of the web page it has to publish ( has to be an html file in your app folder )
            - the name of a custom function to receive the client request as parameter 1 and produce an answer for the client
        - optionally encrypts end bas64 encodes the traffic
        - manages iptables for your websocket server port
        - gives easy access to : Toon IP address, Mobile Login user and password, ....
    - contains a wrapper function wssWrapper which you can copy into your app and use without modification needed
        - hides the details to make life easy for you.
    - has documentation like 
        - required details for a web page with websocket client with/without data encryption ( end of file )
        - a short description of how it does what.
    - a complete use case is in the app thermostatPlus (install it and check files in /qmf/qml/apps/thermostatPlus)
        
This websocket server, how does it do what ? :

    - keeps the value of the websocket server port in /mnt/data/tsc/<webpagename>.websocketPort
        - webpagename is the name of the webpage you specify as one of the required properties

    - during startup it reads this /mnt/data/tsc/<webpagename>.websocketPort and
        - when nothing found (not saved before) or there is the value -1 it means server stays down
            - not your webpage but a message saying your websocket server is down is published
            - variable wssPort gets a value of a free port from iptables you may use on your configuration page
        - a valid value means that the server is to be started on the port found
            - your webpage is published
            - variable wssPort gets the value found in the file or a value of a free port you may use or 

    - publishing makes sure the client in your page can find the websocket server port
        - in your page to be published you need to use $$wssPort$$ as port number. 
            This is replaced by the actual value of wssPort during publishing.
            (Example code is at the end of this file.)

    - concerning iptables and wssPort
        - when the server is not enabled it will assign a free port number to variable wssPort during startup
        - on your configuration screen you should create a function to change the value of this wssPort before activating the websocket server
        - (you need to do this because one may want port forwarding on a router and the suggested port may already forwarded to something else)
        - enabling of the websocket server via the wrapper function wssWrapper("enableWSS")
            - will only work and reboot Toon when the port wssPort is free
            - opens the port in iptables and saves the number in /mnt/data/tsc/<webpagename>.websocketPort
        - disabling of the websocket server via the wrapper function wssWrapper("disableWSS")
            - will only work and reboot Toon when the port wssPort is in use in iptables
            - removes the opening of the port from iptables and writes -1 in /mnt/data/tsc/<webpagename>.websocketPort
        
Minimal implementation : Copy the next into the ....App.qml of your app

// Create the WSS object in your ....App.qml

    WSS {
        id:wss
        webPage:"/qmf/qml/apps/<yourapp>/<thumbLabel>.html" // this page is published as http://toon-ip/<thumbLabel>.html
                                                            //   use the 'thumbLabel' you used to register your tile and remove any spaces from it
                                                            //   'thumbLabel' keeps it unique and is recognised by the user
        encryption:false                                    // use unencrypted traffic between client and server ( use the same in your html )
        requestHandler: handleWSSRequest                    // name without quotes of function below to act and answer to clientRequest
    }

// Your app code in ...App.qml can use the next function like : 
//      - var toonIP = wssWrapper("getwssIPAddress")
//      - assuming your ...App.qml has id app then other qml files can use : var toonIP = app.wssWrapper("getwssIPAddress")
//

    function wssWrapper(action,param) {
        var result = "Unsupported action : "+action
        if (action == "setwssPort" )        { wss.wssPort = param }         // changes the proposed websocket server port
        if (action == "enableWSS")          { result = wss.enableWSS() }    // enables WSS when wss.wssPort is a free port and reboots
        if (action == "disableWSS")         { result = wss.disableWSS() }   // disbles WSS when wss.wssPort is used and reboots
        if (action == "getUser" )           { result = wss.user }           // gets user from Mobile Login settings
        if (action == "getPassword" )       { result = wss.password }       // gets password from Mobile Login settings
        if (action == "getWSSEnabled" )     { result = wss.listen }         // true when server is running, false when server is down
        if (action == "getwssIPAddress" )   { result = wss.wssIPAddress }   // the IP address of your Toon
        if (action == "getwssPort" )        { result = wss.wssPort }        // gets the current wssPort
        if (action == "getAccessedUrl" )    { result = wss.accessedUrl }    // gets url used by client
        return result
    }

// Create the function (which you named in your WSS) to process the requests in ....App.qml :

    function handleWSSRequest(clientRequest) {       // Receive clientRequest

        var answer = "....."

// Do your thing and create an answer based on the clientRequest
 
        return answer
    }

*/
// ------------------------------------------------------- Start of code

import QtQuick 2.1
import QtWebSockets 1.1
import BxtClient 1.0
import FileIO 1.0

Item {
    id:wss
// ---------------------------------------------------------------- Data

// ----- Required Configuration properties

    property string webPage                 // The web page for the client like : "/qmf/qml/apps/thermostatPlus/Thermostat+.html"
    property var requestHandler: null       // The reference to the function to process the received message
                                            // handleWSSRequest when you have a function 'function handleWSSRequest(clientRequest) { .... return response }'
                                            // Find an example in ThermostatPlusApp.qml

// ----- Optional Configuration properties

    property string downPage                // html string to replace default down page contents
    property bool encryption : false        // false : plain text | true : use sencdec encryption and base64 encoding

// ----- Output properies

    property string user                    // user from /qmf/etc/lighttpd/lighttpd.user
    property string password                // password from /qmf/etc/lighttpd/lighttpd.user
    property string accessedUrl             // url used to access websocket server
    property string wssIPAddress            // The IP adress of Toon
    property int wssPort                    // websocket server port : generated starting at 8801
    property alias listen : server.listen   // The socket server is up and running when this is true

// ----- Internal variables

    property string wssHost : "0.0.0.0"     // Adress to listen on : Either "127.0.0.1" for local only or "0.0.0.0" for network interface
    property string wssResponse             // Answer to be sent back to client
    property variant ipTablesContent : []

// ------------------------------------- Actions right after APP startup

    Component.onCompleted: {

        wssPort = readWSSPortAppFile()  // check if a wssPort has been opened

// iptables can be cleared due to factory reset. So even if wssPort can be read back the firewall may be closed
        if ( (wssPort > -1) && (iptablesLineNumber(wssPort) != -1) ) {
            publishWebPage()
            server.host=wssHost
            server.port=wssPort
            server.listen=true
        } else {
            closeWebPage()
            server.listen=false
// Find a free port to publish on so you can show it as info on a settings page
            wssPort = iptablesFindFreePort()
        }
// Find the IP address of your Toon so you can show it as info on a settings page
        wssIPAddress = getWSSIPAddress()
    }

// --------------------------------------------------- Reboot functions

    property string configMsgUuid : ""

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

// -------------------------------------------- Get IP address function

    FileIO {
        id: tcpFile
        source: "file:///proc/net/tcp"
    }

    function getWSSIPAddress() {
        var ipAddress = "0.0.0.0"
        var tcpFileLines = tcpFile.read();
        var lines = tcpFileLines.split('\n');
        var hexAddress = ""
        var i = 1
        while ( ( i < lines.length ) && (ipAddress == "0.0.0.0") ) {
            hexAddress = lines[i].toString()
            if (hexAddress.length > 0) {
                hexAddress = hexAddress.substring(hexAddress.indexOf(":")+1).replace(' ','')
                hexAddress = hexAddress.substring(0,hexAddress.indexOf(":"))
                if ( (hexAddress.substring(6,8) != "00" ) && (hexAddress.substring(6,8) != "7F") ) {
                    ipAddress = parseInt(hexAddress.substring(6,8),16)+"."+
                                parseInt(hexAddress.substring(4,6),16)+"."+
                                parseInt(hexAddress.substring(2,4),16)+"."+
                                parseInt(hexAddress.substring(0,2),16)
                }
            }
            i++
        }
        return ipAddress
    }
// --------------------------------------------------- Publish Web Page

    FileIO {
        id                          : webPageSource
        source                      : ""
     }

    FileIO {
        id                          : webPageTarget
        source                      : ""
     }

    function publishWebPage() {

        webPageSource.source = "file://"+webPage
        webPageTarget.source = "file:///qmf/www"+webPage.substring(webPage.lastIndexOf("/"))

        var wps = webPageSource.read();
        var wpslines = wps.split('\n');
        var wptlines = []
        for (var i=0; i<wpslines.length; i++) {
            wptlines.push(wpslines[i].toString().replace("$$wssPort$$",wssPort))
        }
        var done = webPageTarget.write(wptlines.join("\n"))
    }

    function closeWebPage() {

        if (downPage == "") { downPage = "<html><br><center><hr><h3>Sorry websocket server for '"+webPage.substring(webPage.lastIndexOf("/")+1)+ "' is down</h3><hr></center></html>" }
        webPageTarget.source = "file:///qmf/www"+webPage.substring(webPage.lastIndexOf("/"))
        var done = webPageTarget.write(downPage)
    }

// ------------------------------------------------------------ Security

    FileIO {
        id: webCredentials
        source: "file:///qmf/etc/lighttpd/lighttpd.user"
    }

    function getCredentials() {
        var credentials = webCredentials.read();
        var credentialsArray = credentials.split('\n')
        var firstcredentials = credentialsArray[0].split(':')
        user = firstcredentials[0]
        password = firstcredentials[1]
    }

    function getkeys() {
        var c0=user.charAt(0)
        var c1=":"
        var c2=password.charAt(0)
        return [ c0, c1, c2 ]
    }

    function sencdec(input, key0, key1, key2) {
/*

    sencdec : Symmetric encryption and decryption by JackV2020

    s(ymmetric) enc(ryption) dec(ryption) is where encryption and decryption use the same algorithm and keys.

    Parameters :
      input : the string to be encrypted / decrypted ( all unencrypted characters in value range 0..127 )
      key0  : character in value range from 0..127
      key1  : character in value range from 0..127
      key2  : character in value range from 0..127

    Algorithm in short :
      Characters in input are XoR-ed with per character changing keys key0, key1 and key2.
      By adding 128 to the keys an XoR will never produce a null character

    Notes:
      1) It uses 3 keys. Why 3 ?
      One key would give a max of 127 different values for the encryption algorithm.
      Two give 127 x 127 and 3 give 127 x 127 x 127 different values for the algorithm.
      The keys are used one by one to encrypt the characters of the input which may
      be unusual for an encryption algorithm I think and may be less easy to crack.
      2) Want more /less keys ?
      Feel free to change the code. Encryption/decryption speed will stay the same.
      3) Communicate with other systems ?
      When data stays in the system you could generate keys based on a hardware property like MAC.
      When you use this encryption method between systems, both need the same algorithm and keys.
      For this you would choose characters for the keys yourself and use them on both sides.

*/

      var enc0 = key0.charCodeAt(0) + 128;
      var enc1 = key1.charCodeAt(0) + 128;
      var enc2 = key2.charCodeAt(0) + 128;

      let result = "";
// Buffer to convert 1 string character of 'input' (length 2 bytes byte0=value, byte1=0) to char
      var temp = "";

      for (var i = 0; i < input.length; i++) {
        switch (i % 3) {
          case 0: // XoR the character with key1
            temp = String.fromCharCode(input.substring(i, i + 1).charCodeAt(0) ^ enc0);
            break;
          case 1: // XoR the character with key2
            temp = String.fromCharCode(input.substring(i, i + 1).charCodeAt(0) ^ enc1);
            break;
          case 2: // XoR the character with key3
            temp = String.fromCharCode(input.substring(i, i + 1).charCodeAt(0) ^ enc2);
            break;
        }
        result += temp; // append it to the result
      }

      return result;
    }

// ---------------------------------------- enable and disable functions

    function enableWSS() {
        if (iptablesLineNumber(wssPort) == -1) {
            saveWSSPortAppFile(wssPort)
            iptablesOpenPort(wssPort)
            rebootToon()
        }
// When we get here the port was already used and we can not reserve it
        return "Port is already in use"
    }

    function disableWSS() {
        saveWSSPortAppFile(-1)
        iptablesClosePort(wssPort)
        rebootToon()
        return "No return due to reboot."
    }

// -------------------------------------------------- iptables functions

    FileIO {
        id: iptablesFile
        source: "file:///etc/default/iptables.conf"
    }

    function getIPTables() {
        var currentIPTables = iptablesFile.read();
        ipTablesContent = currentIPTables.split('\n')
    }

    function saveIPTables() {
        var done = iptablesFile.write(ipTablesContent.join("\n"))
    }

    function iptablesLineNumber(port) {
        getIPTables()
        var lineNumberIPTables = -1
        var lookfor = " "+port+" "
        for (var i = 0 ; i < ipTablesContent.length - 1; i++ ) {
            if ( ipTablesContent[i].indexOf(lookfor) > 0 ) { lineNumberIPTables = i }
        }
        return lineNumberIPTables
    }

    function iptablesOpenPort(port) {
        if (iptablesLineNumber(port) == -1) {
            var insertAtEntry = iptablesLineNumber(22)
            ipTablesContent.splice(insertAtEntry, 0, "-A HCB-INPUT -p tcp -m tcp --dport "+port+" -j ACCEPT")
            saveIPTables()
        }
    }

    function iptablesClosePort(port) {
        var linenumber = iptablesLineNumber(port)
        if ( linenumber > -1 ) {
            ipTablesContent.splice(linenumber, 1)
            saveIPTables()
        }
    }

    function iptablesFindFreePort() {
        getIPTables()
        var port = 8800
        var used = true
        while (used) {
            used = false
            port = port + 1
            var lookfor = " "+port+" "
            for (var i = 0 ; i < ipTablesContent.length - 1; i++ ) {
                used = used || ( ipTablesContent[i].indexOf(lookfor) > 0 )
            }
            
        }
        return port
    } 

// ------------------------------------------------------ WSSPortAppFile

    FileIO {
        id                          : wssPortAppFile
        source                      : ""
     }

    function readWSSPortAppFile() {
        wssPortAppFile.source = "file:///mnt/data/tsc"+webPage.substring(webPage.lastIndexOf("/"))+".websocketPort"
        var wssPortInAdmin = wssPortAppFile.read()
        if (wssPortInAdmin == "") { wssPortInAdmin = "-1" }
        return wssPortInAdmin
    }

    function saveWSSPortAppFile(port) {
        wssPortAppFile.source = "file:///mnt/data/tsc"+webPage.substring(webPage.lastIndexOf("/"))+".websocketPort"
        var done = wssPortAppFile.write(port)
    }
    
// ----------------------------------------------- The websocket server

    WebSocketServer {
        id: server

        onClientConnected: {
            webSocket.onTextMessageReceived.connect(function(message) {
// getCredentials() so username and password are available for validation in app and for getkeys() below
                getCredentials()
                accessedUrl = webSocket.url
                try {
                    if (encryption) {
                        var keys = getkeys()
// Qt.btoa and Qt.atob do NOT do the same as my browser javascript btoa and atob.
// The b2a and a2b I found do the the same as my browser javascript btoa and atob
                        wssResponse = b2a(sencdec(requestHandler(sencdec(a2b(message),keys[0],keys[1],keys[2])),keys[0],keys[1],keys[2]))
                    } else {
                        wssResponse = requestHandler(message)
                    }
                } catch (e) {
                    wssResponse = "Error creating response : "+e
                }
                webSocket.sendTextMessage(wssResponse);
            });
        }

        onErrorStringChanged: {
            console.log(qsTr("WSS Server error: %1").arg(errorString));
        }

    }

// ------------------------------------------ encode and decode routines

// btoa and atob alternatives I found https://gist.github.com/JackV2020/952450f2c98febbf2024868649d97025

  function b2a(a) {
    var c, d, e, f, g, h, i, j, o, b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=", k = 0, l = 0, m = "", n = [];
    if (!a) return a;
    do c = a.charCodeAt(k++), d = a.charCodeAt(k++), e = a.charCodeAt(k++), j = c << 16 | d << 8 | e,
    f = 63 & j >> 18, g = 63 & j >> 12, h = 63 & j >> 6, i = 63 & j, n[l++] = b.charAt(f) + b.charAt(g) + b.charAt(h) + b.charAt(i); while (k < a.length);
    return m = n.join(""), o = a.length % 3, (o ? m.slice(0, o - 3) :m) + "===".slice(o || 3);
  }

  function a2b(a) {
    var b, c, d, e = {}, f = 0, g = 0, h = "", i = String.fromCharCode, j = a.length;
    for (b = 0; 64 > b; b++) e["ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/".charAt(b)] = b;
    for (c = 0; j > c; c++) for (b = e[a.charAt(c)], f = (f << 6) + b, g += 6; g >= 8; ) ((d = 255 & f >>> (g -= 8)) || j - 2 > c) && (h += i(d));
    return h;
  }

}

// *********************************************************************

/*

*** Creating a web page with a websocket client

    Two things to inlude in the <script></script> part of your html file :
    - the function sencdec from this WSS.qml which you find somewhere above in the code
    - the code between <script> and </script> below

<script>
// ------------------------------------------------ Web Socket functions

    let socket;

    function initWebSocket() {

// NOTE : $$wssPort$$ is replaced by the actual value of wssPort when your page is published during startup of the app

        var wsshost = 'ws://'+window.location.href.split("/")[2].split(":")[0]+':$$wssPort$$'
        socket = new WebSocket(wsshost);

        socket.addEventListener('open', (event) => {
            console.log('WebSocket Connection Opened:', event);
        });

        socket.addEventListener('message', (event) => {

// NOTE : this calls a function you fill in further below

            processResponse(event.data)                 
        });

        socket.addEventListener('error', (event) => {
            console.error('WebSocket Error:', event);
        });

        socket.addEventListener('close', (event) => {
            console.log('WebSocket Connection Closed:', event);
        });

// when the connection to Toon is lost I start retrying to connect every second

        socket.addEventListener('close', (event) => {
            console.log('WebSocket Connection Closed:', event);
            setTimeout(initWebSocket, 1000);
        });

    }

    initWebSocket();

// ---------------------------------------------- Send command to server

    var encryption = true
    
    function doSomething(param1, param2) {

// getkeys is further below
// btoa is standard javascript base64 encoding 
// you should copy sencdec from WSS.qml as mentioned

        var command = 'create a command to send based on param1 and param2';
        if (encryption) {
            var keys = getkeys()
            socket.send(btoa(sencdec(command, keys[0], keys[1], keys[2])));
        }else {
            socket.send(command);
        }
    }

// ---------------------------------------- Process response from server

    function processResponse(response) {

// getkeys is further below
// atob is standard javascript base64 decoding 
// you should copy sencdec from WSS.qml as mentioned

        if (encryption) {
            var keys = getkeys()
            response = sencdec(atob(response), keys[0], keys[1], keys[2])
        }

// Do something with the response string you received

    }

// ------------------------------------------------------------ Security

// You will need some fields on your web page to change default user and password

    var user="myUser"           // same as user in Toon "Mobile Login" 
    var password="myPassword"   // same as password in Toon "Mobile Login" 

    function getkeys() {
        var c0=user.charAt(0)
        var c1 = ":"
        var c2=password.charAt(0)
        return [c0, c1, c2 ]
    }

</script>
     
*/
