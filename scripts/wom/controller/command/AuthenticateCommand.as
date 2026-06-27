package wom.controller.command
{
   import peak.network.ServerConnection;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.message.request.AuthRequest;
   
   public class AuthenticateCommand extends PCommand
   {
      
      [Inject(name="gameServer")]
      public var connection:ServerConnection;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function AuthenticateCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:String = documentConfiguration.getParameter("gameid");
         var _loc14_:String = documentConfiguration.getParameter("sig");
         var _loc11_:String = documentConfiguration.getParameter("fbid");
         var _loc3_:String = documentConfiguration.getParameter("ios_udid");
         var _loc4_:String = documentConfiguration.getParameter("ios_ifv");
         var _loc8_:String = documentConfiguration.getParameter("and_id");
         var _loc5_:String = documentConfiguration.getParameter("kid");
         var _loc9_:Array = [];
         for(var _loc7_ in documentConfiguration.womFriends)
         {
            _loc9_.push(_loc7_);
         }
         var _loc2_:String = documentConfiguration.hasParameter("fblang") ? documentConfiguration.getParameter("fblang") : "en_US";
         var _loc6_:Number = documentConfiguration.getParameter("timestamp");
         var _loc13_:AuthRequest = new AuthRequest(_loc1_,_loc11_,_loc3_,_loc4_,_loc8_,_loc5_,_loc9_,_loc6_,_loc2_,_loc14_,documentConfiguration.axess);
         var _loc10_:int = documentConfiguration.hasParameter("store_discount") ? documentConfiguration.getParameter("store_discount") : 0;
         var _loc12_:Number = documentConfiguration.hasParameter("store_end") ? documentConfiguration.getParameter("store_end") : 0;
         if(_loc10_ > 0 && _loc12_ > 0)
         {
            _loc13_.sdp = String(_loc10_);
            _loc13_.sdt = String(_loc12_);
         }
         dispatch(new OutgoingMessageEvent("outgoingMessage",_loc13_));
      }
   }
}

