package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.alliance.MyAllianceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.window.MobileWindowEnumerationButton;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.alliance.GetAllianceInfoRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceGeneralInfoPanel;
   
   public class MobileAllianceGeneralInfoPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAllianceGeneralInfoPanel;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileAllianceGeneralInfoPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.editButton,"triggered",onEditClicked,Event);
         eventMap.mapStarlingListener(view.quitButton,"triggered",onQuitClicked,Event);
         addContextListener("allianceSummaryUpdated",onAllianceSummaryUpdated,ModelUpdateEvent);
         addContextListener("allianceInfoUpdated",onAllianceInfoUpdated,ModelUpdateEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         if(!view.fromBrowseTab && allianceInfo.myAllianceSummary)
         {
            view.updateWithAllianceInfo(allianceInfo.myAlliance,allianceInfo.myAllianceSummary.role);
            requestAllianceDetails();
         }
      }
      
      private function onEditClicked(param1:Event) : void
      {
         dispatch(new MyAllianceEvent("editAlliance"));
      }
      
      private function onQuitClicked(param1:Event) : void
      {
         var _loc2_:Vector.<MobileWindowEnumerationButton> = new Vector.<MobileWindowEnumerationButton>();
         var _loc3_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _loc3_.width = 182;
         var _temp_1:* = _loc3_;
         var _loc4_:String = "ui.windows.alliance.myalliance.confirm";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _loc2_.push(new MobileWindowEnumerationButton(new WindowEnumeration(36,{}),_loc3_));
         var _temp_6:* = §§findproperty(MobilePopUpWindowEvent);
         var _temp_5:* = "showSecondaryPopUpWindow";
         var _temp_4:* = §§findproperty(MobileClementineChangableActionPopUp);
         var _temp_3:* = 2;
         var _temp_2:* = "";
         var _loc5_:String = "ui.windows.alliance.myalliance.areyousureleave";
         dispatch(new MobilePopUpWindowEvent(_temp_5,new MobileClementineChangableActionPopUp(_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc5_),_loc2_)));
      }
      
      private function onAllianceInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(!view.fromBrowseTab && allianceInfo.myAllianceSummary)
         {
            view.updateWithAllianceInfo(allianceInfo.myAlliance,allianceInfo.myAllianceSummary.role);
            updateLeaderName();
         }
      }
      
      private function onAllianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         requestAllianceDetails();
      }
      
      private function requestAllianceDetails() : void
      {
         if(allianceInfo.myAllianceSummary)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetAllianceInfoRequest()));
         }
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateLeaderName();
      }
      
      private function updateLeaderName() : void
      {
         if(view.allianceDetail)
         {
            view.updateLeaderName(facebookAPIManager.getUserNameByProfile(view.allianceDetail.leader));
         }
      }
   }
}

