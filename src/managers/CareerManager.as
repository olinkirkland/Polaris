package managers
{
    import statistics.Career;

    public class CareerManager
    {
        private static var _instance:CareerManager;

        public var careers:Object = {};

        public function CareerManager()
        {
            if (_instance)
                throw new Error("Singletons can only have one instance");
            _instance = this;
        }

        public function addCareer(career:Career):void
        {
            careers[career.name] = career;
        }

        public function getCareer(name:String):Career
        {
            return careers[name];
        }

        public static function get instance():CareerManager
        {
            if (!_instance)
                new CareerManager();
            return _instance;
        }
    }
}
