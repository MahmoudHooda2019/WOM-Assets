package wom.view.screen.windows.watchpost
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferWindow;
   
   public class MobileFriendWatchPostTransferWindow extends MobileMercenaryTransferWindow
   {
      
      private var _memberId:String;
      
      private var _unitLevels:Dictionary;
      
      public function MobileFriendWatchPostTransferWindow(param1:String, param2:Vector.<WindowEnumeration> = null)
      {
         super(3,param2);
         _memberId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.watchpost.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
      }
      
      public function get memberId() : String
      {
         return _memberId;
      }
      
      public function get unitLevels() : Dictionary
      {
         return _unitLevels;
      }
      
      public function set unitLevels(param1:Dictionary) : void
      {
         _unitLevels = param1;
      }
   }
}

