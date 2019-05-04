package game;

import pongo.Pongo;
import pongo.ecs.transform.Transform;
import pongo.ecs.transform.TransformSystem;
import pongo.ecs.Component;
import pongo.ecs.System;
import pongo.ecs.group.SourceGroup;
import pongo.display.FillSprite;

class Game {
    public static function start() : Void
    {
        pongo.platform.Pongo.create("Example", 1366, 768, onStart);
    }

    private static function onStart(pongo :Pongo) : Void
    {
        pongo
            .addSystem(new TransformSystem())
            .addSystem(new HeroSystem());

        pongo.root
            .addComponent(new Transform(new FillSprite(0xff00ff00, 40, 40)))
            .addComponent(new Position(200, 200, 30))
            .addComponent(new Hero(400));
    }
}

class Position implements Component
{
    var x :Float;
    var y :Float;
    var angle :Float;
}

class Hero implements Component
{
    var speed :Float;
}

class HeroSystem extends System
{
    public var heroes :SourceGroup;

    public function new() : Void
    {
    }

    override public function onAdded() : Void
    {
        this.heroes = this.pongo.manager.registerGroup([Position, Hero, Transform]);   
    }

    override public function update(dt :Float) : Void
    {
        heroes.iterate(function(entity) {
            var hero :Hero = entity.getComponent(Hero);
            var pos :Position = entity.getComponent(Position);
            var transform :Transform = entity.getComponent(Transform);
            var sprite :FillSprite = cast transform.sprite;

            pos.x = (hero.speed*dt) * Math.cos(pos.angle) + pos.x;
            pos.y = (hero.speed*dt) * Math.sin(pos.angle) + pos.y;

            if(pos.y <= 0) {
                pos.angle = (-pos.angle);
                pos.y = 1;
                sprite.color = 0xff00ff00;
            }
            else if(pos.y >= pongo.window.height) {
                pos.angle = (-pos.angle);
                pos.y = pongo.window.height - 1;
                sprite.color = 0xff0000ff;
            }
            if(pos.x >= pongo.window.width) {
                pos.angle = (pos.angle+180) % 360;
                pos.x = pongo.window.width -1;
                sprite.color = 0xffffff00;
            }
            else if(pos.x <= 0) {
                pos.angle = (pos.angle+180) % 360;
                pos.x = 1;
                sprite.color = 0xffff00ff;
            }

            transform.y = pos.y;
            transform.x = pos.x;
        });
    }
}