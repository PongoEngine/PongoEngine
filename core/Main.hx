import towser.Architecture;
import towser.RenderFunction;
import towser.Html.*;
import perdita.Material.*;
import perdita.model.Textfield;

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
			tooltip("Open ⌘ + O"),
			div([STYLE({marginTop: "10px"})], [
				textFieldFilled(UPDATE_TEXT, model.moneyField)
			]),
			div([STYLE({marginTop: "10px"})], [
				textFieldOutlined(UPDATE_TEXT, model.moneyField)
			])
		]);
	}

	public static function update(msg:PongoMsg, model:PongoModel):Bool {
		switch msg {
			case UPDATE_TEXT(text):
				model.moneyField.value = text;
		}
		return true;
	}
}

class PongoModel
{
	public var moneyField :Textfield;

	public function new() : Void
	{
		this.moneyField = new Textfield("Money", "");
	}
}

enum PongoMsg
{
	UPDATE_TEXT(text :String);
}
