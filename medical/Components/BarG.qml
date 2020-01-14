import QtQuick 2.0

Item {
    width: 150; height: 400

    property Component myBarG: barG

    Component {
        id: bargG


//BarG
            Text {
                id: elementTextBarG
                x: 405
                y: 118
                color: "white"
                text: qsTr("BarG")
                font.pixelSize: 14
            }
            Text {
                id: elementTextBarGVal
                property int BarGValue: 0
                x: 401
                y: 130
                color: "#c2b59b"
                text: BarGValue
                font.pixelSize: 40
                font.family: sourceSansLight.name
            }
            NumberAnimation {
                id: barGTextAnimation
                target: elementTextBarGVal
                property: "BarGValue"
                duration: 2200
                from: 0
                to:BarGTimer.selectedPercentage
                running: true
            }

            Text {
                id: barGPercentage
                color: "#c2b59b"
                text: "%"
                font.pixelSize: 30
                font.family: sourceSansLight.name
                anchors {left: elementTextBarGVal.right; top: elementTextBarGVal.top; }
            }

            Rectangle
            {
                id: rectangleRepeaterComponent
                x: 372
                y: 120
                width: 28
                height: 188
                color: main.backgroundColor
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
                    id: barGTimer
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

                        if (repeater.itemAt(BarGTimer.sliderNumber) !== null){
                            repeater.itemAt(BarGTimer.sliderNumber).color = main.mustard
                        }
                        if (BarGTimer.sliderNumber === BarGTimer.sliderEnd) {
                            BarGTimer.stop()
                        }

                    }
                }
                NumberAnimation {
                    id: barGAnimation
                    target: BarGTimer
                    property: "sliderNumber"
                    from: BarGTimer.sliderNumber
                    to: BarGTimer.sliderEnd
                    duration: 2200
                    running: true
                }

                MouseArea{
                    anchors.fill:parent
                    onClicked: {
                        for (var i = 0; i < repeater.count; ++i)
                        {
                            if(repeater.itemAt(i).y+5 >= mouseY)
                            {
                                repeater.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                repeater.itemAt(i).color = "#414142"
                                elementTextBarGVal.BarGValue = 96-4*i
                            }
                        }
                    }
                    onPositionChanged: {
                        for (var i = 0; i < repeater.count; ++i)
                        {
                            if(repeater.itemAt(i).y >= mouseY)
                            {
                                repeater.itemAt(i).color = main.mustard
                            }
                            else
                            {
                                elementTextBarGVal.BarGValue = 96-4*i
                                repeater.itemAt(i).color = "#414142"
                            }
                        }

                    }

                }
            }
    }
}
