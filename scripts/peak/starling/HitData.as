package peak.starling
{
   import flash.utils.ByteArray;
   
   public class HitData
   {
      
      public var source:ByteArray;
      
      public var width:uint;
      
      public var height:uint;
      
      public function HitData(param1:ByteArray, param2:uint, param3:uint)
      {
         super();
         this.source = param1;
         this.width = param2;
         this.height = param3;
      }
      
      final public function hitTest(param1:Number, param2:Number) : Boolean
      {
         var _loc3_:int = param2 * width + param1;
         return (source[_loc3_ >>> 3] & 1 << (_loc3_ & 7)) != 0;
      }
   }
}

