package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class TransferWatchPostUnitsToFriendResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _userId:String;
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      private var _friendUnits:Vector.<UnitTypeAmountDTO>;
      
      private var _friendWatchPostLevel:int;
      
      private var _availableFriendWatchPostCapacity:int;
      
      private var _source:int;
      
      private var _unitLevels:Dictionary;
      
      public function TransferWatchPostUnitsToFriendResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _userId = param1.userId;
         _source = param1.source;
         _friendWatchPostLevel = param1.friendWatchPostLevel;
         _availableFriendWatchPostCapacity = param1.availableFriendWatchPostCapacity;
         _units = new Vector.<UnitTypeAmountDTO>();
         _friendUnits = new Vector.<UnitTypeAmountDTO>();
         if(param1.units)
         {
            for each(var _loc3_ in param1.units)
            {
               _units.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
            }
         }
         if(param1.memberUnits)
         {
            for each(_loc3_ in param1.memberUnits)
            {
               _friendUnits.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
            }
         }
         _unitLevels = new Dictionary();
         if(param1.unitLevels)
         {
            for(var _loc2_ in param1.unitLevels)
            {
               _unitLevels[_loc2_] = param1.unitLevels[_loc2_];
            }
         }
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get source() : int
      {
         return _source;
      }
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
      
      public function get friendUnits() : Vector.<UnitTypeAmountDTO>
      {
         return _friendUnits;
      }
      
      public function get friendWatchPostLevel() : int
      {
         return _friendWatchPostLevel;
      }
      
      public function get availableFriendWatchPostCapacity() : int
      {
         return _availableFriendWatchPostCapacity;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
   }
}

