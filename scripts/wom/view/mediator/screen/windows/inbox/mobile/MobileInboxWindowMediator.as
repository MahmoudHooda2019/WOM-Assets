package wom.view.mediator.screen.windows.inbox.mobile
{
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.AttackLogEvent;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.util.MobileButtonTabbedWindowMediator;
   import wom.view.screen.windows.inbox.mobile.MobileInboxWindow;
   
   public class MobileInboxWindowMediator extends MobileButtonTabbedWindowMediator
   {
      
      [Inject]
      public var view:MobileInboxWindow;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      public function MobileInboxWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("getBattleReport",onGetBattleReport,AttackLogEvent);
      }
      
      override protected function closeWindow() : void
      {
         inboxInfo.inboxOpened = false;
         super.closeWindow();
      }
      
      override protected function onTabButtonClicked(param1:Event) : void
      {
         super.onTabButtonClicked(param1);
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_ == view.inboxTabButton)
         {
            inboxInfo.inboxOpened = true;
            dispatch(new MobileExternalInterfaceEvent("retrieveRequests",{}));
         }
      }
      
      private function onGetBattleReport(param1:AttackLogEvent) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(23,{"womview":view}));
         view.addWindowEnumeration(new WindowEnumeration(24,{
            "logId":param1.attackLog.id,
            "startInMillis":param1.attackLog.attackDurationInMillis,
            "afterAttack":false,
            "attacker":param1.attackLog.attacker,
            "defender":param1.attackLog.defender
         }));
         closeWindow();
      }
   }
}

