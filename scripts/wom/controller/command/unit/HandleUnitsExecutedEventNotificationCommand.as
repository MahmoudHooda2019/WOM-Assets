package wom.controller.command.unit
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.notification.UnitsExecutedEventNotification;
   
   public class HandleUnitsExecutedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleUnitsExecutedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:UnitsExecutedEventNotification = messageReceivedEvent.message as UnitsExecutedEventNotification;
         var _loc1_:Vector.<UnitTypeAmountDTO> = _loc2_.unitTypeAmountTuple;
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc3_ = 0;
            while(_loc3_ < _loc1_[_loc5_].amount)
            {
               _loc4_ = 0;
               while(_loc4_ < city.units.length)
               {
                  if(city.units[_loc4_].typeId == _loc1_[_loc5_].id && city.units[_loc4_].status == UnitStatusType.IN_BARRACKS)
                  {
                     coreManager.executeUnitInBarracks(city.units[_loc4_].instanceId);
                     city.units.splice(_loc4_,1);
                     dispatch(new ModelUpdateEvent("unitsInBarracksUpdated"));
                     break;
                  }
                  _loc4_++;
               }
               _loc3_++;
            }
            _loc5_++;
         }
      }
   }
}

