package peak.cuckoo.core
{
   public class SparseBehavior extends Behavior
   {
      
      public var interval:int = 0;
      
      public var bookedFrame:int = -1;
      
      public var startFrameNum:int = 1;
      
      public function SparseBehavior()
      {
         super();
         priority = 0;
      }
      
      override protected function start() : void
      {
         if(interval > 1)
         {
            owner.root.behaviorUpdater.registerSparse(this);
         }
         else
         {
            super.start();
         }
      }
      
      override protected function stop() : void
      {
         if(bookedFrame != -1)
         {
            startFrameNum = bookedFrame - owner.root.behaviorUpdater.currentFrame;
            if(startFrameNum == 0)
            {
               startFrameNum = interval;
            }
            else if(bookedFrame < owner.root.behaviorUpdater.currentFrame)
            {
               startFrameNum += 10800;
            }
            owner.root.behaviorUpdater.deregisterSparse(this);
            bookedFrame = -1;
         }
         else
         {
            super.stop();
         }
      }
      
      public function setInterval(param1:int) : void
      {
         if(enabled)
         {
            disable();
            this.interval = param1;
            enable();
         }
         else
         {
            this.interval = param1;
         }
      }
      
      public function setNextTnterval(param1:int = 1) : void
      {
         if(enabled)
         {
            disable();
            startFrameNum = param1 < 1 ? 1 : param1;
            enable();
         }
         else
         {
            startFrameNum = param1 < 1 ? 1 : param1;
         }
      }
      
      override public function terminate() : void
      {
         super.terminate();
         bookedFrame = -1;
         startFrameNum = 1;
      }
      
      override public function destroy() : void
      {
         disable();
         bookedFrame = -1;
         startFrameNum = 1;
      }
   }
}

