import haxe.Json;
import towser.Towser;
import engine.model.Model;
import engine.Update.update;
import engine.View.view;
// import game.Game;
import js.Browser.window;

class Main {
	static function main() {
		var item = window.localStorage.getItem("appState");
		var model : Model = (item != null)
			? {
				try{
					Model.fromSave(Json.parse(item));
				}
				catch(e :Dynamic) {
					new Model();
				}
			}
			: new Model();

		new Towser("app", update, view, model);
		// Game.start(pongo -> {
			
		// });
	}
}