package wom.model.component.behavior.unit
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.behavior.FpsSync;
   import wom.model.component.attribute.viewManager.UnitViewManager;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.speech.SpeechType;
   
   public class Speak extends Behavior
   {
      
      public static const TYPE_ID:String = "Speak";
      
      private static const BUBBLE_DISPLAY_TIME:int = 300;
      
      private var wait:Number;
      
      private var viewManager:UnitViewManager;
      
      private var sync:FpsSync;
      
      public function Speak()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "Speak";
      }
      
      override public function init() : void
      {
         super.init();
         viewManager = (owner as Unit).viewManager;
         wait = 0;
         startEnabled = false;
         sync = owner.root.sync;
      }
      
      override public function update() : void
      {
         wait -= sync.precise;
         if(wait <= 0)
         {
            viewManager.clearSpeechBubble();
            wait = 0;
            this.disable();
         }
      }
      
      public function speak(param1:SpeechType) : void
      {
         var _loc2_:int = Math.random() * param1.count;
         viewManager.drawSpeechBubble(param1.id,_loc2_);
         wait = 300;
         enable();
      }
      
      override protected function stop() : void
      {
         viewManager.clearSpeechBubble();
         wait = 0;
         super.stop();
      }
   }
}

