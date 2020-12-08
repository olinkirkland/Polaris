package logic
{
    import characterAndGear.Character;

    import flash.events.Event;
    import flash.filesystem.File;
    import flash.utils.setTimeout;

    import statistics.Career;

    public class AssetManager
    {
        private static var _instance:AssetManager;

        private var onCompleteCallback:Function;

        private var loadingQueue:Array = [
//            {path: "careers", callback: parseCareer},
//            {path: "character templates", callback: parseCharacterTemplate},
//            {path: "items", callback: parseItems}
        ];

        public function AssetManager()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public static function get instance():AssetManager
        {
            if (!_instance)
                new AssetManager();
            return _instance;
        }

        private function loadNextInQueue():void
        {
            // todo remove this if statement because there will always be entries in the loading queue
            if (loadingQueue.length == 0)
            {
                setTimeout(onCompleteCallback, 500);
                return;
            }

            var u:Object = loadingQueue.shift();
            loadAssetsFromDirectory(u.path, u.callback);
        }

        private function loadAssetsFromDirectory(path:String, onDataLoaded:Function):void
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
                    loadNextInQueue();
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

        private function parseItems(data:Object):void
        {

        }

        public function load(onCompleteCallback:Function):void
        {
            this.onCompleteCallback = onCompleteCallback;
            loadNextInQueue();
        }
    }
}
