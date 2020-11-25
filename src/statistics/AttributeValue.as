package statistics
{
    import flash.events.EventDispatcher;

    import global.Utils;

    import mx.utils.UIDUtil;

    public class AttributeValue extends EventDispatcher
    {
        public var operator:String;
        public var base:Boolean;
        public var quantity:Number;

        public function AttributeValue(quantity:Number, operator:String, base:Boolean = false)
        {
            this.operator = operator;
            this.base = base;
            this.quantity = quantity;
        }
    }
}
