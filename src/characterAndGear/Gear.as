package characterAndGear
{
    public class Gear
    {
        // Slots
        public var head:Item;
        public var torso:Item;
        public var gloves:Item;
        public var legs:Item;
        public var boots:Item;
        public var rightHand:Item;
        public var leftHand:Item;

        // All items
        public var items:Vector.<Item> = Vector.<Item>([head, torso, gloves, legs, boots, rightHand, leftHand]);

        public function Gear()
        {
        }
    }
}
