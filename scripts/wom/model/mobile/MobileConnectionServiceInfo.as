package wom.model.mobile
{
   public class MobileConnectionServiceInfo
   {
      
      private var _peakToken:String;
      
      private var _peakTokenExpires:Number;
      
      private var _loginType:String;
      
      private var _facebookId:String;
      
      private var _facebookToken:String;
      
      private var _authenticatedToWeb:Boolean;
      
      private var _authenticatedToGameServer:Boolean;
      
      private var _invalidWebCalls:Array;
      
      private var _mobileUdId:String;
      
      private var _languageId:String;
      
      public function MobileConnectionServiceInfo()
      {
         super();
         _peakToken = null;
         _peakTokenExpires = -1;
         _loginType = null;
         _facebookId = null;
         _facebookToken = null;
         _authenticatedToWeb = false;
         _authenticatedToGameServer = false;
         _invalidWebCalls = [];
         _mobileUdId = null;
         _languageId = null;
      }
      
      public function get peakToken() : String
      {
         return _peakToken;
      }
      
      public function get peakTokenExpires() : Number
      {
         return _peakTokenExpires;
      }
      
      public function get loginType() : String
      {
         return _loginType;
      }
      
      public function set peakToken(param1:String) : void
      {
         _peakToken = param1;
      }
      
      public function set peakTokenExpires(param1:Number) : void
      {
         _peakTokenExpires = param1;
      }
      
      public function set loginType(param1:String) : void
      {
         _loginType = param1;
      }
      
      public function isConnectedWithFacebook() : Boolean
      {
         return _loginType == "FB";
      }
      
      public function get facebookId() : String
      {
         return _facebookId;
      }
      
      public function set facebookId(param1:String) : void
      {
         _facebookId = param1;
      }
      
      public function get facebookToken() : String
      {
         return _facebookToken;
      }
      
      public function set facebookToken(param1:String) : void
      {
         _facebookToken = param1;
      }
      
      public function get authenticatedToWeb() : Boolean
      {
         return _authenticatedToWeb;
      }
      
      public function set authenticatedToWeb(param1:Boolean) : void
      {
         _authenticatedToWeb = param1;
      }
      
      public function reset() : void
      {
         _peakToken = null;
         _peakTokenExpires = -1;
         _loginType = null;
         _facebookId = null;
         _facebookToken = null;
         _authenticatedToWeb = false;
         _authenticatedToGameServer = false;
         _invalidWebCalls = [];
         _mobileUdId = null;
         _languageId = null;
      }
      
      public function get invalidWebCalls() : Array
      {
         return _invalidWebCalls;
      }
      
      public function get authenticatedToGameServer() : Boolean
      {
         return _authenticatedToGameServer;
      }
      
      public function set authenticatedToGameServer(param1:Boolean) : void
      {
         _authenticatedToGameServer = param1;
      }
      
      public function get mobileUdId() : String
      {
         return _mobileUdId;
      }
      
      public function set mobileUdId(param1:String) : void
      {
         _mobileUdId = param1;
      }
      
      public function get languageId() : String
      {
         return _languageId;
      }
      
      public function set languageId(param1:String) : void
      {
         _languageId = param1;
      }
   }
}

