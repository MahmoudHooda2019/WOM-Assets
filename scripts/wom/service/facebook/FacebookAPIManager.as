package wom.service.facebook
{
   import flash.display.BitmapData;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import org.robotlegs.mvcs.Actor;
   import peak.i18n.PText;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.facebook.FacebookUserInfo;
   import wom.model.game.Profile;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.game.viral.UserNotification;
   
   public class FacebookAPIManager extends Actor
   {
      
      public static const GRAPH_SERVER_ADDR:String = "https://graph.facebook.com/v2.2/";
      
      private static const PAGE_SIZE:uint = 50;
      
      private var _platformIds:Dictionary;
      
      private var _screenshot:ByteArray;
      
      private var _screenshotBitmapData:BitmapData;
      
      public function FacebookAPIManager()
      {
         var _loc1_:FacebookUserInfo = null;
         super();
         _platformIds = new Dictionary();
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_1";
         var _temp_2:* = _loc1_;
         var _loc2_:String = "domain.npcs.1.name";
         _temp_2.fullName = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_2";
         var _temp_3:* = _loc1_;
         var _loc3_:String = "domain.npcs.2.name";
         _temp_3.fullName = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_3";
         var _temp_4:* = _loc1_;
         var _loc4_:String = "domain.npcs.3.name";
         _temp_4.fullName = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_4";
         var _temp_5:* = _loc1_;
         var _loc5_:String = "domain.npcs.4.name";
         _temp_5.fullName = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_5";
         var _temp_6:* = _loc1_;
         var _loc6_:String = "domain.npcs.5.name";
         _temp_6.fullName = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC-6";
         var _temp_7:* = _loc1_;
         var _loc7_:String = "domain.npcs.6.name";
         _temp_7.fullName = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _platformIds[_loc1_.uid] = _loc1_;
         _loc1_ = new FacebookUserInfo();
         _loc1_.uid = "NPC_D";
         var _temp_8:* = _loc1_;
         var _loc8_:String = "domain.npcs.d.name";
         _temp_8.fullName = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _platformIds[_loc1_.uid] = _loc1_;
      }
      
      public function getUserInfo(param1:String, param2:Vector.<ProfileIdPair>) : void
      {
         var _loc5_:* = 0;
         var _loc7_:* = undefined;
         var _loc3_:URLLoader = null;
         var _loc4_:Vector.<String> = new Vector.<String>();
         for each(var _loc8_ in param2)
         {
            if(_loc8_ != null && _loc8_.platformId != null && !(_loc8_.platformId in _platformIds) && !isNaN(Number(_loc8_.platformId)))
            {
               _loc4_.push(_loc8_.platformId);
            }
         }
         var _loc6_:uint = _loc4_.length / 50;
         if(_loc4_.length / 50 % 50 != 0)
         {
            _loc6_++;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc7_ = _loc4_.slice(_loc5_ * 50,_loc5_ * 50 + 50);
            try
            {
               _loc3_ = new URLLoader(getUserInfoBatchRequest(param1,_loc7_));
               _loc3_.addEventListener("complete",onURLLoaderComplete);
               _loc3_.addEventListener("ioError",onURLLoaderError);
            }
            catch(e:Error)
            {
            }
            _loc5_++;
         }
      }
      
      private function onURLLoaderError(param1:IOErrorEvent) : void
      {
      }
      
      private function onURLLoaderComplete(param1:Event) : void
      {
         var _loc3_:Object = null;
         var _loc6_:Array = null;
         var _loc5_:int = 0;
         var _loc2_:Object = null;
         var _loc7_:FacebookUserInfo = null;
         try
         {
            _loc3_ = PJSON.decode(param1.target.data);
         }
         catch(e:Error)
         {
         }
         if(_loc3_ && _loc3_ is Array)
         {
            _loc6_ = _loc3_ as Array;
            for each(var _loc4_ in _loc6_)
            {
               if(_loc4_ && "code" in _loc4_ && _loc4_["code"] && "body" in _loc4_ && _loc4_["body"])
               {
                  _loc5_ = int(_loc4_["code"]);
                  if(_loc5_ >= 200 && _loc5_ <= 299)
                  {
                     if(_loc4_["body"] is String)
                     {
                        try
                        {
                           _loc2_ = PJSON.decode(_loc4_["body"]);
                        }
                        catch(e:Error)
                        {
                        }
                     }
                     else
                     {
                        _loc2_ = _loc4_["body"];
                     }
                     if(_loc2_ && "id" in _loc2_ && _loc2_["id"] && "name" in _loc2_ && _loc2_["name"])
                     {
                        _loc7_ = new FacebookUserInfo();
                        _loc7_.loadDataFromObject(_loc2_);
                        _platformIds[_loc2_["id"]] = _loc7_;
                     }
                  }
               }
            }
            eventDispatcher.dispatchEvent(new ModelUpdateEvent("platformUsersUpdated"));
         }
         else
         {
            log(LoggerContexts.UNEXPECTED,"UNEXPECTED RESPONSE FROM FACEBOOK",_loc3_);
         }
      }
      
      private function getUserInfoBatchRequest(param1:String, param2:Vector.<String>) : URLRequest
      {
         var _loc6_:URLVariables = new URLVariables();
         _loc6_["access_token"] = param1;
         _loc6_["include_headers"] = "false";
         var _loc4_:Array = [];
         for each(var _loc3_ in param2)
         {
            _loc4_.push({
               "method":"GET",
               "relative_url":_loc3_ + "?fields=id,name"
            });
         }
         _loc6_["batch"] = PJSON.encode(_loc4_);
         var _loc5_:URLRequest = new URLRequest("https://graph.facebook.com/v2.2/");
         _loc5_.data = _loc6_;
         _loc5_.method = "POST";
         return _loc5_;
      }
      
      public function getUserName(param1:String, param2:String, param3:Boolean = true) : String
      {
         var _loc4_:FacebookUserInfo = null;
         if(param1 != null && param1 in _platformIds)
         {
            _loc4_ = _platformIds[param1] as FacebookUserInfo;
         }
         if(_loc4_ != null)
         {
            return param3 ? _loc4_.shortenedFullName() : _loc4_.fullName;
         }
         return param2;
      }
      
      public function getUserNameByProfile(param1:Profile, param2:Boolean = true, param3:Boolean = false) : String
      {
         if(param1 == null)
         {
            return "";
         }
         if(param1.isNpc)
         {
            return getUserName(param1.npcClan,param1.npcClan,param2);
         }
         if(!param1.platformId && param1.avatar)
         {
            return param1.mobileName;
         }
         var _loc4_:String;
         return getUserName(param1.platformId,param3 ? param1.gameId : (_loc4_ = "ui.defaultplayername",peak.i18n.PText.INSTANCE.getText0(_loc4_)),param2);
      }
      
      public function setUserInfo(param1:Profile, param2:String) : void
      {
         var _loc3_:FacebookUserInfo = null;
         if(param1 != null && param2 != null && param2 != "")
         {
            if(param1.platformId != null)
            {
               _loc3_ = new FacebookUserInfo();
               _loc3_.fullName = param2;
               _loc3_.uid = param1.platformId;
               _platformIds[param1.platformId] = _loc3_;
            }
         }
      }
      
      public function uploadScreenshot(param1:String, param2:String) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"Preparing POST Request: access_token: " + param1);
         var _loc5_:URLRequest = new URLRequest("https://graph.facebook.com/v2.2/" + param2 + "/photos");
         var _loc4_:FacebookPostRequest = new FacebookPostRequest();
         _loc4_.writePostData("access_token",param1);
         _loc4_.writeFileData(new Date().valueOf() + ".png",_screenshot,"image/png");
         _loc4_.close();
         _loc5_.contentType = "multipart/form-data; boundary=" + _loc4_.boundary;
         _loc5_.data = _loc4_.getPostData();
         _loc5_.method = "POST";
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.addEventListener("complete",onLoaderComplete,false,0,false);
         _loc3_.addEventListener("ioError",onLoaderIOError,false,0,true);
         _loc3_.addEventListener("securityError",onLoaderSecurityError,false,0,true);
         _loc3_.load(_loc5_);
         log(LoggerContexts.INFRASTRUCTURE,"POST Request sent");
      }
      
      private function onLoaderComplete(param1:Event) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"SS Loader Complete!");
         _screenshot = null;
         var _loc2_:String = "";
         _loc2_ = "ELOPositive";
         var _temp_7:* = §§findproperty(UserNotificationEvent);
         var _temp_6:* = "userNotificationEventShow";
         var _temp_5:* = §§findproperty(UserNotification);
         var _temp_4:* = 9;
         var _temp_3:* = 0;
         var _temp_2:* = _loc2_;
         var _loc3_:String = "ui.popups.uploadcaps.success";
         dispatch(new UserNotificationEvent(_temp_6,new UserNotification(_temp_4,_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc3_))));
      }
      
      private function onLoaderIOError(param1:IOErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"SS IO Error" + param1.errorID);
      }
      
      private function onLoaderSecurityError(param1:SecurityErrorEvent) : void
      {
         log(LoggerContexts.INFRASTRUCTURE,"SS Security Error" + param1.errorID);
      }
      
      public function get screenshot() : ByteArray
      {
         return _screenshot;
      }
      
      public function set screenshot(param1:ByteArray) : void
      {
         _screenshot = param1;
      }
      
      public function get screenshotBitmapData() : BitmapData
      {
         return _screenshotBitmapData;
      }
      
      public function set screenshotBitmapData(param1:BitmapData) : void
      {
         _screenshotBitmapData = param1;
      }
      
      public function get platformIds() : Dictionary
      {
         return _platformIds;
      }
   }
}

