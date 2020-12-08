package logic
{
    import flash.events.Event;
    import flash.events.EventDispatcher;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;

    import logic.GameState;

    public class SaveManager
    {
        private static var _instance:SaveManager;
        private var saves:Array = [];

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
            var data:Object = GameState.instance.toObject();
            data.name       = name;
            data.time       = new Date().time;

            var f:File            = File.applicationStorageDirectory.resolvePath("saves/" + name + ".json");
            var stream:FileStream = new FileStream();
            stream.open(f, FileMode.WRITE);
            stream.writeUTFBytes(JSON.stringify(data));
            stream.close();
        }

        public function load(name:String):void
        {
            // Load by name
            var f:File            = File.applicationStorageDirectory.resolvePath("saves/" + name + ".json");
            var stream:FileStream = new FileStream();
            stream.open(f, FileMode.READ);
            var data:Object = JSON.parse(stream.readUTFBytes(stream.bytesAvailable));
            stream.close();

            GameState.instance.parse(data);
        }

        public function getSavesAsync(callback:Function):void
        {
            var d:File = File.applicationStorageDirectory.resolvePath("saves");
            if (!d.exists)
                d.createDirectory();
            var files:Array = d.getDirectoryListing();

            var arr:Array = [];
            load(null);

            function load(event:Event):void
            {
                if (event)
                {
                    // Load
                    var f:File = event.target as File;
                    try
                    {
                        var save:Save = Save.fromObject(JSON.parse(String(f.data)));
                        save.file     = f;
                        arr.push(save);
                    } catch (error:Error)
                    {
                        // There was a problem loading a file
                        throw new Error("Invalid save: " + f.url);
                    }
                }

                if (files.length == 0)
                {
                    saves = arr;
                    callback.apply(null, [saves]);
                    return;
                }

                f = files.shift();
                f.addEventListener(Event.COMPLETE, load);
                f.load();
            }
        }
    }
}
