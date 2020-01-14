import QtQuick 2.9
import QtQuick 2.12
import QtQuick.Window 2.2
import QtCharts 2.2
import QtQuick.Controls 2.3
import QtPositioning 5.4
import QtSensors 5.9
import QtQuick.Scene2D 2.9
import QtQuick 2.1
import QtQuick.Layouts 1.11
import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 2.12


Window {
    id: mainWindow
    visible: true
    width: 800
    height: 480
    color: "black"
    title: qsTr("Reach Technologies -- Medical Demo")

    signal submitTextField(string text)

    StackLayout {
        id: stackMain
        currentIndex: 0

        Rectangle {
            id: main
            signal sendPreviousScreen(int screen)
            signal startAnimation()


            FontLoader { id: sourceSansLight; source: "Fonts/SourceSansPro-Light.otf" }

            property var screen: { "main": 0, "schedule": 1, "patients": 2, "alarm": 3 }

            property int buttonsAnimationX: 760
            property color backgroundColor: "black"
            property color secondaryColor: "#939598"
            property color detailsColor: "#414142"
            property color mustard: "#c2b59b"
            property color purple: "#662D91"
            property color green: "#39B54A"
            property color blue: "#2075BC"
            property color textButtonColor: "white"


            property int circleDuration: 1000
            property int gifDuration: 1500
            property int gifDelay: 1200
            property int textDuration: 2000
            property int textDelay: 1500

            property string gender: "Male"
            property var patient: { "name": "Patient Name", "paNum": "148326", "admDate": "Feb 22, 2019", "admTime": "12:34 PM", "dob": "03/18/1967", "room": "201-B2", "bloodPressureSys": 120, "bloodPressureDia": 78 }
            property var patientObj

            property double subTextOpacity: 0.8
            property int opacityAnimation: 0

            function receivePatientInfo(patientJSON){ //TO DO: change to patientInfo (object)
                patientObj = JSON.parse(patientJSON);
                patient = patientObj;
            }

            function restartYAnimations(){
                patientAnimation.restart();
                secondRowAnimation.restart();
                conditionRowAnimation.restart();
                greenDotAnimation.restart();
                hospitalAnimation.restart();
                paNumAnimation.restart();
                clockAnimation.restart();
            }

            function restartOpacityAnimations(){

                gifAnimation.restart();
                circleAnimation.restart();
                textAnimation.restart();
                valueAnimation.restart();
                bloodPressureLeftAnimation.restart()
                bloodPressureRightAnimation.restart()
                buttonAnimation.restart()
                alarmButtonAnimation.restart()
                temperatureAnimation.restart()
            }

            function initializeOpacity(){
                //Initialize the target elements on opacity 0
                gifEKGLine.opacity = 0;
                gifPulseLine.opacity = 0;
                greenCircle.opacity = 0;
                purpleCircle.opacity = opacityAnimation;
                blueCircle.opacity = opacityAnimation;
                textEKG.opacity = opacityAnimation;
                textEKGValue.opacity = opacityAnimation;
                textBMP.opacity = opacityAnimation;
                textPulse.opacity = opacityAnimation;
                textPulseValue.opacity = opacityAnimation;
                textSpO.opacity = opacityAnimation;
                textInsulinPump.opacity = opacityAnimation;
                textUHr.opacity = opacityAnimation;
                element9.opacity = opacityAnimation;
                temperatureLeft.opacity = opacityAnimation;
                temperatureRight.opacity = opacityAnimation;
                salineTimer.sliderNumber = 25;
            }

            function restartSliders(){
                for (var i = 0; i < 25; ++i){
                    if(repeater.itemAt(i) !== null) {
                        repeater.itemAt(i).color = "#414142"
                    }

                    if(repeater1.itemAt(i) !== null) {
                        repeater1.itemAt(i).color = "#414142"
                    }

                    if(repeater2.itemAt(i) !== null) {
                        repeater2.itemAt(i).color = "#414142"
                    }
                }
                salineAnimation.restart()
                salineTimer.restart()
                salineTextAnimation.restart()

                hicorAnimation.restart()
                hicorTimer.restart()
                hicorTextAnimation.restart()

                glucagonAnimation.restart()
                glucagonTimer.restart()
                glucagonTextAnimation.restart()

            }


            function receiveAnimation(){
                initializeOpacity();
                restartYAnimations();
                restartOpacityAnimations();
                restartSliders();
            }

            color: backgroundColor

            NumberAnimation {
                id: mainAnimation
                target: main
                property: "opacity"
                running: stackMain.currentIndex === 0
                easing.type: Easing.InOutQuad
                duration: 300
                from: 0
                to: 1
            }

            AnimatedImage {
                id: gifEKGLine
                x: 103
                y: 317
                source: "Images/ekg-line.gif"
                opacity: 0
            }

            AnimatedImage {
                id: gifPulseLine
                x: 103
                y: 400
                source: "Images/pulse-line.gif"
                opacity: 0
            }

            SequentialAnimation {
                id: gifAnimation
                running: true
                PauseAnimation {
                    duration: main.gifDelay
                }

                NumberAnimation {
                    targets: [gifEKGLine, gifPulseLine]
                    property: "opacity"
                    easing.type: Easing.InOutQuad
                    duration: main.gifDuration
                    from: 0
                    to: 1
                }
            }

            Rectangle {
                id: greenCircle
                x: 38
                y: 297
                width: 70
                height: width
                radius: 200
                color: main.green
                opacity: main.opacityAnimation
            }
            SequentialAnimation {
                id: circleAnimation
                running: true
                PauseAnimation {
                    duration: 1000
                }
                NumberAnimation {
                    targets: [greenCircle, purpleCircle, purpleCircle, blueCircle]
                    property: 'opacity'
                    from: 0
                    to: 1
                    duration: main.circleDuration
                }
            }

            Rectangle {
                id: purpleCircle
                x: 334
                y: 324
                width: 105
                height: width
                radius: 300
                color: main.purple
                opacity: 0
            }

            Rectangle {
                id: blueCircle
                x: 40
                y: 382
                width: 70
                height: width
                radius: 200
                color: main.blue
                opacity: 0
            }

            Item {
                id: functionEKGContainer
                property int value: 87
                property bool up: true
                property int increment: 1
                property int ceiling: 105
                property int bottomValue: 80

                function increaseDecreaseNumber() {
                    if (up === true && value <= ceiling) {
                        value += increment

                        if (value === ceiling) {
                            up = false;
                        }
                    } else {
                        up = false
                        value -= increment;

                        if (value === bottomValue) {
                            up = true;
                        }
                    }
                    textEKGValue.text = value;

                }

                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: functionEKGContainer.increaseDecreaseNumber()
                }
            }

            Item {
                id: functionPulseContainer
                property int value: 80
                property bool up: true
                property int increment: 1
                property int ceiling: 105
                property int bottomValue: 80

                function increaseDecreaseNumber() {
                    if (up === true && value <= ceiling) {
                        value += increment

                        if (value === ceiling) {
                            up = false;
                        }
                    } else {
                        up = false
                        value -= increment;

                        if (value === bottomValue) {
                            up = true;
                        }
                    }

                    textPulseValue.text = value;

                }

                Timer {
                    interval: 1500
                    running: true
                    repeat: true
                    triggeredOnStart: true
                    onTriggered: functionPulseContainer.increaseDecreaseNumber()
                }
            }


            Image {
                id: imageLogoReach
                anchors { bottom: bottomLine.bottom; left: bottomLine.right; leftMargin: 10 }
                fillMode: Image.PreserveAspectFit
                source: "Images/logo-reach.png"
            }


//EKG
            Text {
                id: textEKG
                color: "#ffffff"
                text: qsTr("EKG")
                font.pixelSize: 12
                anchors { horizontalCenter: greenCircle.horizontalCenter; top: greenCircle.top; topMargin: 5 }
                opacity: 0
            }

            Text {
                objectName: "textEKGValue"
                id: textEKGValue
                color: "#ffffff"
                text: qsTr("92")
                font.pixelSize: 35
                font.family: sourceSansLight.name
                anchors.centerIn: greenCircle
                opacity: 0
            }

            Text {
                id: textBMP
                x: 63
                y: 349
                color: "#ffffff"
                text: qsTr("BMP")
                font.pixelSize: 11
                anchors { horizontalCenter: greenCircle.horizontalCenter; bottom: greenCircle.bottom; bottomMargin: 5 }
                opacity: 0
            }

            Text {
                id: textPulse
                color: "#ffffff"
                text: qsTr("Pulse")
                font.pixelSize: 12
                anchors { horizontalCenter: blueCircle.horizontalCenter; top: blueCircle.top; topMargin: 5 }
                opacity: 0
            }

            Text {
                id: textPulseValue
                color: "#ffffff"
                text: qsTr("95")
                font.pixelSize: 35
                font.family: sourceSansLight.name
                opacity: 0
                anchors.centerIn: blueCircle
            }

            SequentialAnimation {
                id: valueAnimation
                running: true
                PauseAnimation {
                    duration: main.textDelay
                }
                NumberAnimation {
                    targets: [textEKGValue, textPulseValue]
                    property: 'opacity'
                    to: 1
                    duration: main.textDuration
                }
            }


//Pulse
            Text {
                id: textSpO
                textFormat: Text.RichText
                text: "SpO<sub>2</sub>"
                color: "#ffffff"
                font.pixelSize: 11
                anchors { horizontalCenter: blueCircle.horizontalCenter; bottom: blueCircle.bottom; bottomMargin: 5 }
                opacity: 0
            }

            Text {
                id: textInsulinPump
                color: "#ffffff"
                text: qsTr("Insulin Pump")
                font.pixelSize: 13
                anchors { horizontalCenter: purpleCircle.horizontalCenter; top: purpleCircle.top; topMargin: 15 }
                opacity: 0
            }

            Text {
                id: textUHr
                color: "#ffffff"
                text: qsTr("U/Hr")
                font.pixelSize: 13
                anchors { horizontalCenter: purpleCircle.horizontalCenter; bottom: purpleCircle.bottom; bottomMargin: 10 }
                opacity: 0
            }

            Text {
                objectName: "insulinP"
                id: element9
                color: "#ffffff"
                text: qsTr("0.65")
                font.pixelSize: 40
                font.family: sourceSansLight.name
                anchors.centerIn: purpleCircle
                opacity: 0
            }

            SequentialAnimation {
                id: textAnimation
                running: true
                PauseAnimation {
                    duration: main.textDelay
                }
                NumberAnimation {
                    targets: [textEKG, textBMP, textPulse, textSpO, textInsulinPump, textUHr, element9]
                    property: 'opacity'
                    to: main.subTextOpacity
                    duration: main.textDuration
                }
            }


//Blood Pressure
            Text {
                id: textBloodPressure
                x: 32
                y: 169
                color: "#c2b59b"
                text: qsTr("Blood Pressure")
                font.pixelSize: 14
            }

            Text {
                objectName: "bpSys"
                id: element11
                property int bloodPressureLeft: 0
                anchors { right: imageBackSlashLarge.left; verticalCenter: imageBackSlashLarge.verticalCenter; rightMargin: 15}
                color: "#c2b59b"
                text: bloodPressureLeft
                font.pixelSize: 80

            }

            NumberAnimation {
                id: bloodPressureLeftAnimation
                property: "bloodPressureLeft"
                from: 0
                to: main.patient.bloodPressureSys
                duration: 4000
                target: element11
                running: true
            }

            Text {
                id: textSYS
                x: 32
                y: 192
                color: "#939598"
                text: qsTr("SYS")
                font.pixelSize: 10
            }

            Image {
                id: imageBackSlashLarge
                x: 188
                y: 212
                fillMode: Image.PreserveAspectFit
                source: "Images/back-slash-large.png"
            }

            Text {
                objectName: "bpDia"
                id: element13
                property int bloodPressureRight: 0
                anchors { left: imageBackSlashLarge.right; verticalCenter: imageBackSlashLarge.verticalCenter; leftMargin: 15}
                color: "#c2b59b"
                text: bloodPressureRight
                font.pixelSize: 80
            }

            NumberAnimation {
                id: bloodPressureRightAnimation
                property: "bloodPressureRight"
                from: 0
                to: main.patient.bloodPressureDia
                duration: 4000
                target: element13
                running: true
            }

            Text {
                id: textDIA
                x: 227
                y: 192
                color: "#939598"
                text: qsTr("DIA")
                font.pixelSize: 10
            }

            Text {
                id: textmmHg
                x: 140
                y: 170
                color: "#939598"
                text: qsTr("mmHg")
                font.pixelSize: 12
            }



//Temperature
            Text {
                id: textTemperature
                x: 32
                y: 93
                color: "white"
                text: qsTr("Temperature")
                font.pixelSize: 13
            }

            Text {
                id: textCelsius
                x: 128
                y: 96
                color: "#939598"
                text: qsTr("Celsius")
                font.pixelSize: 10
            }

            Text {
                objectName: "tempLeft"
                id: temperatureLeft
                anchors { top: textTemperature.bottom; left: parent.left; leftMargin: 30 }
                bottomPadding: 5
                color: "#c2b59b"
                text: qsTr("36.7")
                font.pixelSize: 32
                font.family: sourceSansLight.name
                opacity: 0
            }

            Image {
                id: imageDegreeLargeCurrent
                anchors { top: textTemperature.bottom; left: temperatureLeft.right; topMargin: 12; leftMargin: 5 }
                fillMode: Image.PreserveAspectFit
                source: "Images/degree-large.png"
            }

            Image {
                id: imageCircleArrow
                anchors { left: temperatureLeft.right; bottom: temperatureLeft.bottom; leftMargin: 20 ; bottomMargin: 16;  }
                fillMode: Image.PreserveAspectFit
                source: "Images/circle-arrow.png"
            }


            Text {
                objectName: "tempRight"
                id: temperatureRight
                anchors { top: textTemperature.bottom; left: imageCircleArrow.right; leftMargin: 20 }
                color: "#c2b59b"
                text: qsTr("37.4")
                font.pixelSize: 32
                font.family: sourceSansLight.name
                opacity: 0
            }

            Image {
                id: imageDegreeLargeHighest
                anchors { top: textTemperature.bottom; left: temperatureRight.right; topMargin: 12; leftMargin: 5 }
                fillMode: Image.PreserveAspectFit
                source: "Images/degree-large.png"
            }

            NumberAnimation {
                id: temperatureAnimation
                targets: [temperatureRight, temperatureLeft]
                property: "opacity"
                running: true
                easing.type: Easing.InOutQuad
                duration: 2000
                to: 1
            }

            Text {
                id: textHighest
                x: 235
                y: 130
                color: "#939598"
                text: qsTr("Highest")
                font.pixelSize: 11
            }

            Text {
                objectName: "tempHigh"
                id: element21
                x: 286
                y: 120
                color: "#939598"
                text: qsTr("38.4°")
                font.pixelSize: 24
                font.family: sourceSansLight.name
            }



//Patient Info
            Text {
                objectName: "textPatientName"
                id: textPatientName
                x: 12
                y: -10
                color: "#c2b59b"
                text: "Fred Dalton Thompson"
                font.pixelSize: 18
            }

            NumberAnimation {
                id: patientAnimation
                target: textPatientName
                property: "y"
                from: -10
                to: 16
                duration: 500
                running: true
            }

            Text {
                objectName: "textPatientGender"
                id: textPatientGender
                x: 32
                y: -10
                color: "white"
                text: main.gender
                font.pixelSize: 14
            }

            Text {
                id: textPatientAgeTitle
                x: 84
                y: -10
                color: "#939598"
                text: qsTr("Age")
                font.pixelSize: 13
            }

            Text {
                objectName: "textPatientAge"
                id: textPatientAgeValue
                x: 118
                y: -10
                color: "white"
                text: qsTr("88")
                font.pixelSize: 14
            }

            NumberAnimation {
                id: secondRowAnimation
                targets: [ textPatientGender, textPatientAgeTitle, textPatientAgeValue, textAdmission, admissionDateValue ]
                property: "y"
                from: -10
                to: 38
                duration: 500
                running: true
            }

//Patient Condition
            Image {
                objectName: "imageGreenDot"
                id: imageGreenDot
                property bool rounded: true
                property bool adapt: true
                x: 32
                y: -8
                width: 10
                height: width
                source: "Images/green-dot.png"

                layer.enabled: rounded
                layer.effect: OpacityMask {
                    maskSource: Item {
                        width: imageGreenDot.width
                        height: imageGreenDot.height
                        Rectangle {
                            anchors.centerIn: parent
                            width: imageGreenDot.adapt ? imageGreenDot.width : Math.min(imageGreenDot.width, imageGreenDot.height)
                            height: imageGreenDot.adapt ? imageGreenDot.height : width
                            radius: Math.min(width, height)
                        }
                    }
                }
            }

            NumberAnimation {
                objectName: "greenDotAnimation"
                id: greenDotAnimation
                target: imageGreenDot
                property: "y"
                from: -10
                to: 62
                duration: 500
                running: true
            }

            Text {
                id: textCondition
                x: 50
                y: -10
                color: "#939598"
                text: qsTr("Condition: ")
                font.pixelSize: 14
            }

            Text {
                objectName: "textConditionValue"
                id: textConditionValue
                x: 130
                y: -10
                color: "white"
                text: qsTr("Stable")
                font.pixelSize: 14
            }

            NumberAnimation {
                id: conditionRowAnimation
                targets: [ textCondition, textConditionValue, textRoomNo, roomValue ]
                property: "y"
                from: -10
                to: 58
                duration: 500
                running: true
            }

            Text
            {
                objectName: "patientNum"
                id: paNumValue
                x: 270
                y: -10
                color: "#c2b59b"
                text: main.patient.paNum
                renderType: Text.NativeRendering
                font.pixelSize: 14
            }
            NumberAnimation {
                id: paNumAnimation
                target: paNumValue
                property: "y"
                duration: 500
                from: -10
                to: 20
                running: true
            }

            Text
            {
                id: textAdmission
                x: 270
                y: -10
                color: "#939598"
                text: qsTr("Admission:")
                font.pixelSize: 14
            }

            Text
            {
                objectName: "admissionDateTime"
                id: admissionDateValue
                x: 355
                y: -10
                color: "white"
                text: main.patient.admDate + " / " + main.patient.admTime
                font.pixelSize: 14
            }




//Room Number
            Text
            {
                id: textRoomNo
                x: 270
                y: -10
                color: "#939598"
                text: qsTr("Room:")
                font.pixelSize: 14
            }

            Text
            {
                objectName: "roomNumber"
                id: roomValue
                x: 320
                y: -10
                color: "white"
                text: main.patient.room
                font.pixelSize: 14
            }


//Hospital Name
            Text
            {
                objectName: "hospitalName"
                id: textHospitalName
                x: 555
                y: -10
                color: "#c2b59b"
                text: "St Elsewhere"
                font.pixelSize: 14
            }
            NumberAnimation {
                id: hospitalAnimation
                target: textHospitalName
                property: "y"
                duration: 500
                from: -10
                to: 18
                running: true
            }



//Date and Time
            Rectangle {
                id: clockRow
                width: 50
                height: hourLabel.implicitHeight
                color: main.backgroundColor
                x: 640
                y: -10

                //Function to split and set the time
                function setTime() {
                    var time = new Date().toLocaleTimeString([], {hour:'2-digit'}, {minute:'2-digit'}).toString()
                    var hour = time.slice(1,2) === ":" ? time.slice(0, 1) : time.slice(0, 2)
                    var minute = time.slice(1, 2) === ":" ? time.slice(2,4) : time.slice(3,5)
                    var am_pm = time.slice(1,2) === ":" ? time.slice(5,7) : time.slice(6,8)
                    hourLabel.text = hour
                    minutesLabel.text = minute
                    am_pmLabel.text = am_pm
                }

                Text {
                    id: hourLabel
                    font.pixelSize: 14
                    color: "white"
                    anchors { right: colonLabel.left; }

                }

                Text {
                    id: colonLabel
                    font.pixelSize: 14
                    text: ":"
                    anchors { right: minutesLabel.left; bottom: parent.bottom }

                    SequentialAnimation on color {
                        loops: Animation.Infinite
                        ColorAnimation { from: "white"; to: main.backgroundColor; duration: 1000 }
                        ColorAnimation { from: main.backgroundColor; to: "white"; duration: 1000 }
                    }
                }

                Text {
                    id: minutesLabel
                    font.pixelSize: 14
                    color: "white"
                    anchors { right: am_pmLabel.left; bottom: parent.bottom }
                }

                Text {
                    id: am_pmLabel
                    font.pixelSize: 13
                    leftPadding: 5
                    bottomPadding: 1
                    color: "white"
                    anchors { right: parent.right; bottom: parent.bottom }
                }

                //Timer to update the time using the setTime() function"
                Timer {
                    id: timeTimer
                    interval: 1000
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: clockRow.setTime()
                }

            }

            NumberAnimation {
                id: clockAnimation
                target: clockRow
                property: "y"
                from: -10
                to: 40
                duration: 500
                running: true
            }

            Label {
                id: currentDateLabel
                property date currentDate: new Date()
                elide: Text.ElideRight
                font.pixelSize: 13
                horizontalAlignment: Text.AlignRight
                anchors { top: clockRow.bottom; right: topLine.left; rightMargin: 39; topMargin: 3 }
                color: main.secondaryColor

                //Function to set the date with the format "Weekday, Month day (Eg. Monday, June 10)"
                function setDate() {
                    var date = new Date();
                    var weekdays = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
                    var months = ['January','February','March','April','May','June','July','August','September','October','November','December'];

                    var weekday = weekdays[ date.getDay() ];
                    var month = months[ date.getMonth() ];
                    var day = date.getDate();

                    var secs = date.getTime();

                    currentDateLabel.text = weekday + ", "+ month + " " + day
                }
            }

            //Timer to update the date using the setDate() function"
            Timer {
                id: dateTimer
                interval: 1000
                repeat: true
                running: true
                triggeredOnStart: true
                onTriggered: currentDateLabel.setDate()
            }

            Image
            {
                id: topLine
                x: 729
                y: 10
                fillMode: Image.PreserveAspectFit
                source: "Images/line-65.png"
            }

            Image {
                id: middleLine
                anchors { top: topLine.bottom; horizontalCenter: topLine.horizontalCenter; topMargin: 46 }
                source: "Images/line-224.png"
                fillMode: Image.PreserveAspectFit
            }


            Image{
                id: bottomLine
                anchors { top: middleLine.bottom; horizontalCenter: middleLine.horizontalCenter; topMargin: 46 }
                fillMode: Image.PreserveAspectFit
                source: "Images/line-78.png"
            }


//Last Bolus
            Text
            {
                id: textLastBolus
                anchors { verticalCenter: textInsulinPump.verticalCenter;  horizontalCenter: lastBolusValue.horizontalCenter; }
                color: "#c2b59b"
                text: qsTr("Last Bolus")
                font.pixelSize: 13
            }

            Text
            {
                objectName: "lastBolusValue"
                id: lastBolusValue
                x: 466
                y: 350
                color: "#c2b59b"
                text: qsTr("3.0")
                font.family: sourceSansLight.name
                font.pixelSize: 40
            }

            Text
            {
                id: textU
                anchors { verticalCenter: textUHr.verticalCenter;  left: lastBolusValue.left; leftMargin: 2 }
                width: 19
                height: 16
                color: "#939598"
                text: qsTr("Hr")
                font.pixelSize: 13
            }

//IOB
            Text
            {
                id: textIOB
                anchors { verticalCenter: textInsulinPump.verticalCenter;  horizontalCenter: iobValue.horizontalCenter; }
                color: "#c2b59b"
                text: qsTr("IOB")
                font.pixelSize: 13
            }

            Text
            {
                objectName: "iobValue"
                id: iobValue
                x: 555
                y: 350
                color: "#c2b59b"
                text: qsTr("2.3")
                font.family: sourceSansLight.name
                font.pixelSize: 40
            }

            Text
            {
                id: textU1
                anchors { verticalCenter: textUHr.verticalCenter;  left: iobValue.left; leftMargin: 2 }
                width: 21
                height: 14
                color: "#939598"
                text: qsTr("U")
                font.pixelSize: 12
            }


//Glucose
            Text
            {
                id: textGlucose
                anchors { verticalCenter: textInsulinPump.verticalCenter;  horizontalCenter: glucoseValue.horizontalCenter; }
                color: "#c2b59b"
                text: qsTr("Glucose")
                font.pixelSize: 13
            }

            Text
            {
                objectName: "glucoseValue"
                id: glucoseValue
                x: 643
                y: 350
                color: "#c2b59b"
                text: qsTr("130")
                font.family: sourceSansLight.name
                font.pixelSize: 40
            }

            Text
            {
                id: textMgDL
                anchors { verticalCenter: textUHr.verticalCenter;  left: glucoseValue.left; leftMargin: 5 }
                color: "#939598"
                text: qsTr("Mg/DL")
                font.pixelSize: 13
            }


//Medications
            Text {
                id: elementTextMedication
                x: 372
                y: 93
                color: "#c2b59b"
                text: qsTr("Medications")
                font.pixelSize: 13
            }


//Saline
            Text {
                id: elementTextSaline
                x: 405
                y: 118
                color: "white"
                text: qsTr("Saline")
                font.pixelSize: 14
            }
            Text {
                objectName: "SalineVal"
                id: elementTextSalineVal
                property int salineValue: 0
                x: 401
                y: 130
                color: "#c2b59b"
                text: salineValue
                font.pixelSize: 40
                font.family: sourceSansLight.name

                function doIt( val ) {
                    for (var i = 0; i < repeater.count; ++i)
                    {
                        if(repeater.itemAt(i).y+5 >= val)
                        {
                            repeater.itemAt(i).color = main.mustard
                        }
                        else
                        {
                            repeater.itemAt(i).color = "#414142"
                        }
                    }
                }

                onTextChanged: {
                    salineValue = elementTextSalineVal.text
                    //console.log("Saline Value changed to " + salineValue + " --> " + elementTextSalineVal.text)
                    rectangleRepeaterComponent.salValue = salineValue
                    doIt( (192 - salineValue *2))
                }
            }
            NumberAnimation {
                id: salineTextAnimation
                target: elementTextSalineVal
                property: "salineValue"
                duration: 2200
                from: 0
                to:salineTimer.selectedPercentage
                running: true
            }

            Text {
                id: salinePercentage
                color: "#c2b59b"
                text: "%"
                font.pixelSize: 30
                font.family: sourceSansLight.name
                anchors {left: elementTextSalineVal.right; top: elementTextSalineVal.top; }
            }

            Rectangle
            {
                id: rectangleRepeaterComponent
                x: 372
                y: 120
                width: 28
                height: 188
                color: main.backgroundColor
                property int salValue: 12
                Column
                {
                    x: 0
                    y: 0
                    spacing: 1.5
                    Repeater
                    {
                        id: repeater
                        model: 25
                        Rectangle {
                            width: 25; height: 6
                            border.width: 2
                            color: "#414142"
                        }
                    }
                }

                Timer{
                    id: salineTimer
                    property int sliderNumber: 25
                    property int selectedPercentage: 17
                    property int sliderEnd: calculateStartPoint(selectedPercentage)
                    property int sliderMarks: 25

                    function calculateStartPoint(percentage) {
                        var startPoint = sliderMarks - (percentage * sliderMarks / 100);
                        return Math.round(startPoint);
                    }

                    interval: 150
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: {

                        if (repeater.itemAt(salineTimer.sliderNumber) !== null){
                            repeater.itemAt(salineTimer.sliderNumber).color = main.mustard
                        }
                        if (salineTimer.sliderNumber === salineTimer.sliderEnd) {
                            salineTimer.stop()
                        }

                    }
                }

              NumberAnimation {
                    id: salineAnimation
                    target: salineTimer
                    property: "sliderNumber"
                    from: salineTimer.sliderNumber
                    to: salineTimer.sliderEnd
                    duration: 2200
                    running: true
                }

                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        console.log("CLK mouse Y === ", mouseY, "repeat ", repeater.count)
                        for (var i = 0; i < repeater.count; ++i)
                        {
                            //console.log("mouse I === ", i)
                            if(repeater.itemAt(i).y+5 >= mouseY)
                            {
                                 console.log("mouse I === ", i, " item = ", repeater.itemAt(i).y+5)
                                repeater.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                repeater.itemAt(i).color = "#414142"
                                elementTextSalineVal.salineValue = 96-4*i
                                parent.salValue = elementTextSalineVal.salineValue
                            }
                        }
                        submitTextField("saline.value="+ elementTextSalineVal.salineValue)
                       // console.log("== Saline slider changed -- " + elementTextSalineVal.salineValue )
                    }

                    onPositionChanged: {
                        console.log("POS mouse Y === ", mouseY)
                        for (var i = 0; i < repeater.count; ++i)
                        {
                            console.log("mouse I === ", i)
                            if(repeater.itemAt(i).y >= mouseY)
                            {
                                repeater.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                repeater.itemAt(i).color = "#414142"
                                elementTextSalineVal.salineValue = 96-4*i
                                parent.salValue = elementTextSalineVal.salineValue
                            }
                        }
                    }
                }
            }

//HiCor
            Text {
                id: elementTextHiCor
                x: 517
                y: 118
                color: "white"
                text: qsTr("Hi-Cor")
                font.pixelSize: 14
            }

            Text {
                objectName: "HiCorVal"
                id: elementTextHiCorVal
                property int hicorValue: 0
                x: 514
                y: 130
                color: "#c2b59b"
                text: hicorValue
                font.pixelSize: 40
                font.family: sourceSansLight.name

            function doItH( val ) {
                for (var i = 0; i < repeater1.count; ++i)
                {
                    if(repeater1.itemAt(i).y+5 >= val)
                    {
                        repeater1.itemAt(i).color = main.mustard
                    }
                    else
                    {
                        repeater1.itemAt(i).color = "#414142"
                    }
                }
            }

            onTextChanged: {
                hicorValue = elementTextHiCorVal.text
                //console.log("HiCor Value changed to " + hicorValue + " --> " + elementTextHiCorVal.text)
                rectangle1RepeaterComponent.hicorValue = hicorValue
                doItH( (192 - hicorValue *2))
            }
        }

            NumberAnimation {
                id: hicorTextAnimation
                target: elementTextHiCorVal
                property: "hicorValue"
                duration: 2200
                from: 0
                to:hicorTimer.selectedPercentage
                running: true
            }

            Text {
                id: hicorPercentage
                color: "#c2b59b"
                text: "%"
                font.pixelSize: 30
                font.family: sourceSansLight.name
                anchors {left: elementTextHiCorVal.right; top: elementTextHiCorVal.top }
            }

            Rectangle {
                id: rectangle1RepeaterComponent
                x: 484
                y: 120
                width: 28
                height: 188
                color: main.backgroundColor
                property int hicorValue: 12
                Column
                {
                    x: 0
                    y: 0
                    spacing: 1.5
                    Repeater
                    {
                        id: repeater1
                        model: 25
                        Rectangle {
                            width: 25; height: 6
                            border.width: 2
                            color: "#414142"
                        }
                    }
                }

                Timer{
                    id: hicorTimer
                    property int sliderNumber: 25
                    property int selectedPercentage: 35
                    property int sliderEnd: calculateStartPoint(selectedPercentage)
                    property int sliderMarks: 25

                    function calculateStartPoint(percentage) {
                        var startPoint = sliderMarks - (percentage * sliderMarks / 100);
                        return Math.round(startPoint);
                    }

                    interval: 150
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: {

                        if (repeater1.itemAt(sliderNumber) !== null){
                            repeater1.itemAt(sliderNumber).color = main.mustard
                        }
                        if (sliderNumber === sliderEnd) {
                            hicorTimer.stop()
                        }

                    }

                }
                NumberAnimation {
                    id: hicorAnimation
                    target: hicorTimer
                    property: "sliderNumber"
                    from: 25
                    to: hicorTimer.sliderEnd
                    duration: 2200
                    running: true
                }


                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        console.log("mouse Y === ", mouseY)
                        for (var i = 0; i < repeater1.count; ++i)
                        {
                            if(repeater1.itemAt(i).y+5 >= mouseY)
                            {
                                repeater1.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                repeater1.itemAt(i).color = "#414142"
                                elementTextHiCorVal.hicorValue = 96-4*i
                                parent.hicorValue = elementTextHiCorVal.hicorValue
                            }
                        }
                        submitTextField("hicor.value=" +  elementTextHiCorVal.hicorValue)
                        console.log("HiCor slider changed -- " +  elementTextHiCorVal.hicorValue)

                    }
                    onPositionChanged: {
                        console.log("mouse Y === ", mouseY)
                        for (var i = 0; i < repeater1.count; ++i)
                        {
                            if(repeater1.itemAt(i).y >= mouseY)
                            {
                                repeater1.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                repeater1.itemAt(i).color = "#414142"
                                elementTextHiCorVal.hicorValue = 96-4*i
                                parent.hicorValue = elementTextHiCorVal.hicorValue
                            }
                        }
                    }
                }
            }


//Glucagon
            Text {
                id: elementTextGlucagon
                x: 633
                y: 118
                color: "white"
                text: qsTr("Glucagon")
                font.pixelSize: 14
            }

            Text {
                objectName: "glucagonValue"
                id: elementTextGlucagonVal
                property int glucagonValue: 0
                x: 634
                y: 130
                color: "#c2b59b"
                text: glucagonValue
                font.pixelSize: 40
                font.family: sourceSansLight.name

                function doItG( val ) {
                    for (var i = 0; i < repeater2.count; ++i)
                    {
                        if(repeater2.itemAt(i).y+5 >= val)
                        {
                            repeater2.itemAt(i).color = main.mustard
                        }
                        else
                        {
                            repeater2.itemAt(i).color = "#414142"
                        }
                    }
                }

                onTextChanged: {
                    glucagonValue = elementTextGlucagonVal.text
                    //console.log("Glucogon Value changed to " + glucagonValue + " --> " + elementTextGlucagonVal.text)
                    rectangle2RepeaterComponent.glucagonValue = glucagonValue
                    doItG( (192 - glucagonValue *2))
                }
            }

            NumberAnimation {
                id: glucagonTextAnimation
                target: elementTextGlucagonVal
                property: "glucagonValue"
                duration: 2200
                from: 0
                to:glucagonTimer.selectedPercentage
                running: true
            }

            Text {
                id: glucagonPercentage
                color: "#c2b59b"
                text: "%"
                font.pixelSize: 30
                font.family: sourceSansLight.name
                anchors {left: elementTextGlucagonVal.right; top: elementTextGlucagonVal.top }
            }

            Rectangle {
                id: rectangle2RepeaterComponent
                x: 600
                y: 120
                width: 28
                height: 188
                color: main.backgroundColor
                property int glucagonValue: 12
                Column
                {
                    x: 0
                    y: 0
                    spacing: 1.5
                    Repeater
                    {
                        id: repeater2
                        model: 25
                        Rectangle {
                            width: 25; height: 6
                            border.width: 2
                            color: "#414142"
                        }
                    }
                }

                Timer {
                    id: glucagonTimer
                    property int sliderNumber: 25
                    property int selectedPercentage: 15
                    property int sliderEnd: calculateStartPoint(selectedPercentage)
                    property int sliderMarks: 25

                    function calculateStartPoint(percentage) {
                        var startPoint = sliderMarks - (percentage * sliderMarks / 100);
                        return Math.round(startPoint);
                    }

                    interval: 150
                    repeat: true
                    running: true
                    triggeredOnStart: true
                    onTriggered: {

                        if (repeater2.itemAt(sliderNumber) !== null){
                            repeater2.itemAt(sliderNumber).color = main.mustard
                        }
                        if (sliderNumber === sliderEnd) {
                            glucagonTimer.stop()
                        }

                    }
                }
                NumberAnimation {
                    id: glucagonAnimation
                    target: glucagonTimer
                    property: "sliderNumber"
                    from: 25
                    to: glucagonTimer.sliderEnd
                    duration: 2200
                    running: true
                }

                MouseArea {
                    anchors.fill:parent
                    onClicked: {
                        for (var i = 0; i < repeater2.count; ++i)
                        {
                            if(repeater2.itemAt(i).y+5 >= mouseY)
                            {
                                repeater2.itemAt(i).color = main.mustard

                            }
                            else
                            {
                                elementTextGlucagonVal.glucagonValue = 96-i*4
                                repeater2.itemAt(i).color = "#414142"
                                parent.glucagonValue =  elementTextGlucagonVal.glucagonValue
                            }

                        }
                        submitTextField("glucagon.value=" +  elementTextGlucagonVal.glucagonValue)
                        console.log("Glucagon slider changed -- " + elementTextGlucagonVal.glucagonValue)

                    }
                    onPositionChanged: {
                        for (var i = 0; i < repeater2.count; ++i)
                        {
                            if(repeater2.itemAt(i).y >= mouseY)
                            {

                                repeater2.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                elementTextGlucagonVal.glucagonValue = 96-i*4
                                repeater2.itemAt(i).color = "#414142"
                                parent.glucagonValue =  elementTextGlucagonVal.glucagonValue
                            }
                        }

                    }

                }
            }


//Alarm
            Rectangle
            {
                id: buttonAlarmOn
                property bool checked: false
                Accessible.role: Accessible.Button
                Accessible.onPressAction:
                {
                    button.clicked()
                }

                signal clicked
                Image
                {
                    id: imageIconGetHelpOn
                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-alarm.png"
                }
                width: 36
                height: 36
                x: main.buttonsAnimationX
                y: 30
                color: main.backgroundColor

                radius: 0
                antialiasing: true
                MouseArea
                {
                    id: mouseAreaAlarmOn
                    anchors.fill: parent
                    onClicked: parent.clicked()
                }

                Keys.onSpacePressed: clicked()
                onClicked: {
                    submitTextField("btnAlarm.value=1")
                    console.log("Button ALARM was pressed")
                }
            }



//Vitals
            Text {
                id: elementTextVitalsOnButton
                color: main.textButtonColor
                text: qsTr("Vitals")
                font.pixelSize: 10
                anchors { bottom: buttonVitalsOn.bottom; horizontalCenter: buttonVitalsOn.horizontalCenter; bottomMargin: 5 }
            }

            Rectangle
            {
                objectName: "btnVitals"
                id: buttonVitalsOn
                x: main.buttonsAnimationX
                y: 121
                width: 71
                height: 50
                color: "#414142"
                property bool checked: false

                Accessible.role: Accessible.Button
                Accessible.onPressAction:
                {
                    button.clicked()
                }

                signal clicked
                Image
                {
                    anchors { top: buttonVitalsOn.top; horizontalCenter: buttonVitalsOn.horizontalCenter }
                    id: imageIconVitalsOn
                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-vitals-on.png"
                }
                radius: 0
                antialiasing: true
                MouseArea
                {
                    id: mouseAreaVitalsOn
                    anchors.fill: parent
                    onClicked: parent.clicked()
                }

                Keys.onSpacePressed: clicked()
                onClicked: {
                    submitTextField("btnVitals.state=1")
                    console.debug("Button VITALS was pressed")
                }
            }


//Help
            Rectangle
            {
                objectName: "btnHelp"
                id: buttonGetHelpOn
                x: main.buttonsAnimationX
                y: 284
                width: 71
                height: 50
                color: main.backgroundColor

                Image {
                    id: imageGetHelp
                    anchors { top: buttonGetHelpOn.top; horizontalCenter: buttonGetHelpOn.horizontalCenter }
                    fillMode: Image.PreserveAspectFit
                    source: "Images/icon-get-help.png"
                }
                property bool checked: false
                Accessible.role: Accessible.Button
                Accessible.onPressAction:
                {
                    button.clicked()
                }
                signal clicked
                radius: 0
                antialiasing: true
                MouseArea
                {
                    id: mouseAreaGetHelpOn
                    anchors.fill: parent
                    onClicked: parent.clicked()
                }
                Keys.onSpacePressed: clicked()
                onClicked: {
                    console.debug("Button HELP was pressed")
                    submitTextField("btnHelp.state=1")
                }
            }


            NumberAnimation {
                id: buttonAnimation
                targets: [ buttonGetHelpOn, buttonVitalsOn ]
                property: "x"
                duration: 800
                from: main.buttonsAnimationX
                to: 730
                running: true
            }

            NumberAnimation {
                id: alarmButtonAnimation
                target: buttonAlarmOn
                property: "x"
                duration: 800
                from: main.buttonsAnimationX
                to: 745
                running: true
            }

            Component.onCompleted: {
                sendPreviousScreen.connect(alarmsId.receivePreviousScreen)
                startAnimation.connect(alarmsId.receiveAnimation)
            }
        }

        AlarmScreen {
            id: alarmsId
            stack: stackMain
            isRunning: stackMain.currentIndex === 3
            previousScreen: stackMain.currentIndex

            Component.onCompleted: {
                startAnimation.connect(main.receiveAnimation)
                startAnimation.connect(alarmsId.receiveAnimation)
            }
        }


    }
}
