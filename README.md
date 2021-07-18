### This Toon thermostat app supports 4 different ways to control heating from 1 or more Toons.

The 4 modes of this app :
 - Standard : like the large thermostat function plus other functions.
 - Mirror   : control the same heating with more Toons.
 - Master   : take over the control of the Toon connected to the heating.
 - Local    : control local temperature via the heating of the other Toon.

The GUI of this app has :
 - 1 Tile for current temperature, target temperature and program state.
 - 1 Beautiful screen to control the heating and a button to enter setup.
 - 1 Setup function with 3 sub screens :
    - Info screen with explanation and language selection for the app.
        ( Nederlands / English / Deutsch )
    - App mode selection : Standard / Mirror / Master / Local.
    - Toon layout selection screen.
        ( More on that further below )

The setup screens have clickable pictures to select the mode and Toon layout.

### The app modes : 
<i>(you can use this app on more Toons but need it on one Toon only)</i>

<b>Standard Mode</b> is to control the heating like you do with the large thermostat function. You can use up and down arrows but also simply click a target temperature so you do not need to push a button 20 times to set the temperature 10 degrees higher or lower.
<br><b><i>Example : The current target temperature is 12 degrees and you click on 22 to put the target on 22 degrees. You can also use up and down arrow keys for smaller steps.</b></i>

<b>Mirror Mode</b> mirrors the thermostat of a Toon located somewhere else. Control is based on the temperature measured by the other Toon. 
Pushing a button on either of the Toons is mirrored to the other and has the same effect on the heating.
<br><b><i>Example : You can control the heating in the downstairs living room from your bedroom in the attic. No need to climb those stairs down and up again because you have 2 Toons 'connected' to control the heating.</b></i>

<b>Master Mode</b> overrrules the temperature setting on another Toon.
Pushing a button on the other Toon is a short change on that Toon because it is overruled by the state of this Toon.
<br><b><i>Example : Your lovely kids in the living room may try to play with the heating but you are in control from the kitchen. No need to rush into the living room and end up with a burnt meal in the oven.</b></i>

<b>Local Mode</b> it seems as if the heating is connected to this Toon and not to the other (where it actually is connected)..... 
Local Mode uses the local temperature of the Toon to control the Toon to which the heating is connected.
When the Local temperature is too low the heating has to be turned on and when the Local temperature is too high the heating has to be turned off.
And this is what this mode does. It simply keeps the setpoint of the other Toon with the heating on 30 degrees to keep the heating on and on 6 degrees to keep the heating off.
This way it seems as if the heating is connected to the Toon with this app......
Make sure that the produced heat arrives in the room where the temperature is measured......
So close the radiators located with the other Toon and open the radiators located with this Toon.
That way the produced heat arrives at the Toon which is measuring the temperature.
<br><b><i> Example : The heating is connected to a Toon in the living room and you spend most time in the kitchen where you would like to control the temperature. It seems as if the heating is connected to the Toon with this app in the kitchen. <br>(also see remark 1 below)</b></i>

Remarks :
 1) When you have the app in Local mode you can also put the app on the Toon with the heating and run that in Mirror mode so both Toons act the same.
    (this way you can control the temperature at the location of the Toon in Local mode from 2 places)
 2) Switching between modes is simple. With a few clicks you switch from Standard to Mirror or Master to adjust/master the temperature somewhere else and you switch back to Standard with a few clicks .
 3) You may use both this app and the large thermostat together in case you have a heating connected and also want to Mirror / Master one other Toon.
 4) Unnecessary remarks : A not so brilliant idea to use 2 Toons in Local mode so they use each others heating. The plan of having 2 Toons in Master mode may also need some rethinking.

### The layout of your Toon screen.

In the standard layout you have a large thermostat function and next to it are 4 smaller tiles.

In all modes you have the option to hide / unhide the large standard thermostat function to have 2 more tile positions.
You may want this because  :

 - There is no heating connected to this Toon and you want to control the temperature in this room.
 - There is no heating connected to this Toon and you want to Mirror / Master a Toon in another room.
 - You have a heating connected to this Toon and you use this app in Standard mode to have an extra tile position.
 - You just want 6 tiles and no heating control. (just add/remove this app to switch between the layouts)
 
### Installation :

You can install this app manually without ToonStore :

 - Open an sftp tool like WinScp/Mozilla on Windows to browse to your Toon.
 - On your Toon go to /qmf/qml/apps and create a folder thermostatPlus.
 - In that folder you put at least the qml files and the drawables folder.
 - Restart the GUI. ( On your Toon go to > Settings > TSC > Restart GUI )


Thanks for reading and enjoy.
