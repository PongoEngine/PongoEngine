package perdita;

import towser.Html.*;
import towser.Attribute;
import towser.RenderFunction;
import perdita.model.Textfield;
import perdita.model.Tab;

class Material
{

    //------------ SLIDERS -----------
    public static function sliderContinuous<Model, Msg>(msg :String -> Msg, min :Int, max :Int) :RenderFunction<Model, Msg>
    {
        var step = (max - min) / 500;
        return input([
            ON_CHANGE(msg),
            ON_INPUT(msg),
            TYPE("range"), 
            ATTR("min", min), 
            ATTR("max", max), 
            ATTR("step", step), 
            CLASS("m-slider-continuous")
        ]);
    }


    //------------ SNACKBARS -----------
    public static function snackbar<Model, Msg>(children :Array<RenderFunction<Model, Msg>>) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-snackbar")], children);
    }

    //------------ TABS -----------
    public static function fixedTabs<Model, Msg>(msg :Array<Tab> -> Tab -> Msg, tabs :Array<Tab>) :RenderFunction<Model, Msg>
    {
        return div([], [
            for(tab in tabs) span([CLASS("m-tab" + (tab.isActive ? " active" : "")), ON_CLICK(msg(tabs, tab))], tab.value)
        ]);
    }

    public static function scrollableTabs<Model, Msg>(msg :Array<Tab> -> Tab -> Msg, tabs :Array<Tab>) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-tab-scrollable")], [
            for(tab in tabs) span([CLASS("m-tab" + (tab.isActive ? " active" : "")), ON_CLICK(msg(tabs, tab))], tab.value)
        ]);
    }

    //------------ TEXTFIELDS -----------
    public static function textFieldFilled<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-filled" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    public static function textFieldOutlined<Model, Msg>(msg :String -> Msg, field :Textfield) :RenderFunction<Model, Msg>
    {
        var filledClass = field.value == "" ? "" : " filled";
        return div([CLASS("m-textfield-outlined" + filledClass)], [
            input([ON_INPUT(msg), VALUE(new String(field.value))]),
            span([], field.label)
        ]);
    }

    //------------ TOOLTIP -----------
    public static function tooltip<Model, Msg>(tip :String) :RenderFunction<Model, Msg>
    {
        return div([CLASS("m-tooltip m-fade-in")], [span([], tip)]);
    }
}