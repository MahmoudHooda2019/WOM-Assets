package wom.model.game.tutorial
{
   public class TutorialActivationState
   {
      
      private var _enabled:Boolean;
      
      private var _activated:Boolean;
      
      public function TutorialActivationState(param1:Boolean = false, param2:Boolean = true)
      {
         super();
         _enabled = param1;
         _activated = param2;
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         _enabled = param1;
      }
      
      public function get activated() : Boolean
      {
         return _activated;
      }
      
      public function set activated(param1:Boolean) : void
      {
         _activated = param1;
      }
   }
}

