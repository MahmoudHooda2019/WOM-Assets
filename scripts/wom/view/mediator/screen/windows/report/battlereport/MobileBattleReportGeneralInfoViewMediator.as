package wom.view.mediator.screen.windows.report.battlereport
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.ModelUpdateEvent;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportGeneralInfoView;
   
   public class MobileBattleReportGeneralInfoViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBattleReportGeneralInfoView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      public function MobileBattleReportGeneralInfoViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         view.lightView.rotate(10);
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         if(view.attackLog == null)
         {
            return;
         }
         view.updateNames(facebookApiManager.getUserNameByProfile(view.attackLog.attacker,!view.attackLog.attacker.isNpc),facebookApiManager.getUserNameByProfile(view.attackLog.defender,!view.attackLog.defender.isNpc));
      }
   }
}

