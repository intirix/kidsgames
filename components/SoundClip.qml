import QtQuick 2.0

import QtMultimedia 5.7
import KidGames 1.0
Item {

    property string qrcPath: "";
    property bool playOnLoad: false;

    Audio {
        id: audioClip
        source: "";
    }

    QrcCache {
        id: soundCache;
        source: qrcPath;

        onPathChanged: {
            audioClip.source = "file:"+path;
            console.log("Path has changed to "+source+" -> "+path);
            if (playOnLoad && path!="") {
                timer.start();
            }
        }
    }

    function play() {
        console.log("Playing ["+audioClip.source+"]");
        audioClip.play();
    }

    Timer {
        id: timer;
        interval: 300;
        repeat: false;
        running: false;

        onTriggered: {
            play();
        }

    }
}
