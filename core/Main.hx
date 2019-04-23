import iqua.Architecture;
import iqua.Lazy;
import iqua.IncrementalDOM;
import gen.model.GenModel;
import gen.update.GenUpdate;
import gen.view.GenView;

class Main {
	static function main() {
		// Iqua.
		trace(IncrementalDOM.patch);

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
