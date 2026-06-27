package wom.view.screen.windows.alliance
{
   import fl.controls.Button;
   import fl.controls.TextInput;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.view.component.SearchTextInputNoIcon;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomRedSmallButton;
   import wom.view.util.BaseWindowPanel;
   
   public class AllianceCandidatesPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 665;
      
      private static const HEIGHT:int = 443;
      
      private var _inviteTextField:TextField;
      
      private var _searchBackground:DisplayObject;
      
      private var _searchTextInput:TextInput;
      
      private var _searchButton:Button;
      
      private var _searchCancelButton:Button;
      
      private var _listPanel:AllianceCandidatesListPanel;
      
      private var _searchPanel:AllianceCandidatesListPanel;
      
      public function AllianceCandidatesPanel()
      {
         super(665,443);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _inviteTextField = new WomTextField();
         _inviteTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_22;
         _inviteTextField.autoSize = "left";
         var _temp_2:* = _inviteTextField;
         var _loc1_:String = "ui.windows.alliance.candidates.invite";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_inviteTextField);
         _searchBackground = assetRepository.getDisplayObject("BackgroundWhite");
         _searchBackground.width = 140;
         _searchBackground.height = 32;
         addChild(_searchBackground);
         _searchTextInput = new SearchTextInputNoIcon();
         _searchTextInput.width = 140;
         _searchTextInput.restrict = "0-9";
         _searchTextInput.maxChars = 20;
         _searchTextInput.setStyle("textFormat",WomTextFormats.WOM_LIGHT_GREY_16);
         var _temp_5:* = _searchTextInput;
         var _loc2_:String = "ui.windows.alliance.candidates.insertid";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_searchTextInput);
         _searchButton = new WomBlueSmallButton();
         _searchButton.width = 32;
         _searchButton.setStyle("icon",assetRepository.getDisplayObject("IconSearch"));
         addChild(_searchButton);
         _searchCancelButton = new WomRedSmallButton();
         _searchCancelButton.width = 32;
         _searchCancelButton.setStyle("icon",assetRepository.getDisplayObject("IconCancel"));
         _searchCancelButton.visible = false;
         addChild(_searchCancelButton);
         _listPanel = new AllianceCandidatesListPanel();
         addChild(_listPanel);
         _searchPanel = new AllianceCandidatesListPanel(true);
         _searchPanel.visible = false;
         addChild(_searchPanel);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_inviteTextField,bg,20,12);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchBackground,_inviteTextField,_inviteTextField.width + 20);
         AlignmentUtil.alignAccordingToPositionOf(_searchTextInput,_searchBackground,0,0);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchButton,_searchBackground,_searchBackground.width);
         AlignmentUtil.alignRightOf(_searchCancelButton,_searchButton,2);
         AlignmentUtil.alignAccordingToPositionOf(_listPanel,bg,2,46);
         AlignmentUtil.alignAccordingToPositionOf(_searchPanel,bg,2,46);
         super.drawLayout();
      }
      
      public function activateSearchedCandidatesPanel() : void
      {
         _listPanel.visible = false;
         _searchPanel.visible = true;
         _searchCancelButton.visible = true;
      }
      
      public function activateCandidatesListPanel() : void
      {
         _listPanel.visible = true;
         _searchPanel.visible = false;
         _searchCancelButton.visible = false;
      }
      
      public function searchTextInputClickedForTheFirstTime() : void
      {
         _searchTextInput.text = "";
         _searchTextInput.setStyle("textFormat",WomTextFormats.WOM_18);
      }
      
      public function get searchButton() : Button
      {
         return _searchButton;
      }
      
      public function get searchCancelButton() : Button
      {
         return _searchCancelButton;
      }
      
      public function get searchTextInput() : TextInput
      {
         return _searchTextInput;
      }
   }
}

