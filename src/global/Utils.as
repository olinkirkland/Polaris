package global
{
    public class Utils
    {
        public static function secondsSince(d:Date):Number
        {
            return Number(((new Date().time - d.time) / 1000).toFixed(4));
        }

        public static function formatTime(t:Number):String
        {
            var d:Date = new Date();
            d.time     = t;
            return d.month + "/" + d.date + "/" + d.fullYear + " " + d.hours + ":" + d.minutes;
        }

        public static function toArray(iterable:*):Array
        {
            var arr:Array = [];
            for each (var elem:* in iterable)
                arr.push(elem);
            return arr;
        }

        public static function fixed(n:Number, places:int = 2):Number
        {
            return Number(n.toFixed(places));
        }

        public static function stringToColor(str:String):uint
        {
            var modifier:int = 1;
            var seed:int     = 0;
            for (var i:int = 0; i < str.length; i++)
            {
                seed = str.charCodeAt(i) + ((seed << 5) - seed);
                seed = seed & seed;
            }

            seed += modifier;

            var max:Number = 1 / 2147483647;
            var min:Number = -max;
            // Deal with zeroes
            if (seed < 1)
                seed *= 9999;
            // Deal with negatives
            if (seed < 1)
                seed = 1;

            seed ^= (seed << 21);
            seed ^= (seed >>> 35);
            seed ^= (seed << 4);

            return 0xffffff * seed * (seed > 0 ? max : min);
        }

        public static function stringToLightColor(str:String):uint
        {
            var color:int = stringToColor(str);
            while (!isLight(color))
                color = lighten(color);
            return color;
        }

        public static function lighten(color:uint, modifier:Number = .2):uint
        {
            var z:int = int(0xff * modifier);

            var r:int = trim(((color & 0xff0000) >> 16) + z);
            var g:int = trim(((color & 0x00ff00) >> 8) + z);
            var b:int = trim(((color & 0x0000ff)) + z);

            return r << 16 | g << 8 | b;
        }

        private static function trim(value:uint):uint
        {
            return Math.min(Math.max(0x00, value), 0xff);
        }

        public static function isLight(color:uint):Boolean
        {
            var rgb:Object = hexToRgb(color);
            var a:Number   = (rgb.r * 0.299) + (rgb.g * 0.587) + (rgb.b * 0.114);
            return a > 186;
        }

        public static function hexToRgb(hex:uint):Object
        {
            return {
                r: (hex & 0xff0000) >> 16,
                g: (hex & 0x00ff00) >> 8,
                b: (hex & 0x0000ff)
            };
        }
    }
}