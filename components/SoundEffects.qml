import QtQuick 2.0

import QtMultimedia 5.7
import KidGames 1.0
Item {

    property int idx: 0;

    Audio {
        id: audioClip1
        source: "";
    }

    Audio {
        id: audioClip2
        source: "";
    }

    property var clips: [audioClip1, audioClip2];

    QrcCache {
        id: incorrectCache;
        source: ":/sounds/incorrect.mp3";
    }

    QrcCache {
        id: correctCache;
        source: ":/sounds/correct.ogg";
    }

    function playEffect(obj) {
        idx++;
        if (idx >= clips.length) {
            idx = 0;
        }

        console.log("Stopping clip["+idx+"]");

        clips[idx].stop();
        clips[idx].source = "file:"+obj.path;
        console.log("Playing clip["+idx+"] -> "+clips[idx].source);
        clips[idx].play();
    }

    function playIncorrectEffect() {
        playEffect(incorrectCache);
    }

    function playCorrectEffect() {
        playEffect(correctCache);
    }
}
