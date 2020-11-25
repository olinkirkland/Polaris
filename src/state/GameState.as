package state
{
    public class GameState
    {
        private static var _instance:GameState;

        public var name:String;
        public var inventory:Inventory;

        public function GameState()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():GameState
        {
            if (!_instance)
                new GameState();
            return _instance;
        }


        public function load(data:Object):void
        {
            name      = data.name;
            inventory = Inventory.fromObject(data.inventory);
        }

        public function save(name:String):void
        {

        }
    }
}
