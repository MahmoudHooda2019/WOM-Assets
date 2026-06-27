package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.UnitTypeAmountDTO;
   
   public class GetWatchPostUnitsOfFriendResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _userId:String;
      
      private var _friendWatchPostLevel:int;
      
      private var _availableFriendWatchPostCapacity:int;
      
      private var _units:Vector.<UnitTypeAmountDTO>;
      
      private var _unitLevels:Dictionary;
      
      public function GetWatchPostUnitsOfFriendResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _resultCode = param1.resultCode;
         _userId = param1.userId;
         _friendWatchPostLevel = param1.friendWatchPostLevel;
         _availableFriendWatchPostCapacity = param1.availableFriendWatchPostCapacity;
         _units = new Vector.<UnitTypeAmountDTO>();
         if(param1.units)
         {
            for each(var _loc3_ in param1.units)
            {
               _units.push(new UnitTypeAmountDTO(_loc3_.id,_loc3_.amount));
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
      
      public function get userId() : String
      {
         return _userId;
      }
      
      public function get friendWatchPostLevel() : int
      {
         return _friendWatchPostLevel;
      }
      
      public function get availableFriendWatchPostCapacity() : int
      {
         return _availableFriendWatchPostCapacity;
      }
      
      public function get units() : Vector.<UnitTypeAmountDTO>
      {
         return _units;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
   }
}

