package peak.util
{
   public class ValidationVerifier extends ValidationRecorder
   {
      
      private static const LAST_FRAMES_TO_DUMP:int = 250;
      
      private var frameIndex:int;
      
      private var recordedFrame:Array;
      
      private var frameInternalIndex:int;
      
      private var frameParams:Array;
      
      private var currentFrameParams:Array;
      
      private var nonEmptyFrames:Array;
      
      private var enabled:Boolean = true;
      
      public function ValidationVerifier()
      {
         super();
         reset();
      }
      
      override public function advanceFrame() : void
      {
         if(!enabled)
         {
            return;
         }
         if(recordedFrame.length > 0)
         {
            nonEmptyFrames.push(frameIndex);
         }
         recordedFrame = _records[++frameIndex];
         frameParams.push(currentFrameParams = []);
         frameInternalIndex = 0;
      }
      
      override public function deserialize(param1:String) : void
      {
         if(param1.length == 0)
         {
            enabled = false;
            return;
         }
         super.deserialize(param1);
         recordedFrame = _records[0];
      }
      
      private function verify(param1:*, param2:Array, ... rest) : void
      {
         var _loc7_:int = 0;
         var _loc5_:* = undefined;
         var _loc4_:* = undefined;
         currentFrameParams.push({
            "length":rest.length,
            "paramNames":param2
         });
         var _loc6_:* = recordedFrame[frameInternalIndex++];
         if(_loc6_ != param1)
         {
            dump();
            throw new Error("VERIFIER#" + frameIndex + " - " + " - PRODUCED: " + param1 + ", RECORD: " + _loc6_);
         }
         _loc7_ = 0;
         while(_loc7_ < rest.length)
         {
            _loc5_ = recordedFrame[frameInternalIndex++];
            _loc4_ = rest[_loc7_];
            if(_loc5_ != _loc4_)
            {
               dump();
               throw new Error("VERIFIER#" + frameIndex + ":" + param1 + " - PRODUCED: " + _loc4_ + ", RECORD: " + _loc5_);
            }
            _loc7_++;
         }
      }
      
      private function dump() : void
      {
         var _loc1_:int = 0;
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         var _loc6_:String = null;
         var _loc5_:int = 0;
         var _loc7_:int = nonEmptyFrames.length - 250;
         if(_loc7_ < 0)
         {
            _loc7_ = 0;
         }
         while(_loc7_ <= frameIndex)
         {
            _loc1_ = int(nonEmptyFrames[_loc7_]);
            _loc3_ = _records[_loc1_];
            _loc2_ = 0;
            for each(var _loc4_ in frameParams[_loc1_])
            {
               _loc6_ = "##Frame : " + _loc1_ + " > " + _loc3_[_loc2_++] + " | ";
               _loc5_ = 0;
               while(_loc5_ < _loc4_.length)
               {
                  _loc6_ += _loc4_.paramNames[_loc5_] + ":" + _loc3_[_loc2_++] + " | ";
                  _loc5_++;
               }
               trace(_loc6_);
            }
            _loc7_++;
         }
      }
      
      override public function record0(param1:*, param2:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,[]);
         if(param2 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record1(param1:*, param2:Array, param3:*, param4:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3);
         if(param4 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record2(param1:*, param2:Array, param3:*, param4:*, param5:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4);
         if(param5 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record3(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5);
         if(param6 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record4(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5,param6);
         if(param7 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record5(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5,param6,param7);
         if(param8 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record6(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5,param6,param7,param8);
         if(param9 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record7(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5,param6,param7,param8,param9);
         if(param10 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function record8(param1:*, param2:Array, param3:*, param4:*, param5:*, param6:*, param7:*, param8:*, param9:*, param10:*, param11:* = undefined) : void
      {
         if(!enabled)
         {
            return;
         }
         verify(param1,param2,param3,param4,param5,param6,param7,param8,param9,param10);
         if(param11 != undefined)
         {
            frameInternalIndex = frameInternalIndex + 1;
            currentFrameParams[currentFrameParams.length - 1].length++;
         }
      }
      
      override public function reset() : void
      {
         frameIndex = 0;
         frameInternalIndex = 0;
         frameParams = [currentFrameParams = []];
         nonEmptyFrames = [];
      }
   }
}

