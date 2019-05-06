import towser.architecture.Architecture;
import engine.Model;
import engine.Update.update;
import engine.View.view;
import game.Game;

class Main {
	static function main() {
		var arch = new Architecture("app", update, view, new Model());
		Game.start(pongo -> {
			
		});
	}
}