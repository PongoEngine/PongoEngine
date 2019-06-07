import towser.Towser;
import engine.model.Model;
import engine.update.Update.update;
import engine.View.view;
import js.Browser.window;
import haxe.Unserializer;
import typing.TypingData;

@:build(typing.TypeWriter.build('../app/editor/Assets/', ['game'], [], true))
class Main {
	static function main() {
		loadComponents(function(data) {
			var item = window.localStorage.getItem("appState");
			var model : Model = (item != null)
				? {
					try{
						Unserializer.run(item);
					}
					catch(e :Dynamic) {
						new Model(data);
					}
				}
				: new Model(data);

			new Towser("app", update, view, Model.clearKeys(model));
		});
	}

	public static function loadComponents(onData :TypingData -> Void) : Void
	{
		var http = new haxe.Http("./baseComponents.json");

		http.onData = function (data:String) {
			onData(Unserializer.run(data));
		}

		http.onError = function (error) {
			trace('error: $error');
		}

		http.request();
	}
}