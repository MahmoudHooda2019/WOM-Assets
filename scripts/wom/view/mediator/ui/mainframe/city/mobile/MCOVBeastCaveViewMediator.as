package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.store.StoreUtil;
   import wom.view.screen.popups.MobileBeastConfirmationPopUp;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCaveView;
   
   public class MCOVBeastCaveViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var beastCaveView:MCOVBeastCaveView;
      
      public function MCOVBeastCaveViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         beastCaveView.beastExists = city.beast != null;
         super.onRegister();
         eventMap.mapStarlingListener(beastCaveView.healBeastButton.button,"triggered",onHealBeastButtonClicked);
         eventMap.mapStarlingListener(beastCaveView.instantEvolveButton.button,"triggered",onInstantEvolveButtonClicked);
         addContextListener("tick",onTick,GameTickEvent);
         onTick(null);
      }
      
      private function onHealBeastButtonClicked(param1:Event) : void
      {
         if(!city.beast)
         {
            return;
         }
         var _loc3_:BeastTypeDIO = domainInfo.getBeast(city.beast.typeId);
         var _loc2_:int = int(city.beast.bonusStage > 0 ? _loc3_.healthPointsPerStage[city.beast.bonusStage - 1] : _loc3_.healthPointsPerLevel[city.beast.level - 1]);
         if(city.beast.healthPoints == _loc2_)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc4_:String = "ui.popups.actionnotpossible.type.94";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_)));
            return;
         }
         if(userInfo.numberOfGolds < getHealCost())
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
            return;
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastConfirmationPopUp(0,getHealCost())));
      }
      
      private function onInstantEvolveButtonClicked(param1:Event) : void
      {
         if(!city.beast)
         {
            return;
         }
         var _loc3_:BeastTypeDIO = domainInfo.getBeast(city.beast.typeId);
         var _loc2_:int = int(city.beast.bonusStage > 0 ? _loc3_.healthPointsPerStage[city.beast.bonusStage - 1] : _loc3_.healthPointsPerLevel[city.beast.level - 1]);
         if(city.beast.healthPoints < _loc2_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(9)));
            return;
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastConfirmationPopUp(1,getEvolveCost())));
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(!city.beast)
         {
            return;
         }
         var _loc2_:int = getHealCost();
         if(_loc2_ <= 0)
         {
            if(beastCaveView.healBeastButton.isEnabled)
            {
               beastCaveView.toggleHealButton(_loc2_);
            }
         }
         else if(!beastCaveView.healBeastButton.isEnabled)
         {
            beastCaveView.toggleHealButton(_loc2_);
         }
         beastCaveView.healBeastButton.subLabel = "" + getHealCost();
         beastCaveView.instantEvolveButton.subLabel = "" + getEvolveCost();
      }
      
      private function getHealCost() : int
      {
         var _loc5_:BeastTypeDIO = null;
         var _loc4_:int = 0;
         var _loc2_:Number = NaN;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(city.beast)
         {
            _loc5_ = domainInfo.getBeast(city.beast.typeId);
            _loc4_ = int(city.beast.bonusStage > 0 ? _loc5_.healthPointsPerStage[city.beast.bonusStage - 1] : _loc5_.healthPointsPerLevel[city.beast.level - 1]);
            _loc2_ = _loc5_.healingCostTimesPerLevel[city.beast.level - 1];
            _loc1_ = Math.ceil((_loc4_ - city.beast.healthPoints) * _loc2_ / _loc4_);
            _loc3_ = StoreUtil.mercenaryTrainAndRecruitPrice(0,_loc1_);
         }
         return _loc3_;
      }
      
      private function getEvolveCost() : int
      {
         if(!city.beast)
         {
            return 0;
         }
         var _loc1_:BeastTypeDIO = domainInfo.getBeast(city.beast.typeId);
         var _loc2_:int = 0;
         if(city.beast.level >= _loc1_.maxLevels)
         {
            _loc2_ = int(city.beast.bonusStage >= _loc1_.maxBonusStages ? _loc1_.levelUpGoldCostsPerStage[_loc1_.maxBonusStages - 1] : _loc1_.levelUpGoldCostsPerStage[city.beast.bonusStage]);
         }
         else
         {
            _loc2_ = int(city.beast.level >= _loc1_.maxLevels ? _loc1_.levelUpGoldCostsPerLevel[_loc1_.maxLevels - 2] : _loc1_.levelUpGoldCostsPerLevel[city.beast.level - 1]);
         }
         return _loc2_;
      }
   }
}

