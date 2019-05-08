import towser.architecture.Architecture;
import engine.Model;
import engine.Update.update;
import engine.View.view;
import game.Game;
import js.Browser.window as W;
import haxe.Unserializer;

class Main {
	static function main() {
		var item = W.localStorage.getItem("appState");
		var savedState :Model = Unserializer.run(item);
		var model = (savedState != null)
			? savedState
			: new Model();

		trace(item);

		var arch = new Architecture("app", update, view, model);
		Game.start(pongo -> {
			
		});
	}
}