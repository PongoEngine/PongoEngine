package game;

import pongo.Pongo;
import pongo.ecs.transform.Transform;
import pongo.display.FillSprite;

class Game {
    public static function start(link :Pongo -> Void) : Void
    {
        pongo.platform.Pongo.create("Example", 1366, 768, onStart.bind(link));
    }

    private static function onStart(link :Pongo -> Void, pongo :Pongo) : Void
    {
        pongo.root
            .addComponent(new Transform(new FillSprite(0xff222222, 1366, 768)));
        link(pongo);
    }
}