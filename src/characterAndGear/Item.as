package characterAndGear
{
    import statistics.AttributeRule;

    public class Item
    {
        public var name:String;
        public var rules:Vector.<AttributeRule>;

        public function Item()
        {
        }

        public static function fromObject(u:Object):Item
        {
            var t:Item = new Item();
            t.name = u.name;
            t.rules = new Vector.<AttributeRule>();
            for each (var r:Object in u.rules)
                t.rules.push(AttributeRule.fromObject(r));

            return t;
        }
    }
}
