import towser.Architecture;
import towser.RenderFunction;
import towser.Attribute;
import towser.Html.*;
import gen.model.GenModel;
import gen.update.GenUpdate;
import gen.view.GenView;
import perdita.view.Tooltip.tooltip;

class Main {
	static function main() {
		// new Architecture("app", GenUpdate.update, GenView.view, new GenModel());
		new Architecture("app", Main.update, Main.view, new PongoModel());
		hotModule();
	}

	static inline function hotModule():Void {
		if (untyped module.hot) {
			untyped module.hot.dispose(function() {
				js.Browser.window.location.reload();
			});
		}
	}

	public static function view(model:PongoModel) : RenderFunction<PongoModel, PongoMsg>
	{
		return div([CLASS("full-screen")], [
			tooltip("Print ⌘ + P")
		]);
	}

	public static function update(msg:PongoMsg, model:PongoModel):Bool {
		return true;
	}
}

class PongoModel
{
	public function new() : Void
	{

	}
}

enum PongoMsg
{

}
