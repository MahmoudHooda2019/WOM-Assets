package wom.controller.event.beast
{
   import flash.events.Event;
   
   public class BeastDeploymentEvent extends Event
   {
      
      public static const CHOOSE:String = "beastDeploymentChoose";
      
      public static const DEPLOY:String = "beastDeploymentDeploy";
      
      public static const HOLD:String = "beastDeploymentHold";
      
      public static const RETREAT:String = "beastDeploymentRetreat";
      
      private var _eventName:String;
      
      private var _beastTypeId:int;
      
      public function BeastDeploymentEvent(param1:String, param2:int, param3:String)
      {
         super(param1);
         _beastTypeId = param2;
         _eventName = param3;
      }
      
      override public function clone() : Event
      {
         return new BeastDeploymentEvent(type,_beastTypeId,_eventName);
      }
      
      public function get beastTypeId() : int
      {
         return _beastTypeId;
      }
      
      public function get eventName() : String
      {
         return _eventName;
      }
   }
}

