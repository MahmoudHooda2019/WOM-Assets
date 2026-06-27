package wom.view.ui.mainframe.combat
{
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.button.MobileWomMenuButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuTab;
   import wom.view.ui.mainframe.combat.eventitems.MobileCombatMenuEventItemsPanel;
   
   public class MobileCombatMenuPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      private var catapultBg:DisplayObject;
      
      private var unitBg:DisplayObject;
      
      private var _nextTargetButton:MobileWomMenuButton;
      
      private var nextTargetGoldIcon:DisplayObject;
      
      private var nextTargetGoldLabel:MobileCaptionTextField;
      
      private var _homeMenuButton:MobileWomMenuButton;
      
      private var _endAttackButton:MobileWomMenuButton;
      
      private var _spyButton:MobileWomMenuButton;
      
      private var spyGoldIcon:DisplayObject;
      
      private var spyGoldLabel:MobileCaptionTextField;
      
      private var mercenaryDeployTab:MobileMercenaryDeployTab;
      
      private var catapultTab:MobileCatapultMenuTab;
      
      private var eventItemsTab:MobileCombatMenuEventItemsPanel;
      
      private var _eventItemsButton:MobileWomButton;
      
      private var _backToArmyButton:MobileWomButton;
      
      private var _clockIcon:DisplayObject;
      
      private var _deployPassedTextField:MobileCaptionTextField;
      
      private var _extendTransparentBg:DisplayObject;
      
      private var _extendYellowBg:DisplayObject;
      
      private var _extendTF:MobileWomTextField;
      
      private var _extendCountdownTF:MobileWomTextField;
      
      private var _extendCountdownSecondTF:MobileWomTextField;
      
      private var _extendButton:MobileWomButton;
      
      private var _warMenuButton:MobileWomMenuButton;
      
      private var _endAttackEnablingTimer:Timer;
      
      private const EXTEND_ALLOW_TIME_MARGIN:Number = 15000;
      
      private const EXTEND_DISALLOW_TIME_MARGIN:Number = 5000;
      
      public function MobileCombatMenuPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         drawBackground();
         createEventItemsViews();
         catapultTab = new MobileCatapultMenuTab();
         addChild(catapultTab);
         mercenaryDeployTab = new MobileMercenaryDeployTab();
         addChild(mercenaryDeployTab);
         _clockIcon = assetRepository.getDisplayObject("IconTimerM");
         _clockIcon.visible = false;
         addChild(_clockIcon);
         var _temp_4:* = getCaptionTextFormat(25);
         var _loc1_:String = "ui.mainframe.combat.deploymenttimeended";
         _deployPassedTextField = createAndAddCaptionTextField(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc1_),400);
         var _temp_7:* = getCaptionTextFormat(27);
         var _loc2_:String = "ui.mainframe.combat.extend";
         _extendTF = createAndAddCaptionTextField(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc2_),280,50);
         _extendCountdownTF = createAndAddCaptionTextField(getCaptionTextFormat(50)," ");
         var _temp_11:* = getCaptionTextFormat(25);
         var _loc3_:String = "ui.mainframe.combat.extendsecondsuffix";
         _extendCountdownSecondTF = createAndAddCaptionTextField(_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc3_),20);
         _extendButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _extendButton.width = 273;
         var _temp_15:* = _extendButton;
         var _loc4_:String = "ui.mainframe.combat.extendbuttonlabel";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _extendButton.defaultIcon = assetRepository.getDisplayObject("IconGoldM");
         _extendButton.rightLabel = (10).toString();
         _extendButton.visible = false;
         addChild(_extendButton);
         _endAttackButton = MobileWomUIComponentFactory.createMenuButton("Red","Large","IconWarL");
         var _temp_17:* = _endAttackButton;
         var _loc5_:String = "ui.mainframe.combat.endattack";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _endAttackButton.width = 125;
         addChild(_endAttackButton);
         _nextTargetButton = MobileWomUIComponentFactory.createMenuButton("Red","Small","");
         _nextTargetButton.buttonTextFormat = getCaptionTextFormat(20,"center");
         _nextTargetButton.yMargin = -17;
         var _temp_19:* = _nextTargetButton;
         var _loc6_:String = "m.ui.mainframe.combat.nextquickattack";
         _temp_19.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _nextTargetButton.width = 67;
         addChild(_nextTargetButton);
         nextTargetGoldIcon = assetRepository.getDisplayObject("IconGoldS");
         nextTargetGoldIcon.width = nextTargetGoldIcon.height = 20;
         _nextTargetButton.addChild(nextTargetGoldIcon);
         nextTargetGoldLabel = createAndAddMenuLabel(_nextTargetButton,(15).toString(),getCaptionTextFormat(21));
         _homeMenuButton = MobileWomUIComponentFactory.createMenuButton("Blue","Small","IconReturnMBordered");
         var _temp_23:* = _homeMenuButton;
         var _loc7_:String = "ui.menupanel.home";
         _temp_23.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         _homeMenuButton.width = 67;
         _homeMenuButton.visible = false;
         addChild(_homeMenuButton);
         _spyButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconSpyM");
         var _temp_25:* = _spyButton;
         var _loc8_:String = "ui.mainframe.combat.spy";
         _temp_25.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _spyButton.width = 67;
         addChild(_spyButton);
         spyGoldIcon = assetRepository.getDisplayObject("IconGoldS");
         spyGoldIcon.width = spyGoldIcon.height = 20;
         _spyButton.addChild(spyGoldIcon);
         spyGoldLabel = createAndAddMenuLabel(_spyButton,(8).toString(),getCaptionTextFormat(21));
         _warMenuButton = MobileWomUIComponentFactory.createMenuButton("Red","Large","IconWarL");
         var _temp_29:* = _warMenuButton;
         var _loc9_:String = "ui.menupanel.war";
         _temp_29.label = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         _warMenuButton.width = 125;
         _warMenuButton.visible = false;
         addChild(_warMenuButton);
         _endAttackEnablingTimer = new Timer(1000,1);
      }
      
      private function createEventItemsViews() : void
      {
         _eventItemsButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
         _eventItemsButton.width = 155;
         var _temp_2:* = _eventItemsButton;
         var _loc1_:String = "ui.mainframe.combat.eventitems.header";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _eventItemsButton.isEnabled = false;
         _eventItemsButton.visible = false;
         addChildAt(_eventItemsButton,0);
         _backToArmyButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
         _backToArmyButton.width = 155;
         _backToArmyButton.visible = false;
         var _temp_4:* = _backToArmyButton;
         var _loc2_:String = "ui.mainframe.combat.backtoarmyheader";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChildAt(_backToArmyButton,0);
         eventItemsTab = new MobileCombatMenuEventItemsPanel();
         eventItemsTab.visible = false;
         addChild(eventItemsTab);
      }
      
      private function createAndAddCaptionTextField(param1:MPBitmapFontTextFormat, param2:String, param3:Object = null, param4:Object = null) : MobileCaptionTextField
      {
         var _loc5_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc5_.textRendererProperties.textFormat = param1;
         if(param3 != null)
         {
            _loc5_.width = param3 as int;
         }
         if(param4 != null)
         {
            _loc5_.height = param4 as int;
         }
         _loc5_.textRendererProperties.wordWrap = true;
         _loc5_.visible = false;
         addChild(_loc5_);
         _loc5_.text = param2;
         return _loc5_;
      }
      
      private function createAndAddWomTextField(param1:int, param2:MPBitmapFontTextFormat, param3:String) : MobileWomTextField
      {
         var _loc4_:MobileWomTextField = new MobileWomTextField();
         _loc4_.textRendererProperties.textFormat = param2;
         _loc4_.width = param1;
         _loc4_.visible = false;
         addChild(_loc4_);
         _loc4_.text = param3;
         return _loc4_;
      }
      
      private function drawBackground() : void
      {
         catapultBg = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         catapultBg.width = 315;
         catapultBg.height = 115;
         addChildAt(catapultBg,0);
         unitBg = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         unitBg.width = 526;
         unitBg.height = 115;
         addChildAt(unitBg,1);
         _extendTransparentBg = assetRepository.getDisplayObject("BackgroundTransparentPanel");
         _extendTransparentBg.width = 853;
         _extendTransparentBg.height = 115;
         _extendTransparentBg.visible = false;
         addChild(_extendTransparentBg);
         _extendYellowBg = assetRepository.getDisplayObject("MobileYellowBackground");
         _extendYellowBg.width = 833;
         _extendYellowBg.height = 95;
         _extendYellowBg.visible = false;
         addChild(_extendYellowBg);
      }
      
      public function drawLayout() : void
      {
         catapultBg.x = 15;
         catapultBg.y = visibleHeight - catapultBg.height - 12;
         MobileAlignmentUtil.alignRightOf(unitBg,catapultBg,10);
         catapultTab.x = 17;
         catapultTab.y = visibleHeight - 128;
         MobileAlignmentUtil.alignRightOf(mercenaryDeployTab,catapultTab,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(eventItemsTab,mercenaryDeployTab,0,0);
         MobileAlignmentUtil.alignAboveOf(_eventItemsButton,unitBg,3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_backToArmyButton,_eventItemsButton,0,0);
         nextTargetGoldIcon.x = 43;
         nextTargetGoldIcon.y = -2;
         MobileAlignmentUtil.alignRightOf(nextTargetGoldLabel,nextTargetGoldIcon,-5);
         nextTargetGoldLabel.y = nextTargetGoldIcon.y - 2;
         spyGoldIcon.x = 43;
         spyGoldIcon.y = -2;
         MobileAlignmentUtil.alignRightOf(spyGoldLabel,spyGoldIcon,-5);
         spyGoldLabel.y = spyGoldIcon.y - 2;
         _homeMenuButton.x = visibleWidth - _homeMenuButton.width - 10;
         _homeMenuButton.y = visibleHeight - _homeMenuButton.height - 216;
         _nextTargetButton.x = visibleWidth - _nextTargetButton.width - 10;
         _nextTargetButton.y = visibleHeight - _nextTargetButton.height - 216;
         _spyButton.x = visibleWidth - _spyButton.width - 10;
         _spyButton.y = visibleHeight - _spyButton.height - 142;
         _deployPassedTextField.validate();
         _extendButton.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendTransparentBg,catapultBg,0,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendYellowBg,_extendTransparentBg,10,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendTF,_extendYellowBg,19,24);
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendCountdownTF,_extendYellowBg,400,25);
         alignCountdownSecondTF();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_clockIcon,_extendCountdownTF,-52);
         _clockIcon.y -= 6;
         MobileAlignmentUtil.alignAccordingToPositionOf(_deployPassedTextField,unitBg,92,36);
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendButton,_extendYellowBg,_extendYellowBg.width - _extendButton.width - 14,14);
         _warMenuButton.x = visibleWidth - _warMenuButton.width - 10;
         _warMenuButton.y = visibleHeight - _warMenuButton.height - 10;
         MobileAlignmentUtil.alignAccordingToPositionOf(_endAttackButton,_warMenuButton,0,0);
      }
      
      private function alignCountdownSecondTF() : void
      {
         _extendCountdownTF.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_extendCountdownSecondTF,_extendCountdownTF,_extendCountdownTF.width + 3,15);
      }
      
      private function createAndAddMenuLabel(param1:MobileWomButton, param2:String, param3:MPBitmapFontTextFormat) : MobileCaptionTextField
      {
         var _loc4_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc4_.textRendererProperties.textFormat = param3;
         param1.addChild(_loc4_);
         _loc4_.text = param2;
         return _loc4_;
      }
      
      public function updatePanelState(param1:AttackInfo) : void
      {
         updateQuickAttackInfo(param1.isQuickAttack);
         _nextTargetButton.isEnabled = _nextTargetButton.isEnabled && param1.isAttackOngoing && !checkAnyUnitOrCatapultUsed(param1);
         var _loc2_:Boolean = checkEndTimeExtendable(param1);
         updateVisibilityOfDeployPassedComponents(!_loc2_ && param1.deployPassed && param1.isAttackOngoing);
         updateVisibilityOfExtendComponents(_loc2_);
         updateExtendCountdownTF(param1);
         _clockIcon.visible = _loc2_ || param1.deployPassed;
         if(param1.deployPassed)
         {
            _backToArmyButton.visible = _eventItemsButton.visible = false;
         }
      }
      
      private function checkAnyUnitOrCatapultUsed(param1:AttackInfo) : Boolean
      {
         var _loc3_:Boolean = false;
         var _loc8_:int = 0;
         var _loc7_:Dictionary = param1.salvosUsed;
         for(var _loc5_ in _loc7_)
         {
            _loc3_ = true;
         }
         var _loc6_:Boolean = param1.beast && (param1.beast.status == UnitStatusType.ATTACKING || param1.beast.status == UnitStatusType.RETREATED || param1.beast.status == UnitStatusType.DEAD);
         var _loc4_:Boolean = false;
         for each(var _loc2_ in param1.units)
         {
            if(_loc2_.status == UnitStatusType.ATTACKING || _loc2_.status == UnitStatusType.DEAD)
            {
               _loc4_ = true;
               break;
            }
         }
         return _loc4_ || _loc6_ || _loc3_;
      }
      
      public function checkEndTimeExtendable(param1:AttackInfo) : Boolean
      {
         var _loc2_:Number = NaN;
         if(param1.isAttackOngoing && !param1.attackEndTimeExtended)
         {
            _loc2_ = param1.attackEndTime - 5000 - getTimer();
            trace(DateTimeUtil.convertMillisecondToSecond(_loc2_));
            return _loc2_ >= 0 && _loc2_ < 15000;
         }
         return false;
      }
      
      public function updateVisibilityOfDeployPassedComponents(param1:Boolean) : void
      {
         _deployPassedTextField.visible = param1;
         if(param1)
         {
            catapultBg.visible = false;
         }
      }
      
      public function updateVisibilityOfExtendComponents(param1:Boolean) : void
      {
         _extendTransparentBg.visible = _extendYellowBg.visible = _extendButton.visible = _extendCountdownTF.visible = _extendCountdownSecondTF.visible = _extendTF.visible = param1;
         unitBg.visible = !param1;
         if(param1)
         {
            catapultBg.visible = false;
         }
      }
      
      public function updateQuickAttackInfo(param1:Boolean) : void
      {
         _nextTargetButton.visible = param1;
      }
      
      public function updateSpyButtonEnabling(param1:Boolean, param2:Boolean) : void
      {
         _spyButton.visible = !param2;
         _spyButton.isEnabled = param1;
         _spyButton.alpha = param1 ? 1 : 0.5;
      }
      
      public function updateExtendCountdownTF(param1:AttackInfo) : void
      {
         _extendCountdownTF.text = (int((param1.attackEndTime - getTimer()) / 1000)).toString();
         alignCountdownSecondTF();
      }
      
      public function scoutMode() : void
      {
         _homeMenuButton.visible = _warMenuButton.visible = true;
         _endAttackButton.visible = false;
         drawLayout();
      }
      
      public function attackMode() : void
      {
         _homeMenuButton.visible = _warMenuButton.visible = false;
         _endAttackButton.visible = true;
         _endAttackButton.isEnabled = false;
         _endAttackEnablingTimer.reset();
         _endAttackEnablingTimer.start();
         drawLayout();
      }
      
      public function updateWarButtonEnabling(param1:Boolean) : void
      {
         _warMenuButton.isEnabled = !param1;
         _warMenuButton.touchable = true;
      }
      
      public function onEndAttackEnablingTimerComplete(param1:Boolean) : void
      {
         if(param1)
         {
            _endAttackButton.isEnabled = true;
         }
         _endAttackEnablingTimer.stop();
      }
      
      public function updateEventItemsPanelVisibility(param1:Boolean, param2:Boolean) : void
      {
         if(param2)
         {
            eventItemsTab.visible = _backToArmyButton.visible = param1;
            mercenaryDeployTab.visible = _eventItemsButton.visible = !param1;
         }
      }
      
      public function updateEventItemsButtonEnabling(param1:Vector.<EventItemDIO>, param2:Boolean, param3:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc4_:EventItemDIO = null;
         if(param3)
         {
            _eventItemsButton.visible = false;
            _eventItemsButton.isEnabled = false;
            if(param2)
            {
               return;
            }
            if(param1 && checkAttackModeOn())
            {
               _loc5_ = 0;
               while(_loc5_ < param1.length)
               {
                  _loc4_ = param1[_loc5_];
                  if(_loc4_.itemType == EventItemType.BEAST.id || _loc4_.itemType == EventItemType.BUILDING.id || _loc4_.itemType == EventItemType.CATAPULT.id || _loc4_.itemType == EventItemType.MERCENARY.id)
                  {
                     _eventItemsButton.isEnabled = true;
                     _eventItemsButton.visible = !_backToArmyButton.visible && !_deployPassedTextField.visible;
                  }
                  _loc5_++;
               }
            }
         }
      }
      
      private function checkAttackModeOn() : Boolean
      {
         return _endAttackButton.visible;
      }
      
      public function get endAttackButton() : MobileWomMenuButton
      {
         return _endAttackButton;
      }
      
      public function get nextTargetButton() : MobileWomMenuButton
      {
         return _nextTargetButton;
      }
      
      public function get spyButton() : MobileWomMenuButton
      {
         return _spyButton;
      }
      
      public function get extendButton() : MobileWomButton
      {
         return _extendButton;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function get warMenuButton() : MobileWomMenuButton
      {
         return _warMenuButton;
      }
      
      public function get homeMenuButton() : MobileWomMenuButton
      {
         return _homeMenuButton;
      }
      
      public function get endAttackEnablingTimer() : Timer
      {
         return _endAttackEnablingTimer;
      }
      
      public function get eventItemsButton() : MobileWomButton
      {
         return _eventItemsButton;
      }
      
      public function get backToArmyButton() : MobileWomButton
      {
         return _backToArmyButton;
      }
   }
}

