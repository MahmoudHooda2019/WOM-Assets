package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import fl.controls.RadioButtonGroup;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceMembershipType;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomCheckBox;
   import wom.view.component.WomRadioButton;
   import wom.view.component.WomTextArea;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.WomTextInput;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.component.button.rigid.QuestHintButton;
   import wom.view.screen.windows.alliance.coa.EditCoatOfArmsPanel;
   import wom.view.ui.mainframe.city.tooltip.AttachableTooltipView;
   import wom.view.util.BaseWindowPanel;
   import wom.view.util.LineUtil;
   
   public class CreateAlliancePanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private var _allianceId:Number;
      
      private var _editModeOn:Boolean;
      
      private var modeTF:WomTextField;
      
      private var allianceNameTF:WomTextField;
      
      private var horizontalLine:Sprite;
      
      private var allianceNameLabel:WomTextField;
      
      private var _allianceNameInput:WomTextInput;
      
      private var _helpButton:QuestHintButton;
      
      private var helpTooltip:AttachableTooltipView;
      
      private var allianceTypeLabel:WomTextField;
      
      private var _membershipTypeRadioGroup:RadioButtonGroup;
      
      private var _openRadioButton:WomRadioButton;
      
      private var _invitationOnlyRadioButton:WomRadioButton;
      
      private var _closedRadioButton:WomRadioButton;
      
      private var minScoreLabel:WomTextField;
      
      private var minLevelLabel:WomTextField;
      
      private var _minScoreCheckBox:WomCheckBox;
      
      private var _minLevelCheckBox:WomCheckBox;
      
      private var _minScoreInput:WomTextInput;
      
      private var _minLevelInput:WomTextInput;
      
      private var _descriptionTextArea:WomTextArea;
      
      private var editCoaPanel:EditCoatOfArmsPanel;
      
      private var _saveButton:Button;
      
      private var _cancelButton:Button;
      
      private const ALLIANCE_NAME_INPUT_WIDTH:int = 370;
      
      private const MINIMUM_SCORE_LEVEL_INPUT_WIDTH:int = 90;
      
      private const DESCRIPTION_WIDTH:int = 620;
      
      private const DESCRIPTION_HEIGHT:int = 107;
      
      private const ALLIANCE_TYPE_RADIO_GROUP:String = "AllianceType";
      
      public function CreateAlliancePanel(param1:Boolean)
      {
         super(665,443);
         _editModeOn = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _allianceId = -1;
         horizontalLine = createAndAddHorizontalLine();
         var _loc1_:String;
         var _loc2_:String;
         modeTF = createAndAddWomTF(_editModeOn ? (_loc1_ = "ui.windows.alliance.browse.create.editheader",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "ui.windows.alliance.browse.create.createheader",peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         allianceNameTF = createAndAddWomCaptionTF("",WomTextFormats.CAPTION_24);
         _allianceNameInput = createAndAddTextInput(370,"A-Za-z0-9 _\\-şŞçÇğĞöÖüÜıİ",13,"inp1");
         _allianceNameInput.editable = !_editModeOn;
         var _loc3_:String = "ui.windows.alliance.browse.create.alliancename";
         allianceNameLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc3_),WomTextFormats.CAPTION_16);
         var _loc4_:String = "ui.windows.alliance.browse.create.membership";
         allianceTypeLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc4_),WomTextFormats.CAPTION_16);
         _helpButton = new QuestHintButton();
         addChild(_helpButton);
         var _temp_13:* = §§findproperty(AttachableTooltipView);
         var _temp_12:* = this;
         var _temp_11:* = _helpButton;
         var _loc5_:String = "ui.windows.alliance.browse.create.help";
         helpTooltip = new AttachableTooltipView(_temp_12,_temp_11,peak.i18n.PText.INSTANCE.getText0(_loc5_),WomTextFormats.FONT_SIZE_14);
         _membershipTypeRadioGroup = new RadioButtonGroup("AllianceType");
         var _loc6_:String = AllianceMembershipType.OPEN.i18nKey;
         _openRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc6_),80,AllianceMembershipType.OPEN);
         var _loc7_:String = AllianceMembershipType.INVITATION.i18nKey;
         _invitationOnlyRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc7_),155,AllianceMembershipType.INVITATION);
         var _loc8_:String = AllianceMembershipType.CLOSED.i18nKey;
         _closedRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc8_),90,AllianceMembershipType.CLOSED);
         _openRadioButton.selected = true;
         var _loc9_:String = "ui.windows.alliance.browse.create.minscore";
         minScoreLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc9_),WomTextFormats.CAPTION_16,88);
         _minScoreCheckBox = createAndAddCheckBox();
         _minScoreInput = createAndAddTextInput(90,"0-9",5,"inp2");
         var _loc10_:String = "ui.windows.alliance.browse.create.minlevel";
         minLevelLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc10_),WomTextFormats.CAPTION_16,93);
         _minLevelCheckBox = createAndAddCheckBox();
         _minLevelInput = createAndAddTextInput(90,"0-9",5,"inp3");
         _descriptionTextArea = new WomTextArea();
         _descriptionTextArea.width = 620;
         _descriptionTextArea.height = 107;
         _descriptionTextArea.setStyle("textFormat",WomTextFormats.WOM_22);
         _descriptionTextArea.maxChars = 250;
         _descriptionTextArea.verticalScrollPolicy = "off";
         _descriptionTextArea.inputId = "area1";
         _descriptionTextArea.externalInputEnabled = true;
         addChild(_descriptionTextArea);
         editCoaPanel = new EditCoatOfArmsPanel();
         addChild(editCoaPanel);
         _saveButton = new WomBlueLargeButton();
         _saveButton.width = 112;
         var _temp_33:* = _saveButton;
         var _loc11_:String = "ui.windows.alliance.browse.create.save";
         _temp_33.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         addChild(_saveButton);
         _cancelButton = new WomRedLargeButton();
         _cancelButton.width = 122;
         var _temp_35:* = _cancelButton;
         var _loc12_:String = "ui.windows.alliance.browse.create.cancel";
         _temp_35.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
         addChild(_cancelButton);
         drawLayout();
      }
      
      private function createAndAddHorizontalLine() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         LineUtil.drawHorizontalSeparatorLine(_loc1_,0,_visibleWidth - 4);
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createAndAddCheckBox() : WomCheckBox
      {
         var _loc1_:WomCheckBox = new WomCheckBox();
         _loc1_.label = "";
         _loc1_.width = 25;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createAndAddTextInput(param1:int, param2:String = null, param3:Object = null, param4:String = "") : WomTextInput
      {
         var _loc5_:WomTextInput = new WomTextInput();
         _loc5_.width = param1;
         _loc5_.height = 32;
         _loc5_.restrict = param2;
         if(param3)
         {
            _loc5_.maxChars = param3 as int;
         }
         _loc5_.inputId = param4;
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function createAndAddWomTF(param1:String) : WomTextField
      {
         var _loc2_:WomTextField = new WomTextField();
         _loc2_.defaultTextFormat = WomTextFormats.FONT_SIZE_22;
         _loc2_.autoSize = "left";
         _loc2_.text = param1;
         addChild(_loc2_);
         return _loc2_;
      }
      
      private function createAndAddWomCaptionTF(param1:String, param2:TextFormat, param3:Number = NaN) : WomTextField
      {
         var _loc4_:WomTextField = new CaptionTextField();
         _loc4_.defaultTextFormat = param2;
         if(!isNaN(param3))
         {
            _loc4_.multiline = true;
            _loc4_.wordWrap = true;
         }
         _loc4_.autoSize = "left";
         if(!isNaN(param3))
         {
            _loc4_.width = param3;
         }
         addChild(_loc4_);
         _loc4_.text = param1;
         return _loc4_;
      }
      
      private function createAndAddAllianceTypeRadioButton(param1:String, param2:int, param3:AllianceMembershipType) : WomRadioButton
      {
         var _loc4_:WomRadioButton = new WomRadioButton();
         _loc4_.setStyle("textFormat",WomTextFormats.WOM_22);
         _loc4_.label = param1;
         _loc4_.group = _membershipTypeRadioGroup;
         _loc4_.width = param2;
         _loc4_.value = param3;
         addChild(_loc4_);
         _membershipTypeRadioGroup.addRadioButton(_loc4_);
         return _loc4_;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         modeTF.x = 20;
         modeTF.y = 10;
         horizontalLine.x = 2;
         horizontalLine.y = 46;
         AlignmentUtil.alignRightOf(allianceNameTF,modeTF,20);
         AlignmentUtil.alignBelowOf(allianceNameLabel,modeTF,30);
         AlignmentUtil.alignAccordingToPositionOf(_allianceNameInput,allianceNameLabel,allianceNameLabel.width + 25,-6);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_helpButton,_allianceNameInput,_allianceNameInput.width + 5);
         helpTooltip.updateTooltipAlignmentAccordingToObject(-helpTooltip.width / 2,-helpTooltip.height);
         AlignmentUtil.alignBelowOf(allianceTypeLabel,allianceNameLabel,22);
         AlignmentUtil.alignAccordingToPositionOf(_openRadioButton,_allianceNameInput,-3,_allianceNameInput.height + 14);
         AlignmentUtil.alignRightOf(_invitationOnlyRadioButton,_openRadioButton,10);
         AlignmentUtil.alignRightOf(_closedRadioButton,_invitationOnlyRadioButton,10);
         AlignmentUtil.alignBelowOf(minScoreLabel,allianceTypeLabel,20);
         AlignmentUtil.alignBelowOf(_minScoreCheckBox,_openRadioButton,17);
         AlignmentUtil.alignAccordingToPositionOf(_minScoreInput,_minScoreCheckBox,_minScoreCheckBox.width + 10,-3);
         AlignmentUtil.alignAccordingToPositionOf(minLevelLabel,minScoreLabel,265,0);
         AlignmentUtil.alignAccordingToPositionOf(_minLevelCheckBox,_minScoreCheckBox,270,0);
         AlignmentUtil.alignAccordingToPositionOf(_minLevelInput,_minScoreInput,270,0);
         AlignmentUtil.alignBelowOf(_descriptionTextArea,minScoreLabel,12);
         AlignmentUtil.alignBelowOf(editCoaPanel,_descriptionTextArea,8);
         var _loc1_:int = _saveButton.width + _cancelButton.width;
         _saveButton.x = int((_visibleWidth - _loc1_ - 5) / 2);
         _saveButton.y = _visibleHeight - _saveButton.height / 2 + 14;
         AlignmentUtil.alignRightOf(_cancelButton,_saveButton,5);
      }
      
      public function getAllianceInfo() : AllianceDetailInfo
      {
         var _loc1_:int = int(_minScoreCheckBox.selected && _minScoreInput.text != null ? int(_minScoreInput.text) : -1);
         var _loc2_:int = int(_minLevelCheckBox.selected && _minLevelInput.text != null ? int(_minLevelInput.text) : -1);
         return new AllianceDetailInfo(_allianceId,_allianceNameInput.text,-1,-1,_membershipTypeRadioGroup.selection.value as AllianceMembershipType,-1,_loc1_,_loc2_,_descriptionTextArea.text,editCoaPanel.getCOAInfo(),null);
      }
      
      public function updateWithAllianceInfo(param1:AllianceDetailInfo) : void
      {
         if(param1)
         {
            _allianceId = param1.id;
            allianceNameTF.text = param1.name != null ? param1.name : "";
            _allianceNameInput.text = param1.name != null ? param1.name : "";
            selectMembershipTypeButton(param1.membershipType);
            _minScoreCheckBox.selected = param1.minScore != -1;
            _minScoreInput.text = param1.minScore != -1 ? param1.minScore.toString() : "";
            _minLevelCheckBox.selected = param1.minLevel != -1;
            _minLevelInput.text = param1.minLevel != -1 ? param1.minLevel.toString() : "";
            _descriptionTextArea.text = param1.description != null ? param1.description : "";
            editCoaPanel.updateWithCOAInfo(param1.coatOfArmsInfo);
            onMembershipTypeSelectionUpdated();
         }
      }
      
      private function selectMembershipTypeButton(param1:AllianceMembershipType) : void
      {
         switch(param1)
         {
            case AllianceMembershipType.OPEN:
               _openRadioButton.selected = true;
               break;
            case AllianceMembershipType.INVITATION:
               _invitationOnlyRadioButton.selected = true;
               break;
            case AllianceMembershipType.CLOSED:
               _closedRadioButton.selected = true;
         }
      }
      
      public function onMembershipTypeSelectionUpdated() : void
      {
         var _loc1_:Boolean = _membershipTypeRadioGroup.selection.value == AllianceMembershipType.OPEN;
         _minScoreCheckBox.enabled = _minLevelCheckBox.enabled = _minScoreInput.enabled = _minLevelInput.enabled = _loc1_;
         if(!_loc1_)
         {
            _minScoreCheckBox.selected = _minLevelCheckBox.selected = false;
            _minScoreCheckBox.enabled = _minLevelCheckBox.enabled = false;
            _minScoreInput.text = _minLevelInput.text = "";
         }
         checkConfirmButtonEnabling();
      }
      
      public function checkConfirmButtonEnabling(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc7_:String = _allianceNameInput.text;
         var _loc6_:Boolean = _loc7_ != null && _loc7_.length >= 4 && _loc7_.length <= 13;
         updateScoreAndLevelAccordingToDependencies(param1,param2,param3,param4);
         var _loc5_:Boolean = _membershipTypeRadioGroup.selection.value != AllianceMembershipType.OPEN || (!_minScoreCheckBox.selected || _minScoreInput.text != "") && (!_minLevelCheckBox.selected || _minLevelInput.text != "");
         _saveButton.enabled = _loc6_ && _loc5_;
      }
      
      private function updateScoreAndLevelAccordingToDependencies(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         _minScoreInput.enabled = _minScoreCheckBox.selected;
         _minLevelInput.enabled = _minLevelCheckBox.selected;
         if(!_minScoreInput.enabled)
         {
            _minScoreInput.text = "";
            if(stage.focus == _minScoreInput.textField)
            {
               stage.focus = _allianceNameInput;
            }
         }
         else if(param1)
         {
            stage.focus = _minScoreInput;
         }
         if(!_minLevelInput.enabled)
         {
            _minLevelInput.text = "";
            if(stage.focus == _minLevelInput.textField)
            {
               stage.focus = _allianceNameInput;
            }
         }
         else if(param2)
         {
            stage.focus = _minLevelInput;
         }
         if(param3)
         {
            _minScoreCheckBox.selected = _minScoreInput.enabled = true;
            stage.focus = _minScoreInput;
         }
         if(param4)
         {
            _minLevelCheckBox.selected = _minLevelInput.enabled = true;
            stage.focus = _minLevelInput;
         }
         _allianceNameInput.text = _allianceNameInput.text.toUpperCase();
      }
      
      public function checkDescriptionLineLength() : void
      {
         var _loc1_:String = null;
         var _loc2_:TextField = _descriptionTextArea.textField;
         var _loc3_:int = 0;
         while(_loc2_.numLines > 5)
         {
            _loc1_ = _loc2_.text;
            _descriptionTextArea.text = _loc1_.substr(0,_loc1_.length - _loc2_.getLineText(_loc2_.numLines - 1).length);
            if(_loc1_.length == _loc3_)
            {
               _descriptionTextArea.text = _loc1_.substr(0,_loc1_.length - 1);
            }
            _loc3_ = _loc1_.length;
         }
      }
      
      public function get membershipTypeRadioGroup() : RadioButtonGroup
      {
         return _membershipTypeRadioGroup;
      }
      
      public function get allianceNameInput() : WomTextInput
      {
         return _allianceNameInput;
      }
      
      public function get minScoreInput() : WomTextInput
      {
         return _minScoreInput;
      }
      
      public function get minLevelInput() : WomTextInput
      {
         return _minLevelInput;
      }
      
      public function get saveButton() : Button
      {
         return _saveButton;
      }
      
      public function get cancelButton() : Button
      {
         return _cancelButton;
      }
      
      public function get minScoreCheckBox() : WomCheckBox
      {
         return _minScoreCheckBox;
      }
      
      public function get minLevelCheckBox() : WomCheckBox
      {
         return _minLevelCheckBox;
      }
      
      public function get descriptionTextArea() : WomTextArea
      {
         return _descriptionTextArea;
      }
      
      public function get editModeOn() : Boolean
      {
         return _editModeOn;
      }
   }
}

