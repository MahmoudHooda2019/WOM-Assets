package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.game.resource.ResourceType;
   
   public class ResourceBarAnimationEvent extends Event
   {
      
      public static const START_ANIMATION:String = "startAnimation";
      
      public var amount:int;
      
      public var resourceType:ResourceType;
      
      public function ResourceBarAnimationEvent(param1:String, param2:ResourceType, param3:int)
      {
         super(param1);
         this.resourceType = param2;
         this.amount = param3;
      }
      
      override public function clone() : Event
      {
         return new ResourceBarAnimationEvent(type,resourceType,amount);
      }
   }
}

