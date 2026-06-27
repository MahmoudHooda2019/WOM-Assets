package wom.view.screen.windows.watchpost
{
   import peak.i18n.PText;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferWindow;
   
   public class MobileWatchPostWindow extends MobileMercenaryTransferWindow
   {
      
      private var _buildingLevel:int;
      
      private var _instanceId:int;
      
      public function MobileWatchPostWindow(param1:int, param2:int)
      {
         super(1);
         _instanceId = param1;
         _buildingLevel = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.watchpost.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
      }
      
      public function get buildingLevel() : int
      {
         return _buildingLevel;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

