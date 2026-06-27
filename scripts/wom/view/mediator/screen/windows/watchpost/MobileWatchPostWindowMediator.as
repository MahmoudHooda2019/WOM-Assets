package wom.view.mediator.screen.windows.watchpost
{
   import flash.utils.Dictionary;
   import wom.controller.event.ExecuteWatchPostUnitEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.DeployUnitsToWatchPostRequest;
   import wom.model.message.request.KillUnitsInWatchPost;
   import wom.view.mediator.screen.windows.transfer.MobileMercenaryTransferWindowMediator;
   import wom.view.screen.windows.watchpost.MobileWatchPostWindow;
   
   public class MobileWatchPostWindowMediator extends MobileMercenaryTransferWindowMediator
   {
      
      [Inject]
      public var view:MobileWatchPostWindow;
      
      public function MobileWatchPostWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         transferWindow.housingCapacity = domainInfo.getBuilding(37).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][view.buildingLevel - 1];
         super.onRegister();
         updateBunkerMercenaries();
         addContextListener("unitsInWatchPostUpdated",onInBunkerUnitsChange,ModelUpdateEvent);
         addContextListener("executeWatchPostUnit",onExecuteUnitInWatchPost,ExecuteWatchPostUnitEvent);
      }
      
      private function onInBunkerUnitsChange(param1:ModelUpdateEvent) : void
      {
         updateBunkerMercenaries();
         updateHousingMercenaries();
         transferWindow.activateTabByIndex(transferWindow.tabBar.selectedIndex);
      }
      
      override protected function transferUnits(param1:Vector.<UnitTypeAmountDTO>, param2:int) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new DeployUnitsToWatchPostRequest(view.instanceId,param1,param2)));
      }
      
      override protected function createEnumeration() : WindowEnumeration
      {
         return new WindowEnumeration(3,{"buildingInstanceId":view.instanceId});
      }
      
      private function updateBunkerMercenaries() : void
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc5_:int = 0;
         var _loc4_:Dictionary = new Dictionary();
         var _loc6_:Dictionary = new Dictionary();
         for each(var _loc1_ in city.units)
         {
            _loc2_ = domainInfo.getUnit(_loc1_.typeId);
            if(_loc1_.buildingId == view.instanceId)
            {
               if(!(_loc1_.typeId in _loc4_))
               {
                  _loc4_[_loc1_.typeId] = 0;
                  _loc6_[_loc1_.typeId] = _loc2_;
               }
               _loc4_[_loc1_.typeId]++;
            }
         }
         var _loc7_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for(var _loc3_ in _loc4_)
         {
            _loc7_.push(new UnitTypeAmountDTO(_loc3_,_loc4_[_loc3_]));
            _loc5_ += _loc4_[_loc3_] * domainInfo.getUnit(_loc3_).spacesPerLevel[(city.unitTypes[_loc3_] as UnitTypeInfo).currentLevel - 1];
         }
         transferWindow.addMercenariesToInBunker(_loc7_,_loc6_,_loc5_);
      }
      
      private function onExecuteUnitInWatchPost(param1:ExecuteWatchPostUnitEvent) : void
      {
         var _loc2_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         _loc2_.push(new UnitTypeAmountDTO(param1.unitTypeId,1));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new KillUnitsInWatchPost(view.instanceId,_loc2_)));
      }
      
      override protected function unitLevelFor(param1:int) : int
      {
         return (city.unitTypes[param1] as UnitTypeInfo).currentLevel;
      }
   }
}

