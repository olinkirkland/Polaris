package managers
{
    import characterAndGear.Character;

    import flash.events.Event;
    import flash.filesystem.File;

    public class CharacterManager
    {
        private static var _instance:CharacterManager;

        public var characters:Object = {};

        public function CharacterManager()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public function addCharacter(character:Character):void
        {
            characters[character.name] = character;
        }

        public function getCharacter(name:String):Character
        {
            return characters[name];
        }

        public static function get instance():CharacterManager
        {
            if (!_instance)
                new CharacterManager();
            return _instance;
        }
    }
}
