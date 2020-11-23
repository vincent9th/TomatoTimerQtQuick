import QtQuick 2.12
import QtQuick.Window 2.12
//import QtQuick.Controls 2.5
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: timerWindow
    //flags: "Widget"
    visible: true
    width: 640
    height: 480
    color: "deepskyblue"
    title: qsTr("Potato Timer")

    QtObject {
        id: countAttrs
        property int countNum: 0
    }

    Timer {
        id: countDownTimer
        interval: 1000
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            if(countAttrs.countNum >= 0) {
                var mins = parseInt(countAttrs.countNum/60);
                var secs = parseInt(countAttrs.countNum%60);
                countShow.text = mins + ":" + secs
                countAttrs.countNum--;
            }
            else {
                //countShow.text = countAttrs.countNum--; //for test
                this.stop();
                countDownStartBtn.status_ = countDownStartBtn.timerTIMEOUT;
                countDownStartBtn.text = "ok";
                countShow.text = "accomplish"

                timerWindow.flags = "Popup";
                /*timerWindow.width = 320
                timerWindow.height = 240
                timerWindow.y = Screen.desktopAvailableHeight - timerWindow.height;
                timerWindow.x = 0; //Screen.desktopAvailableWidth - timerWindow.width;*/
            }
       }
   }

    RowLayout {

        anchors.centerIn: parent

        Text {
            id: countShow
            anchors.centerIn: parent
            font.pointSize: 48*2
            color: "white"
        }

        Text {
            id: statusShow
            anchors.bottom: countShow.top
            anchors.bottomMargin: 20
            anchors.horizontalCenter: countShow.horizontalCenter
            font.pointSize: 48
            color: "white"
            //text: 'test'
        }

        RowLayout {
            anchors.top: countShow.bottom
            anchors.topMargin: 40
            anchors.horizontalCenter: countShow.horizontalCenter
            Button {
                id: countDownStartBtn
                text: "Start"
                onClicked: {
                    if(timerSTOP == status_ || timerPAUSE == status_) {

                        if(countDownType.type_) {
                            statusShow.text = "Rest"
                            if(timerSTOP == status_) {
                                countAttrs.countNum = 5*60
                            }
                        }else{
                            statusShow.text = "Work"
                            if(timerSTOP == status_) {
                                countAttrs.countNum = 25*60
                            }
                        }

                        status_ = timerSTART;
                        text = "Pause";
                        countDownTimer.start()
                    } else if(timerSTART == status_) {
                        status_ = timerPAUSE;
                        text = "Start";
                        statusShow.text = "Pause"
                        countDownTimer.stop()
                    } else if(timerTIMEOUT == status_) {
                        status_ = timerSTOP;
                        text = "Start";
                        timerWindow.flags = "Window";
                        countShow.text = "0:0"
                        /*timerWindow.width = 640
                        timerWindow.height = 480
                        timerWindow.y = (Screen.desktopAvailableHeight - timerWindow.height)/2;
                        timerWindow.x = (Screen.desktopAvailableWidth - timerWindow.width)/2;*/
                    }
                }
                property int status_: 0
                property int timerSTOP: 0
                property int timerSTART: 1
                property int timerPAUSE: 2
                property int timerTIMEOUT: 3
            }

            Button {
                id: countDownType
                text: "Work"
                onClicked: {
                    type_ = !type_;
                    if(0 == type_){
                        statusShow.text = text = "Work"
                    }else {
                        statusShow.text = text = "Rest"
                    }
                }
                property int type_: 0
            }

            Button {
                id: countDownRest
                text: "Stop"
                onClicked: {
                    countDownTimer.stop()
                    timerWindow.flags = "Window";
                    countDownStartBtn.status_ = countDownStartBtn.timerSTOP
                    countDownStartBtn.text = "Start"
                    countShow.text = "0:0"
                    if(countDownType.type_) {
                        statusShow.text = "Rest"
                    }else{
                        statusShow.text = "Work"
                    }
                }
            }
        }
    }

}
