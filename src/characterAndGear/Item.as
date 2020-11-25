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
            var item:Item = new Item();
            item.name = u.name;
            item.rules = new Vector.<AttributeRule>();
            for each (var r:Object in u.rules)
                item.rules.push(AttributeRule.fromObject(r));

            return item;
        }
    }
}
