package wom.view.screen.popups
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileFortificationCompletedPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 503;
      
      private static const WINDOW_HEIGHT:int = 280;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _fortificationLevel:int;
      
      private var _fortificationSilhouetteBack:DisplayObject;
      
      private var _fortificationSilhouetteFront:DisplayObject;
      
      private var innerBackground:DisplayObject;
      
      private var levelUpgradeAsset:DisplayObject;
      
      private var levelTextField:MPTextField;
      
      private var messageField:MPTextField;
      
      private var _bragToYourFriendsButton:MobileWomButton;
      
      public function MobileFortificationCompletedPopUp(param1:BuildingTypeDIO, param2:int, param3:int = 503, param4:int = 280)
      {
         super(param3,param4);
         _buildingTypeDIO = param1;
         _fortificationLevel = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "ui.popups.fortificationcompleted.header";
         var _loc1_:String = "domain.building." + _buildingTypeDIO.id + ".name";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         _fortificationSilhouetteBack = assetRepository.getDisplayObject("FortificationMediumS" + fortificationLevel + "Back");
         addChild(_fortificationSilhouetteBack);
         _fortificationSilhouetteFront = assetRepository.getDisplayObject("FortificationMediumS" + fortificationLevel + "Front");
         addChild(_fortificationSilhouetteFront);
         levelUpgradeAsset = assetRepository.getDisplayObject("IconUpgradeM");
         addChild(levelUpgradeAsset);
         levelTextField = new MobileCaptionTextField();
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(38,"center");
         addChild(levelTextField);
         levelTextField.text = String(_fortificationLevel);
         messageField = new MobileWomTextField();
         messageField.textRendererProperties.wordWrap = true;
         messageField.width = 285;
         messageField.textRendererProperties.textFormat = getWomTextFormat(23);
         addChild(messageField);
         var _temp_9:* = messageField;
         var _temp_8:* = "domain.buildingkinds." + _buildingTypeDIO.kind.id + ".fortificationcompleted";
         var _loc4_:String = "domain.building." + _buildingTypeDIO.id + ".name";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc6_:String = _temp_8;
         _temp_9.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         _bragToYourFriendsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _bragToYourFriendsButton.width = 460;
         var _temp_11:* = _bragToYourFriendsButton;
         var _loc7_:String = "ui.popups.fortificationcompleted.bragtoyourfriends";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         addChild(_bragToYourFriendsButton);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         innerBackground = assetRepository.getDisplayObject("MobileBeigeBackground");
         innerBackground.width = 433;
         innerBackground.height = 165;
         addChild(innerBackground);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(innerBackground,_background,35);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelUpgradeAsset,innerBackground,32,14);
         MobileAlignmentUtil.alignAccordingToPositionOf(messageField,innerBackground,125,40);
         MobileAlignmentUtil.alignBelowWithXMarginOf(_fortificationSilhouetteBack,levelUpgradeAsset,levelUpgradeAsset.width - _fortificationSilhouetteBack.width >> 1,-1);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_fortificationSilhouetteFront,_fortificationSilhouetteBack,_fortificationSilhouetteBack.height - 20);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(levelTextField,levelUpgradeAsset,22);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_bragToYourFriendsButton,_background,210);
      }
      
      public function get bragToYourFriendsButton() : MobileWomButton
      {
         return _bragToYourFriendsButton;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get fortificationLevel() : int
      {
         return _fortificationLevel;
      }
   }
}

