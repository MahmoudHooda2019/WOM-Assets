package wom.controller.command.beast
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.component.CoreManager;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.notification.UnitsKilledForBeastEventNotification;
   
   public class HandleUnitsKilledForBeastEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleUnitsKilledForBeastEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:UnitsKilledForBeastEventNotification = messageReceivedEvent.message as UnitsKilledForBeastEventNotification;
         var _loc2_:Vector.<UnitTypeAmountDTO> = _loc3_.unitTypeAmountTuple;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 29)
            {
               _loc6_ = _loc1_.instanceId;
               break;
            }
         }
         _loc7_ = 0;
         while(_loc7_ < _loc2_.length)
         {
            _loc4_ = 0;
            while(_loc4_ < _loc2_[_loc7_].amount)
            {
               _loc5_ = 0;
               while(_loc5_ < city.units.length)
               {
                  if(city.units[_loc5_].typeId == _loc2_[_loc7_].id && city.units[_loc5_].status == UnitStatusType.IN_BARRACKS)
                  {
                     coreManager.killUnitForBeast(city.units[_loc5_].instanceId,_loc6_);
                     city.units.splice(_loc5_,1);
                     dispatch(new ModelUpdateEvent("unitsInBarracksUpdated"));
                     break;
                  }
                  _loc5_++;
               }
               _loc4_++;
            }
            _loc7_++;
         }
      }
   }
}

