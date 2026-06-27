package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class ChatAuthRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _gameId:String;
      
      private var _fbid:String;
      
      private var _iosUDID:String;
      
      private var _iosIFV:String;
      
      private var _andID:String;
      
      private var _username:String;
      
      private var _locale:String;
      
      private var _clusterId:int;
      
      private var _timestamp:Number;
      
      private var _signature:String;
      
      private var _axess:String;
      
      private var _allianceName:String;
      
      private var _allianceSig:String;
      
      private var _sdp:String;
      
      private var _sdt:String;
      
      private var _languageId:String;
      
      private var _kid:String;
      
      public function ChatAuthRequest(param1:String, param2:String, param3:String, param4:String, param5:String, param6:String, param7:String, param8:String, param9:int, param10:Number, param11:String, param12:String, param13:String, param14:String, param15:String = null)
      {
         super();
         _gameId = param1;
         _fbid = param2;
         _iosUDID = param3;
         _iosIFV = param4;
         _andID = param5;
         _kid = param6;
         _username = param7;
         _locale = param8;
         _clusterId = param9;
         _timestamp = param10;
         _signature = param11;
         _allianceName = param12;
         _allianceSig = param13;
         _axess = param15;
         _sdp = null;
         _sdt = null;
         _languageId = param14;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {
            "guid":_gameId,
            "fbid":_fbid,
            "ios_udid":_iosUDID,
            "ios_ifv":_iosIFV,
            "kid":_kid,
            "and_id":_andID,
            "name":_username,
            "loc":_locale,
            "ts":_timestamp,
            "cid":_clusterId,
            "sig":_signature,
            "aname":_allianceName,
            "asig":_allianceSig,
            "lid":_languageId
         };
         if(_axess != null)
         {
            _loc1_.axess = _axess;
         }
         if(_sdp != null && _sdt != null)
         {
            _loc1_.sdp = _sdp;
            _loc1_.sdt = _sdt;
         }
         return _loc1_;
      }
      
      public function set sdp(param1:String) : void
      {
         _sdp = param1;
      }
      
      public function set sdt(param1:String) : void
      {
         _sdt = param1;
      }
   }
}

