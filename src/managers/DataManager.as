package managers
{
    import characterAndGear.Character;

    import flash.events.Event;
    import flash.filesystem.File;

    import statistics.Career;

    public class DataManager
    {
        private static var _instance:DataManager;

        private var onCompleteCallback:Function;

        private var loadingQueue:Array = [
            {path: "careers", callback: parseCareer},
            {path: "characters", callback: parseCharacter},
            {path: "items", callback: parseItems}
        ];

        public function DataManager()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():DataManager
        {
            if (!_instance)
                new DataManager();
            return _instance;
        }

        public function loadNextInQueue(onCompleteCallback:Function):void
        {
            this.onCompleteCallback = onCompleteCallback;

            var u:Object = loadingQueue.shift();
            loadDataInPath(u.path, u.callback);
        }

        public function loadDataInPath(path:String, onDataLoaded:Function):void
        {
            trace("Loading " + path);
            var file:File = File.applicationDirectory.resolvePath("data/" + path);
            if (!file.isDirectory)
                throw new Error(file.url + " is not a directory");

            var files:Array = file.getDirectoryListing();
            trace("  " + files.length + " files");
            for each (file in files)
            {
                file.addEventListener(Event.COMPLETE, onFileLoaded);
                file.load();
            }

            function onFileLoaded(event:Event):void
            {
                var f:File = File(event.target);
                trace("    Loaded " + f.name);
                files.removeAt(files.indexOf(f));

                var str:String = f.data.readUTFBytes(f.data.length);
                onDataLoaded.apply(null, [JSON.parse(str)]);

                // Need to load more files
                if (files.length > 0)
                    return;

                // Data group fully loaded
                if (loadingQueue.length > 0)
                {
                    loadNextInQueue(onCompleteCallback);
                    return;
                }

                // All data groups fully loaded
                onCompleteCallback.apply();
            }
        }

        private function parseCareer(data:Object):void
        {
            CareerManager.instance.addCareer(Career.fromObject(data));
        }

        private function parseCharacter(data:Object):void
        {
            CharacterManager.instance.addCharacter(Character.fromObject(data));
        }

        private function parseItems(data:Object):void
        {

        }
    }
}
