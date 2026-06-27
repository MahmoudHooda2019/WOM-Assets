package wom.controller.event.staff
{
   import flash.events.Event;
   import wom.model.domain.domaininfoobject.StaffDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.staff.StaffInfo;
   
   public class StaffsReadyEvent extends Event
   {
      
      public static const STAFFS_READY:String = "staffsReady";
      
      private var _buildingInfo:BuildingInfo;
      
      private var _staffPrerequisites:Vector.<StaffDIO>;
      
      private var _staffs:Vector.<StaffInfo>;
      
      public function StaffsReadyEvent(param1:String, param2:BuildingInfo, param3:Vector.<StaffDIO>, param4:Vector.<StaffInfo>)
      {
         super(param1);
         _buildingInfo = param2;
         _staffPrerequisites = param3;
         _staffs = param4;
      }
      
      override public function clone() : Event
      {
         return new StaffsReadyEvent(type,_buildingInfo,_staffPrerequisites,_staffs);
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get staffPrerequisites() : Vector.<StaffDIO>
      {
         return _staffPrerequisites;
      }
      
      public function get staffs() : Vector.<StaffInfo>
      {
         return _staffs;
      }
   }
}

