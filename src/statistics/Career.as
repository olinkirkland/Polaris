package statistics
{
    public class Career
    {
        public var name:String;
        public var rules:Vector.<AttributeRule>;

        public function Career()
        {
        }

        public static function fromObject(u:Object):Career
        {
            var c:Career = new Career();
            c.name = u.name;
            c.rules = new Vector.<AttributeRule>();
            for each (var r:Object in u.rules)
                c.rules.push(AttributeRule.fromObject(r));

            return c;
        }
    }
}
