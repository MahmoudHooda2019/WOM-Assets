package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.gold.MonetizationType;
   import wom.model.game.gold.PaymentInfo;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   import wom.view.ui.mainframe.city.MobileCurrencyPanel;
   import wom.view.ui.tooltip.MobileInformativeTooltipView;
   
   public class MobileCurrencyPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCurrencyPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var paymentInfo:PaymentInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function MobileCurrencyPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("helpInfoUpdated",onHelpInfoUpdated,ModelUpdateEvent);
         addContextListener("goldAmountUpdated",onGoldAmountUpdated,ModelUpdateEvent);
         addContextListener("reconPoinrsUpdated",onReconPointsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.rpIcon,"touch",onTab,TouchEvent);
         eventMap.mapStarlingListener(view.addGoldButton,"triggered",onAddGoldButtonClicked,Event);
         reconPointsUpdated();
         goldAmountUpdated();
      }
      
      private function onAddGoldButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileGetGoldWindow(paymentInfo.goldProducts,MonetizationType.ADD_GOLD,paymentInfo.getMobileGoldProductsLength() > 0,paymentInfo.topSellerGoldProductId,null,null)));
      }
      
      private function onHelpInfoUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateWithHelpCount(visitInfo.landlord && visitInfo.landlord.gameId in userInfo.helpCountDictionary ? userInfo.helpCountDictionary[visitInfo.landlord.gameId] : 0);
      }
      
      private function onReconPointsUpdated(param1:ModelUpdateEvent) : void
      {
         reconPointsUpdated();
      }
      
      private function reconPointsUpdated() : void
      {
         view.updateWithRpAmount(userInfo.reconPoints);
      }
      
      private function goldAmountUpdated() : void
      {
         view.updateWithGoldAmount(userInfo.numberOfGolds,userInfo.mandatoryTutorialCompleted);
      }
      
      private function onGoldAmountUpdated(param1:ModelUpdateEvent) : void
      {
         goldAmountUpdated();
      }
      
      private function onTab(param1:Event) : void
      {
         var _loc3_:MobileInformativeTooltipView = null;
         var _loc2_:Touch = (param1 as TouchEvent).getTouch(view,"ended");
         if(_loc2_)
         {
            _loc3_ = new MobileInformativeTooltipView("rp",323,127);
            dispatch(new MobileTooltipEvent("mobileTooltipEventShow",_loc3_,view.parent.x + view.x - 280,view.parent.y + view.y + view.height - 2));
         }
      }
   }
}

