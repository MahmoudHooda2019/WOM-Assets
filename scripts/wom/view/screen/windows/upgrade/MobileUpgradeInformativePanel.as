package wom.view.screen.windows.upgrade
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.windows.build.MobileBuildingSilhouette;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileUpgradeInformativePanel extends MobileBaseWindowPanel
   {
      
      private static const WINDOW_WIDTH:int = 787;
      
      private static const WINDOW_HEIGHT:int = 213;
      
      private static const X_MARGIN_OF_LABELS:int = 246;
      
      protected var functionLabel:MPTextField;
      
      protected var functionTextField:MPTextField;
      
      protected var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingSilhouette:DisplayObject;
      
      private var _targetLevel:int;
      
      public function MobileUpgradeInformativePanel(param1:BuildingTypeDIO, param2:int)
      {
         super(787,213);
         _buildingTypeDIO = param1;
         _targetLevel = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _buildingSilhouette = new MobileBuildingSilhouette(_buildingTypeDIO.id,_targetLevel);
         addChild(_buildingSilhouette);
         functionLabel = new MobileCaptionTextField();
         functionLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(functionLabel);
         var _temp_3:* = functionLabel;
         var _loc1_:String = "ui.windows.upgrade.function";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_) + " :";
         functionTextField = new MobileWomTextField();
         functionTextField.width = 495;
         functionTextField.textRendererProperties.textFormat = getWomTextFormat(21);
         functionTextField.textRendererProperties.wordWrap = true;
         addChild(functionTextField);
         var _temp_5:* = functionTextField;
         var _loc2_:String = "domain.building." + _buildingTypeDIO.id + ".function";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "MobileBeigeBackground";
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_buildingSilhouette,bg,246 - _buildingSilhouette.width >> 1);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(functionTextField,bg,246);
         MobileAlignmentUtil.alignAboveOf(functionLabel,functionTextField,4);
      }
   }
}

