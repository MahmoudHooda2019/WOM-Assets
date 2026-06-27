package wom.service
{
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.Dictionary;
   import org.robotlegs.core.ICommandMap;
   import org.robotlegs.mvcs.Actor;
   import peak.serialization.json.PJSON;
   import peak.util.DateTimeUtil;
   import wom.controller.command.ConnectToGameServerCommand;
   import wom.controller.command.bootstrap.BootstrapFacebookCacheCommand;
   import wom.controller.command.mobile.MobileExternalInterfaceEventCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.WomScreenType;
   import wom.model.game.friend.ProfileIdPair;
   import wom.service.facebook.FacebookAPIManager;
   
   public class RetrieveDevelopersService extends Actor
   {
      
      private static const API_URL:String = MobileExternalInterfaceEventCommand.END_POINT + "api";
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var commandMap:ICommandMap;
      
      private var urlLoader:URLLoader;
      
      public function RetrieveDevelopersService()
      {
         super();
         urlLoader = new URLLoader();
      }
      
      public function loadDevelopers() : void
      {
         var _loc1_:URLRequest = new URLRequest(API_URL);
         _loc1_.method = "POST";
         var _loc2_:URLVariables = new URLVariables();
         _loc2_.action = "getMobileUsers";
         _loc1_.data = _loc2_;
         urlLoader.addEventListener("ioError",handleError);
         urlLoader.addEventListener("securityError",handleError);
         urlLoader.addEventListener("complete",handleLoadDevelopersComplete);
         urlLoader.load(_loc1_);
      }
      
      public function loadDeveloperDetail(param1:String) : void
      {
         var _loc2_:URLRequest = new URLRequest(API_URL);
         _loc2_.method = "POST";
         var _loc3_:URLVariables = new URLVariables();
         _loc3_.action = "getMobileUser";
         _loc3_.pid = param1;
         _loc2_.data = _loc3_;
         urlLoader.addEventListener("ioError",handleError);
         urlLoader.addEventListener("securityError",handleError);
         urlLoader.addEventListener("complete",handleLoadDeveloperDetailComplete);
         urlLoader.load(_loc2_);
      }
      
      private function handleError(param1:Event) : void
      {
         removeLoaderListeners();
      }
      
      private function handleLoadDevelopersComplete(param1:Event) : void
      {
         removeLoaderListeners();
         var _loc2_:Object = PJSON.decode((param1.target as URLLoader).data);
         var _loc3_:Vector.<String> = new Vector.<String>();
         var _loc6_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         for each(var _loc5_ in _loc2_)
         {
            _loc3_.push(_loc5_);
            _loc6_.push(new ProfileIdPair(_loc5_,null));
         }
         var _loc4_:Dictionary = new Dictionary();
         _loc4_["users"] = _loc3_;
         dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc6_));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.MANUEL_AUTHENTICATION,_loc4_));
      }
      
      private function handleLoadDeveloperDetailComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         removeLoaderListeners();
         if(!documentConfiguration.hasParameter("force_local_config") || !documentConfiguration.getParameter("force_local_config"))
         {
            _loc2_ = PJSON.decode((param1.target as URLLoader).data);
            for(var _loc3_ in _loc2_)
            {
               documentConfiguration.setParameter(_loc3_,_loc2_[_loc3_]);
            }
            documentConfiguration.setParameter("loginTime",DateTimeUtil.getUTCFormattedDateAndTimeDescendingOrderFromDate(new Date()));
            documentConfiguration.setParameter("serverUrl",_loc2_.ip);
            documentConfiguration.setParameter("serverPort",_loc2_.port);
            documentConfiguration.setParameter("user",_loc2_.gameid);
            documentConfiguration.extractFriends();
            documentConfiguration.extractSettings();
            documentConfiguration.extractOptionalParameters();
            if(_loc2_.axess)
            {
               documentConfiguration.axess = _loc2_.axess;
            }
         }
         documentConfiguration.setParameter("manualAuthentication",true);
         commandMap.execute(ConnectToGameServerCommand);
         commandMap.execute(BootstrapFacebookCacheCommand);
      }
      
      private function removeLoaderListeners() : void
      {
         urlLoader.removeEventListener("ioError",handleError);
         urlLoader.removeEventListener("securityError",handleError);
         urlLoader.removeEventListener("complete",handleLoadDevelopersComplete);
         urlLoader.removeEventListener("complete",handleLoadDeveloperDetailComplete);
      }
   }
}

