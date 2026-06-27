package wom.view.mediator.screen.windows.transfer
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPList;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ExecuteWatchPostUnitEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferViewRenderer;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferWindow;
   
   public class MobileMercenaryTransferWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var transferWindow:MobileMercenaryTransferWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      private var pressDownCount:int;
      
      private var mouseDownForPlusButton:Boolean = false;
      
      private var lastTouch:Touch;
      
      private var mouseDownForMinusButton:Boolean = false;
      
      private var lastEventHandledTime:Number;
      
      public function MobileMercenaryTransferWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(transferWindow.tabBar,"change",onTabChanged,Event);
         transferWindow.activateTabByIndex(transferWindow.tabToBeActivated);
         addViewListener("enterFrame",onEnterFrame,Event);
         eventMap.mapStarlingListener(transferWindow.fromHousingList,"rendererAdd",onFromRendererAdded,Event);
         eventMap.mapStarlingListener(transferWindow.fromHousingList,"rendererRemove",onFromRendererRemoved,Event);
         eventMap.mapStarlingListener(transferWindow.fromStoreList,"rendererAdd",onFromRendererAdded,Event);
         eventMap.mapStarlingListener(transferWindow.fromStoreList,"rendererRemove",onFromRendererRemoved,Event);
         eventMap.mapStarlingListener(transferWindow.inBunkerList,"rendererAdd",onToRendererAdded,Event);
         eventMap.mapStarlingListener(transferWindow.inBunkerList,"rendererRemove",onToRendererRemoved,Event);
         addContextListener("unitsInBarracksUpdated",onInBarracksUnitsChange,ModelUpdateEvent);
         addContextListener("resourceTypeKnown",onNotEnoughResource,NotEnoughResourceEvent);
         eventMap.mapStarlingListener(transferWindow.transferWithGoldButton,"triggered",onTransferWithGoldButtonClicked,Event);
         eventMap.mapStarlingListener(transferWindow.transferWithResourceButton,"triggered",onTransferWithResourceButtonClicked,Event);
         updateHousingMercenaries();
         updateStoreMercenaries();
      }
      
      private function onFromRendererAdded(param1:Event, param2:MobileMercenaryTransferViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2.minusButton,"triggered",onMinusButtonClicked,Event);
         eventMap.mapStarlingListener(param2.plusButton,"triggered",onPlusButtonClicked,Event);
         eventMap.mapStarlingListener(param2.minusButton,"touch",onMinusTouch,TouchEvent);
         eventMap.mapStarlingListener(param2.plusButton,"touch",onPlusTouch,TouchEvent);
      }
      
      private function onFromRendererRemoved(param1:Event, param2:MobileMercenaryTransferViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.minusButton,"triggered",onMinusButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.plusButton,"triggered",onPlusButtonClicked,Event);
         eventMap.unmapStarlingListener(param2.minusButton,"touch",onMinusTouch,TouchEvent);
         eventMap.unmapStarlingListener(param2.plusButton,"touch",onPlusTouch,TouchEvent);
      }
      
      private function onToRendererAdded(param1:Event, param2:MobileMercenaryTransferViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2.executeButton,"triggered",onExecuteButtonClicked,Event);
      }
      
      private function onToRendererRemoved(param1:Event, param2:MobileMercenaryTransferViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.executeButton,"triggered",onExecuteButtonClicked,Event);
      }
      
      public function onPlusTouch(param1:TouchEvent) : void
      {
         var _loc4_:MobileMercenaryTransferViewRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         var _loc2_:Touch = param1.getTouch(_loc4_.plusButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForPlusButton = true;
            lastTouch = _loc2_;
            lastEventHandledTime = getTimer() + 250;
         }
         var _loc3_:Touch = param1.getTouch(_loc4_.plusButton,"ended");
         if(_loc3_)
         {
            mouseDownForPlusButton = false;
            lastTouch = null;
         }
      }
      
      public function onMinusTouch(param1:TouchEvent) : void
      {
         var _loc4_:MobileMercenaryTransferViewRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         var _loc2_:Touch = param1.getTouch(_loc4_.minusButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForMinusButton = true;
            lastTouch = _loc2_;
            lastEventHandledTime = getTimer() + 250;
         }
         var _loc3_:Touch = param1.getTouch(_loc4_.minusButton,"ended");
         if(_loc3_)
         {
            mouseDownForMinusButton = false;
            lastTouch = null;
         }
      }
      
      private function onNotEnoughResource(param1:NotEnoughResourceEvent) : void
      {
         if(param1.resourceType != ResourceType.MIGHT)
         {
            return;
         }
         var _loc2_:Vector.<WindowEnumeration> = new Vector.<WindowEnumeration>();
         _loc2_.push(createEnumeration());
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(),0,null,null,false,userInfo.delayPopups));
         closeWindow();
      }
      
      private function onInBarracksUnitsChange(param1:ModelUpdateEvent) : void
      {
         updateHousingMercenaries();
      }
      
      private function onTransferWithGoldButtonClicked(param1:Event) : void
      {
         var _loc2_:Vector.<UnitTypeAmountDTO> = getSelectedUnitAmounts(transferWindow.fromStoreList);
         if(transferWindow.transferGoldAmount > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         if(_loc2_.length > 0)
         {
            soundPlayer.playSfxById("PurchaseSuccessful");
            transferUnits(_loc2_,2);
         }
      }
      
      private function onTransferWithResourceButtonClicked(param1:Event) : void
      {
         var _loc2_:Vector.<UnitTypeAmountDTO> = getSelectedUnitAmounts(transferWindow.fromHousingList);
         if(transferWindow.type == 1 && transferWindow.transferResourceAmount > city.resourceAmounts[ResourceType.MIGHT.id])
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughResourcePopUp(-1,ResourceType.MIGHT)));
            return;
         }
         if(_loc2_.length > 0)
         {
            transferUnits(_loc2_,1);
         }
      }
      
      private function getSelectedUnitAmounts(param1:MPList) : Vector.<UnitTypeAmountDTO>
      {
         var _loc5_:int = 0;
         var _loc3_:Object = null;
         var _loc4_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         var _loc2_:ListCollection = param1.dataProvider;
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc3_ = _loc2_.getItemAt(_loc5_);
            if(_loc3_.selectedAmount > 0)
            {
               _loc4_.push(new UnitTypeAmountDTO(_loc3_.unitTypeDIO.id,_loc3_.selectedAmount));
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function onAmountChange(param1:MobileMercenaryTransferViewRenderer, param2:Boolean) : void
      {
         var _loc4_:MPList = null;
         var _loc3_:UnitTypeDIO = param1.unitTypeDIO;
         var _loc5_:int = unitLevelFor(_loc3_.id) - 1;
         if(!param2)
         {
            transferWindow.housingToBeAdd -= _loc3_.spacesPerLevel[_loc5_];
            if(param1.mode == 0)
            {
               transferWindow.transferResourceAmount -= _loc3_.hiringCostsPerLevel[_loc5_][0].resourceAmount / 2 << 0;
               _loc4_ = transferWindow.fromHousingList;
            }
            else
            {
               transferWindow.transferGoldAmount -= goldAmountFor(_loc3_,_loc5_);
               _loc4_ = transferWindow.fromStoreList;
            }
            transferWindow.decrementSelectedAmount(param1.unitTypeDIO.id,_loc4_);
         }
         else if(transferWindow.currentHousing + transferWindow.housingToBeAdd + _loc3_.spacesPerLevel[_loc5_] <= transferWindow.housingCapacity && (param1.mode != 0 || param1.amount >= param1.selectedAmount + 1))
         {
            transferWindow.housingToBeAdd += _loc3_.spacesPerLevel[_loc5_];
            if(param1.mode == 0)
            {
               transferWindow.transferResourceAmount += _loc3_.hiringCostsPerLevel[_loc5_][0].resourceAmount / 2 << 0;
               _loc4_ = transferWindow.fromHousingList;
            }
            else
            {
               if(transferWindow.transferGoldAmount > userInfo.numberOfGolds)
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
                  return;
               }
               transferWindow.transferGoldAmount += goldAmountFor(_loc3_,_loc5_);
               _loc4_ = transferWindow.fromStoreList;
            }
            transferWindow.incrementSelectedAmount(param1.unitTypeDIO.id,_loc4_);
         }
      }
      
      private function minusButtonClicked(param1:MPButton) : void
      {
         var _loc2_:MobileMercenaryTransferViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            if(_loc2_.selectedAmount > 0)
            {
               onAmountChange(_loc2_,false);
            }
         }
      }
      
      private function onMinusButtonClicked(param1:Event) : void
      {
         minusButtonClicked(param1.target as MPButton);
      }
      
      private function plusButtonClicked(param1:MPButton) : void
      {
         var _loc2_:MobileMercenaryTransferViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            onAmountChange(_loc2_,true);
         }
      }
      
      private function onPlusButtonClicked(param1:Event) : void
      {
         plusButtonClicked(param1.target as MPButton);
      }
      
      private function onExecuteButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileMercenaryTransferViewRenderer = checkRendererValidityForClickedButton(param1.target as MPButton);
         if(_loc2_)
         {
            dispatch(new ExecuteWatchPostUnitEvent("executeWatchPostUnit",_loc2_.unitTypeDIO.id));
         }
      }
      
      private function goldAmountFor(param1:UnitTypeDIO, param2:int) : int
      {
         return transferWindow.type == 2 ? param1.barracksGoldPricesPerLevel[param2] : param1.watchpostGoldPricesPerLevel[param2];
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         var _loc2_:Boolean = transferWindow.activateTabByIndex(transferWindow.tabBar.selectedIndex);
         if(_loc2_)
         {
            updateStoreMercenaries();
         }
         transferWindow.clearAllSelectedAmountsOfList(transferWindow.fromHousingList);
         transferWindow.clearAllSelectedAmountsOfList(transferWindow.fromStoreList);
      }
      
      protected function updateHousingMercenaries() : void
      {
         var _loc2_:UnitTypeDIO = null;
         var _loc4_:Dictionary = new Dictionary();
         var _loc5_:Dictionary = new Dictionary();
         for each(var _loc1_ in city.units)
         {
            _loc2_ = domainInfo.getUnit(_loc1_.typeId);
            if(_loc1_.status == UnitStatusType.IN_BARRACKS && (!_loc2_.flying || transferWindow.type == 2))
            {
               if(!(_loc1_.typeId in _loc4_))
               {
                  _loc4_[_loc1_.typeId] = 0;
                  _loc5_[_loc1_.typeId] = _loc2_;
               }
               _loc4_[_loc1_.typeId]++;
            }
         }
         var _loc6_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for(var _loc3_ in _loc4_)
         {
            _loc6_.push(new UnitTypeAmountDTO(_loc3_,_loc4_[_loc3_]));
         }
         transferWindow.addMercenariesToFromHousing(_loc6_,_loc5_);
      }
      
      private function updateStoreMercenaries() : void
      {
         var _loc1_:Vector.<UnitTypeDIO> = new Vector.<UnitTypeDIO>();
         for each(var _loc2_ in domainInfo.getUnits())
         {
            if(!_loc2_.flying || transferWindow.type == 2)
            {
               _loc1_.push(_loc2_);
            }
         }
         transferWindow.addMercenariesToFromStore(_loc1_);
      }
      
      private function checkRendererValidityForClickedButton(param1:MPButton) : MobileMercenaryTransferViewRenderer
      {
         var _loc2_:MobileMercenaryTransferViewRenderer = null;
         if(param1 && param1.parent && param1.parent is MobileMercenaryTransferViewRenderer)
         {
            _loc2_ = param1.parent as MobileMercenaryTransferViewRenderer;
            if(_loc2_.transferData)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function transferUnits(param1:Vector.<UnitTypeAmountDTO>, param2:int) : void
      {
      }
      
      protected function createEnumeration() : WindowEnumeration
      {
         return null;
      }
      
      protected function unitLevelFor(param1:int) : int
      {
         return -1;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(lastTouch && mouseDownForPlusButton)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               plusButtonClicked(lastTouch.target as MPButton);
            }
         }
         if(lastTouch && mouseDownForMinusButton)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               minusButtonClicked(lastTouch.target as MPButton);
            }
         }
         transferWindow.transferWithResourceButton.isEnabled = transferWindow.getTotalAmountInList(transferWindow.fromHousingList) > 0;
         transferWindow.transferWithGoldButton.isEnabled = transferWindow.getTotalAmountInList(transferWindow.fromStoreList) > 0;
      }
   }
}

