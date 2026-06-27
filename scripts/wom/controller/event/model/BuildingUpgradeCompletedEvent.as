package wom.controller.event.model
{
   import flash.events.Event;
   import wom.model.game.building.BuildingInfo;
   
   public class BuildingUpgradeCompletedEvent extends Event
   {
      
      public static const DONE:String = "buildingUpgradeCompleted";
      
      private var _buildingInfo:BuildingInfo;
      
      public function BuildingUpgradeCompletedEvent(param1:String, param2:BuildingInfo)
      {
         super(param1);
         _buildingInfo = param2;
      }
      
      override public function clone() : Event
      {
         return new BuildingUpgradeCompletedEvent(type,_buildingInfo);
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

