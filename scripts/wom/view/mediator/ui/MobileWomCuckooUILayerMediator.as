package wom.view.mediator.ui
{
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.mobile.MobileCanvasDeployHandEvent;
   import wom.controller.event.mobile.MobileCanvasOptionsPanelEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.UserInfo;
   import wom.view.ui.MobileWomCuckooUILayer;
   
   public class MobileWomCuckooUILayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileWomCuckooUILayer;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileWomCuckooUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("showBuilidingOptionsPanel",showBuildingOptionsPanel,MobileCanvasOptionsPanelEvent);
         addContextListener("closeBuilidingOptionsPanel",closeBuildingOptionsPanel,MobileCanvasOptionsPanelEvent);
         addContextListener("showCanvasDeployHand",showDeployHand,MobileCanvasDeployHandEvent);
         addContextListener("hideCanvasDeployHand",hideDeployHand,MobileCanvasDeployHandEvent);
         addViewListener("fakeDeployCircle",onFakeDeployCircle,Event);
      }
      
      private function showBuildingOptionsPanel(param1:MobileCanvasOptionsPanelEvent) : void
      {
         view.showBuildingOptionsPanel(param1.panel);
      }
      
      private function closeBuildingOptionsPanel(param1:MobileCanvasOptionsPanelEvent) : void
      {
         view.closeBuildingOptionsPanel();
      }
      
      private function showDeployHand(param1:MobileCanvasDeployHandEvent) : void
      {
         if(!userInfo.tutorialsInfo.additionalInfo.deployHandAnimationCompleted)
         {
            userInfo.tutorialsInfo.additionalInfo.deployHandAnimationCompleted = true;
            view.showDeployHand(param1.deployHand);
         }
      }
      
      private function hideDeployHand(param1:MobileCanvasDeployHandEvent) : void
      {
         view.hideDeployHand();
      }
      
      private function onFakeDeployCircle(param1:Event) : void
      {
         coreManager.createFakeMobileDeployCircle(param1.data.point);
      }
   }
}

