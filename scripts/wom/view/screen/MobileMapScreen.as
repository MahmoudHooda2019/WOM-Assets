package wom.view.screen
{
   public class MobileMapScreen extends MobileBaseScreen
   {
      
      public static const MARGIN:int = 0;
      
      private var _openMapListWindowAfterInitialization:Boolean;
      
      private var _campaignMode:Boolean = true;
      
      public function MobileMapScreen(param1:Boolean = false)
      {
         super();
         _openMapListWindowAfterInitialization = param1;
      }
      
      public function get openMapListWindowAfterInitialization() : Boolean
      {
         return _openMapListWindowAfterInitialization;
      }
      
      public function set openMapListWindowAfterInitialization(param1:Boolean) : void
      {
         _openMapListWindowAfterInitialization = param1;
      }
      
      public function get campaignMode() : Boolean
      {
         return _campaignMode;
      }
      
      public function set campaignMode(param1:Boolean) : void
      {
         _campaignMode = param1;
      }
   }
}

