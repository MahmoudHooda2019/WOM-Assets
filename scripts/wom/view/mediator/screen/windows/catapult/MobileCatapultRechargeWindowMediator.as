package wom.view.mediator.screen.windows.catapult
{
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.catapult.MobileCatapultRechargeWindow;
   
   public class MobileCatapultRechargeWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileCatapultRechargeWindow;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileCatapultRechargeWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("buildingTypesUpdated",onBuildingsUpdated,ModelUpdateEvent);
      }
      
      private function onBuildingsUpdated(param1:ModelUpdateEvent) : void
      {
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 23)
            {
               view.updateWithCatapultLevel(_loc2_.level);
               break;
            }
         }
      }
   }
}

