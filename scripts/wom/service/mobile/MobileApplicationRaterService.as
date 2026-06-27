package wom.service.mobile
{
   import com.distriqt.extension.applicationrater.ApplicationRater;
   import com.distriqt.extension.applicationrater.events.ApplicationRaterEvent;
   import com.freshplanet.ane.AirDeviceId;
   import org.robotlegs.mvcs.Actor;
   import peak.config.DocumentConfiguration;
   import peak.i18n.PText;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   
   public class MobileApplicationRaterService extends Actor
   {
      
      public static const DEV_KEY:String = "284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==";
      
      public static const RATED_STATUS_TRUE:String = "true";
      
      public static const RATED_STATUS_FALSE:String = "false";
      
      private static var INITIALIZED:Boolean = false;
      
      public static var RATED:Boolean = true;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      public function MobileApplicationRaterService()
      {
         super();
      }
      
      public function init() : void
      {
         if(INITIALIZED)
         {
            return;
         }
         INITIALIZED = true;
         RATED = documentConfiguration.getParameter(AirDeviceId.getInstance().isOnAndroid ? "and_rated" : "ios_rated2") as Boolean;
         ApplicationRater.init("284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==");
         ApplicationRater.service.setApplicationId("air.wom.Client","Android");
         ApplicationRater.service.setApplicationId("778530732","iOS");
         ApplicationRater.service.addEventListener("applicationRater:selected:rate",onRateSelected);
         ApplicationRater.service.addEventListener("applicationRater:selected:decline",onDeclineSelected);
         setDialogTexts();
         ApplicationRater.service.autoPrompt = false;
         ApplicationRater.service.applicationLaunched();
      }
      
      public function setDialogTexts() : void
      {
         var _temp_1:* = ApplicationRater.service;
         var _loc1_:String = RATED ? "m.ui.applicationrater.rated_title" : "m.ui.applicationrater.unrated_title";
         _temp_1.setDialogTitle(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _temp_2:* = ApplicationRater.service;
         var _loc2_:String = RATED ? "m.ui.applicationrater.rated_message" : "m.ui.applicationrater.unrated_message";
         _temp_2.setDialogMessage(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         §§push(ApplicationRater.service);
         var _loc3_:String = RATED ? "m.ui.applicationrater.rated_ratebutton" : "m.ui.applicationrater.unrated_ratebutton";
         §§push(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _loc4_:String = RATED ? "m.ui.applicationrater.rated_neverbutton" : "m.ui.applicationrater.unrated_neverbutton";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = RATED ? "m.ui.applicationrater.rated_laterbutton" : "m.ui.applicationrater.unrated_laterbutton";
         §§pop().setLabels(§§pop(),_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc5_));
      }
      
      public function significantEventOccured() : void
      {
         var _loc2_:int = 0;
         var _loc1_:String = EncryptedLocalStoreUtil.getLocalData("Peak-Application-Rater",true);
         if(!_loc1_)
         {
            _loc2_ = EncryptedLocalStoreUtil.getSuccessfulAuth();
            if(_loc2_ == 2 || _loc2_ == 5 || _loc2_ == 10)
            {
               ApplicationRater.service.showRateDialog();
            }
         }
      }
      
      private function onRateSelected(param1:ApplicationRaterEvent) : void
      {
         EncryptedLocalStoreUtil.setLocalData("Peak-Application-Rater","true",true);
         dispatch(new MobileExternalInterfaceEvent("notifyAppRating"));
      }
      
      private function onDeclineSelected(param1:ApplicationRaterEvent) : void
      {
         EncryptedLocalStoreUtil.setLocalData("Peak-Application-Rater","false",true);
      }
   }
}

