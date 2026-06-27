package wom.controller.event.combat
{
   import flash.events.Event;
   
   public class EndDeploymentEvent extends Event
   {
      
      public static const END_DEPLOYMENT:String = "endDeployment";
      
      public function EndDeploymentEvent(param1:String)
      {
         super(param1);
      }
      
      override public function clone() : Event
      {
         return new EndDeploymentEvent(type);
      }
   }
}

