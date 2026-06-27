package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.alliance.UnitsOfMemberOrFriendReceivedEvent;
   import wom.model.component.CoreManager;
   import wom.model.dto.FriendWatchPostInfo;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.response.TransferWatchPostUnitsToFriendResponse;
   
   public class HandleTransferWatchPostUnitsToFriendResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleTransferWatchPostUnitsToFriendResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:int = 0;
         var _loc3_:UnitTypeAmountDTO = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:UnitInfo = null;
         var _loc1_:TransferWatchPostUnitsToFriendResponse = messageReceivedEvent.message as TransferWatchPostUnitsToFriendResponse;
         if(_loc1_.resultCode != 0)
         {
            return;
         }
         if(_loc1_.userId in userInfo.friendWatchPostInfos)
         {
            (userInfo.friendWatchPostInfos[_loc1_.userId] as FriendWatchPostInfo).availableCapacity = _loc1_.availableFriendWatchPostCapacity;
            (userInfo.friendWatchPostInfos[_loc1_.userId] as FriendWatchPostInfo).level = _loc1_.friendWatchPostLevel;
         }
         else
         {
            userInfo.friendWatchPostInfos[_loc1_.userId] = new FriendWatchPostInfo(_loc1_.friendWatchPostLevel,_loc1_.availableFriendWatchPostCapacity);
         }
         dispatch(new ModelUpdateEvent("friendWatchPostDataUpdated"));
         dispatch(new UnitsOfMemberOrFriendReceivedEvent("unitsOfFriendWatchPostReceived",_loc1_.friendWatchPostLevel,_loc1_.availableFriendWatchPostCapacity,_loc1_.friendUnits,_loc1_.unitLevels));
         if(_loc1_.source == 1)
         {
            _loc6_ = 0;
            while(_loc6_ < _loc1_.units.length)
            {
               _loc3_ = _loc1_.units[_loc6_];
               _loc4_ = 0;
               while(_loc4_ < _loc3_.amount)
               {
                  _loc5_ = 0;
                  while(_loc5_ < cityInfo.units.length)
                  {
                     _loc2_ = cityInfo.units[_loc5_];
                     if(_loc2_.typeId == _loc3_.id && _loc2_.status == UnitStatusType.IN_BARRACKS)
                     {
                        coreManager.transferUnitInBarracks(cityInfo.units[_loc5_].instanceId);
                        cityInfo.units.splice(_loc5_,1);
                        dispatch(new ModelUpdateEvent("unitsInBarracksUpdated"));
                        break;
                     }
                     _loc5_++;
                  }
                  _loc4_++;
               }
               _loc6_++;
            }
         }
      }
   }
}

