package wom.view.screen.windows.alliance.mobile
{
   import feathers.controls.text.StageTextTextEditor;
   import feathers.core.ITextEditor;
   import feathers.core.ToggleGroup;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRadioButton;
   import peak.component.mobile.MPTextArea;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.AllianceDetailInfo;
   import wom.model.game.alliance.AllianceMembershipType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomCheckBox;
   import wom.view.component.MobileWomTextArea;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.alliance.coa.mobile.MobileEditCoatOfArmsPanel;
   
   public class MobileCreateAlliancePanel extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _allianceId:Number;
      
      private var _editModeOn:Boolean;
      
      private var background:DisplayObject;
      
      private var allianceNameLabel:MPTextField;
      
      private var _allianceNameInput:MobileWomTextInput;
      
      private var _membershipTypeRadioGroup:ToggleGroup;
      
      private var _openRadioButton:MPRadioButton;
      
      private var _invitationOnlyRadioButton:MPRadioButton;
      
      private var _closedRadioButton:MPRadioButton;
      
      private var _membershipTypesForRadioButtons:Dictionary;
      
      private var minScoreLabel:MPTextField;
      
      private var minLevelLabel:MPTextField;
      
      private var _minScoreCheckBox:MobileWomCheckBox;
      
      private var _minLevelCheckBox:MobileWomCheckBox;
      
      private var _minScoreInput:MobileWomTextInput;
      
      private var _minLevelInput:MobileWomTextInput;
      
      private var _descriptionTextArea:MPTextArea;
      
      private var editCoaPanel:MobileEditCoatOfArmsPanel;
      
      private var _widthDifference:int;
      
      private var _saveButton:MPButton;
      
      private var _cancelButton:MPButton;
      
      private const ALLIANCE_NAME_INPUT_WIDTH:int = 370;
      
      private const MINIMUM_SCORE_LEVEL_INPUT_WIDTH:int = 218;
      
      private const DESCRIPTION_WIDTH:int = 710;
      
      private const DESCRIPTION_HEIGHT:int = 177;
      
      private const lineRegex:RegExp = /[\r\n]/gm;
      
      public function MobileCreateAlliancePanel(param1:Boolean, param2:int)
      {
         super();
         _editModeOn = param1;
         _widthDifference = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _allianceId = -1;
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = 999 + _widthDifference;
         background.height = _editModeOn ? 671 : 627;
         addChild(background);
         _allianceNameInput = createAndAddTextInput(370,"A-Za-z0-9 _\\-şŞçÇğĞöÖüÜıİ",13,"inp1");
         _allianceNameInput.isEditable = !_editModeOn;
         _allianceNameInput.paddingTop = 8;
         var _loc1_:String = "m.ui.windows.alliance.browse.create.alliancename";
         allianceNameLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc1_),getCaptionTextFormat(25,"right"));
         _membershipTypesForRadioButtons = new Dictionary();
         _membershipTypeRadioGroup = new ToggleGroup();
         var _loc2_:String = AllianceMembershipType.OPEN.mobileI18nKey;
         _openRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc2_),115,AllianceMembershipType.OPEN);
         var _loc3_:String = AllianceMembershipType.INVITATION.mobileI18nKey;
         _invitationOnlyRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc3_),158,AllianceMembershipType.INVITATION);
         var _loc4_:String = AllianceMembershipType.CLOSED.mobileI18nKey;
         _closedRadioButton = createAndAddAllianceTypeRadioButton(peak.i18n.PText.INSTANCE.getText0(_loc4_),120,AllianceMembershipType.CLOSED);
         _openRadioButton.isSelected = true;
         var _loc5_:String = "ui.windows.alliance.browse.create.minscore";
         minScoreLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc5_),getCaptionTextFormat(25,"right"));
         _minScoreCheckBox = createAndAddCheckBox();
         _minScoreInput = createAndAddTextInput(218,"0-9",5,"inp2");
         _minScoreInput.textEditorFactory = stageTextEditorFactory;
         _minScoreInput.textEditorProperties.softKeyboardType = "number";
         _minScoreInput.paddingTop = 8;
         var _loc6_:String = "ui.windows.alliance.browse.create.minlevel";
         minLevelLabel = createAndAddWomCaptionTF(peak.i18n.PText.INSTANCE.getText0(_loc6_),getCaptionTextFormat(25,"right"));
         _minLevelCheckBox = createAndAddCheckBox();
         _minLevelInput = createAndAddTextInput(218,"0-9",5,"inp3");
         _minLevelInput.textEditorFactory = stageTextEditorFactory;
         _minLevelInput.textEditorProperties.softKeyboardType = "number";
         _minLevelInput.paddingTop = 8;
         _descriptionTextArea = new MobileWomTextArea();
         _descriptionTextArea.width = 710;
         _descriptionTextArea.height = 177;
         _descriptionTextArea.maxChars = 250;
         _descriptionTextArea.verticalScrollPolicy = "off";
         _descriptionTextArea.inputId = "area1";
         addChild(_descriptionTextArea);
         editCoaPanel = new MobileEditCoatOfArmsPanel();
         addChild(editCoaPanel);
         _saveButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _saveButton.width = 140;
         var _temp_25:* = _saveButton;
         var _loc7_:String = "ui.windows.alliance.browse.create.save";
         _temp_25.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_saveButton);
         _cancelButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _cancelButton.width = 165;
         var _temp_27:* = _cancelButton;
         var _loc8_:String = "ui.windows.alliance.browse.create.cancel";
         _temp_27.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         addChild(_cancelButton);
      }
      
      private function stageTextEditorFactory() : ITextEditor
      {
         var _loc1_:StageTextTextEditor = new StageTextTextEditor();
         _loc1_.fontFamily = "BlambotFXProLightBB";
         _loc1_.fontSize = 27;
         return _loc1_;
      }
      
      private function createAndAddCheckBox() : MobileWomCheckBox
      {
         var _loc1_:MobileWomCheckBox = new MobileWomCheckBox();
         _loc1_.label = "";
         _loc1_.width = 50;
         addChild(_loc1_);
         return _loc1_;
      }
      
      private function createAndAddTextInput(param1:int, param2:String = null, param3:Object = null, param4:String = "") : MobileWomTextInput
      {
         var _loc5_:MobileWomTextInput = new MobileWomTextInput();
         _loc5_.width = param1;
         _loc5_.height = 52;
         _loc5_.restrict = param2;
         if(param3)
         {
            _loc5_.maxChars = param3 as int;
         }
         _loc5_.inputId = param4;
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function createAndAddWomCaptionTF(param1:String, param2:MPBitmapFontTextFormat) : MPTextField
      {
         var _loc3_:MPTextField = new MobileCaptionTextField();
         _loc3_.textRendererProperties.textFormat = param2;
         addChild(_loc3_);
         _loc3_.text = param1;
         return _loc3_;
      }
      
      private function createAndAddAllianceTypeRadioButton(param1:String, param2:int, param3:AllianceMembershipType) : MPRadioButton
      {
         var _loc4_:MPRadioButton = new MPRadioButton();
         _loc4_.defaultIcon = assetRepository.getDisplayObject("FormRadio");
         _loc4_.defaultSelectedIcon = assetRepository.getDisplayObject("FormRadioSelected");
         _loc4_.defaultLabelProperties.textFormat = getWomTextFormat(25,"left",16777215);
         _loc4_.label = param1;
         _loc4_.toggleGroup = _membershipTypeRadioGroup;
         _loc4_.width = param2;
         addChild(_loc4_);
         _membershipTypesForRadioButtons[_loc4_] = param3;
         return _loc4_;
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = _widthDifference >> 1;
         allianceNameLabel.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_allianceNameInput,background,135 + _loc2_,34);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(allianceNameLabel,_allianceNameInput,-allianceNameLabel.width - 12);
         minScoreLabel.validate();
         _minScoreCheckBox.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_minScoreInput,background,background.width - 21 - _minScoreInput.width - _loc2_,34);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minScoreCheckBox,_minScoreInput,-7 - _minScoreCheckBox.width);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(minScoreLabel,_minScoreCheckBox,-11 - minScoreLabel.width);
         minLevelLabel.validate();
         _minLevelCheckBox.validate();
         MobileAlignmentUtil.alignBelowOf(_minLevelInput,_minScoreInput,5);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_minLevelCheckBox,_minLevelInput,-7 - _minLevelCheckBox.width);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(minLevelLabel,_minLevelCheckBox,-11 - minLevelLabel.width);
         _openRadioButton.validate();
         _invitationOnlyRadioButton.validate();
         _closedRadioButton.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_openRadioButton,_allianceNameInput,-12,_allianceNameInput.height + 20);
         MobileAlignmentUtil.alignAccordingToPositionOf(_invitationOnlyRadioButton,_openRadioButton,118,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_closedRadioButton,_invitationOnlyRadioButton,158,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_descriptionTextArea,background,background.width - _descriptionTextArea.width - 21 - _loc2_,186);
         MobileAlignmentUtil.alignAccordingToPositionOf(editCoaPanel,background,20 + _loc2_,186);
         _saveButton.validate();
         _cancelButton.validate();
         var _loc1_:int = _saveButton.width + _cancelButton.width;
         _saveButton.x = background.width - _loc1_ - 15 >> 1;
         _saveButton.y = background.height - _saveButton.height - (_editModeOn ? 40 : 24);
         MobileAlignmentUtil.alignRightOf(_cancelButton,_saveButton,15);
      }
      
      public function getAllianceInfo() : AllianceDetailInfo
      {
         var _loc1_:int = int(_minScoreCheckBox.isSelected && _minScoreInput.text != null ? int(_minScoreInput.text) : -1);
         var _loc2_:int = int(_minLevelCheckBox.isSelected && _minLevelInput.text != null ? int(_minLevelInput.text) : -1);
         return new AllianceDetailInfo(_allianceId,_allianceNameInput.text,-1,-1,_membershipTypesForRadioButtons[_membershipTypeRadioGroup.selectedItem] as AllianceMembershipType,-1,_loc1_,_loc2_,_descriptionTextArea.text,editCoaPanel.getCOAInfo(),null);
      }
      
      public function updateWithAllianceInfo(param1:AllianceDetailInfo) : void
      {
         if(param1)
         {
            _allianceId = param1.id;
            _allianceNameInput.text = param1.name != null ? param1.name : "";
            selectMembershipTypeButton(param1.membershipType);
            _minScoreCheckBox.isSelected = param1.minScore != -1;
            _minScoreInput.text = param1.minScore != -1 ? param1.minScore.toString() : "";
            _minLevelCheckBox.isSelected = param1.minLevel != -1;
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
               _openRadioButton.isSelected = true;
               break;
            case AllianceMembershipType.INVITATION:
               _invitationOnlyRadioButton.isSelected = true;
               break;
            case AllianceMembershipType.CLOSED:
               _closedRadioButton.isSelected = true;
         }
      }
      
      public function onMembershipTypeSelectionUpdated() : void
      {
         var _loc1_:Boolean = _openRadioButton.isSelected == true;
         _minScoreCheckBox.isEnabled = _minLevelCheckBox.isEnabled = _minScoreInput.isEnabled = _minLevelInput.isEnabled = _loc1_;
         if(!_loc1_)
         {
            _minScoreCheckBox.isSelected = _minLevelCheckBox.isSelected = false;
            _minScoreCheckBox.isSelected = _minLevelCheckBox.isSelected = false;
            _minScoreInput.text = _minLevelInput.text = "";
         }
         checkConfirmButtonEnabling();
      }
      
      public function checkConfirmButtonEnabling(param1:Boolean = false, param2:Boolean = false, param3:Boolean = false, param4:Boolean = false) : void
      {
         var _loc7_:String = _allianceNameInput.text;
         var _loc6_:Boolean = _loc7_ != null && _loc7_.length >= 4 && _loc7_.length <= 13;
         updateScoreAndLevelAccordingToDependencies(param1,param2,param3,param4);
         var _loc5_:Boolean = _openRadioButton.isSelected != true || (!_minScoreCheckBox.isSelected || _minScoreInput.text != "") && (!_minLevelCheckBox.isSelected || _minLevelInput.text != "");
         _saveButton.isEnabled = _loc6_ && _loc5_;
      }
      
      private function updateScoreAndLevelAccordingToDependencies(param1:Boolean, param2:Boolean, param3:Boolean, param4:Boolean) : void
      {
         _minScoreInput.isEnabled = _minScoreCheckBox.isSelected;
         _minLevelInput.isEnabled = _minLevelCheckBox.isSelected;
         if(!_minScoreInput.isEnabled)
         {
            _minScoreInput.text = "";
         }
         else if(param1)
         {
            _minScoreInput.setFocus();
         }
         if(!_minLevelInput.isEnabled)
         {
            _minLevelInput.text = "";
         }
         else if(param2)
         {
            _minLevelInput.setFocus();
         }
      }
      
      public function checkDescriptionLineLength() : void
      {
         var _loc1_:String = _descriptionTextArea.text;
         while(_loc1_.split(lineRegex).length > 5)
         {
            _descriptionTextArea.text = _loc1_.substr(0,_loc1_.length - 1);
            _loc1_ = _descriptionTextArea.text;
         }
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         _allianceNameInput.isFocusEnabled = _allianceNameInput.visible = _minLevelInput.isFocusEnabled = _minLevelInput.visible = _minScoreInput.isFocusEnabled = _minScoreInput.visible = param1 && visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && _allianceNameInput && !_allianceNameInput.visible)
         {
            updateTabActivation(true);
         }
         super.visible = param1;
      }
      
      public function get membershipTypeRadioGroup() : ToggleGroup
      {
         return _membershipTypeRadioGroup;
      }
      
      public function get allianceNameInput() : MobileWomTextInput
      {
         return _allianceNameInput;
      }
      
      public function get minScoreInput() : MobileWomTextInput
      {
         return _minScoreInput;
      }
      
      public function get minLevelInput() : MobileWomTextInput
      {
         return _minLevelInput;
      }
      
      public function get saveButton() : MPButton
      {
         return _saveButton;
      }
      
      public function get cancelButton() : MPButton
      {
         return _cancelButton;
      }
      
      public function get minScoreCheckBox() : MobileWomCheckBox
      {
         return _minScoreCheckBox;
      }
      
      public function get minLevelCheckBox() : MobileWomCheckBox
      {
         return _minLevelCheckBox;
      }
      
      public function get descriptionTextArea() : MPTextArea
      {
         return _descriptionTextArea;
      }
      
      public function get editModeOn() : Boolean
      {
         return _editModeOn;
      }
   }
}

