package wom.view.mediator.screen.popups.passafriend
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.view.screen.popups.passafriend.MobileAvatarWithArrowView;
   
   public class MobileAvatarWithArrowViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAvatarWithArrowView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileAvatarWithArrowViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.picture,"change",onAssetChanged,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
   }
}

