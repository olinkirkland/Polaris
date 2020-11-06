package characterAndGear
{
    import global.Operator;

    import managers.CareerManager;

    import statistics.*;
    import statistics.Career;

    public class Character
    {
        // Properties
        public var name:String;
        public var career:Career;

        // Progression
        public var experience:int;
        public var experienceNeeded:int;
        public var level:int;
        public var skillPoints:int;

        // Resources
        public var health:int;
        public var stamina:int;

        // Gear
        public var gear:Gear;

        // Effects
        private var rules:Vector.<AttributeRule>;

        // Primary Attributes
        public var strength:Attribute = new Attribute(Attribute.STRENGTH);
        public var defense:Attribute = new Attribute(Attribute.DEFENSE);
        public var agility:Attribute = new Attribute(Attribute.AGILITY);
        public var aura:Attribute = new Attribute(Attribute.AURA);
        public var perception:Attribute = new Attribute(Attribute.PERCEPTION);
        public var luck:Attribute = new Attribute(Attribute.LUCK);

        // Bound Attributes
        public var meleeDamage:Attribute = new Attribute(Attribute.MELEE_DAMAGE);
        public var healthPool:Attribute = new Attribute(Attribute.HEALTH_POOL);
        public var armor:Attribute = new Attribute(Attribute.ARMOR);
        public var physicalResistance:Attribute = new Attribute(Attribute.PHYSICAL_RESISTANCE);
        public var blockChance:Attribute = new Attribute(Attribute.BLOCK_CHANCE);
        public var accuracy:Attribute = new Attribute(Attribute.ACCURACY);
        public var evade:Attribute = new Attribute(Attribute.EVADE);
        public var speed:Attribute = new Attribute(Attribute.SPEED);
        public var staminaPool:Attribute = new Attribute(Attribute.STAMINA_POOL);
        public var rangedDamage:Attribute = new Attribute(Attribute.RANGED_DAMAGE);
        public var discount:Attribute = new Attribute(Attribute.DISCOUNT);
        public var intimidation:Attribute = new Attribute(Attribute.INTIMIDATION);
        public var charm:Attribute = new Attribute(Attribute.CHARM);
        public var crafting:Attribute = new Attribute(Attribute.CRAFTING);
        public var loot:Attribute = new Attribute(Attribute.LOOT);
        public var healthRegeneration:Attribute = new Attribute(Attribute.HEALTH_REGENERATION);
        public var staminaRegeneration:Attribute = new Attribute(Attribute.STAMINA_REGENERATION);
        public var lifeSteal:Attribute = new Attribute(Attribute.LIFE_STEAL);
        public var preventKnockout:Attribute = new Attribute(Attribute.PREVENT_KNOCKOUT);
        public var fireResistance:Attribute = new Attribute(Attribute.FIRE_RESISTANCE);
        public var iceResistance:Attribute = new Attribute(Attribute.ICE_RESISTANCE);
        public var shockResistance:Attribute = new Attribute(Attribute.SHOCK_RESISTANCE);
        public var poisonResistance:Attribute = new Attribute(Attribute.POISON_RESISTANCE);

        // Attributes in Vectors
        public var primaryAttributes:Vector.<Attribute> = Vector.<Attribute>([strength, defense, agility, aura, perception, luck]);
        public var boundAttributes:Vector.<Attribute> = Vector.<Attribute>([meleeDamage, healthPool, armor, physicalResistance,
            blockChance, accuracy, evade, speed, staminaPool, rangedDamage, discount, intimidation, charm, crafting, loot, healthRegeneration,
            staminaRegeneration, lifeSteal, preventKnockout, fireResistance, iceResistance, shockResistance, poisonResistance]);

        public function Character()
        {
        }

        public function validate():void
        {
            // Determine all Rules
            rules = new Vector.<AttributeRule>();

            // From career
            for each (var rule:AttributeRule in career.rules)
                rules.push(rule);

            // From items
            for each (var item:Item in gear.items)
                if (item)
                    for each (rule in item.rules)
                        rules.push(rule);

            // Clear all non-base Attribute values
            for each (var attribute:Attribute in primaryAttributes.concat(boundAttributes))
                attribute.removeNonBaseValues();

            // Apply Attribute values from rules
            for each (rule in rules)
            {
                var targetAttribute:Attribute = this[rule.attributeName];
                var valueAttribute:Attribute = this[rule.sourceAttributeName];
                targetAttribute.addValue(new AttributeValue(valueAttribute.value * rule.value, rule.operator));
            }

            trace("Validation complete");
        }

        public static function fromObject(u:Object):Character
        {
            var c:Character = new Character();
            c.name = u.name;
            c.career = CareerManager.instance.getCareer(u.career);
            for each (var attribute:Attribute in c.primaryAttributes)
            {
                // Assign base values from object
                attribute.addValue(new AttributeValue(u.primaryAttributes[attribute.name].add, Operator.ADD, true));
                attribute.addValue(new AttributeValue(u.primaryAttributes[attribute.name].multiply, Operator.MULTIPLY, true));
            }

            c.gear = new Gear();
            for (var slot:String in u.items)
                c.gear[slot] = Item.fromObject(u.items[slot]);

            c.validate();
            return c;
        }

        public function toObject():Object
        {
            var u:Object = {};
            u.career = career.name;
            u.strength = strength.baseValue();
            u.defense = defense.baseValue();
            u.agility = agility.baseValue();
            u.aura = aura.baseValue();
            u.perception = perception.baseValue();
            u.luck = luck.baseValue();
            return u;
        }
    }
}
