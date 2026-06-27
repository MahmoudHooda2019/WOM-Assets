package peak.util
{
   import flash.utils.ByteArray;
   
   public class ValidationRecorder
   {
      
      private static var _INSTANCE:ValidationRecorder;
      
      protected var _records:Array;
      
      private var currentFrameRecord:Array;
      
      public function ValidationRecorder()
      {
         super();
         reset();
      }
      
      public static function get INSTANCE() : ValidationRecorder
      {
         if(!_INSTANCE)
         {
            _INSTANCE = new ValidationRecorder();
         }
         return _INSTANCE;
      }
      
      public function serialize() : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(_records);
         _loc2_.deflate();
         var _loc1_:String = Base64.encodeByteArray(_loc2_);
         trace("VALIDATION RECORDS " + _loc1_.length);
         return _loc1_;
      }
      
      public function deserialize(param1:String) : void
      {
         var _loc2_:ByteArray = Base64.decodeToByteArray(param1);
         _loc2_.inflate();
         _records = _loc2_.readObject();
      }
      
      public function advanceFrame() : void
      {
         _records.push(currentFrameRecord = []);
      }
      
      public function record0(param1:*, param2:* = undefined) : void
      {
         currentFrameRecord.push(param1);
         if(param2 != undefined)
         {
            currentFrameRecord.push(param2);
         }
      }
      
      public function record1(param1:*, param2:Array, param3:*, param4:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3);
         if(param4 != undefined)
         {
            currentFrameRecord.push(param4);
         }
      }
      
      public function record2(param1:*, param2:Array, param3:*, param4:*, param5:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4);
         if(param5 != undefined)
         {
            currentFrameRecord.push(param5);
         }
      }
      
      public function record3(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5);
         if(param6 != undefined)
         {
            currentFrameRecord.push(param6);
         }
      }
      
      public function record4(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5,param6);
         if(param7 != undefined)
         {
            currentFrameRecord.push(param7);
         }
      }
      
      public function record5(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5,param6,param7);
         if(param8 != undefined)
         {
            currentFrameRecord.push(param8);
         }
      }
      
      public function record6(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5,param6,param7,param8);
         if(param9 != undefined)
         {
            currentFrameRecord.push(param9);
         }
      }
      
      public function record7(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5,param6,param7,param8,param9);
         if(param10 != undefined)
         {
            currentFrameRecord.push(param10);
         }
      }
      
      public function record8(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:* = undefined) : void
      {
         currentFrameRecord.push(param1,param3,param4,param5,param6,param7,param8,param9,param10);
         if(param11 != undefined)
         {
            currentFrameRecord.push(param11);
         }
      }
      
      public function reset() : void
      {
         _records = [currentFrameRecord = []];
      }
   }
}

