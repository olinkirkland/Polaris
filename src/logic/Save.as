package logic
{
    public class Save
    {
        public var name:String;
        public var time:Number;
        public var data:Object;

        public var size:Number;

        public function Save()
        {
        }

        public static function fromObject(u:Object):Save
        {
            var s:Save = new Save();
            s.name     = u.name;
            s.time     = u.time;
            s.data     = u;

            return s;
        }
    }
}
