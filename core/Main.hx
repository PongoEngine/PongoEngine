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
		var disableSelect = model.selectedFloater != null ? " disable-user-select" : "";
		return div([CLASS("full-screen" + disableSelect), MOUSE_DOWN(GlobalDown), MOUSE_UP(GlobalUp), MOUSE_MOVE(GlobalMove)], [
			div([CLASS("nav-bar color-container-darker border-bottom")], [
			]),
			div([CLASS("main-content flex-row")], [
				drawer(StretchColumn, ToggleColumn, model.columnLeft, [for (window in model.windows) collapsingWindow(ToggleWindow, window, [
					
				])]),
				div([CLASS("woah flex-column")], [
					div([CLASS("game-window")], [])
				]),
				drawer(StretchColumn, ToggleColumn, model.columnRight , [])
			]),
			div([], [for (f in model.floaters) floater(SelectWindow, f, [
				div([STYLE({margin: "2px"})], [
					textFieldOutlined(TextInput, model.text),
					textFieldOutlined(TextInput, model.text2),
					div([], [
						p([], "Hello"),
						toggle(ToggleButton, model.button1)
					]),
					div([], [
						p([], "Goodbye"),
						toggle(ToggleButton, model.button2)
					])
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