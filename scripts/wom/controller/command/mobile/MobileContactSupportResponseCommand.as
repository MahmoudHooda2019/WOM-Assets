package wom.controller.command.mobile
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileContactSupportResponseEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   
   public class MobileContactSupportResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MobileContactSupportResponseEvent;
      
      public function MobileContactSupportResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(event.success)
         {
            var _temp_5:* = §§findproperty(MobilePopUpWindowEvent);
            var _temp_4:* = "showSecondaryPopUpWindow";
            var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
            var _temp_2:* = 1;
            var _temp_1:* = "";
            var _loc1_:String = "m.ui.windows.contactsupport.success";
            dispatch(new MobilePopUpWindowEvent(_temp_4,new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_))));
         }
         else
         {
            var _temp_8:* = §§findproperty(MobileUINotificationEvent);
            var _temp_7:* = "mobileUINotificationEventShow";
            var _loc2_:String = "m.ui.windows.contactsupport.fail";
            dispatch(new MobileUINotificationEvent(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
      }
   }
}

