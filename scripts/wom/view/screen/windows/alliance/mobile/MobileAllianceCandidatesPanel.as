package wom.view.screen.windows.alliance.mobile
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextInput;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   
   public class MobileAllianceCandidatesPanel extends Sprite implements View
   {
      
      private static const WIDTH:int = 1006;
      
      private static const HEIGHT:int = 678;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var listBackground:DisplayObject;
      
      private var _searchBackground:DisplayObject;
      
      private var _searchTextInput:MPTextInput;
      
      private var _searchButton:MPButton;
      
      private var _cancelSearchButton:MPButton;
      
      private var _listPanel:MobileAllianceCandidatesListPanel;
      
      private var _searchPanel:MobileAllianceCandidatesListPanel;
      
      private var _widthDifference:int;
      
      public function MobileAllianceCandidatesPanel(param1:int)
      {
         super();
         _widthDifference = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _searchBackground = assetRepository.getDisplayObject("MobileInnerBeigeBackground");
         var _temp_2:* = _searchBackground;
         var _loc1_:MobileAllianceMembersPanel = MobileAllianceMembersPanel;
         _temp_2.width = 1000 + _widthDifference;
         _searchBackground.height = 75;
         addChild(_searchBackground);
         _searchTextInput = new MobileWomTextInput();
         _searchTextInput.width = 455;
         _searchTextInput.restrict = "0-9";
         _searchTextInput.maxChars = 20;
         addChild(_searchTextInput);
         _searchTextInput.promptProperties.textFormat = getWomTextFormat(30,"left",8882055);
         var _temp_4:* = _searchTextInput;
         var _loc2_:String = "ui.windows.alliance.candidates.insertid";
         _temp_4.prompt = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _searchButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _searchButton.width = 71;
         _searchButton.defaultIcon = assetRepository.getDisplayObject("SymbolSearch");
         addChild(_searchButton);
         _cancelSearchButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _cancelSearchButton.width = 71;
         _cancelSearchButton.label = "X";
         _cancelSearchButton.visible = false;
         addChild(_cancelSearchButton);
         listBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         listBackground.width = 1000 + _widthDifference;
         listBackground.height = 574;
         addChild(listBackground);
         _listPanel = new MobileAllianceCandidatesListPanel(_widthDifference);
         addChild(_listPanel);
         _searchPanel = new MobileAllianceCandidatesListPanel(_widthDifference,true);
         _searchPanel.visible = false;
         addChild(_searchPanel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _searchBackground.x = 0;
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchTextInput,_searchBackground,11);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_searchButton,_searchBackground,446);
         MobileAlignmentUtil.alignRightOf(_cancelSearchButton,_searchButton,5);
         MobileAlignmentUtil.alignBelowOf(listBackground,_searchBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(_listPanel,listBackground,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_searchPanel,listBackground,0);
      }
      
      public function activateSearchedCandidatesPanel() : void
      {
         _listPanel.visible = false;
         _searchPanel.visible = true;
         _cancelSearchButton.visible = true;
      }
      
      public function activateCandidatesListPanel() : void
      {
         _listPanel.visible = true;
         _searchPanel.visible = false;
         _cancelSearchButton.visible = false;
      }
      
      public function updateTabActivation(param1:Boolean) : void
      {
         _searchTextInput.isFocusEnabled = _searchTextInput.isEnabled = _searchTextInput.visible = param1;
      }
      
      public function get searchTextInput() : MPTextInput
      {
         return _searchTextInput;
      }
      
      public function get searchButton() : MPButton
      {
         return _searchButton;
      }
      
      public function get cancelSearchButton() : MPButton
      {
         return _cancelSearchButton;
      }
   }
}

