package wom.controller.event.alliance
{
   import flash.events.Event;
   import flash.utils.Dictionary;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class UnitsOfMemberOrFriendReceivedEvent extends Event
   {
      
      public static const UNITS_OF_ALLIANCE_MEMBER_RECEIVED:String = "unitsOfAllianceMemberReceived";
      
      public static const UNITS_OF_FRIEND_WATCH_POST_RECEIVED:String = "unitsOfFriendWatchPostReceived";
      
      private var _buildingLevel:int;
      
      private var _capacity:int;
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      private var _unitLevels:Dictionary;
      
      public function UnitsOfMemberOrFriendReceivedEvent(param1:String, param2:int, param3:int, param4:Vector.<UnitTypeAmountDTO>, param5:Dictionary)
      {
         super(param1);
         _buildingLevel = param2;
         _capacity = param3;
         _units = param4;
         _unitLevels = param5;
      }
      
      public function get buildingLevel() : int
      {
         return _buildingLevel;
      }
      
      public function get capacity() : int
      {
         return _capacity;
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
      
      override public function clone() : Event
      {
         return new UnitsOfMemberOrFriendReceivedEvent(type,buildingLevel,capacity,units,unitLevels);
      }
   }
}

