package wom.controller.command.chat
{
   import peak.i18n.PText;
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.request.ChatAuthRequest;
   import wom.service.facebook.FacebookAPIManager;
   
   public class ChatAuthenticateCommand extends PCommand
   {
      
      [Inject(name="chatServer")]
      public var connection:ServerConnection;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var pText:PText;
      
      public function ChatAuthenticateCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         userInfo.chatRetryAttemptCount = 5;
         var _loc11_:String = userInfo.profile.mobileName ? userInfo.profile.mobileName : facebookApiManager.getUserNameByProfile(userInfo.profile);
         var _loc9_:String = documentConfiguration.getParameter("fbid");
         var _loc3_:String = documentConfiguration.getParameter("ios_udid");
         var _loc4_:String = documentConfiguration.getParameter("ios_ifv");
         var _loc7_:String = documentConfiguration.getParameter("and_id");
         var _loc5_:String = documentConfiguration.getParameter("kid");
         var _loc14_:String = documentConfiguration.getParameter("sig");
         var _loc2_:String = documentConfiguration.hasParameter("fblang") ? documentConfiguration.getParameter("fblang") : "en_US";
         var _loc10_:int = documentConfiguration.hasParameter("cid") ? documentConfiguration.getParameter("cid") : 2;
         var _loc6_:Number = documentConfiguration.getParameter("timestamp");
         var _loc1_:String = allianceInfo.myAllianceSummary != null ? allianceInfo.myAllianceSummary.name : documentConfiguration.getParameter("allianceName");
         var _loc13_:ChatAuthRequest = new ChatAuthRequest(userInfo.profile.gameId,_loc9_,_loc3_,_loc4_,_loc7_,_loc5_,_loc11_,_loc2_,_loc10_,_loc6_,_loc14_,_loc1_,allianceInfo.allianceSig,pText.activeLanguage.id,documentConfiguration.axess);
         var _loc8_:int = documentConfiguration.hasParameter("store_discount") ? documentConfiguration.getParameter("store_discount") : 0;
         var _loc12_:Number = documentConfiguration.hasParameter("store_end") ? documentConfiguration.getParameter("store_end") : 0;
         if(_loc8_ > 0 && _loc12_ > 0)
         {
            _loc13_.sdp = String(_loc8_);
            _loc13_.sdt = String(_loc12_);
         }
         dispatch(new OutgoingMessageEvent("outgoingChatMessage",_loc13_));
      }
   }
}

