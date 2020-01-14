import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls.Styles 1.4
import QtQuick.Controls 2.1
import QtQuick.Controls 1.4
import QtQuick.Controls 2.4
import QtQuick.Layouts 1.11
import QtQuick 2.11

Rectangle {
    id: alarm
    property alias isRunning: timer.running
    property bool animationRunning
    property int previousScreen
    property int mainScreen: 0
    property int scheduleScreen: 1
    property int patientListScreen: 2
    property color backgroundColor: "black"
    property color textButtonColor: "white"
    property int buttonsX: 730
    property color detailsColor: "#414142"

    FontLoader { id: sourceSansLight; source: "Fonts/SourceSansPro-Light.otf" }


    property StackLayout stack

    signal startAnimation()

    function receivePreviousScreen(screen){
        previousScreen = screen
    }

    function receiveAnimation(){
        alarm.opacity = 0
        alarmAnimation.restart()
        alarmImageAnimation.restart()
    }

    visible: true
    width: 800
    height: 480
    color: "black"

    NumberAnimation {
        id: alarmAnimation
        target: alarm
        property: "opacity"
        easing.type: Easing.InOutQuad
        duration: 1000
        from: 0
        to: 1
    }

    Timer {
        id: timer
        interval: 3000
        running: true
        onTriggered: {
            stack.currentIndex = previousScreen
            startAnimation()
        }
    }

    Image {
        id: alarmImage
        x: 284
        y: 67
        source: "Images/icon-alarm-x-large.png"
        fillMode: Image.PreserveAspectFit
    }
    SequentialAnimation/* on opacity*/ {
        id: alarmImageAnimation
        loops: 2
        running: true
        NumberAnimation { target: alarmImage; property: "opacity"; from: 0 ; to: 1; duration: 500 }
        NumberAnimation { target: alarmImage; property: "opacity"; from: 1 ; to: 0; duration: 500 }
        onRunningChanged: {
            alarmImage.opacity = 1
        }
    }

    Text {
        id: textAlarmIsActivated
        x: 108
        y: 325
        color: "#c2b59b"
        text: qsTr("Alarm is activated!")
        font.pixelSize: 70
        font.family: sourceSansLight.name
    }

    Image {
        id: imageLogoReach
        anchors { bottom: bottomLine.bottom; left: bottomLine.right; leftMargin: 10 }
        fillMode: Image.PreserveAspectFit
        source: "Images/logo-reach.png"
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
        x: 745
        anchors.verticalCenter: topLine.verticalCenter
        color: alarm.backgroundColor

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
        }
    }

    Rectangle
    {
        id: buttonVitalsOn
        x: buttonsX
        y: 121
        width: 71
        height: 50
        color: alarm.backgroundColor
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
            source: "Images/icon-vitals.png"
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
            alarm.startAnimation()
            stack.currentIndex = alarm.screen.main
        }
    }

    Rectangle
    {
        id: buttonScheduleOn
        anchors { top: buttonVitalsOn.bottom; horizontalCenter: buttonVitalsOn.horizontalCenter; topMargin: 10 }
        width: 71
        height: 50
        color: alarm.backgroundColor

        Image
        {
            anchors { top: buttonScheduleOn.top; horizontalCenter: buttonScheduleOn.horizontalCenter }
            id: imageScheduleOn
            fillMode: Image.PreserveAspectFit
            source: "Images/icon-schedule.png"
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
            id: mouseAreaScheduleOn
            anchors.fill: parent
            onClicked: parent.clicked()
        }
        Keys.onSpacePressed: clicked()
        onClicked: {
//            schedule.startAnimation()
//            stack.currentIndex = schedule.screen.schedule
        }
    }

    Rectangle
    {
        id: buttonHistoryOn
        anchors { top: buttonScheduleOn.bottom; horizontalCenter: buttonScheduleOn.horizontalCenter; topMargin: 10 }
        width: 71
        height: 50
        color: alarm.backgroundColor

        Image {
            anchors { top: buttonHistoryOn.top; horizontalCenter: buttonHistoryOn.horizontalCenter }
            id: imageHistoryOn
            fillMode: Image.PreserveAspectFit
            source: "Images/icon-history.png"
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
            id: mouseAreaHistoryOn
            anchors.fill: parent
            onClicked: parent.clicked()
        }
        Keys.onSpacePressed: clicked()
        onClicked: console.debug("Button history on was clicked")
    }

    Rectangle
    {
        id: buttonGetHelpOn
        anchors { top: buttonHistoryOn.bottom; horizontalCenter: buttonHistoryOn.horizontalCenter; topMargin: 5 }
        width: 71
        height: 50
        color: alarm.backgroundColor

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
            console.debug("Button get help was clicked")
        }
    }

    Rectangle
    {
        id: buttonPatientOn
        x: buttonsX
        y: 394
//                anchors { top: buttonGetHelpOn.bottom; horizontalCenter: buttonGetHelpOn.horizontalCenter; topMargin: 10 }
        width: 71
        height: 50
        color: alarm.backgroundColor

        Image
        {
            id: imagePatientOn
            anchors { top: buttonPatientOn.top; horizontalCenter: buttonPatientOn.horizontalCenter }
            fillMode: Image.PreserveAspectFit
            source: "Images/icon-patients.png"
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
            id: mouseAreaPatientsOn
            anchors.fill: parent
            onClicked: parent.clicked()
        }
        Keys.onSpacePressed: clicked()
        onClicked: {
        }
    }

    Text {
        id: elementTextVitalsOnButton
        color: alarm.textButtonColor
        text: qsTr("Vitals")
        font.pixelSize: 10
        anchors { bottom: buttonVitalsOn.bottom; horizontalCenter: buttonVitalsOn.horizontalCenter; bottomMargin: 5 }
    }

    Text {
        id: elementTextScheduleOnButton
        anchors { bottom: buttonScheduleOn.bottom; horizontalCenter: buttonScheduleOn.horizontalCenter; bottomMargin: 5 }
        color: alarm.textButtonColor
        text: qsTr("Schedule")
        font.pixelSize: 10
    }

    Text {
        id: elementTextHistoryOnButton
        anchors { bottom: buttonHistoryOn.bottom; horizontalCenter: buttonHistoryOn.horizontalCenter; bottomMargin: 5 }
        color: alarm.textButtonColor
        text: qsTr("History")
        font.pixelSize: 10
    }

    Text {
        id: elementTextGetHelpOnButton
        anchors { bottom: buttonGetHelpOn.bottom; horizontalCenter: buttonGetHelpOn.horizontalCenter; bottomMargin: 5 }
        color: alarm.textButtonColor
        text: qsTr("Get Help")
        font.pixelSize: 10
    }

    Text {
        id: elementTextPatientOnButton
        anchors { bottom: buttonPatientOn.bottom; horizontalCenter: buttonPatientOn.horizontalCenter; bottomMargin: 5 }
        color: alarm.textButtonColor
        text: qsTr("Patients")
        font.pixelSize: 10
    }

}
