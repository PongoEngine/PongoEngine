package towser.util;

import haxe.extern.Rest;
import js.html.Element;
import js.html.Text;
import js.html.Node;

@:jsRequire("incremental-dom")
extern class IncrementalDOM
{
    /**
     * [Description]
     * @param tagname 
     * @param key 
     * @param staticPropertyValuePairs 
     * @param vargs 
     * @return Element
     */
    public static function elementOpen(tagname :String, key :String, staticPropertyValuePairs :Array<String>, vargs :Rest<Dynamic>) : Element;

    /**
     * [Description]
     * @param tagname 
     * @param key 
     * @param staticPropertyValuePairs 
     * @return Dynamic
     */
    public static function elementOpenStart(tagname :String, key :String, staticPropertyValuePairs :Array<String>) : Dynamic;

    /**
     * [Description]
     * @param name 
     * @param value 
     * @return Dynamic
     */
    public static function attr(name :String, value :Any) : Dynamic;

    /**
     * [Description]
     * @return Element
     */
    public static function elementOpenEnd() : Element;

    /**
     * [Description]
     * @param tagname 
     * @return Element
     */
    public static function elementClose(tagname :String) : Element;

    /**
     * [Description]
     * @param tagname 
     * @param key 
     * @param staticPropertyValuePairs 
     * @param vargs 
     * @return Element
     */
    public static function elementVoid(tagname :String, key :String, staticPropertyValuePairs :Array<String>, vargs :Rest<Dynamic>) : Element;

    /**
     * [Description]
     * @param node 
     * @param description 
     * @param data 
     * @return Element
     */
    public static function text<Model, Msg>(value :Dynamic, ?formatters :RenderFunction<Model, Msg>) : Text;

    /**
     * [Description]
     * @param node 
     * @param description 
     * @param data 
     * @return Element
     */
    public static function patch<Model, Msg>(node :Node, description :RenderFunction<Model, Msg>, data :Any) : Element;

    /**
     * [Description]
     * @return Element
     */
    public static function currentElement() : Element;

    /**
     * [Description]
     * @return Node
     */
    public static function currentPointer() : Node;

    /**
     * [Description]
     */
    public static function skip() : Void;

    /**
     * [Description]
     */
    public static function skipNode() : Void;
}