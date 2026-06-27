package wom.model.component.entity.gamesprite
{
   import flash.utils.getTimer;
   
   public class Worker extends Unit
   {
      
      public var lastWorkerSpeechTimer:int = 0;
      
      public function Worker()
      {
         super();
         scheduleScpeech();
      }
      
      public function scheduleScpeech() : void
      {
         lastWorkerSpeechTimer = getTimer() + 60000 + int(Math.random() * 60000);
      }
   }
}

