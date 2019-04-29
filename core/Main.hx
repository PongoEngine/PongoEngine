import towser.Architecture;
import towser.Html.*;
import towser.RenderFunction;
import engine.Model;
import engine.Update.update;
import engine.Update.GenMsg;
import perdita.Perdita.*;

class Main {
	static function main() {
		new Architecture("app", update, view, new Model());
		hotModule();
	}

	public static function view(model:Model) : RenderFunction<Model, GenMsg>
	{
		return div([CLASS("full-screen"), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
				pushButton(ToggleButton, model.button1, [p([], "Hello")])
			]),
			div([CLASS("main-content flex-row")], [
				column(StretchColumn, ToggleColumn, model.columnLeft ,[for (window in model.columnLeft.windows) collapsingWindow(ToggleWindow, window, [
					
				])]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], [])
				]),
				column(StretchColumn, ToggleColumn, model.columnRight ,[for (window in model.columnRight.windows) collapsingWindow(ToggleWindow, window, [

				])])
			]),
			div([], [for (f in model.floaters) floater(SelectWindow, f, [
				div([STYLE({margin: "2px"})], [
					textFieldOutlined(TextInput.bind(model.text), model.text),
					textFieldOutlined(TextInput.bind(model.text2), model.text2)
				])
			])])
		]);
	}

	static inline function hotModule():Void {
		if (untyped module.hot) {
			untyped module.hot.dispose(function() {
				js.Browser.window.location.reload();
			});
		}
	}
}