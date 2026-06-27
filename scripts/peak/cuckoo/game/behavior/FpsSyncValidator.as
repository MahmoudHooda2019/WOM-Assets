package peak.cuckoo.game.behavior
{
   import flash.utils.ByteArray;
   import peak.cuckoo.game.Root;
   import peak.util.VarIntUtil;
   
   public class FpsSyncValidator extends FpsSync
   {
      
      private var last:int = 0;
      
      private var _delteTimeVector:Vector.<ByteArray>;
      
      private var currentDeltaTimeBytes:ByteArray;
      
      private var nextIndex:int;
      
      public function FpsSyncValidator(param1:int, param2:Root)
      {
         super(param1,param2);
      }
      
      override public function get typeId() : String
      {
         return "FPSSync";
      }
      
      override public function init() : void
      {
         nextIndex = 0;
      }
      
      override public function update() : void
      {
         deltaTime = getDeltaTimeForFrame();
         currentGameTime += deltaTime;
         precise = elapsed = (currentGameTime - last) * factor;
         elapsed += over;
         elapsedDiscrete = elapsed;
         over = elapsed - elapsedDiscrete;
         last = currentGameTime;
         frameNum = frameNum + 1;
      }
      
      private function getDeltaTimeForFrame() : int
      {
         if(!currentDeltaTimeBytes || currentDeltaTimeBytes.bytesAvailable <= 0)
         {
            currentDeltaTimeBytes = _delteTimeVector[nextIndex++];
            currentDeltaTimeBytes.inflate();
         }
         var _temp_5:* = VarIntUtil;
         var _loc3_:ByteArray = currentDeltaTimeBytes;
         var _loc1_:VarIntUtil = _temp_5;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         while(_loc5_ < 64)
         {
            var _loc4_:uint = uint(_loc3_.readByte());
            _loc2_ |= (_loc4_ & 0x7F) << _loc5_;
            if((_loc4_ & 0x80) == 0)
            {
               return _loc2_;
            }
            _loc5_ += 7;
         }
         throw new Error("Invalid varint byte array");
      }
      
      public function setDeltaTimeVector(param1:Vector.<ByteArray>) : void
      {
         _delteTimeVector = param1;
      }
      
      override public function reset() : void
      {
         super.reset();
         last = 0;
         currentGameTime = 0;
         nextIndex = 0;
         currentDeltaTimeBytes = null;
         _delteTimeVector = null;
      }
   }
}

