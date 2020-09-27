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
        incrementCounter();

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

    function prepareExternalClip(url) {
        incrementCounter();
        clips[idx].source = url;
    }

    function prepareVoice(qs) {
        prepareExternalClip("https://t0hatr9ymk.execute-api.us-east-1.amazonaws.com/prod/v1/voice?"+qs);
    }

    function playPreparedClip() {
        console.log("Playing "+clips[idx].source);
        clips[idx].stop();
        clips[idx].play();
    }

    function incrementCounter() {
        idx++;
        if (idx >= clips.length) {
            idx = 0;
        }
        console.log("SoundEffects: idx="+idx);
    }
}
