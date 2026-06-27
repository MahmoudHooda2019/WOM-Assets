package wom.view.screen.windows.alliance
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenMediumButton;
   import wom.view.component.button.colored.WomRedMediumButton;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.util.BaseWindowPanel;
   
   public class AllianceTournamentPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private var nextAttackLabel:TextField;
      
      private var _nextAttackTimeLabel:TextField;
      
      private var tournamentLabel:TextField;
      
      private var _tournamentTimeLabel:TextField;
      
      private var _attackButton:WomButton;
      
      private var _attackWithGoldButton:WomButton;
      
      private var _listPanel:AllianceTournamentListPanel;
      
      private var _helpContainer:Sprite;
      
      private var _helpButton:QuestHintButton;
      
      public function AllianceTournamentPanel()
      {
         super(665,443);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _listPanel = new AllianceTournamentListPanel();
         addChild(_listPanel);
         var _temp_2:* = this;
         var _loc1_:String = "ui.windows.alliance.tournament.nextattack";
         nextAttackLabel = createDefaultCaptionTextField(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc1_),WomTextFormats.FONT_SIZE_18,200);
         _nextAttackTimeLabel = createDefaultCaptionTextField(this,"MM:SS",WomTextFormats.FONT_SIZE_18,200);
         var _temp_6:* = this;
         var _loc2_:String = "ui.windows.alliance.tournament.tournamentend";
         tournamentLabel = createDefaultCaptionTextField(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc2_),WomTextFormats.FONT_SIZE_18,200);
         _tournamentTimeLabel = createDefaultCaptionTextField(this,"DD/MM/YY",WomTextFormats.FONT_SIZE_18,200);
         _attackButton = new WomRedMediumButton();
         _attackButton.width = 150;
         var _temp_11:* = _attackButton;
         var _loc3_:String = "ui.windows.alliance.tournament.attack";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_attackButton);
         _attackWithGoldButton = new WomGreenMediumButton();
         var _temp_13:* = _attackWithGoldButton;
         var _loc4_:String = "ui.windows.alliance.tournament.attacknow";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _attackWithGoldButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _attackWithGoldButton.width = 150;
         addChild(_attackWithGoldButton);
         createAndAddHelpContent();
         drawLayout();
      }
      
      private function createAndAddHelpContent() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc5_:TextField = null;
         var _loc6_:int = 0;
         _helpContainer = new Sprite();
         _helpContainer.visible = false;
         addChild(_helpContainer);
         _helpButton = new QuestHintButton();
         addChild(_helpButton);
         var _loc4_:DisplayObject = assetRepository.getDisplayObject("BackgroundDark");
         _loc4_.width = 664;
         _loc4_.height = 392;
         AlignmentUtil.alignAccordingToPositionOf(_loc4_,bg,0,52);
         _helpContainer.addChild(_loc4_);
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("TournamentReward1");
         _helpContainer.addChild(_loc3_);
         AlignmentUtil.alignAccordingToPositionOf(_loc3_,_loc4_,85,30);
         var _loc10_:DisplayObject = assetRepository.getDisplayObject("TournamentReward2");
         _helpContainer.addChild(_loc10_);
         AlignmentUtil.alignAccordingToPositionOf(_loc10_,_loc4_,9,135);
         var _loc9_:DisplayObject = assetRepository.getDisplayObject("TournamentReward3");
         _helpContainer.addChild(_loc9_);
         AlignmentUtil.alignAccordingToPositionOf(_loc9_,_loc4_,110,210);
         var _temp_4:* = _helpContainer;
         var _loc11_:String = "ui.windows.alliance.tournament.help.title";
         var _loc2_:TextField = createDefaultCaptionTextField(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc11_),WomTextFormats.FONT_SIZE_22);
         AlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc4_,200,40);
         var _loc8_:DisplayObject = _loc2_;
         var _loc7_:int = _loc2_.height;
         _loc6_ = 1;
         while(_loc6_ < 6)
         {
            _loc1_ = assetRepository.getDisplayObject("MainQuestPreviewComplete");
            AlignmentUtil.alignHeightSpecifiedBelowOf(_loc1_,_loc8_,10,_loc7_);
            if(_loc6_ == 1)
            {
               _loc1_.x += 25;
               _loc1_.y += 5;
            }
            _helpContainer.addChild(_loc1_);
            var _temp_8:* = _helpContainer;
            var _loc12_:String = "ui.windows.alliance.tournament.help.tips." + _loc6_;
            _loc5_ = createDefaultTextField(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc12_),WomTextFormats.FONT_SIZE_18,405);
            AlignmentUtil.alignRightOf(_loc5_,_loc1_,3);
            _helpContainer.addChild(_loc5_);
            _loc8_ = _loc1_;
            _loc7_ = _loc5_.height;
            _loc6_++;
         }
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(_attackButton,bg,665 - _attackButton.width - 20,6);
         AlignmentUtil.alignAccordingToPositionOf(_attackWithGoldButton,bg,665 - _attackButton.width - 20,6);
         AlignmentUtil.alignLeftOf(nextAttackLabel,_attackButton,8);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_nextAttackTimeLabel,nextAttackLabel,20);
         AlignmentUtil.alignAccordingToPositionOf(tournamentLabel,bg,40,6);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_tournamentTimeLabel,tournamentLabel,20);
         AlignmentUtil.alignAccordingToPositionOf(_helpButton,bg,10,10);
      }
      
      private function createDefaultCaptionTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:int = -1) : TextField
      {
         var _loc5_:TextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.text = param2;
         if(param4 > 0)
         {
            _loc5_.width = param4;
         }
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      private function createDefaultTextField(param1:DisplayObjectContainer, param2:String, param3:TextFormat, param4:Object = null) : TextField
      {
         var _loc5_:TextField = new WomTextField();
         _loc5_.defaultTextFormat = param3;
         _loc5_.autoSize = "left";
         _loc5_.width = param4 == null ? 450 : param4 as int;
         _loc5_.multiline = true;
         _loc5_.wordWrap = true;
         _loc5_.text = param2;
         param1.addChild(_loc5_);
         return _loc5_;
      }
      
      public function get helpButton() : QuestHintButton
      {
         return _helpButton;
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         _helpContainer.visible = param1;
      }
      
      public function get attackButton() : WomButton
      {
         return _attackButton;
      }
      
      public function get attackWithGoldButton() : WomButton
      {
         return _attackWithGoldButton;
      }
      
      public function updateDurationRelatedFields(param1:Number, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:Boolean = param1 <= 0;
         if(param3 > 0)
         {
            nextAttackLabel.visible = _nextAttackTimeLabel.visible = _attackWithGoldButton.visible = _attackButton.visible = false;
            _tournamentTimeLabel.visible = tournamentLabel.visible = true;
            var _temp_3:* = tournamentLabel;
            var _loc7_:String = "ui.windows.alliance.tournament.tournamentstart";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            _tournamentTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param3);
            var _temp_5:* = _listPanel;
            var _temp_4:* = true;
            var _loc8_:String = "ui.windows.alliance.tournament.warning.starting";
            _temp_5.setWarningText(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc8_));
         }
         else if(param2 > 0)
         {
            nextAttackLabel.visible = _nextAttackTimeLabel.visible = _attackWithGoldButton.visible = !_loc5_;
            _attackButton.visible = _loc5_;
            _tournamentTimeLabel.visible = tournamentLabel.visible = true;
            var _temp_8:* = tournamentLabel;
            var _loc9_:String = "ui.windows.alliance.tournament.tournamentend";
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc9_);
            _tournamentTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param2);
            if(!_loc5_)
            {
               _nextAttackTimeLabel.text = DateTimeUtil.getUserFriendlyTime(param1);
               _attackWithGoldButton.rightLabel = StoreUtil.buildingPrice(0,param1 / 1000) + "";
            }
            var _temp_11:* = _listPanel;
            var _temp_10:* = param4 == 0 && _listPanel.alliances.length == 0;
            var _loc10_:String = "ui.windows.alliance.tournament.warning.shouldwin";
            _temp_11.setWarningText(_temp_10,peak.i18n.PText.INSTANCE.getText0(_loc10_));
         }
         else
         {
            nextAttackLabel.visible = _nextAttackTimeLabel.visible = _attackWithGoldButton.visible = _attackButton.visible = _tournamentTimeLabel.visible = false;
            tournamentLabel.visible = true;
            var _temp_15:* = tournamentLabel;
            var _loc11_:String = "ui.windows.alliance.tournament.tournamentlimbo";
            _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc11_);
            var _temp_17:* = _listPanel;
            var _temp_16:* = true;
            var _loc12_:String = "ui.windows.alliance.tournament.tournamentlimbo";
            _temp_17.setWarningText(_temp_16,peak.i18n.PText.INSTANCE.getText0(_loc12_));
         }
         drawLayout();
      }
   }
}

