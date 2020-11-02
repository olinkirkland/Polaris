package statistics
{
    public class AttributeRule
    {
        public var attributeName:String;
        public var sourceAttributeName:String;
        public var value:Number;
        public var operator:String;

        public function AttributeRule()
        {
        }

        static public function fromObject(u:Object):AttributeRule
        {
            var r:AttributeRule = new AttributeRule();
            r.attributeName = u.attribute;
            r.sourceAttributeName = u.source;
            r.value = u.value;
            r.operator = u.operator;
            return r;
        }
    }
}
