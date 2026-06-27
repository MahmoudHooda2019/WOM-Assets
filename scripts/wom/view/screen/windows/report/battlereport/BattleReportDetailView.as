package wom.view.screen.windows.report.battlereport
{
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.combat.CatapultInfo;
   import wom.model.game.report.battlereport.BattleReportLog;
   import wom.model.game.report.battlereport.BeastDeployedOnBattleFieldLog;
   import wom.model.game.report.battlereport.BeastFledLog;
   import wom.model.game.report.battlereport.BuildingDestroyedOrDamagedLog;
   import wom.model.game.report.battlereport.CatapultUsedLog;
   import wom.model.game.report.battlereport.PartLootedLog;
   import wom.model.game.report.battlereport.TriggeredExplosivesBattleLog;
   import wom.model.game.report.battlereport.TroopsDeployedOnBattleFieldLog;
   import wom.model.game.report.battlereport.TroopsReleaseFromWatchpostLog;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class BattleReportDetailView extends Sprite implements View
   {
      
      private var _battleReportLog:BattleReportLog;
      
      private var _baseBattleReportViews:Vector.<BaseBattleReportView>;
      
      public function BattleReportDetailView(param1:BattleReportLog)
      {
         super();
         _battleReportLog = param1;
      }
      
      private static function determineDescriptionTextColor(param1:int) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case 1:
               _loc2_ = 16711680;
               break;
            case 2:
               _loc2_ = 16711680;
               break;
            case 3:
               _loc2_ = 0;
               break;
            case 4:
               _loc2_ = 1140623;
               break;
            case 5:
               _loc2_ = 8388736;
               break;
            case 666:
               _loc2_ = 0;
               break;
            case 6:
               _loc2_ = 1140623;
         }
         return _loc2_;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc3_:String = null;
         var _loc15_:BaseBattleReportView = null;
         var _loc4_:BuildingDestroyedOrDamagedLog = null;
         var _loc5_:String = null;
         var _loc1_:TroopsReleaseFromWatchpostLog = null;
         var _loc9_:BeastFledLog = null;
         var _loc13_:String = null;
         var _loc12_:String = null;
         var _loc10_:TroopsDeployedOnBattleFieldLog = null;
         var _loc14_:CatapultUsedLog = null;
         var _loc8_:CatapultInfo = null;
         var _loc16_:String = null;
         var _loc7_:PartLootedLog = null;
         var _loc6_:BeastDeployedOnBattleFieldLog = null;
         var _loc2_:TriggeredExplosivesBattleLog = null;
         _baseBattleReportViews = new Vector.<BaseBattleReportView>();
         switch(_battleReportLog.logType)
         {
            case 1:
               _loc4_ = _battleReportLog as BuildingDestroyedOrDamagedLog;
               var _loc21_:String = "domain.building." + _loc4_.buildingTypeId + ".name";
               _loc5_ = peak.i18n.PText.INSTANCE.getText0(_loc21_);
               if(_loc4_.level > 0)
               {
                  var _temp_3:* = _loc5_;
                  var _temp_2:* = " ";
                  var _loc22_:String = "ui.windows.upgrade.levelabbreviation";
                  _loc5_ += _temp_2 + peak.i18n.PText.INSTANCE.getText0(_loc22_) + String(_loc4_.level);
               }
               else if(_loc4_.level == 0)
               {
                  var _temp_4:* = "ui.windows.battlereport.logtype.1.beingbuilt";
                  var _loc23_:String = _loc5_;
                  var _loc24_:String = _temp_4;
                  _loc5_ = peak.i18n.PText.INSTANCE.getText1(_loc24_,_loc23_);
               }
               if(_loc4_.amount > 1)
               {
                  var _temp_6:* = "ui.windows.battlereport.logtype.1.buildingamount";
                  var _temp_5:* = _loc4_.amount;
                  var _loc25_:String = _loc5_;
                  var _loc26_:int = _temp_5;
                  var _loc27_:String = _temp_6;
                  _loc5_ = peak.i18n.PText.INSTANCE.getText2(_loc27_,_loc26_,_loc25_);
               }
               var _temp_7:*;
               var _temp_9:*;
               var _temp_8:*;
               var _loc28_:String;
               var _loc29_:String;
               var _loc30_:int;
               var _loc31_:String;
               var _loc32_:String;
               _loc3_ = _loc4_.damagePercent == 0 ? (_temp_7 = "ui.windows.battlereport.logtype.1.descdestroyed",_loc28_ = _loc5_,_loc29_ = _temp_7,peak.i18n.PText.INSTANCE.getText1(_loc29_,_loc28_)) : (_temp_9 = "ui.windows.battlereport.logtype.1.descdamaged",_temp_8 = _loc5_,_loc30_ = _loc4_.damagePercent,_loc31_ = _temp_8,_loc32_ = _temp_9,peak.i18n.PText.INSTANCE.getText2(_loc32_,_loc31_,_loc30_));
               _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
               break;
            case 2:
               _loc1_ = _battleReportLog as TroopsReleaseFromWatchpostLog;
               for each(var _loc11_ in _loc1_.troops)
               {
                  §§push("ui.windows.battlereport.logtype.2.desc");
                  §§push(_loc11_.amount);
                  var _loc33_:String = "domain.units." + _loc11_.id + ".name";
                  var _temp_10:* = peak.i18n.PText.INSTANCE.getText0(_loc33_);
                  var _loc34_:String;
                  var _loc35_:String;
                  var _loc36_:* = _loc11_.amount > 1 ? (_loc34_ = "ui.windows.battlereport.pastsimpleofbe.were",peak.i18n.PText.INSTANCE.getText0(_loc34_)) : (_loc35_ = "ui.windows.battlereport.pastsimpleofbe.was",peak.i18n.PText.INSTANCE.getText0(_loc35_));
                  var _loc37_:* = _temp_10;
                  var _loc38_:* = §§pop();
                  var _loc39_:* = §§pop();
                  _loc3_ = peak.i18n.PText.INSTANCE.getText3(_loc39_,_loc38_,_loc37_,_loc36_);
                  _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
                  addChild(_loc15_);
                  _baseBattleReportViews.push(_loc15_);
               }
               break;
            case 3:
               _loc9_ = _battleReportLog as BeastFledLog;
               var _loc40_:String;
               var _loc41_:String;
               _loc13_ = _loc9_.isAttacker ? (_loc40_ = "ui.windows.battlereport.logtype.3.attacking",peak.i18n.PText.INSTANCE.getText0(_loc40_)) : (_loc41_ = "ui.windows.battlereport.logtype.3.defending",peak.i18n.PText.INSTANCE.getText0(_loc41_));
               var _loc42_:String = "domain.beasts." + _loc9_.beastId + ".name";
               _loc12_ = peak.i18n.PText.INSTANCE.getText0(_loc42_);
               var _temp_13:* = "ui.windows.battlereport.logtype.3.desc";
               var _temp_12:* = _loc13_;
               var _loc43_:String = _loc12_;
               var _loc44_:String = _temp_12;
               var _loc45_:String = _temp_13;
               _loc3_ = peak.i18n.PText.INSTANCE.getText2(_loc45_,_loc44_,_loc43_);
               _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
               break;
            case 4:
               _loc10_ = _battleReportLog as TroopsDeployedOnBattleFieldLog;
               for each(_loc11_ in _loc10_.troops)
               {
                  §§push("ui.windows.battlereport.logtype." + _battleReportLog.logType + ".desc");
                  §§push(_loc11_.amount);
                  var _loc46_:String = "domain.units." + _loc11_.id + ".name";
                  var _temp_14:* = peak.i18n.PText.INSTANCE.getText0(_loc46_);
                  var _loc47_:String;
                  var _loc48_:String;
                  var _loc49_:* = _loc11_.amount > 1 ? (_loc47_ = "ui.windows.battlereport.pastsimpleofbe.were",peak.i18n.PText.INSTANCE.getText0(_loc47_)) : (_loc48_ = "ui.windows.battlereport.pastsimpleofbe.was",peak.i18n.PText.INSTANCE.getText0(_loc48_));
                  var _loc50_:* = _temp_14;
                  var _loc51_:* = §§pop();
                  var _loc52_:* = §§pop();
                  _loc3_ = peak.i18n.PText.INSTANCE.getText3(_loc52_,_loc51_,_loc50_,_loc49_);
                  _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
                  addChild(_loc15_);
                  _baseBattleReportViews.push(_loc15_);
               }
               break;
            case 5:
               _loc14_ = _battleReportLog as CatapultUsedLog;
               _loc8_ = _loc14_.catapultInfo;
               var _loc53_:String;
               _loc16_ = _loc8_.type < 5 ? (_loc53_ = "ui.windows.battlereport.salvo.size." + (_loc8_.size + 1),peak.i18n.PText.INSTANCE.getText0(_loc53_)) : "";
               var _temp_19:* = "ui.windows.battlereport.logtype." + _battleReportLog.logType + ".desc";
               var _temp_18:* = "ui.windows.battlereport.salvo.desc";
               var _temp_17:* = _loc16_;
               var _loc54_:String = "ui.windows.battlereport.salvo.type." + _loc8_.type + ".name";
               var _loc55_:* = peak.i18n.PText.INSTANCE.getText0(_loc54_);
               var _loc56_:String = _temp_17;
               var _loc57_:String = _temp_18;
               var _loc58_:* = peak.i18n.PText.INSTANCE.getText2(_loc57_,_loc56_,_loc55_);
               var _loc59_:String = _temp_19;
               _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc59_,_loc58_);
               _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
               break;
            case 666:
               _loc7_ = _battleReportLog as PartLootedLog;
               var _temp_21:* = "ui.windows.battlereport.logtype." + _battleReportLog.logType + "." + (_loc7_.lootedPart.amount > 1 ? "plural" : "single");
               var _temp_20:* = _loc7_.lootedPart.amount;
               var _loc60_:String = "domain.parts." + _loc7_.lootedPart.id + ".name2";
               var _loc61_:* = peak.i18n.PText.INSTANCE.getText0(_loc60_);
               var _loc62_:int = _temp_20;
               var _loc63_:String = _temp_21;
               _loc3_ = peak.i18n.PText.INSTANCE.getText2(_loc63_,_loc62_,_loc61_);
               var _temp_23:* = §§findproperty(PartLootBattleReportView);
               var _temp_22:* = _loc7_.lootedPart.id;
               var _loc64_:String = "ui.windows.battlereport.logtype." + _battleReportLog.logType + ".header";
               _loc15_ = new PartLootBattleReportView(_temp_22,peak.i18n.PText.INSTANCE.getText0(_loc64_),_loc3_,determineDescriptionTextColor(_battleReportLog.logType),true);
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
               break;
            case 6:
               _loc6_ = _battleReportLog as BeastDeployedOnBattleFieldLog;
               var _temp_24:* = "ui.windows.battlereport.logtype." + _battleReportLog.logType + ".desc";
               var _loc65_:String = "domain.beasts." + _loc6_.beastId + ".name";
               var _loc66_:* = peak.i18n.PText.INSTANCE.getText0(_loc65_);
               var _loc67_:String = _temp_24;
               _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc67_,_loc66_);
               _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
               break;
            case 7:
               _loc2_ = _battleReportLog as TriggeredExplosivesBattleLog;
               var _temp_25:* = "ui.windows.battlereport.logtype." + _battleReportLog.logType + ".desc";
               var _loc68_:String = "domain.building." + _loc2_.typeId + ".name";
               var _loc69_:* = peak.i18n.PText.INSTANCE.getText0(_loc68_);
               var _loc70_:String = _temp_25;
               _loc3_ = peak.i18n.PText.INSTANCE.getText1(_loc70_,_loc69_);
               _loc15_ = new BaseBattleReportView(LocalizedDateTimeUtil.getUserFriendlyTime(_battleReportLog.occurrenceTimeInMillis),_loc3_,determineDescriptionTextColor(_battleReportLog.logType));
               addChild(_loc15_);
               _baseBattleReportViews.push(_loc15_);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _baseBattleReportViews.length)
         {
            _baseBattleReportViews[_loc1_].x = 0;
            _baseBattleReportViews[_loc1_].y = _loc1_ * 31;
            _loc1_++;
         }
      }
   }
}

