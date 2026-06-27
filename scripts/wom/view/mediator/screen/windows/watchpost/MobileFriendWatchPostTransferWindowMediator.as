package wom.view.mediator.screen.windows.watchpost
{
   import flash.utils.Dictionary;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.UnitsOfMemberOrFriendReceivedEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.TransferUnitsToFriendWatchPostRequest;
   import wom.view.mediator.screen.windows.transfer.MobileMercenaryTransferWindowMediator;
   import wom.view.screen.windows.watchpost.MobileFriendWatchPostTransferWindow;
   
   public class MobileFriendWatchPostTransferWindowMediator extends MobileMercenaryTransferWindowMediator
   {
      
      [Inject]
      public var view:MobileFriendWatchPostTransferWindow;
      
      public function MobileFriendWatchPostTransferWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("unitsOfFriendWatchPostReceived",onUnitsReceived,UnitsOfMemberOrFriendReceivedEvent);
      }
      
      private function onUnitsReceived(param1:UnitsOfMemberOrFriendReceivedEvent) : void
      {
         var _loc2_:UnitTypeDIO = null;
         if(param1.buildingLevel == 0)
         {
            closeWindow();
            return;
         }
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc4_ in param1.units)
         {
            _loc2_ = domainInfo.getUnit(_loc4_.id);
            _loc3_[_loc4_.id] = _loc2_;
         }
         var _loc5_:int = int(domainInfo.getBuilding(38).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id][param1.buildingLevel - 1]);
         view.unitLevels = param1.unitLevels;
         transferWindow.addMercenariesToInBunker(param1.units,_loc3_,_loc5_ - param1.capacity);
         view.housingCapacity = _loc5_;
         updateHousingMercenaries();
         transferWindow.activateTabByIndex(transferWindow.tabBar.selectedIndex);
      }
      
      override protected function transferUnits(param1:Vector.<UnitTypeAmountDTO>, param2:int) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new TransferUnitsToFriendWatchPostRequest(view.memberId,param1,param2)));
         closeWindow();
      }
      
      override protected function createEnumeration() : WindowEnumeration
      {
         return new WindowEnumeration(0,{"womview":this});
      }
      
      override protected function unitLevelFor(param1:int) : int
      {
         return view.unitLevels && param1 in view.unitLevels ? view.unitLevels[param1] : 1;
      }
   }
}

