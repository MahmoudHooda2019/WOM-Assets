package wom.service.mobile
{
   import com.distriqt.extension.dialog.Dialog;
   import com.distriqt.extension.dialog.events.DialogEvent;
   import com.freshplanet.ane.AirDeviceId;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import org.robotlegs.core.ICommandMap;
   import org.robotlegs.mvcs.Actor;
   import wom.controller.command.mobile.HandleRetrieveFlashVarsCommand;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.model.mobile.MobileAlertDialog;
   
   public class MobileAlertDialogsManager extends Actor
   {
      
      public static const DEV_KEY:String = "284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==";
      
      private static var INITIALIZED:Boolean = false;
      
      private static var INSTANCE:MobileAlertDialogsManager;
      
      [Inject]
      public var commandMap:ICommandMap;
      
      public function MobileAlertDialogsManager()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         if(INITIALIZED)
         {
            Dialog.service.removeEventListener("dialog:cancelled",INSTANCE.dialogCancelledCallback);
            Dialog.service.removeEventListener("dialog:closed",INSTANCE.dialogClosedCallback);
            eventDispatcher.removeEventListener("showMobileAlertDialog",showMobileAlertDialog);
            eventDispatcher.removeEventListener("dismissDialog",dismissMobileAlertDialog);
         }
         else
         {
            Dialog.init("284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==");
         }
         INITIALIZED = true;
         INSTANCE = this;
         Dialog.service.addEventListener("dialog:cancelled",INSTANCE.dialogCancelledCallback);
         Dialog.service.addEventListener("dialog:closed",INSTANCE.dialogClosedCallback);
         eventDispatcher.addEventListener("showMobileAlertDialog",showMobileAlertDialog);
         eventDispatcher.addEventListener("dismissDialog",dismissMobileAlertDialog);
      }
      
      public function dialogCancelledCallback(param1:DialogEvent) : void
      {
         trace("DIALOG","dialog cancelled with button",param1.data);
      }
      
      public function dialogClosedCallback(param1:DialogEvent) : void
      {
         trace("DIALOG","dialog closed with button",param1.data);
         if(param1.id == 0)
         {
            dispatch(new MobileApplicationEvent("restartMobileApplication"));
         }
         else if(param1.id == 2)
         {
            if(AirDeviceId.getInstance().isOnAndroid)
            {
               navigateToURL(new URLRequest("market://details?id=air.wom.Client"));
            }
            else if(AirDeviceId.getInstance().isOnIOS)
            {
               navigateToURL(new URLRequest("http://itunes.apple.com/us/app/war-of-mercenaries/id778530732?ls=1&mt=8"));
            }
         }
         else if(param1.id == 4)
         {
            commandMap.execute(HandleRetrieveFlashVarsCommand);
         }
      }
      
      public function showMobileAlertDialog(param1:MobileAlertDialogsEvent) : void
      {
         if(!INITIALIZED)
         {
            return;
         }
         var _loc2_:MobileAlertDialog = param1.mobileAlertDialogType;
         trace("DIALOG ID ",_loc2_.id);
         switch(_loc2_.dialogType)
         {
            case 0:
               Dialog.service.showMultipleChoiceDialog(_loc2_.id,_loc2_.title,_loc2_.message,_loc2_.labels);
               break;
            case 1:
               Dialog.service.showAlertDialog(_loc2_.id,_loc2_.title,_loc2_.message,_loc2_.cancelLabel,_loc2_.labels);
               break;
            case 2:
               Dialog.service.showProgressDialog(_loc2_.id,_loc2_.title,_loc2_.message,"spinner",_loc2_.cancelable);
         }
      }
      
      private function dismissMobileAlertDialog(param1:MobileAlertDialogsEvent) : void
      {
         if(param1.dialogType == 2)
         {
            Dialog.service.dismissProgressDialog(param1.dialogId);
         }
         else
         {
            Dialog.service.dismissDialog(param1.dialogId);
         }
      }
   }
}

