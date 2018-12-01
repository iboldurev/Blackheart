import QtQuick 2.2
import QtMultimedia 5.0
import "../variables.js" as Global

Item {
    id: valueSource
    SoundEffect {
        id: playWarning
        source: "../sounds/warning.wav"
    }

    property real kph: 0
    property real rpm: 0
    property real fuel: 0
    property real temperature: 0
    property int maxSpeed: 0
    property real batt: 0
    property real oil: 0
    property real dallas: 0
    property real trip1: Global.trip1
    property real trip2: Global.trip2
    property real trip3: Global.trip3
    property string connected: ""
    property string i0to50: "--.-"
    property string i0to100: "--.-"
    property string tahoColor: "#007f8a"
    property string speedColor: "#007f8a"
    property string fuelColor:  "#007f8a"
    property string fuelTxtColor:  "#b6b6b6"
    property string tempTxtColor:  "#b6b6b6"
    property string battTxtColor:  "#b6b6b6"
    property color clusterColor: "#d5e5f5"
    property real clusterOpacity: 0.4
    property bool playSpeed: false
    property bool playFuel: false
    property bool playTemp: false
    property bool playBatt: false
    property bool playTaho: false
    property bool sounds: false;
    property real battLamp: 0.1
    property real oilLamp: 0.1
    property real cornersLamp: 0.1
    property real lobeamLamp: 0.1
    property real hibeamLamp: 0.1
    property real fogFLamp: 0.1
    property real fogRLamp: 0.1
    property real fuelLamp: 0.1
    property int calculateSpeed: {
        Global.currentSpeed = kph;
        Global.voltage = batt;

        if (Global.currentSpeed > Global.lastSpeed) {
            Global.speedUp = 1;
            if (Global.nowStop) { Global.maxSpeed = 0; Global.nowStop = 0; Global.from0to50 = 0; Global.from0to100 = 0; i0to50 = "--.-"; i0to100 = "--.-";  }
            Global.lastSpeed = Global.currentSpeed;
        }
        if (Global.currentSpeed < Global.lastSpeed) { Global.speedUp = 0; Global.lastSpeed = Global.currentSpeed;}
        if (!Global.speedUp && Global.currentSpeed == 0 && Global.maxSpeed >0 ) Global.nowStop = 1;
        if (Global.speedUp && Global.currentSpeed > Global.maxSpeed) Global.maxSpeed = Global.currentSpeed;
        if (!Global.speedUp) Global.lastTime =  new Date().getTime();
        if (!Global.from0to50  && Global.currentSpeed >= 50) {
            Global.from0to50 =  (new Date().getTime() - Global.lastTime) * 3.4 / 1000 ;
            i0to50 = Global.from0to50.toFixed(2);
        }
        if (!Global.from0to100 && Global.currentSpeed >= 100) {
            Global.from0to100 =  (new Date().getTime() - Global.lastTime) * 3.4 / 1000;
            i0to100 = Global.from0to100.toFixed(2);
        }

        maxSpeed = Global.maxSpeed;

        if (rpm < Global.lowRPM) {
            playTaho = false;
            tahoColor = "#007f8a"; // BLUE
        }
        else if (rpm > Global.maxRPM) {
            playTaho = true;
            tahoColor = "#da243d"; // RED
        }
        else {
            playTaho = false;
            tahoColor = "#2a9b65"; // GREEN
        }

        if (kph < Global.lowSpd) speedColor = "#007f8a"; //BLUE
        else if (kph > Global.maxSpd) {
            playSpeed = true;
            speedColor = "#da243d"; //RED
        }
        else {
            playSpeed = false;
            speedColor = "#2a9b65"; //GREEN
        }

        if (fuel < Global.lowFuel) {
            playFuel = true;
            fuelColor = "#da243d";
        }
        else if (temperature < Global.lowTemp) fuelColor = "#007f8a";
        else if (temperature > Global.maxTemp) {
            playTemp = true;
            fuelColor = "#da243d";
        }
        else {
            playFuel = false;
            playTemp = false;
            fuelColor = "#2a9b65";
        }

        if (fuel < Global.lowFuel) {
            fuelLamp = 0.7;
            fuelTxtColor = "#da243d";
        }
        else {
            fuelLamp = 0.1;
            fuelTxtColor = "#b6b6b6"
        }
        if (temperature > Global.maxTemp) tempTxtColor = "#da243d"; else tempTxtColor = "#b6b6b6"

        if (Global.voltage < Global.lowBatt) {
            playBatt = true;
            battTxtColor = "#da243d";
        } else {
            playBatt = false;
            battTxtColor = "#b6b6b6";
        }

        //"#007f8a" blue
        //"#2a9b65" greens
        //"#da243d" red
        return 0;
    }
    property int turnSignal: 0
    property bool start: false


//    function randomDirection() {
//        return Math.random() > 0.5 ? Qt.LeftArrow : Qt.RightArrow;
//    }

}