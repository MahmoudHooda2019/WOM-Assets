package wom.view.screen.windows.report.battlereport
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.component.enum.ELOStarType;
   import wom.model.game.Profile;
   import wom.model.game.report.AttackLog;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileLightAnimationView;
   
   public class MobileBattleReportGeneralInfoView extends Sprite implements View
   {
      
      private static const WIDTH:int = 573;
      
      private static const HEIGHT:int = 399;
      
      public static const EVENT_NPC_COLOR:int = 14331123;
      
      [Inject]
      public var _assetRepository:MobileWomAssetRepository;
      
      private var _background:DisplayObject;
      
      private var _attackerFlagBackground:DisplayObject;
      
      private var _attackerLevelIndicator:DisplayObject;
      
      private var _attackerAvatar:DisplayObject;
      
      private var _attackerLevelTF:MPTextField;
      
      private var _attackerNameTF:MPTextField;
      
      private var _defenderFlagBackground:DisplayObject;
      
      private var _defenderLevelIndicator:DisplayObject;
      
      private var _defenderAvatar:DisplayObject;
      
      private var _defenderLevelTF:MPTextField;
      
      private var _defenderNameTF:MPTextField;
      
      private var _vsAvatar:DisplayObject;
      
      private var _vsLabel:MPTextField;
      
      private var _outcomeLabel:MPTextField;
      
      private var _starsBackground:DisplayObject;
      
      private var _starViews:Vector.<MobileBattlePointsBigStarView>;
      
      private var _scoreTextField:MPTextField;
      
      private var _tournamentScoreTextField:MPTextField;
      
      private var _lightView:MobileLightAnimationView;
      
      private var _attacker:Profile;
      
      private var _defender:Profile;
      
      private var _battleReport:BattleReport;
      
      private var _attackLog:AttackLog;
      
      public function MobileBattleReportGeneralInfoView(param1:Number = 573, param2:Number = 399)
      {
         super();
         this.width = param1;
         this.height = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MobileBattlePointsBigStarView = null;
         _background = _assetRepository.getDisplayObject("MobileDarkBackground");
         _background.width = 573;
         _background.height = 399;
         addChildAt(_background,0);
         _lightView = new MobileLightAnimationView();
         _lightView.scaleX = _lightView.scaleY = 2;
         addChild(_lightView);
         _lightView.visible = false;
         _attackerFlagBackground = _assetRepository.getDisplayObject("AvatarBackground");
         addChild(_attackerFlagBackground);
         _attackerAvatar = _assetRepository.getDisplayObject("FacebookFallbackPicture");
         _attackerAvatar.addEventListener("change",onAvatarLoaded);
         addChild(_attackerAvatar);
         _attackerLevelIndicator = _assetRepository.getDisplayObject("IconLevelM");
         _attackerLevelIndicator.scaleX = _attackerLevelIndicator.scaleY = 0.7;
         addChild(_attackerLevelIndicator);
         _attackerLevelTF = new MobileCaptionTextField();
         _attackerLevelTF.textRendererProperties.textFormat = getCaptionTextFormat(19,"center");
         _attackerLevelTF.width = 25;
         addChild(_attackerLevelTF);
         _attackerNameTF = new MobileCaptionTextField();
         _attackerNameTF.textRendererProperties.textFormat = getCaptionTextFormat(17,"center");
         _attackerNameTF.width = 67;
         _attackerNameTF.textRendererProperties.wordWrap = true;
         addChild(_attackerNameTF);
         _defenderFlagBackground = _assetRepository.getDisplayObject("AvatarBackground");
         addChild(_defenderFlagBackground);
         _defenderAvatar = _assetRepository.getDisplayObject("FacebookFallbackPicture");
         _defenderAvatar.addEventListener("change",onAvatarLoaded);
         addChild(_defenderAvatar);
         _defenderLevelIndicator = _assetRepository.getDisplayObject("IconLevelM");
         _defenderLevelIndicator.scaleX = _defenderLevelIndicator.scaleY = 0.7;
         addChild(_defenderLevelIndicator);
         _defenderLevelTF = new MobileCaptionTextField();
         _defenderLevelTF.textRendererProperties.textFormat = getCaptionTextFormat(19,"center");
         _defenderLevelTF.width = 25;
         addChild(_defenderLevelTF);
         _defenderNameTF = new MobileCaptionTextField();
         _defenderNameTF.textRendererProperties.textFormat = getCaptionTextFormat(17,"center");
         _defenderNameTF.width = 67;
         _defenderNameTF.textRendererProperties.wordWrap = true;
         addChild(_defenderNameTF);
         _vsAvatar = _assetRepository.getDisplayObject("VsShieldSword");
         addChild(_vsAvatar);
         _vsLabel = new MobileCaptionTextField();
         _vsLabel.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         _vsLabel.width = 47;
         addChild(_vsLabel);
         var _temp_15:* = _vsLabel;
         var _loc4_:String = "ui.windows.battlereport.vs";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _starsBackground = _assetRepository.getDisplayObject("BackgroundLight");
         _starsBackground.width = 546;
         _starsBackground.height = 215;
         addChild(_starsBackground);
         _starViews = new Vector.<MobileBattlePointsBigStarView>(3,true);
         _loc2_ = 0;
         while(_loc2_ < _starViews.length)
         {
            _loc1_ = new MobileBattlePointsBigStarView(_assetRepository.getDisplayObject(ELOStarType.EMPTY.bigAssetName),ELOStarType.EMPTY);
            addChild(_loc1_);
            _starViews[_loc2_] = _loc1_;
            _loc2_++;
         }
         _scoreTextField = new MobileCaptionTextField();
         _scoreTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center",16777215);
         addChild(_scoreTextField);
         _tournamentScoreTextField = new MobileCaptionTextField();
         _tournamentScoreTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center",2849024);
         addChild(_tournamentScoreTextField);
         _outcomeLabel = new MobileCaptionTextField();
         _outcomeLabel.textRendererProperties.textFormat = getCaptionTextFormat(62,"center",14723355);
         addChild(_outcomeLabel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(_lightView,_background,290,284);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_vsAvatar,_background,30);
         MobileAlignmentUtil.alignMiddleOf(_vsLabel,_vsAvatar);
         _vsLabel.x -= 5;
         MobileAlignmentUtil.alignAccordingToPositionOf(_attackerFlagBackground,_background,126,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_attackerAvatar,_attackerFlagBackground,21,35);
         MobileAlignmentUtil.alignAccordingToPositionOf(_attackerLevelIndicator,_attackerFlagBackground,6,19);
         MobileAlignmentUtil.alignAccordingToPositionOf(_attackerLevelTF,_attackerLevelIndicator,19,19);
         _attackerLevelTF.x -= _attackerLevelTF.width / 2 + 3;
         _attackerLevelTF.y -= _attackerLevelTF.height / 2;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_attackerNameTF,_attackerFlagBackground,88);
         MobileAlignmentUtil.alignAccordingToPositionOf(_defenderFlagBackground,_background,356,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_defenderAvatar,_defenderFlagBackground,21,35);
         MobileAlignmentUtil.alignAccordingToPositionOf(_defenderLevelIndicator,_defenderFlagBackground,6,19);
         MobileAlignmentUtil.alignAccordingToPositionOf(_defenderLevelTF,_defenderLevelIndicator,19,19);
         _defenderLevelTF.x -= _defenderLevelTF.width / 2 + 3;
         _defenderLevelTF.y -= _defenderLevelTF.height / 2;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_defenderNameTF,_defenderFlagBackground,88);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_starsBackground,_background,174);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_outcomeLabel,_starsBackground,-(_outcomeLabel.height >> 1));
         _loc1_ = 0;
         while(_loc1_ < _starViews.length)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_starViews[_loc1_],_starsBackground,81 + _loc1_ * 128,34);
            _loc1_++;
         }
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_scoreTextField,_starsBackground,163);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_tournamentScoreTextField,_starsBackground,183);
      }
      
      public function battleReportUpdated(param1:BattleReport, param2:AttackLog, param3:String, param4:String, param5:Boolean) : void
      {
         _battleReport = param1;
         _attackLog = param2;
         _defender = param2.defender;
         _attacker = param2.attacker;
         _attackerNameTF.text = param3;
         var _loc6_:int = getChildIndex(_attackerFlagBackground);
         removeChild(_attackerFlagBackground);
         _attackerFlagBackground = _assetRepository.getDisplayObject(param2.attacker.isNpc ? "NPCAvatarBackground" : "AvatarBackground");
         addChildAt(_attackerFlagBackground,_loc6_);
         var _loc10_:int = getChildIndex(_attackerLevelIndicator) - 1;
         if(contains(_attackerAvatar))
         {
            _loc10_ = getChildIndex(_attackerAvatar);
            removeChild(_attackerAvatar);
         }
         _attackerAvatar = _assetRepository.getAvatarByProfile(param2.attacker,50,50);
         addChildAt(_attackerAvatar,_loc10_);
         _attackerLevelIndicator.visible = _attackerLevelTF.visible = !_attackLog.attacker.isNpc && _battleReport.attackerLevel >= 0;
         _attackerLevelTF.text = _battleReport.attackerLevel + "";
         _defenderLevelIndicator.visible = _defenderLevelTF.visible = (_attackLog.defender.npcClan == "NPC-6" || _attackLog.defender.npcClan == "NPC_D" || !_attackLog.defender.isNpc) && _battleReport.defenderLevel >= 0;
         _defenderLevelTF.text = _battleReport.defenderLevel + "";
         _defenderNameTF.text = param4;
         var _loc13_:int = getChildIndex(_defenderFlagBackground);
         removeChild(_defenderFlagBackground);
         _defenderFlagBackground = _assetRepository.getDisplayObject(param2.defender.npcClan == "NPC-6" ? "NPCAvatarBackground" : (param2.defender.isNpc ? "NPCAvatarBackground" : "AvatarBackground"));
         addChildAt(_defenderFlagBackground,_loc13_);
         var _loc11_:int = getChildIndex(_defenderLevelIndicator) - 1;
         if(contains(_defenderAvatar))
         {
            _loc11_ = getChildIndex(_defenderAvatar);
            removeChild(_defenderAvatar);
         }
         _defenderAvatar = _assetRepository.getAvatarByProfile(param2.defender,50,50);
         addChildAt(_defenderAvatar,_loc11_);
         var _loc9_:Boolean = checkDefenderIsNpc(_attackLog,_defender);
         var _loc12_:int = int(param5 ? _attackLog.star : 0 - _attackLog.star);
         if(_loc12_ == 1 && _loc9_)
         {
            _loc12_ = 2;
         }
         updateStars(_loc12_);
         _starViews[0].visible = _starViews[2].visible = !_loc9_;
         _outcomeLabel.textRendererProperties.textFormat = getCaptionTextFormat(62,"center",_loc12_ > 0 ? 14657070 : 15682332);
         var _loc15_:String;
         var _loc16_:String;
         _outcomeLabel.text = _loc12_ > 0 ? (_loc15_ = "ui.windows.battlereport.victory",peak.i18n.PText.INSTANCE.getText0(_loc15_)) : (_loc16_ = "ui.windows.battlereport.defeat",peak.i18n.PText.INSTANCE.getText0(_loc16_));
         _lightView.visible = _loc12_ > 0;
         var _loc7_:int = int(param5 ? _attackLog.battlePointDifference : 0 - _attackLog.battlePointDifference);
         var _loc8_:String = _attackLog.eventPoints > 0 ? "+" + _attackLog.eventPoints : (_loc7_ > 0 ? "+" + _loc7_ : _loc7_ + "");
         _scoreTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center",_attackLog.eventPoints > 0 ? 14331123 : (_loc12_ > 0 ? 16777215 : 15682332));
         var _temp_18:*;
         var _temp_19:*;
         var _loc17_:String;
         var _loc18_:String;
         var _loc19_:String;
         var _loc20_:String;
         _scoreTextField.text = _attackLog.eventPoints > 0 ? (_temp_18 = "ui.windows.battlereport.eventscore",_loc17_ = _loc8_,_loc18_ = _temp_18,peak.i18n.PText.INSTANCE.getText1(_loc18_,_loc17_)) : (_temp_19 = "ui.windows.battlereport.score",_loc19_ = _loc8_,_loc20_ = _temp_19,peak.i18n.PText.INSTANCE.getText1(_loc20_,_loc19_));
         _scoreTextField.visible = _attackLog.eventPoints > 0 && _defender.npcClan == "NPC-6" || !_loc9_;
         var _temp_23:* = _tournamentScoreTextField;
         var _temp_22:* = "ui.windows.battlereport.tournamentscore";
         var _loc21_:String = String(_battleReport.tournamentPoints);
         var _loc22_:String = _temp_22;
         _temp_23.text = peak.i18n.PText.INSTANCE.getText1(_loc22_,_loc21_);
         _tournamentScoreTextField.visible = _battleReport.isTournamentAttack && param5;
         drawLayout();
      }
      
      private function checkDefenderIsNpc(param1:AttackLog, param2:Profile) : Boolean
      {
         if(param1.tutorialAttack && param2.npcId == "NPC_D")
         {
            return false;
         }
         return param2.isNpc;
      }
      
      private function updateStars(param1:Number) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _starViews.length)
         {
            if(param1 > _loc2_)
            {
               updateStarView(_loc2_,ELOStarType.POSITIVE);
            }
            else
            {
               updateStarView(_loc2_,ELOStarType.NEGATIVE);
            }
            _loc2_++;
         }
      }
      
      private function updateStarView(param1:int, param2:ELOStarType) : Boolean
      {
         var _loc3_:Boolean = false;
         if(_starViews[param1].starType != param2)
         {
            _loc3_ = true;
            removeChild(_starViews[param1]);
            _starViews[param1] = new MobileBattlePointsBigStarView(_assetRepository.getDisplayObject(param2.mobileBigAssetName),param2);
            addChild(_starViews[param1]);
         }
         return _loc3_;
      }
      
      public function updateNames(param1:String, param2:String) : void
      {
         _attackerNameTF.text = param1;
         _defenderNameTF.text = param2;
         drawLayout();
      }
      
      private function onAvatarLoaded(param1:Event) : void
      {
         drawLayout();
      }
      
      public function get attackLog() : AttackLog
      {
         return _attackLog;
      }
      
      public function get lightView() : MobileLightAnimationView
      {
         return _lightView;
      }
   }
}

