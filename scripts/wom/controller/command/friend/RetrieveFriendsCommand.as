package wom.controller.command.friend
{
   import com.distriqt.extension.facebookapi.FacebookAPI;
   import com.distriqt.extension.facebookapi.events.FacebookAPIEvent;
   import com.distriqt.extension.facebookapi.objects.FacebookGraphRequest;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.Profile;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.message.request.GetUserIdsOfFriendsRequest;
   import wom.service.facebook.FacebookAPIManager;
   
   public class RetrieveFriendsCommand extends PCommand
   {
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      public function RetrieveFriendsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(!FacebookAPI.isSupported)
         {
            return;
         }
         if(documentConfiguration.friends.length > 0)
         {
            return;
         }
         FacebookAPI.service.addEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.addEventListener("facebookapi:graphrequest:error",onGraphRequestError);
         var _loc1_:FacebookGraphRequest = new FacebookGraphRequest("/me/friends");
         _loc1_.method = "GET";
         FacebookAPI.service.graphRequest(_loc1_);
      }
      
      protected function onGraphRequestCompleted(param1:FacebookAPIEvent) : void
      {
         var _loc6_:Array = null;
         var _loc3_:Array = null;
         var _loc2_:String = null;
         var _loc5_:FriendInfo = null;
         var _loc7_:Profile = null;
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:error",onGraphRequestError);
         if(param1.data && "data" in param1.data && param1.data["data"] && param1.data["data"] is Array)
         {
            _loc6_ = param1.data["data"] as Array;
            _loc3_ = [];
            for each(var _loc4_ in _loc6_)
            {
               _loc2_ = _loc4_["id"];
               _loc3_.push(_loc2_);
               _loc7_ = new Profile(null,_loc2_,null);
               _loc5_ = new DefaultFriendInfo(_loc4_["name"],_loc7_);
               documentConfiguration.friends.push(_loc5_);
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetUserIdsOfFriendsRequest(_loc3_)));
         }
      }
      
      protected function onGraphRequestError(param1:FacebookAPIEvent) : void
      {
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:completed",onGraphRequestCompleted);
         FacebookAPI.service.removeEventListener("facebookapi:graphrequest:error",onGraphRequestError);
      }
   }
}

