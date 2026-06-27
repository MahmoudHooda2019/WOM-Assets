package wom.service.mobile
{
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.utils.Dictionary;
   
   public class MobileExternalPages
   {
      
      public static const FAQ:String = "faq";
      
      public static const FORUM:String = "forum";
      
      public static const SUPPORT:String = "support";
      
      public static const PIGEON_POST:String = "pigeonpost";
      
      public static const PLAYER_GUIDE:String = "playerguide";
      
      private static const DEFAULT_PAGE_URL:String = "http://www.peakgames.net";
      
      private var _externalPages:Dictionary;
      
      public function MobileExternalPages()
      {
         super();
         _externalPages = null;
      }
      
      public function get externalPages() : Dictionary
      {
         return _externalPages;
      }
      
      public function set externalPages(param1:Dictionary) : void
      {
         _externalPages = param1;
      }
      
      public function openURL(param1:String) : void
      {
         var _loc2_:String = _externalPages ? _externalPages[param1] : null;
         navigateToURL(new URLRequest(_loc2_ ? _loc2_ : "http://www.peakgames.net"));
      }
   }
}

