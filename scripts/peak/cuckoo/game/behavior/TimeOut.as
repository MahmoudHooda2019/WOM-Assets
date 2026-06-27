package peak.cuckoo.game.behavior
{
   import flash.utils.Dictionary;
   import peak.cuckoo.core.Behavior;
   import peak.signal.Signal0;
   
   public class TimeOut extends Behavior
   {
      
      public static const TYPE_ID:String = "TimeOut";
      
      public var FRAME_NUMBER_TO_DIE:int = 5;
      
      private var currentFrame:int;
      
      private var jobs:Dictionary;
      
      public function TimeOut()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "TimeOut";
      }
      
      override public function init() : void
      {
         super.init();
         currentFrame = 0;
         jobs = new Dictionary();
      }
      
      override public function update() : void
      {
         if(currentFrame == FRAME_NUMBER_TO_DIE)
         {
            disable();
         }
         var _loc1_:Signal0 = jobs[currentFrame];
         if(_loc1_)
         {
            _loc1_.dispatch();
         }
         delete jobs[currentFrame++];
      }
      
      public function addJobToFrame(param1:int, param2:Function, ... rest) : void
      {
         var targetFrame:int;
         var targetSignal:Signal0;
         var timeOut:int = param1;
         var job:Function = param2;
         var parameters:Array = rest;
         enable();
         targetFrame = currentFrame + timeOut;
         if(targetFrame >= FRAME_NUMBER_TO_DIE)
         {
            FRAME_NUMBER_TO_DIE = targetFrame + 1;
         }
         targetSignal = jobs[targetFrame];
         if(!targetSignal)
         {
            targetSignal = jobs[targetFrame] = new Signal0();
         }
         if(parameters.length > 0)
         {
            targetSignal.addFunctionOnce(function():void
            {
               job.apply(undefined,parameters);
            });
         }
         else
         {
            targetSignal.addFunctionOnce(job);
         }
      }
      
      override public function disable() : void
      {
         currentFrame = 0;
         super.disable();
      }
      
      override public function terminate() : void
      {
         super.terminate();
      }
   }
}

