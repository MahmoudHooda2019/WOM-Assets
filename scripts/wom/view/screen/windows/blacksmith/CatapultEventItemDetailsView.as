package wom.view.screen.windows.blacksmith
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class CatapultEventItemDetailsView extends BaseEventItemDetailsView
   {
      
      private var _catapultTypeId:int;
      
      private var _catapultTypeDIO:CatapultTypeDIO;
      
      public function CatapultEventItemDetailsView(param1:EventItemDIO)
      {
         super(param1);
         _catapultTypeId = param1.relatedId;
      }
      
      public function updateFields() : void
      {
         var _loc1_:Number = NaN;
         if(_catapultTypeId == 4 || _catapultTypeId == 5 || _catapultTypeId == 6)
         {
            var _temp_3:* = label1;
            var _loc2_:String = "ui.windows.blacksmith.radius";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_) + ":";
            var _temp_4:* = label2;
            var _loc3_:String = "ui.windows.eventstore.duration";
            _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc3_) + ":";
            textField1.text = "" + _catapultTypeDIO.rangesPerStaqe[0];
            _loc1_ = _catapultTypeDIO.activationTimesPerStage[0] / 60;
            textField2.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_loc1_);
            if(_catapultTypeId == 4)
            {
               damageTextField.text = "" + _catapultTypeDIO.effectValues[0].effectValuesPerStage[0] / _loc1_;
            }
            else if(_catapultTypeId == 6)
            {
               var _temp_5:* = _damageLabel;
               var _loc4_:String = "ui.windows.eventstore.heal";
               _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + ":";
               damageTextField.text = "" + _catapultTypeDIO.effectValues[0].effectValuesPerStage[0];
            }
            timeTextField.text = timeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(catapultTypeDIO.upgradeTimesInSecs.length > 0 ? catapultTypeDIO.upgradeTimesInSecs[0] : 0);
            updateResourceCosts(catapultTypeDIO.resourceCosts[0]);
         }
      }
      
      public function get catapultTypeDIO() : CatapultTypeDIO
      {
         return _catapultTypeDIO;
      }
      
      public function set catapultTypeDIO(param1:CatapultTypeDIO) : void
      {
         _catapultTypeDIO = param1;
      }
      
      public function get catapultTypeId() : int
      {
         return _catapultTypeId;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_catapultTypeId == 5)
         {
            _damageTextField.visible = false;
            _damageLabel.visible = false;
            AlignmentUtil.alignAccordingToPositionOf(_timeLabel,label1,0,48);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(timeTextField,_timeLabel,63);
         }
      }
   }
}

