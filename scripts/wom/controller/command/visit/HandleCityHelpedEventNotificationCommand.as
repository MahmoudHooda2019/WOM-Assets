package wom.controller.command.visit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.help.HelpInfo;
   import wom.model.message.notification.CityHelpedEventNotification;
   
   public class HandleCityHelpedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function HandleCityHelpedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:HelpInfo = null;
         var _loc1_:CityHelpedEventNotification = messageReceivedEvent.message as CityHelpedEventNotification;
         if(_loc1_.helpInfo != null)
         {
            _loc3_ = _loc1_.helpInfo;
            if(!(_loc3_.helper.gameId in userInfo.helps))
            {
               userInfo.helps[_loc3_.helper.gameId] = new Vector.<HelpInfo>();
            }
            for each(var _loc2_ in city.buildings)
            {
               if(_loc2_.instanceId == _loc3_.buildingInstanceId)
               {
                  _loc3_.buildingTypeId = _loc2_.buildingTypeId;
                  break;
               }
            }
            userInfo.helps[_loc3_.helper.gameId].push(_loc3_);
         }
      }
   }
}

