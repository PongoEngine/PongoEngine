import towser.Towser;
import engine.model.Model;
import engine.update.Update.update;
import engine.View.view;
import js.Browser.window;
import haxe.Unserializer;

class Main {
	static function main() {
		var item = window.localStorage.getItem("appState");
		var model : Model = (item != null)
			? {
				try{
					Unserializer.run(item);
				}
				catch(e :Dynamic) {
					new Model();
				}
			}
			: new Model();

		new Towser("app", update, view, Model.clearKeys(model));
	}
}