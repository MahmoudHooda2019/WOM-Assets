package wom.view.screen.popups
{
   import starling.events.Event;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   
   public class MobileDidYouKnowPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileDidYouKnowPopUp;
      
      public function MobileDidYouKnowPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onAwesomeButtonClicked,Event);
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
      
      private function onAwesomeButtonClicked(param1:Event) : void
      {
         closeWindow();
      }
   }
}

