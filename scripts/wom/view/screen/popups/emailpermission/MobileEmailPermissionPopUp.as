package wom.view.screen.popups.emailpermission
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.*;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileEmailPermissionPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_HEIGHT:int = 397;
      
      private static const WINDOW_WIDTH:int = 612;
      
      private var _permissionTF:MPTextField;
      
      private var _permission2TF:MPTextField;
      
      private var _freeGoldTF:MPTextField;
      
      private var _goldIcon:DisplayObject;
      
      private var _goldStackAsset2:DisplayObject;
      
      public function MobileEmailPermissionPopUp()
      {
         super(612,397);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = "m.ui.popups.emailpermission.header";
         var _loc1_:String = "m.ui.popups.emailpermission.goldAmount";
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
         _imageAsset = assetRepository.getDisplayObject("FBGoldStack");
         addChild(_imageAsset);
         _goldStackAsset2 = assetRepository.getDisplayObject("FBGoldStack");
         addChild(_goldStackAsset2);
         _permissionTF = new MobileCaptionTextField();
         _permissionTF.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(_permissionTF);
         var _temp_6:* = _permissionTF;
         var _loc4_:String = "m.ui.popups.emailpermission.desc1";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _permission2TF = new MobileWomTextField();
         _permission2TF.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         addChild(_permission2TF);
         var _temp_8:* = _permission2TF;
         var _loc5_:String = "m.ui.popups.emailpermission.desc2";
         _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         var _temp_10:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_9:* = 373;
         var _loc6_:String = "m.ui.popups.emailpermission.enjoy";
         _speechBubble = new MobileSpeechBubbleView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc6_),getCaptionTextFormat(33,"center"),false,30,102);
         addChild(_speechBubble);
         _speechBubble.speechBubbleArrow.visible = false;
         _goldIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_goldIcon);
         _freeGoldTF = new MobileCaptionTextField();
         _freeGoldTF.textRendererProperties.textFormat = getCaptionTextFormat(50);
         addChild(_freeGoldTF);
         var _temp_15:* = _freeGoldTF;
         var _temp_14:* = "m.ui.popups.emailpermission.freeGold";
         var _loc7_:String = "m.ui.popups.emailpermission.goldAmount";
         var _loc8_:* = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         var _loc9_:String = _temp_14;
         _temp_15.text = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 280;
         var _temp_17:* = _actionButton;
         var _loc10_:String = "m.ui.popups.emailpermission.claimGold";
         _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_permissionTF,_background,70);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_permission2TF,_background,98);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_speechBubble,_background,139);
         MobileAlignmentUtil.alignAccordingToPositionOf(_goldIcon,_speechBubble,43,58);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_freeGoldTF,_goldIcon,42);
         _freeGoldTF.y += 5;
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-5,_speechBubble.y + (_speechBubble.height >> 2) + 15);
         MobileAlignmentUtil.alignAccordingToPositionOf(_goldStackAsset2,_background,29 + windowWidth - _goldStackAsset2.width,_imageAsset.y);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - (_actionButton.height >> 1) - 16);
      }
   }
}

