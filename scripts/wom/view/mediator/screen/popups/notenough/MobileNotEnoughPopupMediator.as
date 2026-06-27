package wom.view.mediator.screen.popups.notenough
{
   import flash.external.ExternalInterface;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ui.GetGoldWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.gold.PaymentInfo;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   
   public class MobileNotEnoughPopupMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileNotEnoughPopup;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function MobileNotEnoughPopupMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onOkButtonClicked,Event);
         soundPlayer.playSfxById("InsufficientGold");
      }
      
      private function onOkButtonClicked(param1:Event) : void
      {
         closeWindowWithCheckPromo();
         if(view.type == "gold")
         {
            dispatch(new GetGoldWindowEvent("showGetGoldWindow",view.monetizationType,null,0));
         }
         closeWindow();
      }
      
      override protected function closeWindow() : void
      {
         closeWindowWithCheckPromo(true);
      }
      
      private function closeWindowWithCheckPromo(param1:Boolean = false) : void
      {
         if(param1 && documentConfiguration.promo && ExternalInterface.available)
         {
            documentConfiguration.promo = false;
            ExternalInterface.call("WOM.gold.showPromo");
         }
         dispatch(new MobilePopUpWindowEvent("closeSecondaryPopUpWindow",view));
      }
   }
}

