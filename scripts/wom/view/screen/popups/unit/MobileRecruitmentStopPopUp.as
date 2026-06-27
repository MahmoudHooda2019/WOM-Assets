package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   
   public class MobileRecruitmentStopPopUp extends MobileGenericStopPopUp
   {
      
      public function MobileRecruitmentStopPopUp(param1:int)
      {
         super(param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = _speechBubble;
         var _temp_1:* = "ui.popups.unit.recruitmentstop.message";
         var _loc1_:String = "domain.units." + unitTypeId + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         drawLayout();
      }
   }
}

