package wom.view.screen.windows.alliance
{
   import flash.display.DisplayObject;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomRedSmallButton;
   import wom.view.screen.windows.alliance.coa.CoatOfArmsView;
   import wom.view.util.BaseWindowPanel;
   import wom.view.util.LineUtil;
   
   public class AllianceGeneralInfoPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 329;
      
      private var coaBackground:DisplayObject;
      
      private var allianceCOA:CoatOfArmsView;
      
      private var nameTF:WomTextField;
      
      private var leaderLabel:WomTextField;
      
      private var leaderTF:WomTextField;
      
      private var pointsLabel:WomTextField;
      
      private var pointsTF:WomTextField;
      
      private var rankingLabel:WomTextField;
      
      private var rankingTF:WomTextField;
      
      private var membersLabel:WomTextField;
      
      private var membersTF:WomTextField;
      
      private var minLevelLabel:WomTextField;
      
      private var minLevelTF:WomTextField;
      
      private var minScoreLabel:WomTextField;
      
      private var minScoreTF:WomTextField;
      
      private var membershipTypeTF:WomTextField;
      
      private var descriptionBackground:DisplayObject;
      
      private var descriptionTextField:WomTextField;
      
      private var _editButton:WomButton;
      
      private var _quitButton:WomButton;
      
      private var _allianceDetail:AllianceDetailInfo;
      
      private var _fromBrowseTab:Boolean;
      
      public function AllianceGeneralInfoPanel(param1:Boolean = false)
      {
         super(665,329);
         _fromBrowseTab = param1;
         _allianceDetail = null;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         LineUtil.drawHorizontalSeparatorLine(this,2,_visibleWidth - 2);
         coaBackground = createAndAddDisplayObject("TooltipInnerBackground",145,128);
         descriptionBackground = createAndAddDisplayObject("TooltipInnerBackground",614,140);
         allianceCOA = new CoatOfArmsView(assetRepository);
         addChild(allianceCOA);
         nameTF = createAndAddWomCaptionTF(" ",WomTextFormats.CAPTION_44);
         var _loc1_:String = "ui.windows.alliance.myalliance.leader";
         leaderLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         leaderTF = createAndAddWomTF(" ");
         var _loc2_:String = "ui.windows.alliance.myalliance.points";
         pointsLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         pointsTF = createAndAddWomTF(" ");
         var _loc3_:String = "ui.windows.alliance.myalliance.ranking";
         rankingLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         rankingTF = createAndAddWomTF(" ");
         var _loc4_:String = "ui.windows.alliance.myalliance.members";
         membersLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         membersTF = createAndAddWomTF(" ");
         var _loc5_:String = "ui.windows.alliance.myalliance.minlevel";
         minLevelLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         minLevelTF = createAndAddWomTF(" ");
         var _loc6_:String = "ui.windows.alliance.myalliance.minscore";
         minScoreLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc6_));
         minScoreTF = createAndAddWomTF(" ");
         membershipTypeTF = createAndAddWomTF(" ");
         descriptionTextField = createAndAddWomTF("",descriptionBackground.width - 60,descriptionBackground.height - 20,Languages.activeLanguageId == "ar");
         descriptionTextField.multiline = true;
         descriptionTextField.wordWrap = true;
         descriptionTextField.selectable = true;
         _editButton = new WomBlueSmallButton();
         _editButton.width = 113;
         var _temp_26:* = _editButton;
         var _loc7_:String = "ui.windows.alliance.myalliance.editbutton";
         _temp_26.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_editButton);
         _quitButton = new WomRedSmallButton();
         _quitButton.width = 113;
         var _temp_28:* = _quitButton;
         var _loc8_:String = "ui.windows.alliance.myalliance.quitbutton";
         _temp_28.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(_quitButton);
         drawLayout();
      }
      
      private function createAndAddDisplayObject(param1:String, param2:int, param3:int) : DisplayObject
      {
         var _loc4_:DisplayObject = assetRepository.getDisplayObject(param1);
         _loc4_.width = param2;
         _loc4_.height = param3;
         addChild(_loc4_);
         return _loc4_;
      }
      
      private function createAndAddWomTF(param1:String, param2:int = -1, param3:int = -1, param4:Boolean = false) : WomTextField
      {
         var _loc5_:WomTextField = new WomTextField();
         _loc5_.defaultTextFormat = param4 ? WomTextFormats.RIGHT_18 : WomTextFormats.FONT_SIZE_18;
         if(param2 != -1 && param3 != -1)
         {
            _loc5_.width = param2;
            _loc5_.height = param3;
         }
         else
         {
            _loc5_.autoSize = "left";
         }
         _loc5_.text = param1;
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function createAndAddWomCaptionTF(param1:String, param2:TextFormat) : WomTextField
      {
         var _loc3_:WomTextField = new CaptionTextField();
         _loc3_.defaultTextFormat = param2;
         _loc3_.autoSize = "left";
         _loc3_.text = param1;
         addChild(_loc3_);
         return _loc3_;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         coaBackground.x = 25;
         coaBackground.y = 32;
         AlignmentUtil.alignAccordingToPositionOf(allianceCOA,coaBackground,49,38);
         AlignmentUtil.alignAccordingToPositionOf(nameTF,coaBackground,coaBackground.width + 20,-8);
         AlignmentUtil.alignBelowOf(leaderLabel,nameTF,5);
         AlignmentUtil.alignBelowOf(pointsLabel,leaderLabel,2);
         AlignmentUtil.alignBelowOf(rankingLabel,pointsLabel,2);
         AlignmentUtil.alignBelowOf(membershipTypeTF,rankingLabel,2);
         AlignmentUtil.alignAccordingToPositionOf(leaderTF,leaderLabel,110,0);
         AlignmentUtil.alignBelowOf(pointsTF,leaderTF,2);
         AlignmentUtil.alignBelowOf(rankingTF,pointsTF,2);
         AlignmentUtil.alignAccordingToPositionOf(minLevelLabel,leaderLabel,225,0);
         AlignmentUtil.alignBelowOf(minScoreLabel,minLevelLabel,2);
         AlignmentUtil.alignBelowOf(membersLabel,minScoreLabel,2);
         AlignmentUtil.alignAccordingToPositionOf(minLevelTF,minLevelLabel,108,0);
         AlignmentUtil.alignBelowOf(minScoreTF,minLevelTF,2);
         AlignmentUtil.alignBelowOf(membersTF,minScoreTF,2);
         AlignmentUtil.alignBelowOf(descriptionBackground,coaBackground,36);
         AlignmentUtil.alignAccordingToPositionOf(descriptionTextField,descriptionBackground,30,10);
         _editButton.x = 434;
         _editButton.y = 370;
         AlignmentUtil.alignRightOf(_quitButton,_editButton,3);
      }
      
      public function updateWithAllianceInfo(param1:AllianceDetailInfo, param2:AllianceRoleType) : void
      {
         if(param1 != null)
         {
            _allianceDetail = param1;
            _editButton.visible = param2 == AllianceRoleType.LEADER;
            _quitButton.visible = param2 != AllianceRoleType.OUTSIDER;
            allianceCOA.updateWithCoatOfArmsInfo(param1.coatOfArmsInfo);
            nameTF.text = param1.name;
            var _loc3_:String;
            pointsTF.text = ": " + (param1.score < 0 ? (_loc3_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc3_)) : param1.score);
            rankingTF.text = ": " + param1.rank;
            membersTF.text = ": " + param1.members;
            var _loc4_:String;
            minLevelTF.text = ": " + (param1.minLevel == -1 ? (_loc4_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc4_)) : param1.minLevel);
            var _loc5_:String;
            minScoreTF.text = ": " + (param1.minScore == -1 ? (_loc5_ = "ui.windows.alliance.myalliance.invalidlevelscore",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : param1.minScore);
            var _temp_2:* = membershipTypeTF;
            var _loc6_:String = param1.membershipType.i18nKey;
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            descriptionTextField.text = param1.description != null ? param1.description : "";
         }
      }
      
      public function updateLeaderName(param1:String) : void
      {
         leaderTF.text = ": " + param1;
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
      
      public function get editButton() : WomButton
      {
         return _editButton;
      }
      
      public function get quitButton() : WomButton
      {
         return _quitButton;
      }
      
      public function get allianceDetail() : AllianceDetailInfo
      {
         return _allianceDetail;
      }
      
      public function get fromBrowseTab() : Boolean
      {
         return _fromBrowseTab;
      }
   }
}

