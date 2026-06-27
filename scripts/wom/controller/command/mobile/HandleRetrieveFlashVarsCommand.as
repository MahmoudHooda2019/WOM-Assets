package wom.controller.command.mobile
{
   import com.freshplanet.ane.AirDeviceId;
   import flash.desktop.NativeApplication;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import peak.i18n.lang.Language;
   import peak.i18n.lang.Languages;
   import peak.serialization.json.PJSON;
   import peak.util.passParameters;
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileAlertDialogsEvent;
   import wom.controller.event.mobile.MobileApplicationEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.mobile.MobileAlertDialog;
   import wom.service.mobile.EncryptedLocalStoreUtil;
   import wom.service.mobile.MobileNetworkInfoService;
   
   public class HandleRetrieveFlashVarsCommand extends PCommand
   {
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var mobileNetworkInfoService:MobileNetworkInfoService;
      
      public function HandleRetrieveFlashVarsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(!mobileNetworkInfoService.isNetworkConnected())
         {
            showConnectionPopup();
         }
         else
         {
            getI18n();
         }
      }
      
      private function getI18n() : void
      {
         var _loc1_:XML = null;
         var _loc4_:Namespace = null;
         var _loc7_:String = EncryptedLocalStoreUtil.getLocalData("Peak-Language");
         var _loc6_:Language = Languages.determineLanguage(_loc7_ ? _loc7_ : Capabilities.language);
         var _loc9_:URLVariables = new URLVariables();
         _loc9_["id"] = _loc6_.webApiId;
         var _loc8_:String = "0.0.0";
         var _loc3_:int = AirDeviceId.getInstance().isOnIOS ? 1 : 2;
         try
         {
            _loc1_ = NativeApplication.nativeApplication.applicationDescriptor;
            _loc4_ = _loc1_.namespace();
            _loc8_ = _loc1_._loc4_::versionLabel;
         }
         catch(e:Error)
         {
         }
         _loc9_["version"] = _loc8_;
         _loc9_["platform"] = _loc3_;
         if(EncryptedLocalStoreUtil.getLocalData("Peak-UDID_2"))
         {
            _loc9_["mobile_udid"] = EncryptedLocalStoreUtil.getLocalData("Peak-UDID_2");
         }
         var _loc5_:URLRequest = new URLRequest(MobileExternalInterfaceEventCommand.MOBILE_END_POINT + "language/get");
         _loc5_.method = "POST";
         _loc5_.data = _loc9_;
         var _loc2_:URLLoader = new URLLoader(_loc5_);
         _loc2_.addEventListener("complete",passParameters(onComplete,_loc6_));
         _loc2_.addEventListener("ioError",onIOError);
      }
      
      private function onComplete(param1:Event, param2:Language) : void
      {
         var _loc3_:Object = PJSON.decode(param1.target.data);
         if(_loc3_.success == true)
         {
            documentConfiguration.setParameter("lang",param2.id);
            documentConfiguration.setParameter("lang_definitions",_loc3_.data);
            dispatch(new MobileApplicationEvent("flashVarsCompleted"));
         }
         else if(_loc3_.data.errorCode == 18)
         {
            trace("UPDATE REQUIRED");
            dispatch(new MobileAlertDialogsEvent("showMobileAlertDialog",new MobileAlertDialog(1,2,"Update required","It seems that you have an older version of WOM. Please update with the latest version","Download")));
         }
         else if(_loc3_.data.errorCode == 20)
         {
            trace("UPDATE REQUIRED");
            dispatch(new MobileAlertDialogsEvent("showMobileAlertDialog",new MobileAlertDialog(1,2,"Update required","It seems that you have an older version of WOM. Please update and get 50 free gold!","Download")));
         }
         else
         {
            trace("LANGUAGE NOT FETCHED : " + _loc3_.data.errorCode);
            showConnectionPopup();
         }
      }
      
      private function onIOError(param1:IOErrorEvent) : void
      {
      }
      
      private function showConnectionPopup() : void
      {
         dispatch(new MobileAlertDialogsEvent("showMobileAlertDialog",new MobileAlertDialog(1,4,"No Internet Connection!","Your device is not connected to the internet!","Retry!")));
      }
   }
}

