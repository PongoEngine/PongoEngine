import iqua.Architecture;
import gen.GenModel;
import gen.GenUpdate;
import gen.GenView;

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
