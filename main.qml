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

    Text {
        id: countShow
        //text: qsTr("00:00")
        //text: 25
        anchors.centerIn: parent
        font.pointSize: 48*2
        color: "white"
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

                timerWindow.flags = "Popup";
                /*timerWindow.width = 320
                timerWindow.height = 240
                timerWindow.y = Screen.desktopAvailableHeight - timerWindow.height;
                timerWindow.x = 0; //Screen.desktopAvailableWidth - timerWindow.width;*/
            }
       }
   }

    RowLayout {
        anchors.top: countShow.bottom
        anchors.topMargin: 40
        anchors.horizontalCenter: countShow.horizontalCenter
        Button {
            id: countDownStartBtn
            text: "start"
            onClicked: {
                if(timerSTOP == status_ || timerPAUSE == status_) {

                    if(timerSTOP == status_){
                        if(countDownType.type_) {
                            countAttrs.countNum = 5*60
                        }else{
                            countAttrs.countNum = 25*60
                        }
                    }

                    status_ = timerSTART;
                    text = "pause";
                    countDownTimer.start()
                } else if(timerSTART == status_) {
                    status_ = timerPAUSE;
                    text = "start";
                    countDownTimer.stop()
                } else if(timerTIMEOUT == status_) {
                    status_ = timerSTOP;
                    text = "start";
                    timerWindow.flags = "Window";
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
                    text = "Work"
                }else {
                    text = "Rest"
                }
            }
            property int type_: 0
        }

        Button {
            id: countDownRest
            text: "Reset"
            onClicked: {
                countDownTimer.stop()
                timerWindow.flags = "Window";
                countDownStartBtn.status_ = countDownStartBtn.timerSTOP
                countDownStartBtn.text = "start"
                countShow.text = "0";
            }
        }
    }

}
