package wom.view.mediator.screen.windows.general
{
   import flash.utils.setTimeout;
   import net.peakgames.ane.DeviceInfo.AirDeviceInfo;
   import starling.events.Event;
   import wom.Environment;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.windows.general.MobileContactSupportWindow;
   
   public class MobileContactSupportWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileContactSupportWindow;
      
      private var keyboardOpen:Boolean = false;
      
      public function MobileContactSupportWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         eventMap.mapStarlingListener(Environment.starling.stage,"softKeyboardActivate",onKeyboardOpen);
         eventMap.mapStarlingListener(Environment.starling.stage,"softKeyboardDeactivate",onKeyboardClose);
         super.onRegister();
         eventMap.mapStarlingListener(view.submitButton,"triggered",onSubmitButtonClicked,Event);
      }
      
      private function onKeyboardClose(param1:Event) : void
      {
         keyboardOpen = false;
         setTimeout(switchKeyboardState,50);
      }
      
      private function onKeyboardOpen(param1:Event) : void
      {
         keyboardOpen = true;
         setTimeout(switchKeyboardState,50);
      }
      
      private function switchKeyboardState() : void
      {
         view.softKeyboardStateChanged(true);
      }
      
      private function onSubmitButtonClicked() : void
      {
         var _loc1_:String = null;
         if(view.isReportValid())
         {
            _loc1_ = AirDeviceInfo.getInstance().deviceInfoJson;
            dispatch(new MobileExternalInterfaceEvent("contactSupport",{
               "category":view.chosenCategory,
               "subject":view.subjectInput.text,
               "body":view.messageInput.text,
               "email":view.emailInput.text,
               "device":_loc1_
            }));
            closeWindow();
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(200)));
         }
      }
   }
}

