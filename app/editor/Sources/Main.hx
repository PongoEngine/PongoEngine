import towser.Towser;
import engine.Model;
import engine.Update.update;
import engine.View.view;
import game.Game;
import js.Browser.window;
import haxe.Unserializer;

class Main {
	static function main() {
		var item = window.localStorage.getItem("appState");
		var savedState :Model = Unserializer.run(item);
		var model = (savedState != null)
			? savedState
			: new Model();

		new Towser("app", update, view, model);
		Game.start(pongo -> {
			
		});
	}
}