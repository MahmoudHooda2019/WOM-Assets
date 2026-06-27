package wom.view.screen.windows.alliance.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceRoleType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileCoatOfArmsView;
   
   public class MobileAllianceGeneralInfoPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var coaBackground:DisplayObject;
      
      private var allianceCOA:MobileCoatOfArmsView;
      
      private var nameTF:MPTextField;
      
      private var leaderLabel:MPTextField;
      
      private var leaderTF:MPTextField;
      
      private var pointsLabel:MPTextField;
      
      private var pointsTF:MPTextField;
      
      private var rankingLabel:MPTextField;
      
      private var rankingTF:MPTextField;
      
      private var membersLabel:MPTextField;
      
      private var membersTF:MPTextField;
      
      private var minLevelLabel:MPTextField;
      
      private var minLevelTF:MPTextField;
      
      private var minScoreLabel:MPTextField;
      
      private var minScoreTF:MPTextField;
      
      private var membershipTypeTF:MPTextField;
      
      private var descriptionBackground:DisplayObject;
      
      private var descriptionTextField:MPTextField;
      
      private var _editButton:MobileWomButton;
      
      private var _quitButton:MobileWomButton;
      
      private var _allianceDetail:AllianceDetailInfo;
      
      private var _fromBrowseTab:Boolean;
      
      public function MobileAllianceGeneralInfoPanel(param1:Boolean = false)
      {
         super();
         _fromBrowseTab = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         coaBackground = createAndAddDisplayObject("MobileBeigeBackground",230,225);
         descriptionBackground = createAndAddDisplayObject("MobileBeigeInnerBackground",960,243);
         allianceCOA = new MobileCoatOfArmsView(assetRepository);
         addChild(allianceCOA);
         nameTF = createAndAddWomCaptionTF(" ",-1,-1,46);
         var _loc1_:String = "ui.windows.alliance.myalliance.leader";
         leaderLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         leaderTF = createAndAddWomCaptionTF(" ");
         var _loc2_:String = "ui.windows.alliance.myalliance.points";
         pointsLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         pointsTF = createAndAddWomCaptionTF(" ");
         var _loc3_:String = "ui.windows.alliance.myalliance.ranking";
         rankingLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         rankingTF = createAndAddWomCaptionTF(" ");
         var _loc4_:String = "ui.windows.alliance.myalliance.members";
         membersLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         membersTF = createAndAddWomCaptionTF(" ");
         var _loc5_:String = "ui.windows.alliance.myalliance.minlevel";
         minLevelLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc5_));
         minLevelTF = createAndAddWomCaptionTF(" ");
         var _loc6_:String = "ui.windows.alliance.myalliance.minscore";
         minScoreLabel = createAndAddWomTF(peak.i18n.PText.INSTANCE.getText0(_loc6_));
         minScoreTF = createAndAddWomCaptionTF(" ");
         membershipTypeTF = createAndAddWomTF(" ");
         descriptionTextField = createAndAddWomTF("",descriptionBackground.width - 60,descriptionBackground.height - 20,Languages.activeLanguageId == "ar",0);
         descriptionTextField.textRendererProperties.multiline = true;
         descriptionTextField.textRendererProperties.wordWrap = true;
         descriptionTextField.textRendererProperties.selectable = true;
         _editButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _editButton.width = 200;
         var _temp_26:* = _editButton;
         var _loc7_:String = "ui.windows.alliance.myalliance.editbutton";
         _temp_26.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_editButton);
         _quitButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _quitButton.width = 200;
         var _temp_28:* = _quitButton;
         var _loc8_:String = "ui.windows.alliance.myalliance.quitbutton";
         _temp_28.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(_quitButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         coaBackground.x = 25;
         coaBackground.y = 32;
         MobileAlignmentUtil.alignAccordingToPositionOf(allianceCOA,coaBackground,37,25);
         MobileAlignmentUtil.alignAccordingToPositionOf(nameTF,coaBackground,coaBackground.width + 60,7);
         MobileAlignmentUtil.alignBelowOf(leaderLabel,nameTF,10);
         MobileAlignmentUtil.alignBelowOf(pointsLabel,leaderLabel,6);
         MobileAlignmentUtil.alignBelowOf(rankingLabel,pointsLabel,6);
         MobileAlignmentUtil.alignBelowOf(membershipTypeTF,rankingLabel,6);
         MobileAlignmentUtil.alignRightWithYMarginOf(leaderTF,leaderLabel,2,14);
         MobileAlignmentUtil.alignBelowOf(pointsTF,leaderTF,6);
         MobileAlignmentUtil.alignBelowOf(rankingTF,pointsTF,6);
         MobileAlignmentUtil.alignAccordingToPositionOf(minLevelLabel,leaderLabel,320,0);
         MobileAlignmentUtil.alignBelowOf(minScoreLabel,minLevelLabel,6);
         MobileAlignmentUtil.alignBelowOf(membersLabel,minScoreLabel,6);
         MobileAlignmentUtil.alignRightWithYMarginOf(minLevelTF,minLevelLabel,2,19);
         MobileAlignmentUtil.alignBelowOf(minScoreTF,minLevelTF,6);
         MobileAlignmentUtil.alignBelowOf(membersTF,minScoreTF,6);
         MobileAlignmentUtil.alignBelowOf(descriptionBackground,coaBackground,29);
         MobileAlignmentUtil.alignAccordingToPositionOf(descriptionTextField,descriptionBackground,30,10);
         _quitButton.x = 545;
         _quitButton.y = 540;
         MobileAlignmentUtil.alignRightOf(_editButton,_quitButton,25);
      }
      
      private function createAndAddDisplayObject(param1:String, param2:int, param3:int) : DisplayObject
      {
         var _loc4_:DisplayObject = assetRepository.getDisplayObject(param1);
         _loc4_.width = param2;
         _loc4_.height = param3;
         addChild(_loc4_);
         return _loc4_;
      }
      
      private function createAndAddWomTF(param1:String, param2:int = -1, param3:int = -1, param4:Boolean = false, param5:int = -1) : MobileWomTextField
      {
         param5 = param5 == -1 ? 16777215 : param5;
         var _loc6_:MobileWomTextField = new MobileWomTextField();
         _loc6_.textRendererProperties.textFormat = getWomTextFormat(25,param4 ? "right" : "left",param5);
         if(param2 != -1)
         {
            _loc6_.width = param2;
         }
         if(param3 != -1)
         {
            _loc6_.height = param3;
         }
         addChild(_loc6_);
         _loc6_.text = param1;
         return _loc6_;
      }
      
      private function createAndAddWomCaptionTF(param1:String, param2:int = -1, param3:int = -1, param4:int = -1) : MobileCaptionTextField
      {
         param4 = param4 < 1 ? 25 : param4;
         var _loc5_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc5_.textRendererProperties.textFormat = getCaptionTextFormat(param4);
         if(param2 != -1)
         {
            _loc5_.width = param2;
         }
         if(param3 != -1)
         {
            _loc5_.height = param3;
         }
         addChild(_loc5_);
         _loc5_.text = param1;
         return _loc5_;
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
      
      public function get editButton() : MobileWomButton
      {
         return _editButton;
      }
      
      public function get quitButton() : MobileWomButton
      {
         return _quitButton;
      }
      
      public function get fromBrowseTab() : Boolean
      {
         return _fromBrowseTab;
      }
      
      public function get allianceDetail() : AllianceDetailInfo
      {
         return _allianceDetail;
      }
   }
}

