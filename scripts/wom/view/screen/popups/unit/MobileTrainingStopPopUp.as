package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   
   public class MobileTrainingStopPopUp extends MobileGenericStopPopUp
   {
      
      private var _buildingInstanceId:int;
      
      public function MobileTrainingStopPopUp(param1:int, param2:int)
      {
         super(param1);
         _buildingInstanceId = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.popups.unit.trainingstop.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         var _temp_3:* = _speechBubble;
         var _temp_2:* = "ui.popups.unit.trainingstop.message";
         var _loc2_:String = "domain.units." + unitTypeId + ".name";
         var _loc3_:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc4_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         drawLayout();
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
   }
}

