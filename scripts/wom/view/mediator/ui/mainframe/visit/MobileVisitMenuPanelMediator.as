package wom.view.mediator.ui.mainframe.visit
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.visit.EndVisitEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.UserInterfaceInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.store.StoreInfo;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.windows.social.MobileSocialMainWindow;
   import wom.view.ui.mainframe.visit.MobileVisitMenuPanel;
   
   public class MobileVisitMenuPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileVisitMenuPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var userInterfaceInfo:UserInterfaceInfo;
      
      [Inject]
      public var storeInfo:StoreInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function MobileVisitMenuPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.returnMenuButton,"triggered",onReturnButtonClicked,Event);
         eventMap.mapStarlingListener(view.friendsMenuButton,"triggered",onFriendsButtonClicked,Event);
      }
      
      private function onReturnButtonClicked(param1:Event) : void
      {
         dispatch(new EndVisitEvent("endVisit"));
      }
      
      private function onFriendsButtonClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileSocialMainWindow()));
      }
   }
}

