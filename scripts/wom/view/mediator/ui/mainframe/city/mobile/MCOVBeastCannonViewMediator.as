package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.UserInfo;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreUtil;
   import wom.model.message.request.RechargeBeastCannonRequest;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCannonView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipBeastCannonInfoView;
   
   public class MCOVBeastCannonViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var beastCannonView:MCOVBeastCannonView;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MCOVBeastCannonViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(beastCannonView.rechargeButton.button,"triggered",onRechargeButtonClicked);
         addContextListener("tick",onTick,GameTickEvent);
         checkCooldown();
      }
      
      private function onRechargeButtonClicked(param1:Event) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RechargeBeastCannonRequest()));
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         var _loc1_:int = buildingInfo.level > 0 ? buildingInfo.level - 1 : 0;
         beastCannonView.addInfoView(new MobileBuildingTooltipBeastCannonInfoView(buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][_loc1_],buildingTypeDIO.healthPointsPerLevel[_loc1_],buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.BEAST_CANNON_MAX_AMMUNITION.id]));
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         checkCooldown();
      }
      
      private function checkCooldown() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         if(city.beastCannonInfo.remainingTimeToRecharge > 0)
         {
            _loc2_ = city.beastCannonInfo.remainingTimeToRecharge / 1000;
            _loc1_ = _loc2_ / 60;
            _loc3_ = _loc1_ / 60;
            _loc2_ %= 60;
            _loc1_ %= 60;
            _loc3_ %= 24;
            if(_loc3_ > 0)
            {
               beastCannonView.rechargeButton.updateMainLabel((_loc3_ < 10 ? "0" : "") + _loc3_ + ":" + ((_loc1_ < 10 ? "0" : "") + _loc1_));
            }
            else
            {
               beastCannonView.rechargeButton.updateMainLabel((_loc1_ < 10 ? "0" : "") + _loc1_ + ":" + ((_loc2_ < 10 ? "0" : "") + _loc2_));
            }
            beastCannonView.rechargeButton.isEnabled = true;
            beastCannonView.rechargeButton.subLabel = "" + StoreUtil.beastCannonPrice(buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.BEAST_CANNON_MAX_AMMUNITION.id] - city.beastCannonInfo.ammoAmount);
         }
         else if(beastCannonView.rechargeButton.isEnabled)
         {
            var _temp_1:* = beastCannonView.rechargeButton;
            var _loc4_:String = "ui.windows.beastcannon.recharge";
            _temp_1.updateMainLabel(peak.i18n.PText.INSTANCE.getText0(_loc4_));
            beastCannonView.rechargeButton.isEnabled = false;
            beastCannonView.rechargeButton.subLabel = "";
         }
      }
   }
}

