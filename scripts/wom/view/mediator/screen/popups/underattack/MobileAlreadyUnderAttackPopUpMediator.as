package wom.view.mediator.screen.popups.underattack
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   
   public class MobileAlreadyUnderAttackPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileAlreadyUnderAttackPopUp;
      
      public function MobileAlreadyUnderAttackPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onReturnButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onReturnButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
   }
}

