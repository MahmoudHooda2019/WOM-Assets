package wom.view.screen.windows.recycle
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileRecycleTrapWindow extends MobileGenericWindow
   {
      
      private const WINDOW_HEIGHT:int = 271;
      
      private const WINDOW_WIDTH:int = 780;
      
      private var _trapsSilhouette:DisplayObject;
      
      private var _gainsBackground:DisplayObject;
      
      private var _gainLabel:MPTextField;
      
      private var _gainView:MobileResourceGroupView;
      
      private var _confirmButton:MobileWomButton;
      
      private var _abandonButton:MobileWomButton;
      
      private var _buildingInfo:BuildingInfo;
      
      public function MobileRecycleTrapWindow(param1:BuildingInfo)
      {
         super(780,271);
         _buildingInfo = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "m.ui.windows.recycletrap.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _trapsSilhouette = assetRepository.getDisplayObject("RearmTraps");
         addChild(_trapsSilhouette);
         _gainsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         _gainsBackground.width = 509;
         _gainsBackground.height = 115;
         addChild(_gainsBackground);
         _gainLabel = new MobileCaptionTextField();
         _gainLabel.textRendererProperties.textFormat = getCaptionTextFormat(25);
         var _temp_5:* = _gainLabel;
         var _loc2_:String = "m.ui.windows.recycletrap.gain";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_gainLabel);
         _gainView = new MobileResourceGroupView(true);
         addChild(_gainView);
         _confirmButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_8:* = _confirmButton;
         var _loc3_:String = "m.ui.windows.recycletrap.confirm";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _confirmButton.width = 248;
         addChild(_confirmButton);
         _abandonButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_10:* = _abandonButton;
         var _loc4_:String = "m.ui.windows.recycletrap.abandon";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _abandonButton.width = 271;
         addChild(_abandonButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_trapsSilhouette,_background,5,63);
         MobileAlignmentUtil.alignAccordingToPositionOf(_gainsBackground,_background,219,63);
         MobileAlignmentUtil.alignAccordingToPositionOf(_gainLabel,_gainsBackground,22,-(_gainLabel.height >> 1));
         MobileAlignmentUtil.alignAccordingToPositionOf(_confirmButton,_background,_background.width - _confirmButton.width - 7 - _abandonButton.width >> 1,_background.height - (_confirmButton.height >> 1) - 6);
         MobileAlignmentUtil.alignRightOf(_abandonButton,_confirmButton,7);
      }
      
      public function updateWithResources(param1:BuildingTypeDIO) : void
      {
         _gainView.updateWithResources(param1.calculateRecycleGainForLevel(_buildingInfo.level));
         MobileAlignmentUtil.alignMiddleOf(_gainView,_gainsBackground);
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      public function get confirmButton() : MobileWomButton
      {
         return _confirmButton;
      }
      
      public function get abandonButton() : MobileWomButton
      {
         return _abandonButton;
      }
      
      public function get trapsSilhouette() : DisplayObject
      {
         return _trapsSilhouette;
      }
   }
}

