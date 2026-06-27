package wom.view.mediator.screen.windows.report.battlereport
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportDetailView;
   
   public class MobileBattleReportDetailViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBattleReportDetailView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBattleReportDetailViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
      }
   }
}

