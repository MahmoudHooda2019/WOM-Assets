package wom.view.screen.windows.report.battlereport
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.PartInfoDTO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.dto.combat.CatapultInfo;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.game.report.battlereport.BattleReportLog;
   import wom.model.game.report.battlereport.BeastDeployedOnBattleFieldLog;
   import wom.model.game.report.battlereport.BeastFledLog;
   import wom.model.game.report.battlereport.BuildingDestroyedOrDamagedLog;
   import wom.model.game.report.battlereport.CatapultUsedLog;
   import wom.model.game.report.battlereport.PartLootedLog;
   import wom.model.game.report.battlereport.TriggeredExplosivesBattleLog;
   import wom.model.game.report.battlereport.TroopsDeployedOnBattleFieldLog;
   import wom.model.game.report.battlereport.TroopsReleaseFromWatchpostLog;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileBattleReportDetailView extends Sprite implements View
   {
      
      private static const WIDTH:int = 573;
      
      private static const HEIGHT:int = 399;
      
      [Inject]
      public var _assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _list:MPList;
      
      private var _damageReportTF:MPTextField;
      
      private var _damageInflictedTextField:MPTextField;
      
      public function MobileBattleReportDetailView(param1:Number = 573, param2:Number = 399)
      {
         super();
         this.width = param1;
         this.height = param2;
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
         _background = _assetRepository.getDisplayObject("MobileDarkBackground");
         _background.width = 573;
         _background.height = 399;
         addChildAt(_background,0);
         _damageReportTF = new MobileWomTextField();
         _damageReportTF.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         _damageReportTF.width = 573 >> 1;
         addChild(_damageReportTF);
         _damageInflictedTextField = new MobileWomTextField();
         _damageInflictedTextField.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         _damageInflictedTextField.width = 573 >> 1;
         addChild(_damageInflictedTextField);
         _list = new MPList();
         _list.itemRendererFactory = factory;
         _list.height = 330;
         _list.width = 546;
         _list.horizontalScrollPolicy = "off";
         _list.verticalScrollPolicy = "on";
         addChild(_list);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_damageReportTF,_background,0,17);
         MobileAlignmentUtil.alignRightOf(_damageInflictedTextField,_damageReportTF);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_list,_background,56);
      }
      
      private function factory() : IListItemRenderer
      {
         var _loc1_:MobileBattleReportDetailLineRenderer = new MobileBattleReportDetailLineRenderer(_assetRepository);
         _loc1_.width = 560;
         _loc1_.height = 52;
         return _loc1_;
      }
      
      public function battleReportUpdated(param1:BattleReport, param2:Number, param3:DomainInfo) : void
      {
         var _loc7_:int = 0;
         var _loc5_:BattleReportLog = null;
         var _loc4_:Array = [];
         for each(var _loc6_ in param1.lootedParts)
         {
            createLineAndAddToArray(_loc4_,new PartLootedLog(666,param2,_loc6_),param3);
         }
         _loc7_ = 0;
         while(_loc7_ < param1.battleReportLogs.length)
         {
            _loc5_ = param1.battleReportLogs[_loc7_];
            createLineAndAddToArray(_loc4_,_loc5_,param3);
            _loc7_++;
         }
         _list.dataProvider = new ListCollection(_loc4_);
         _list.validate();
         var _temp_2:* = _damageReportTF;
         var _temp_1:* = "ui.windows.battlereport.totaldamage";
         var _loc10_:String = (100 - param1.totalDamagePercentage).toString();
         var _loc11_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_);
         var _temp_4:* = _damageInflictedTextField;
         var _temp_3:* = "ui.windows.battlereport.damageinflicted";
         var _loc12_:int = param1.lastBattleDamagePercentage;
         var _loc13_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_);
         drawLayout();
      }
      
      private function createLineAndAddToArray(param1:Array, param2:BattleReportLog, param3:DomainInfo) : void
      {
         var _loc6_:String = null;
         var _loc7_:BuildingDestroyedOrDamagedLog = null;
         var _loc8_:String = null;
         var _loc4_:TroopsReleaseFromWatchpostLog = null;
         var _loc12_:BeastFledLog = null;
         var _loc16_:String = null;
         var _loc15_:String = null;
         var _loc13_:TroopsDeployedOnBattleFieldLog = null;
         var _loc17_:CatapultUsedLog = null;
         var _loc11_:CatapultInfo = null;
         var _loc18_:String = null;
         var _loc10_:PartLootedLog = null;
         var _loc9_:BeastDeployedOnBattleFieldLog = null;
         var _loc5_:TriggeredExplosivesBattleLog = null;
         switch(param2.logType)
         {
            case 1:
               _loc7_ = param2 as BuildingDestroyedOrDamagedLog;
               var _loc23_:String = "domain.building." + _loc7_.buildingTypeId + ".name";
               _loc8_ = peak.i18n.PText.INSTANCE.getText0(_loc23_);
               if(_loc7_.level > 0)
               {
                  var _temp_2:* = _loc8_;
                  var _temp_1:* = " ";
                  var _loc24_:String = "ui.windows.upgrade.levelabbreviation";
                  _loc8_ += _temp_1 + peak.i18n.PText.INSTANCE.getText0(_loc24_) + String(_loc7_.level);
               }
               else if(_loc7_.level == 0)
               {
                  var _temp_3:* = "ui.windows.battlereport.logtype.1.beingbuilt";
                  var _loc25_:String = _loc8_;
                  var _loc26_:String = _temp_3;
                  _loc8_ = peak.i18n.PText.INSTANCE.getText1(_loc26_,_loc25_);
               }
               if(_loc7_.amount > 1)
               {
                  var _temp_5:* = "ui.windows.battlereport.logtype.1.buildingamount";
                  var _temp_4:* = _loc7_.amount;
                  var _loc27_:String = _loc8_;
                  var _loc28_:int = _temp_4;
                  var _loc29_:String = _temp_5;
                  _loc8_ = peak.i18n.PText.INSTANCE.getText2(_loc29_,_loc28_,_loc27_);
               }
               var _temp_6:*;
               var _temp_8:*;
               var _temp_7:*;
               var _loc30_:String;
               var _loc31_:String;
               var _loc32_:int;
               var _loc33_:String;
               var _loc34_:String;
               _loc6_ = _loc7_.damagePercent == 0 ? (_temp_6 = "ui.windows.battlereport.logtype.1.descdestroyed",_loc30_ = _loc8_,_loc31_ = _temp_6,peak.i18n.PText.INSTANCE.getText1(_loc31_,_loc30_)) : (_temp_8 = "ui.windows.battlereport.logtype.1.descdamaged",_temp_7 = _loc8_,_loc32_ = _loc7_.damagePercent,_loc33_ = _temp_7,_loc34_ = _temp_8,peak.i18n.PText.INSTANCE.getText2(_loc34_,_loc33_,_loc32_));
               param1.push({
                  "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType)
               });
               break;
            case 2:
               _loc4_ = param2 as TroopsReleaseFromWatchpostLog;
               for each(var _loc14_ in _loc4_.troops)
               {
                  §§push("ui.windows.battlereport.logtype.2.desc");
                  §§push(_loc14_.amount);
                  var _loc35_:String = "domain.units." + _loc14_.id + ".name";
                  var _temp_9:* = peak.i18n.PText.INSTANCE.getText0(_loc35_);
                  var _loc36_:String;
                  var _loc37_:String;
                  var _loc38_:* = _loc14_.amount > 1 ? (_loc36_ = "ui.windows.battlereport.pastsimpleofbe.were",peak.i18n.PText.INSTANCE.getText0(_loc36_)) : (_loc37_ = "ui.windows.battlereport.pastsimpleofbe.was",peak.i18n.PText.INSTANCE.getText0(_loc37_));
                  var _loc39_:* = _temp_9;
                  var _loc40_:* = §§pop();
                  var _loc41_:* = §§pop();
                  _loc6_ = peak.i18n.PText.INSTANCE.getText3(_loc41_,_loc40_,_loc39_,_loc38_);
                  param1.push({
                     "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                     "desc":_loc6_,
                     "color":determineDescriptionTextColor(param2.logType)
                  });
               }
               break;
            case 3:
               _loc12_ = param2 as BeastFledLog;
               var _loc42_:String;
               var _loc43_:String;
               _loc16_ = _loc12_.isAttacker ? (_loc42_ = "ui.windows.battlereport.logtype.3.attacking",peak.i18n.PText.INSTANCE.getText0(_loc42_)) : (_loc43_ = "ui.windows.battlereport.logtype.3.defending",peak.i18n.PText.INSTANCE.getText0(_loc43_));
               var _loc44_:String = "domain.beasts." + _loc12_.beastId + ".name";
               _loc15_ = peak.i18n.PText.INSTANCE.getText0(_loc44_);
               var _temp_12:* = "ui.windows.battlereport.logtype.3.desc";
               var _temp_11:* = _loc16_;
               var _loc45_:String = _loc15_;
               var _loc46_:String = _temp_11;
               var _loc47_:String = _temp_12;
               _loc6_ = peak.i18n.PText.INSTANCE.getText2(_loc47_,_loc46_,_loc45_);
               param1.push({
                  "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType)
               });
               break;
            case 4:
               _loc13_ = param2 as TroopsDeployedOnBattleFieldLog;
               for each(_loc14_ in _loc13_.troops)
               {
                  §§push("ui.windows.battlereport.logtype." + param2.logType + ".desc");
                  §§push(_loc14_.amount);
                  var _loc48_:String = "domain.units." + _loc14_.id + ".name";
                  var _temp_13:* = peak.i18n.PText.INSTANCE.getText0(_loc48_);
                  var _loc49_:String;
                  var _loc50_:String;
                  var _loc51_:* = _loc14_.amount > 1 ? (_loc49_ = "ui.windows.battlereport.pastsimpleofbe.were",peak.i18n.PText.INSTANCE.getText0(_loc49_)) : (_loc50_ = "ui.windows.battlereport.pastsimpleofbe.was",peak.i18n.PText.INSTANCE.getText0(_loc50_));
                  var _loc52_:* = _temp_13;
                  var _loc53_:* = §§pop();
                  var _loc54_:* = §§pop();
                  _loc6_ = peak.i18n.PText.INSTANCE.getText3(_loc54_,_loc53_,_loc52_,_loc51_);
                  param1.push({
                     "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                     "desc":_loc6_,
                     "color":determineDescriptionTextColor(param2.logType)
                  });
               }
               break;
            case 5:
               _loc17_ = param2 as CatapultUsedLog;
               _loc11_ = _loc17_.catapultInfo;
               var _loc55_:String;
               _loc18_ = _loc11_.type < 4 ? (_loc55_ = "ui.windows.battlereport.salvo.size." + (_loc11_.size + 1),peak.i18n.PText.INSTANCE.getText0(_loc55_)) : "";
               var _temp_18:* = "ui.windows.battlereport.logtype." + param2.logType + ".desc";
               var _temp_17:* = "ui.windows.battlereport.salvo.desc";
               var _temp_16:* = _loc18_;
               var _loc56_:String = "ui.windows.battlereport.salvo.type." + _loc11_.type + ".name";
               var _loc57_:* = peak.i18n.PText.INSTANCE.getText0(_loc56_);
               var _loc58_:String = _temp_16;
               var _loc59_:String = _temp_17;
               var _loc60_:* = peak.i18n.PText.INSTANCE.getText2(_loc59_,_loc58_,_loc57_);
               var _loc61_:String = _temp_18;
               _loc6_ = peak.i18n.PText.INSTANCE.getText1(_loc61_,_loc60_);
               param1.push({
                  "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType)
               });
               break;
            case 666:
               _loc10_ = param2 as PartLootedLog;
               var _temp_20:* = "ui.windows.battlereport.logtype." + param2.logType + "." + (_loc10_.lootedPart.amount > 1 ? "plural" : "single");
               var _temp_19:* = _loc10_.lootedPart.amount;
               var _loc62_:String = "domain.parts." + _loc10_.lootedPart.id + ".name2";
               var _loc63_:* = peak.i18n.PText.INSTANCE.getText0(_loc62_);
               var _loc64_:int = _temp_19;
               var _loc65_:String = _temp_20;
               _loc6_ = peak.i18n.PText.INSTANCE.getText2(_loc65_,_loc64_,_loc63_);
               var _temp_26:* = param1;
               var _temp_25:* = "icon";
               var _temp_24:* = param3.getPart(_loc10_.lootedPart.id).visual;
               var _temp_23:* = "iconScale";
               var _temp_22:* = 0.25;
               var _temp_21:* = "occurenceTime";
               var _loc66_:String = "ui.windows.battlereport.logtype." + param2.logType + ".header";
               _temp_26.push({
                  _temp_25:_temp_24,
                  _temp_23:_temp_22,
                  _temp_21:peak.i18n.PText.INSTANCE.getText0(_loc66_),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType),
                  "occurrenceTimeAlreadyCalculated":true
               });
               break;
            case 6:
               _loc9_ = param2 as BeastDeployedOnBattleFieldLog;
               var _temp_27:* = "ui.windows.battlereport.logtype." + param2.logType + ".desc";
               var _loc67_:String = "domain.beasts." + _loc9_.beastId + ".name";
               var _loc68_:* = peak.i18n.PText.INSTANCE.getText0(_loc67_);
               var _loc69_:String = _temp_27;
               _loc6_ = peak.i18n.PText.INSTANCE.getText1(_loc69_,_loc68_);
               param1.push({
                  "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType)
               });
               break;
            case 7:
               _loc5_ = param2 as TriggeredExplosivesBattleLog;
               var _temp_28:* = "ui.windows.battlereport.logtype." + param2.logType + ".desc";
               var _loc70_:String = "domain.building." + _loc5_.typeId + ".name";
               var _loc71_:* = peak.i18n.PText.INSTANCE.getText0(_loc70_);
               var _loc72_:String = _temp_28;
               _loc6_ = peak.i18n.PText.INSTANCE.getText1(_loc72_,_loc71_);
               param1.push({
                  "occurenceTime":LocalizedDateTimeUtil.getUserFriendlyTime(param2.occurrenceTimeInMillis),
                  "desc":_loc6_,
                  "color":determineDescriptionTextColor(param2.logType)
               });
         }
      }
   }
}

