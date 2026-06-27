package wom.view.mediator.ui.mainframe.combat
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.view.ui.mainframe.combat.MobileBaseBottomMainframePanel;
   
   public class MobileBaseBottomMainframePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var baseBottomMainframePanel:MobileBaseBottomMainframePanel;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileBaseBottomMainframePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(baseBottomMainframePanel);
         mapPanelSpecificListeners();
         updateViews();
      }
      
      protected function mapPanelSpecificListeners() : void
      {
      }
      
      protected function updateViews() : void
      {
      }
   }
}

