package wom.view.mediator.screen.popups
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.message.request.SetAvatarRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.MobileGuestNamingPopUp;
   
   public class MobileGuestNamingPopUpMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGuestNamingPopUp;
      
      public function MobileGuestNamingPopUpMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.actionButton,"triggered",onDoneButtonClicked,Event);
         eventMap.mapStarlingListener(view.nameInput,"focusIn",view.onKeyboardOpened,Event);
         eventMap.mapStarlingListener(view.nameInput,"focusOut",onCheckNameInput,Event);
         eventMap.mapStarlingListener(view.nameInput,"change",onCheckNameInput,Event);
      }
      
      private function onCheckNameInput(param1:Event) : void
      {
         var _loc3_:String = view.nameInput.text;
         var _loc2_:int = _loc3_.split(" ").length - 1;
         view.actionButton.isEnabled = !(_loc2_ == _loc3_.length || _loc2_ > 5) && _loc3_.length - _loc2_ >= 3;
      }
      
      private function onDoneButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new SetAvatarRequest(view.nameInput.text,view.avatarId)));
      }
   }
}

