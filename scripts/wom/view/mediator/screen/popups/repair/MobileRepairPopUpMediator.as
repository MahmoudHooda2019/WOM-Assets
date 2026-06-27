package wom.view.mediator.screen.popups.repair
{
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.BuyItemRequest;
   import wom.model.message.request.StartRepairsRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.repair.MobileRepairPopUp;
   
   public class MobileRepairPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRepairPopUp;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileRepairPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         userInfo.repairPopupShown = true;
         eventMap.mapStarlingListener(view.actionButton,"triggered",onRepairButtonClicked,Event);
         eventMap.mapStarlingListener(view.repairDamageWithGoldButton,"triggered",onRepairWithGoldButtonClicked,Event);
      }
      
      private function onRepairButtonClicked(param1:Event) : void
      {
         soundPlayer.playSfxById("BuildingRepair");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new StartRepairsRequest()));
         super.closeWindow();
      }
      
      private function onRepairWithGoldButtonClicked(param1:Event) : void
      {
         if(view.repairNowCost > userInfo.numberOfGolds)
         {
            view.addWindowEnumeration(new WindowEnumeration(25,{"repairNowCost":view.repairNowCost}));
            view.addWindowEnumeration(new WindowEnumeration(16,{"monetizationType":MonetizationType.NOT_ENOUGH_GOLD}));
         }
         else
         {
            soundPlayer.playSfxById("BuildingRepair");
            soundPlayer.playSfxById("PurchaseSuccessful");
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2008)));
         }
         super.closeWindow();
      }
      
      override protected function closeWindow() : void
      {
      }
   }
}

