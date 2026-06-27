package wom.view.mediator.ui
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.model.component.CoreManager;
   import wom.view.ui.MobileCanvasOptionsPanel;
   
   public class MobileCanvasOptionsPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCanvasOptionsPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileCanvasOptionsPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.okButton,"triggered",onOkButtonClicked);
         eventMap.mapStarlingListener(view.cancelButton,"triggered",onCancelButtonClicked);
      }
      
      private function onOkButtonClicked(param1:Event) : void
      {
         coreManager.mobileConfirmCanvasOperation();
      }
      
      private function onCancelButtonClicked(param1:Event) : void
      {
         coreManager.mobileCancelCanvasOperation();
         dispatch(new CombatEventItemsEvent("itemDeployIsCancelled",-1));
      }
   }
}

