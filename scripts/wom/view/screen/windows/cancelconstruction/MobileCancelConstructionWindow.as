package wom.view.screen.windows.cancelconstruction
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileCancelConstructionWindow extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 380;
      
      private var _buildingInfo:BuildingInfo;
      
      private var buildingTypeDIO:BuildingTypeDIO;
      
      private var gainsBackground:DisplayObject;
      
      private var gainLabel:MPTextField;
      
      private var resourceGroupView:MobileResourceGroupView;
      
      private var jobType:BuildingUpgradeJobType;
      
      private var _capacityWillExceed:Boolean;
      
      public function MobileCancelConstructionWindow(param1:BuildingInfo, param2:BuildingTypeDIO, param3:BuildingUpgradeJobType, param4:Boolean)
      {
         super(586,380);
         _buildingInfo = param1;
         buildingTypeDIO = param2;
         this.jobType = param3;
         _capacityWillExceed = param4;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.windows.cancelconstruction.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _imageAsset = assetRepository.getDisplayObject("PoseWorker3");
         _staticLayer.addChildAt(_imageAsset,_staticLayer.getChildIndex(_windowHeader) + 1);
         var _temp_4:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_3:* = 450;
         var _loc3_:String = "ui.windows.cancelconstruction.bycancellingcontent";
         _speechBubble = new MobileSpeechBubbleView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc3_),null,false,35,39);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _actionButton.width = 228;
         var _temp_7:* = _actionButton;
         var _loc4_:String = "ui.windows.alliance.myalliance.confirm";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _actionButton.invalidate("styles");
         addChild(_actionButton);
         gainsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         gainsBackground.width = 422;
         gainsBackground.height = 120;
         addChild(gainsBackground);
         gainLabel = new MobileCaptionTextField();
         gainLabel.textRendererProperties.textFormat = getCaptionTextFormat(23);
         var _temp_10:* = gainLabel;
         var _loc5_:String = "ui.windows.cancelconstruction.gain";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         resourceGroupView = new MobileResourceGroupView(true);
         addChild(resourceGroupView);
         var _loc1_:Vector.<ResourceAmountDTO> = jobType == BuildingUpgradeJobType.UPGRADE ? buildingTypeDIO.resourceCosts[_buildingInfo.level] : (buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO).resourceCosts[_buildingInfo.fortificationLevel];
         resourceGroupView.updateWithResources(_loc1_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         gainLabel.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_imageAsset,_background,-_imageAsset.width / 5 * 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,70,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - _actionButton.height / 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(gainsBackground,_background,70,181);
         MobileAlignmentUtil.alignMiddleOf(resourceGroupView,gainsBackground);
         MobileAlignmentUtil.alignAboveWithXMarginOf(gainLabel,gainsBackground,15,-gainLabel.height >> 1);
      }
      
      public function get capacityWillExceed() : Boolean
      {
         return _capacityWillExceed;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

