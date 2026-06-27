package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.view.screen.popups.MobileSpecialOfferPopUp;
   import wom.view.ui.mainframe.city.MobileSpecialOfferPanel;
   
   public class MobileSpecialOfferPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileSpecialOfferPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileSpecialOfferPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.specialOfferButton,"triggered",onSpecialOfferButtonClicked,Event);
      }
      
      private function onSpecialOfferButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSpecialOfferPopUp()));
      }
   }
}

