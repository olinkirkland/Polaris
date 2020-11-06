package characterAndGear
{
    public class Gear
    {
        public static const SLOT_NAMES:Vector.<String> = Vector.<String>(["head", "torso", "gloves", "legs", "boots", "rightHand", "leftHand"]);

        // Slots
        public var head:Item;
        public var torso:Item;
        public var gloves:Item;
        public var legs:Item;
        public var boots:Item;
        public var rightHand:Item;
        public var leftHand:Item;

        public function Gear()
        {
        }

        public function get items():Vector.<Item>
        {
            return Vector.<Item>([head, torso, gloves, legs, boots, rightHand, leftHand]);
        }
    }
}
