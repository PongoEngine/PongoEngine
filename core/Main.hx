import towser.Architecture;
import gen.model.GenModel;
import gen.update.GenUpdate;
import gen.view.GenView;

class Main {
	static function main() {
		new Architecture("app", GenUpdate.update, GenView.view, new GenModel());
		hotModule();
	}

	static inline function hotModule():Void {
		if (untyped module.hot) {
			untyped module.hot.dispose(function() {
				js.Browser.window.location.reload();
			});
		}
	}
}
