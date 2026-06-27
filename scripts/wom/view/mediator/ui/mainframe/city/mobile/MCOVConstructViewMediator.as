package wom.view.mediator.ui.mainframe.city.mobile
{
   import flash.geom.Point;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.request.BuyItemRequest;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   import wom.view.ui.mainframe.city.mobile.MCOVConstructView;
   
   public class MCOVConstructViewMediator extends MobileConstructableOptionsViewMediator
   {
      
      [Inject]
      public var constructView:MCOVConstructView;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MCOVConstructViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("tick",onGameTick);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         eventMap.mapStarlingListener(constructView.finishNowButton.button,"triggered",onFinishNowButtonClicked);
         eventMap.mapStarlingListener(constructView.cut30Button.button,"triggered",onCut30ButtonClicked);
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,constructView.finishNowButton.localToGlobal(new Point()),param1.additionalInfo));
      }
      
      protected function onGameTick(param1:GameTickEvent) : void
      {
         updateConstructionInfo();
      }
      
      protected function updateConstructionInfo() : void
      {
         var _loc1_:int = calculateInstancePrice();
         var _loc2_:String;
         constructView.finishNowButton.subLabel = _loc1_ == 0 ? (_loc2_ = "ui.windows.store.free",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : _loc1_ + "";
      }
      
      protected function onFinishNowButtonClicked(param1:Event) : void
      {
         var _loc2_:int = calculateInstancePrice();
         cancelSelection();
         if(_loc2_ > userInfo.numberOfGolds)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
         }
         else if(_loc2_ == 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,buildingInfo.instanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,buildingInfo.instanceId)));
         }
      }
      
      protected function onCut30ButtonClicked(param1:Event) : void
      {
         if(30 > userInfo.reconPoints)
         {
            cancelSelection();
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("recon")));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2004,buildingInfo.instanceId)));
         }
      }
      
      protected function calculateInstancePrice() : int
      {
         return 2147483647;
      }
   }
}

