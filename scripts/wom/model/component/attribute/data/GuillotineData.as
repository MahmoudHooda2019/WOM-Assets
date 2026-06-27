package wom.model.component.attribute.data
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import wom.model.component.entity.gamesprite.Building;
   
   public class GuillotineData extends Attribute
   {
      
      public static const TYPE_ID:String = "GuillotineData";
      
      private var actionAnimation:ActionAnimation;
      
      private var waitingToExecute:uint = 0;
      
      public function GuillotineData()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "GuillotineData";
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
         actionAnimation = (owner as Building).viewManager.animation as ActionAnimation;
      }
      
      public function addUnit() : void
      {
         if(!actionAnimation || !actionAnimation.owner)
         {
            init();
         }
         if(waitingToExecute == 0)
         {
            actionAnimation.fpsChangeRate = 15;
            actionAnimation.setStopFrame(4);
            actionAnimation.startAnimation();
         }
         waitingToExecute = waitingToExecute + 1;
      }
      
      public function removeUnit() : void
      {
         if(!actionAnimation || !actionAnimation.owner)
         {
            init();
         }
         waitingToExecute = waitingToExecute - 1;
         actionAnimation.fpsChangeRate = 3;
         if(!actionAnimation.enabled)
         {
            actionAnimation.setFrame(5);
         }
         if(waitingToExecute != 0)
         {
            actionAnimation.setStopFrame(4);
         }
         else
         {
            actionAnimation.setStopFrame(12);
         }
         actionAnimation.startAnimation();
      }
   }
}

