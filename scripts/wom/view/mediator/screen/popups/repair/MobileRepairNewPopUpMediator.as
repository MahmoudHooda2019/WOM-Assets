package wom.view.mediator.screen.popups.repair
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.AttackLogWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.StartRepairsRequest;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.repair.MobileRepairNewPopUp;
   
   public class MobileRepairNewPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRepairNewPopUp;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function MobileRepairNewPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         userInfo.repairPopupShown = true;
         eventMap.mapStarlingListener(view.actionButton,"triggered",onConfirmButtonClicked,Event);
      }
      
      private function onConfirmButtonClicked(param1:Event) : void
      {
         if(view.type == 1)
         {
            if(view.repairNowCost > userInfo.numberOfGolds)
            {
               view.addWindowEnumeration(new WindowEnumeration(0,{"womview":view}));
               view.addWindowEnumeration(new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD}));
            }
            else
            {
               soundPlayer.playSfxById("BuildingRepair");
               soundPlayer.playSfxById("PurchaseSuccessful");
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2008)));
            }
         }
         else
         {
            kontagentApi.trackUIEvent("attack_log","ClickedAttackLog");
            dispatch(new AttackLogWindowEvent("showAttackLogWindow"));
         }
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         if(view.type == 1)
         {
            soundPlayer.playSfxById("BuildingRepair");
            dispatch(new OutgoingMessageEvent("outgoingMessage",new StartRepairsRequest()));
         }
         super.closeWindow();
      }
   }
}

