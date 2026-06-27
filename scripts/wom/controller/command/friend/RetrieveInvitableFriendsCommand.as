package wom.controller.command.friend
{
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.net.URLVariables;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.facebook.FacebookUserInfo;
   import wom.model.game.Profile;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.service.facebook.FacebookAPIManager;
   
   public class RetrieveInvitableFriendsCommand extends PCommand
   {
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      public function RetrieveInvitableFriendsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:URLLoader = null;
         var _loc3_:URLVariables = new URLVariables();
         _loc3_["access_token"] = documentConfiguration.getParameter("access_token");
         _loc3_["limit"] = "5000";
         var _loc2_:URLRequest = new URLRequest("https://graph.facebook.com/v2.2/me/invitable_friends");
         _loc2_.data = _loc3_;
         _loc2_.method = "GET";
         try
         {
            _loc1_ = new URLLoader(_loc2_);
            _loc1_.addEventListener("complete",onURLLoaderComplete);
            _loc1_.addEventListener("ioError",onURLLoaderError);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onURLLoaderComplete(param1:Event) : void
      {
         var _loc2_:Object = null;
         var _loc5_:Array = null;
         var _loc4_:FriendInfo = null;
         var _loc6_:FacebookUserInfo = null;
         var _loc7_:Profile = null;
         try
         {
            _loc2_ = PJSON.decode(param1.target.data);
         }
         catch(e:Error)
         {
         }
         if(_loc2_ && "data" in _loc2_ && _loc2_["data"] && _loc2_["data"] is Array)
         {
            _loc5_ = _loc2_["data"] as Array;
            for each(var _loc3_ in _loc5_)
            {
               if(_loc3_ && "id" in _loc3_ && _loc3_["id"] && "name" in _loc3_ && _loc3_["name"])
               {
                  _loc7_ = new Profile(null,_loc3_["id"],null);
                  try
                  {
                     if(_loc3_["picture"]["data"]["url"])
                     {
                        _loc7_.invitableFriendPictureUrl = _loc3_["picture"]["data"]["url"];
                     }
                  }
                  catch(e:Error)
                  {
                  }
                  _loc4_ = new DefaultFriendInfo(_loc3_["name"],_loc7_);
                  documentConfiguration.invitableFriends.push(_loc4_);
                  _loc6_ = new FacebookUserInfo();
                  _loc6_.loadDataFromObject(_loc3_);
                  facebookApiManager.platformIds[_loc3_["id"]] = _loc6_;
               }
            }
            dispatch(new ModelUpdateEvent("invitableFriendsUpdated"));
         }
         else
         {
            log(LoggerContexts.UNEXPECTED,"UNEXPECTED RESPONSE FROM FACEBOOK",_loc2_);
         }
      }
      
      private function onURLLoaderError(param1:IOErrorEvent) : void
      {
         trace(param1.toString());
      }
   }
}

