package wom.controller.command.city.friendwatchpost
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.unit.UnitInfoUtil;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.notification.FriendWatchpostHelpNotification;
   import wom.view.screen.popups.friendwatchpost.MobileFriendWatchpostHelpPopUp;
   
   public class HandleFriendWatchpostHelpNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleFriendWatchpostHelpNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:* = undefined;
         var _loc3_:BuildingInfo = null;
         var _loc2_:FriendWatchpostHelpNotification = messageReceivedEvent.message as FriendWatchpostHelpNotification;
         if(_loc2_.helpInfo && _loc2_.helpInfo.helpedFriends.length > 0)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFriendWatchpostHelpPopUp(_loc2_.helpInfo)));
            _loc1_ = createUnitAmountVector(_loc2_.helpInfo.helpedFriends[0].helpedUnits);
            _loc3_ = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,38);
            if(_loc3_)
            {
               UnitInfoUtil.addUnitInfoToCity(userInfo,city,domainInfo,_loc1_,_loc3_.instanceId,UnitStatusType.IN_WATCH_POST);
               dispatch(new ModelUpdateEvent("unitsInWatchPostUpdated"));
            }
         }
      }
      
      private function createUnitAmountVector(param1:Dictionary) : Vector.<UnitTypeAmountDTO>
      {
         var _loc2_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for(var _loc3_ in param1)
         {
            _loc2_.push(new UnitTypeAmountDTO(int(_loc3_),param1[_loc3_]));
         }
         return _loc2_;
      }
   }
}

