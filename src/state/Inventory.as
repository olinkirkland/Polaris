package state
{
    import characterAndGear.Item;

    public class Inventory
    {
        public var items:Array;

        public function Inventory()
        {
        }

        public static function fromObject(u:Object):Inventory
        {
            var inventory:Inventory = new Inventory();
            inventory.items = [];
            for each (var r:Object in u.items)
                inventory.items.push(Item.fromObject(r));

            return inventory;
        }

        public function toObject():Object
        {
            var u:Object = {};
            u.items = items;

            return u;
        }
    }
}
