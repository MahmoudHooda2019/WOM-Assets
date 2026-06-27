package wom.controller.event.model
{
   import flash.events.Event;
   import wom.model.game.resource.ResourceType;
   
   public class NotEnoughResourceEvent extends Event
   {
      
      public static const RESOURCE_TYPE_KNOWN:String = "resourceTypeKnown";
      
      public static const RESOURCE_TYPE_UNKNOWN:String = "resourceTypeUnknown";
      
      private var _resourceType:ResourceType;
      
      private var _params:Object;
      
      public function NotEnoughResourceEvent(param1:String, param2:ResourceType, param3:Object = null)
      {
         super(param1);
         _resourceType = param2;
         _params = param3;
      }
      
      override public function clone() : Event
      {
         return new NotEnoughResourceEvent(type,_resourceType,_params);
      }
      
      public function get params() : Object
      {
         return _params;
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
   }
}

