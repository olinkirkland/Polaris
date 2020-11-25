package managers
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import state.GameState;

    public class SaveManager
    {
        private static var _instance:SaveManager;

        public function SaveManager()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():SaveManager
        {
            if (!_instance)
                new SaveManager();
            return _instance;
        }

        public function save(name:String):void
        {
            // Save by name
            var data:Object = {};
            data.name = name;

            var f:File = File.applicationStorageDirectory.resolvePath("saves/" + name + ".json");
            var stream:FileStream = new FileStream();
            stream.open(f, FileMode.WRITE);
            stream.writeUTFBytes(JSON.stringify(data));
            stream.close();
        }

        public function quickSave():void
        {
            save(GameState.instance.name + " (Quicksave)");
        }

        public function load(name:String):void
        {
            // Load by name
            var f:File = File.applicationStorageDirectory.resolvePath("saves/" + name + ".json");
            var stream:FileStream = new FileStream();
            stream.open(f, FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));
            stream.close();
            
            GameState.instance.load(data);
        }

        public function quickLoad():void
        {
            load(GameState.instance.name + " (Quicksave)");
        }

        public function get saves():Array
        {

        }
    }
}
