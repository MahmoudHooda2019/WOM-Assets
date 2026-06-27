package wom.view.screen.windows.alliance.mobile
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.screen.windows.transfer.MobileMercenaryTransferWindow;
   
   public class MobileAllianceBarracksTransferWindow extends MobileMercenaryTransferWindow
   {
      
      private var _memberId:String;
      
      private var _unitLevels:Dictionary;
      
      public function MobileAllianceBarracksTransferWindow(param1:String, param2:Vector.<WindowEnumeration> = null)
      {
         super(2,param2);
         _memberId = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.alliancebarracks.header";
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

