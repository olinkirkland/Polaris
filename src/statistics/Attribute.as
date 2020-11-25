package statistics
{
    import flash.events.Event;
    import flash.events.EventDispatcher;

    import global.Operator;

    import global.Utils;

    public class Attribute extends EventDispatcher
    {
        // Primary
        public static const STRENGTH:String = "strength";
        public static const DEFENSE:String = "defense";
        public static const AGILITY:String = "agility";
        public static const AURA:String = "aura";
        public static const PERCEPTION:String = "perception";
        public static const LUCK:String = "luck";

        // Bound Attributes
        public static const MELEE_DAMAGE:String = "meleeDamage";
        public static const HEALTH_POOL:String = "healthPool";
        public static const ARMOR:String = "armor";
        public static const PHYSICAL_RESISTANCE:String = "physicalResistance";
        public static const BLOCK_CHANCE:String = "blockChance";
        public static const ACCURACY:String = "accuracy";
        public static const EVADE:String = "evade";
        public static const SPEED:String = "speed";
        public static const STAMINA_POOL:String = "staminaPool";
        public static const RANGED_DAMAGE:String = "rangedDamage";
        public static const DISCOUNT:String = "discount";
        public static const INTIMIDATION:String = "intimidation";
        public static const CHARM:String = "charm";
        public static const CRAFTING:String = "crafting";
        public static const LOOT:String = "loot";
        public static const HEALTH_REGENERATION:String = "healthRegeneration";
        public static const STAMINA_REGENERATION:String = "staminaRegeneration";
        public static const LIFE_STEAL:String = "lifeSteal";
        public static const PREVENT_KNOCKOUT:String = "preventKnockout";
        public static const FIRE_RESISTANCE:String = "fireResistance";
        public static const ICE_RESISTANCE:String = "iceResistance";
        public static const SHOCK_RESISTANCE:String = "shockResistance";
        public static const POISON_RESISTANCE:String = "poisonResistance";

        public var name:String;
        public var values:Vector.<AttributeValue>;

        public function Attribute(name:String)
        {
            this.name = name;
            values = new Vector.<AttributeValue>();
        }

        public function addValue(v:AttributeValue):void
        {
            values.push(v);
        }

        public function get value():Number
        {
            var add:Number = 0;
            var multiply:Number = 1;

            for each (var v:AttributeValue in values)
            {
                if (v.operator == Operator.ADD)
                    add += v.quantity;
                else if (v.operator == Operator.MULTIPLY)
                    multiply += v.quantity;
            }

            return Utils.fixed(add * multiply);
        }

        public function baseValue():Object
        {
            var u:Object = {};
            for each (var value:AttributeValue in values)
            {
                if (!value.base)
                    continue;
                else if (value.operator == Operator.ADD)
                    u.add = value.quantity;
                else if (value.operator == Operator.MULTIPLY)
                    u.multiply = value.quantity;
            }

            return u;
        }


        public function removeNonBaseValues():void
        {
            for (var i:int = 0; i < values.length; i++)
            {
                if (values[i].base)
                    continue;

                values.removeAt(i);
                i--;
            }
        }
    }
}
