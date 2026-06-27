package wom.view.screen.windows.blacksmith
{
   import peak.i18n.PText;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class UnitEventItemDetailsView extends BaseEventItemDetailsView
   {
      
      private var _unitTypeId:int;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      public function UnitEventItemDetailsView(param1:EventItemDIO)
      {
         super(param1);
         _unitTypeId = param1.relatedId;
      }
      
      public function update(param1:UnitTypeDIO, param2:UnitTypeInfo) : void
      {
         _unitTypeDIO = param1;
         var _loc3_:int = param2.currentLevel - 1;
         if(eventItemTypeDIO.warBuilding)
         {
            var _temp_2:* = label1;
            var _loc4_:String = "ui.windows.eventstore.range";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_) + ":";
            textField1.text = "" + _unitTypeDIO.range(_loc3_) * 5;
         }
         else
         {
            var _temp_3:* = label1;
            var _loc5_:String = "ui.windows.eventstore.speed";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_) + ":";
            var _temp_6:* = textField1;
            var _temp_5:* = "ui.windows.blacksmith.speedandkph";
            var _temp_4:* = _unitTypeDIO.speed(_loc3_);
            var _loc6_:String = "ui.windows.trainingchamber.kph";
            var _loc7_:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            var _loc8_:Number = _temp_4;
            var _loc9_:String = _temp_5;
            _temp_6.text = peak.i18n.PText.INSTANCE.getText2(_loc9_,_loc8_,_loc7_);
         }
         var _temp_7:* = label2;
         var _loc10_:String = "ui.windows.eventstore.health";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc10_) + ":";
         textField2.text = "" + _unitTypeDIO.healthPointsPerLevel[_loc3_];
         damageTextField.text = "" + _unitTypeDIO.damage(_loc3_);
         timeTextField.text = LocalizedDateTimeUtil.getUserFriendlyTimeFromSeconds(_unitTypeDIO.hiringDurationPerLevelInSecs[_loc3_]);
         updateResourceCosts(_unitTypeDIO.hiringCostsPerLevel[_loc3_]);
      }
      
      public function get unitTypeId() : int
      {
         return _unitTypeId;
      }
   }
}

