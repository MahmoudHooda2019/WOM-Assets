package peak.util
{
   import flash.utils.ByteArray;
   
   public class VarIntUtil
   {
      
      public function VarIntUtil()
      {
         super();
      }
      
      public static function readNextVarIntFrom(param1:ByteArray) : int
      {
         var _loc3_:* = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         while(_loc4_ < 64)
         {
            _loc3_ = uint(param1.readByte());
            _loc2_ |= (_loc3_ & 0x7F) << _loc4_;
            if((_loc3_ & 0x80) == 0)
            {
               return _loc2_;
            }
            _loc4_ += 7;
         }
         throw new Error("Invalid varint byte array");
      }
      
      public static function writeVarIntTo(param1:ByteArray, param2:int) : void
      {
         var _loc3_:* = 0;
         while(true)
         {
            _loc3_ = uint(param2 & 0xFF);
            if((param2 & -128) == 0)
            {
               break;
            }
            param1.writeByte(_loc3_ & 0x7F | 0x80);
            param2 >>>= 7;
         }
         param1.writeByte(_loc3_);
      }
   }
}

