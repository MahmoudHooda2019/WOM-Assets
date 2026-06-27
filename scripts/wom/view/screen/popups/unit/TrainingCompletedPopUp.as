package wom.view.screen.popups.unit
{
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.GenericUnitTypeDIO;
   
   public class TrainingCompletedPopUp extends GenericUnitCompletionPopUp
   {
      
      private var _level:int;
      
      public function TrainingCompletedPopUp(param1:GenericUnitTypeDIO, param2:int)
      {
         super(param1);
         _level = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = messageField;
         var _temp_1:* = "ui.popups.unit.trainingcompleted.message";
         var _loc1_:String = "domain.units." + unitTypeDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      public function get level() : int
      {
         return _level;
      }
   }
}

