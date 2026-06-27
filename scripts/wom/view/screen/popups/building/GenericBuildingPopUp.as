package wom.view.screen.popups.building
{
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.util.GenericWindow;
   
   public class GenericBuildingPopUp extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 646;
      
      private static const WINDOW_HEIGHT:int = 222;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _level:int;
      
      private var _buildingSilhouette:AssetDisplayObject;
      
      private var levelBackground:AssetDisplayObject;
      
      private var levelTitleTextField:TextField;
      
      private var levelUpgradeAsset:AssetDisplayObject;
      
      private var levelTextField:TextField;
      
      protected var messageField:TextField;
      
      private var _bragToYourFriendsButton:WomButton;
      
      public function GenericBuildingPopUp(param1:BuildingTypeDIO, param2:int, param3:int = 646, param4:int = 222)
      {
         super(param3,param4);
         _buildingTypeDIO = param1;
         _level = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _buildingSilhouette = assetRepository.getDisplayObject(_buildingTypeDIO.silhouetteVisuals[_level - 1]);
         addChildAt(_buildingSilhouette,getChildIndex(_windowHeader) - 1);
         levelBackground = assetRepository.getDisplayObject("BackgroundDark");
         levelBackground.width = 114;
         levelBackground.height = 40;
         addChild(levelBackground);
         levelTitleTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         levelTitleTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         levelTitleTextField.autoSize = "left";
         addChild(levelTitleTextField);
         var _temp_4:* = levelTitleTextField;
         var _loc1_:String = "ui.popups.building.level";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         levelUpgradeAsset = assetRepository.getDisplayObject("Upgrade");
         addChild(levelUpgradeAsset);
         levelTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         levelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         levelTextField.autoSize = "left";
         addChild(levelTextField);
         levelTextField.text = "" + _level;
         messageField = new WomTextField();
         messageField.multiline = true;
         messageField.wordWrap = true;
         messageField.width = 430;
         messageField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         addChild(messageField);
         _bragToYourFriendsButton = new WomBlueLargeButton();
         _bragToYourFriendsButton.width = 289;
         var _temp_9:* = _bragToYourFriendsButton;
         var _loc2_:String = "ui.popups.building.bragtoyourfriends";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_bragToYourFriendsButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _buildingSilhouette.x = 180 - _buildingSilhouette.width;
         _buildingSilhouette.y = 238 - _buildingSilhouette.height;
         AlignmentUtil.alignAccordingToPositionOf(levelBackground,_background,193,45);
         AlignmentUtil.alignAccordingToPositionOf(messageField,_background,193,105);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(levelTitleTextField,levelBackground,17);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(levelUpgradeAsset,levelBackground,94);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(levelTextField,levelUpgradeAsset,22);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_bragToYourFriendsButton,_background,189);
      }
      
      public function get buildingSilhouette() : AssetDisplayObject
      {
         return _buildingSilhouette;
      }
      
      public function get bragToYourFriendsButton() : WomButton
      {
         return _bragToYourFriendsButton;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get level() : int
      {
         return _level;
      }
   }
}

