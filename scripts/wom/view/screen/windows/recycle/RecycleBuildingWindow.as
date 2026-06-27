package wom.view.screen.windows.recycle
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomRedLargeButton;
   import wom.view.ui.common.ResourceGroupView;
   import wom.view.util.GenericWindow;
   
   public class RecycleBuildingWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 734;
      
      private static const WINDOW_HEIGHT:int = 378;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingAsset:DisplayObject;
      
      private var currentLevelBackground:DisplayObject;
      
      private var gainsBackground:DisplayObject;
      
      private var currentLevelLabel:TextField;
      
      private var currentLevelIcon:DisplayObject;
      
      private var currentLevelTF:TextField;
      
      private var functionHeader:TextField;
      
      private var descriptionTextField:TextField;
      
      private var gainLabel:TextField;
      
      private var resourceGroupView:ResourceGroupView;
      
      private var _recycleButton:Button;
      
      public function RecycleBuildingWindow(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         super(734,378);
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _buildingAsset = assetRepository.getDisplayObject(_buildingTypeDIO.silhouetteVisuals[_buildingInfo.level - 1]);
         addChild(_buildingAsset);
         var _temp_2:* = "ui.windows.recycle.header";
         var _loc2_:String = "domain.building." + _buildingInfo.buildingTypeId + ".name";
         var _loc3_:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc4_:String = _temp_2;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_));
         currentLevelLabel = new CaptionTextField();
         var _loc1_:TextFormat = currentLevelLabel.getTextFormat();
         §§push(_loc1_);
         var _loc5_:int = 20;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc5_ : _loc5_ - 4;
         currentLevelLabel.defaultTextFormat = _loc1_;
         currentLevelLabel.autoSize = "left";
         var _temp_5:* = currentLevelLabel;
         var _loc6_:String = "ui.windows.recycle.currentlevel";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc6_) + " :";
         addChild(currentLevelLabel);
         currentLevelIcon = assetRepository.getDisplayObject("Upgrade");
         addChild(currentLevelIcon);
         currentLevelTF = new CaptionTextField();
         _loc1_ = currentLevelTF.getTextFormat();
         _loc1_.align = "center";
         §§push(_loc1_);
         var _loc7_:int = 20;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc7_ : _loc7_ - 4;
         currentLevelTF.defaultTextFormat = _loc1_;
         currentLevelTF.width = 42;
         currentLevelTF.height = 25;
         currentLevelTF.text = _buildingInfo.level + "";
         addChild(currentLevelTF);
         _recycleButton = new WomRedLargeButton();
         var _temp_9:* = _recycleButton;
         var _loc8_:String = "ui.windows.recycle.recycle";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
         _recycleButton.width = 210;
         addChild(_recycleButton);
         functionHeader = new CaptionTextField();
         _loc1_ = functionHeader.getTextFormat();
         §§push(_loc1_);
         var _loc9_:int = 20;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc9_ : _loc9_ - 4;
         functionHeader.defaultTextFormat = _loc1_;
         functionHeader.autoSize = "left";
         var _temp_11:* = functionHeader;
         var _loc10_:String = "ui.windows.recycle.function";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc10_) + ":";
         addChild(functionHeader);
         descriptionTextField = new WomTextField();
         _loc1_ = descriptionTextField.getTextFormat();
         §§push(_loc1_);
         var _loc11_:int = 18;
         §§pop().size = peak.i18n.lang.Languages.isActiveLanguageEmdedded() ? _loc11_ : _loc11_ - 4;
         descriptionTextField.defaultTextFormat = _loc1_;
         descriptionTextField.width = 500;
         descriptionTextField.multiline = true;
         descriptionTextField.wordWrap = true;
         var _temp_13:* = descriptionTextField;
         var _loc12_:String = "domain.building." + _buildingInfo.buildingTypeId + ".desc";
         _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc12_) + ":";
         addChild(descriptionTextField);
         gainLabel = new CaptionTextField();
         gainLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         gainLabel.autoSize = "left";
         var _temp_15:* = gainLabel;
         var _loc13_:String = "ui.windows.cancelconstruction.gain";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc13_);
         addChild(gainLabel);
         resourceGroupView = new ResourceGroupView(true);
         addChild(resourceGroupView);
         resourceGroupView.updateWithResources(_buildingTypeDIO.calculateRecycleGainForLevel(_buildingInfo.level));
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         currentLevelBackground = assetRepository.getDisplayObject("BackgroundLight");
         currentLevelBackground.width = 171;
         currentLevelBackground.height = 40;
         currentLevelBackground.x = 168;
         currentLevelBackground.y = 41;
         addChild(currentLevelBackground);
         gainsBackground = assetRepository.getDisplayObject("BackgroundLight");
         gainsBackground.width = 520;
         gainsBackground.height = 105;
         AlignmentUtil.alignBelowOf(gainsBackground,currentLevelBackground,115);
         addChild(gainsBackground);
      }
      
      public function drawLayout() : void
      {
         _buildingAsset.x = 170 - _buildingAsset.width;
         _buildingAsset.y = 250 - _buildingAsset.height;
         AlignmentUtil.alignAccordingToPositionOf(currentLevelLabel,currentLevelBackground,18,9);
         AlignmentUtil.alignRightOf(currentLevelIcon,currentLevelLabel,10);
         currentLevelIcon.y = currentLevelBackground.y - 9;
         AlignmentUtil.alignAccordingToPositionOf(currentLevelTF,currentLevelIcon,0,22);
         AlignmentUtil.alignBelowOf(functionHeader,currentLevelLabel,23);
         AlignmentUtil.alignBelowOf(descriptionTextField,functionHeader,1);
         AlignmentUtil.alignAccordingToPositionOf(gainLabel,gainsBackground,20,-10);
         resourceGroupView.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(resourceGroupView,gainsBackground,gainsBackground.width - resourceGroupView.width >> 1,17);
         _recycleButton.x = 734 - _recycleButton.width >> 1;
         _recycleButton.y = 334;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get buildingAsset() : DisplayObject
      {
         return _buildingAsset;
      }
      
      public function get recycleButton() : Button
      {
         return _recycleButton;
      }
   }
}

