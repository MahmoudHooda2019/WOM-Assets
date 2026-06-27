package wom.controller.event.mobile
{
   import flash.events.Event;
   import wom.model.mobile.MobileAlertDialog;
   
   public class MobileAlertDialogsEvent extends Event
   {
      
      public static const SETUP:String = "setupMobileAlertDialogs";
      
      public static const SHOW_MOBILE_ALERT_DIALOG:String = "showMobileAlertDialog";
      
      public static const DISMISS_MOBILE_ALERT_DIALOG:String = "dismissDialog";
      
      private var _mobileAlertDialogType:MobileAlertDialog;
      
      private var _dialogId:int;
      
      private var _dialogType:int;
      
      public function MobileAlertDialogsEvent(param1:String, param2:MobileAlertDialog = null, param3:int = -1, param4:int = -1)
      {
         super(param1);
         _mobileAlertDialogType = param2;
         _dialogId = param3;
         _dialogType = param4;
      }
      
      override public function clone() : Event
      {
         return new MobileAlertDialogsEvent(type,mobileAlertDialogType);
      }
      
      public function get mobileAlertDialogType() : MobileAlertDialog
      {
         return _mobileAlertDialogType;
      }
      
      public function get dialogId() : int
      {
         return _dialogId;
      }
      
      public function get dialogType() : int
      {
         return _dialogType;
      }
   }
}

