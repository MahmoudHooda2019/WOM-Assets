package wom.view.ui.mainframe.combat.catapult
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileCatapultCombatRechargePopUp extends MobileBasePopUp
   {
      
      public static const WINDOW_WIDTH:int = 495;
      
      public static const WINDOW_HEIGHT:int = 306;
      
      private var _type:int;
      
      private var _remainingTime:int;
      
      private var _descTF:MPTextField;
      
      private var _durationTF:MPTextField;
      
      public function MobileCatapultCombatRechargePopUp(param1:int)
      {
         super(495,306);
         _type = param1;
      }
      
      override protected function initLayout() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         super.initLayout();
         switch(_type - 1)
         {
            case 0:
               _loc1_ = "CatapultButtonLumber";
               var _loc3_:String = "ui.mainframe.combat.catapult.lumber";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               break;
            case 1:
               _loc1_ = "CatapultButtonStone";
               var _loc4_:String = "ui.mainframe.combat.catapult.stone";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 2:
               _loc1_ = "CatapultButtonMight";
               var _loc5_:String = "ui.mainframe.combat.catapult.might";
               _loc2_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         var _temp_1:* = "m.ui.mainframe.catapult.rechargeResource";
         var _loc6_:String = _loc2_;
         var _loc7_:String = _temp_1;
         setHeader(peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_));
         var _temp_5:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_4:* = 415;
         var _temp_3:* = "ui.mainframe.combat.catapult.availablein";
         var _loc8_:String = "";
         var _loc9_:String = _temp_3;
         _speechBubble = new MobileSpeechBubbleView(_temp_4,peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_),null,null,50,83);
         addChild(_speechBubble);
         _speechBubble.speechBubbleArrow.visible = false;
         _imageAsset = assetRepository.getDisplayObject(_loc1_);
         addChild(_imageAsset);
         _durationTF = new MobileCaptionTextField();
         _durationTF.textRendererProperties.textFormat = getCaptionTextFormat(30);
         _durationTF.text = "";
         addChild(_durationTF);
         _descTF = new MobileWomTextField();
         _descTF.textRendererProperties.textFormat = getWomTextFormat(25,"center",16777215);
         addChild(_descTF);
         var _temp_10:* = _descTF;
         var _loc10_:String = "m.ui.mainframe.catapult.rechargeDescription";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 398;
         var _temp_12:* = _actionButton;
         var _loc11_:String = "ui.mainframe.combat.catapult.rechargenow";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc11_);
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_actionButton);
         _actionButton.rightLabel = "";
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,40,36);
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_speechBubble,39,44);
         _speechBubble.textField.x += 40;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_durationTF,_speechBubble.textField,_speechBubble.textField.height + 13);
         MobileAlignmentUtil.alignAccordingToPositionOf(_descTF,_background,115,220);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1) - 6);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function updateDuration(param1:int) : void
      {
         _remainingTime = param1;
         _durationTF.text = DateTimeUtil.getFormattedTime(param1).substring(3,8);
         _actionButton.rightLabel = rechargeCost.toString();
         _actionButton.validate();
      }
      
      public function get rechargeCost() : int
      {
         return Math.ceil(StoreUtil.resourcePrice(_remainingTime / 10));
      }
   }
}

