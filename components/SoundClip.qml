import QtQuick 2.0

import QtMultimedia 5.7
import KidGames 1.0
Item {

    property string qrcPath: "";
    QrcCache {
        id: soundCache;
        source: qrcPath;
    }

    Audio {
        id: audioClip
        source: "file:"+soundCache.path
    }

    function play() {
        audioClip.play();
    }
}
