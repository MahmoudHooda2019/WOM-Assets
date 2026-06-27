package wom.view.screen.popups.topoff
{
   import peak.i18n.PText;
   import peak.i18n.i18nN;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileBaseTopOffResourcesPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 592;
      
      private static const WINDOW_HEIGHT:int = 271;
      
      public static const RECRUIT:String = "recruit";
      
      public static const UPGRADE:String = "upgrade";
      
      public static const FORTIFY:String = "fortify";
      
      public static const CONSTRUCT:String = "construct";
      
      public static const TRAIN:String = "train";
      
      public static const EVENT_ITEM:String = "blacksmith";
      
      private var _type:String;
      
      private var _missingResourcesArray:Array;
      
      private var _requiredGold:int;
      
      public function MobileBaseTopOffResourcesPopUp(param1:String, param2:Array = null, param3:Vector.<WindowEnumeration> = null, param4:int = 592, param5:int = 271)
      {
         super(param4,param5,param3);
         _type = param1;
         _missingResourcesArray = param2;
      }
      
      override protected function initLayout() : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         var _loc4_:String = null;
         var _loc6_:String = null;
         super.initLayout();
         var _loc7_:String = "ui.popups.topoffresources.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         _imageAsset = assetRepository.getDisplayObject("MPose7Right");
         addChild(_imageAsset);
         var _loc5_:int;
         switch((_loc5_ = int(_missingResourcesArray.length)) - 1)
         {
            case 0:
               var _temp_5:* = "ui.common.resource.nameamountpair1";
               var _loc8_:String = "domain.resource." + _missingResourcesArray[0].resourceType + ".name";
               var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               var _loc9_:* = _missingResourcesArray[0].amount;
               var _loc10_:* = _temp_4;
               var _loc11_:String = _temp_5;
               _loc2_ = peak.i18n.PText.INSTANCE.getText2(_loc11_,_loc10_,_loc9_);
               break;
            case 1:
               var _temp_7:* = "ui.common.resource.nameamountpair1";
               var _loc12_:String = "domain.resource." + _missingResourcesArray[0].resourceType + ".name";
               var _temp_6:* = peak.i18n.PText.INSTANCE.getText0(_loc12_);
               var _loc13_:* = _missingResourcesArray[0].amount;
               var _loc14_:* = _temp_6;
               var _loc15_:String = _temp_7;
               _loc6_ = peak.i18n.PText.INSTANCE.getText2(_loc15_,_loc14_,_loc13_);
               var _temp_9:* = "ui.common.resource.nameamountpair1";
               var _loc16_:String = "domain.resource." + _missingResourcesArray[1].resourceType + ".name";
               var _temp_8:* = peak.i18n.PText.INSTANCE.getText0(_loc16_);
               var _loc17_:* = _missingResourcesArray[1].amount;
               var _loc18_:* = _temp_8;
               var _loc19_:String = _temp_9;
               _loc3_ = peak.i18n.PText.INSTANCE.getText2(_loc19_,_loc18_,_loc17_);
               var _temp_11:* = "ui.common.resource.nameamountpair2";
               var _temp_10:* = _loc6_;
               var _loc20_:String = _loc3_;
               var _loc21_:String = _temp_10;
               var _loc22_:String = _temp_11;
               _loc2_ = peak.i18n.PText.INSTANCE.getText2(_loc22_,_loc21_,_loc20_);
               break;
            case 2:
               var _temp_13:* = "ui.common.resource.nameamountpair1";
               var _loc23_:String = "domain.resource." + _missingResourcesArray[0].resourceType + ".name";
               var _temp_12:* = peak.i18n.PText.INSTANCE.getText0(_loc23_);
               var _loc24_:* = _missingResourcesArray[0].amount;
               var _loc25_:* = _temp_12;
               var _loc26_:String = _temp_13;
               _loc6_ = peak.i18n.PText.INSTANCE.getText2(_loc26_,_loc25_,_loc24_);
               var _temp_15:* = "ui.common.resource.nameamountpair1";
               var _loc27_:String = "domain.resource." + _missingResourcesArray[1].resourceType + ".name";
               var _temp_14:* = peak.i18n.PText.INSTANCE.getText0(_loc27_);
               var _loc28_:* = _missingResourcesArray[1].amount;
               var _loc29_:* = _temp_14;
               var _loc30_:String = _temp_15;
               _loc3_ = peak.i18n.PText.INSTANCE.getText2(_loc30_,_loc29_,_loc28_);
               var _temp_17:* = "ui.common.resource.nameamountpair1";
               var _loc31_:String = "domain.resource." + _missingResourcesArray[2].resourceType + ".name";
               var _temp_16:* = peak.i18n.PText.INSTANCE.getText0(_loc31_);
               var _loc32_:* = _missingResourcesArray[2].amount;
               var _loc33_:* = _temp_16;
               var _loc34_:String = _temp_17;
               _loc1_ = peak.i18n.PText.INSTANCE.getText2(_loc34_,_loc33_,_loc32_);
               var _temp_20:* = "ui.common.resource.nameamountpair3";
               var _temp_19:* = _loc6_;
               var _temp_18:* = _loc3_;
               var _loc35_:String = _loc1_;
               var _loc36_:String = _temp_18;
               var _loc37_:String = _temp_19;
               var _loc38_:String = _temp_20;
               _loc2_ = peak.i18n.PText.INSTANCE.getText3(_loc38_,_loc37_,_loc36_,_loc35_);
               break;
            case 3:
               var _temp_22:* = "ui.common.resource.nameamountpair1";
               var _loc39_:String = "domain.resource." + _missingResourcesArray[0].resourceType + ".name";
               var _temp_21:* = peak.i18n.PText.INSTANCE.getText0(_loc39_);
               var _loc40_:* = _missingResourcesArray[0].amount;
               var _loc41_:* = _temp_21;
               var _loc42_:String = _temp_22;
               _loc6_ = peak.i18n.PText.INSTANCE.getText2(_loc42_,_loc41_,_loc40_);
               var _temp_24:* = "ui.common.resource.nameamountpair1";
               var _loc43_:String = "domain.resource." + _missingResourcesArray[1].resourceType + ".name";
               var _temp_23:* = peak.i18n.PText.INSTANCE.getText0(_loc43_);
               var _loc44_:* = _missingResourcesArray[1].amount;
               var _loc45_:* = _temp_23;
               var _loc46_:String = _temp_24;
               _loc3_ = peak.i18n.PText.INSTANCE.getText2(_loc46_,_loc45_,_loc44_);
               var _temp_26:* = "ui.common.resource.nameamountpair1";
               var _loc47_:String = "domain.resource." + _missingResourcesArray[2].resourceType + ".name";
               var _temp_25:* = peak.i18n.PText.INSTANCE.getText0(_loc47_);
               var _loc48_:* = _missingResourcesArray[2].amount;
               var _loc49_:* = _temp_25;
               var _loc50_:String = _temp_26;
               _loc1_ = peak.i18n.PText.INSTANCE.getText2(_loc50_,_loc49_,_loc48_);
               var _temp_28:* = "ui.common.resource.nameamountpair1";
               var _loc51_:String = "domain.resource." + _missingResourcesArray[3].resourceType + ".name";
               var _temp_27:* = peak.i18n.PText.INSTANCE.getText0(_loc51_);
               var _loc52_:* = _missingResourcesArray[3].amount;
               var _loc53_:* = _temp_27;
               var _loc54_:String = _temp_28;
               _loc4_ = peak.i18n.PText.INSTANCE.getText2(_loc54_,_loc53_,_loc52_);
               _loc2_ = i18nN("ui.common.resource.nameamountpair4",_loc6_,_loc3_,_loc1_,_loc4_);
         }
         _speechBubble = new MobileSpeechBubbleView(windowWidth - 225,i18nN("ui.popups.topoffresources.message." + _type,_loc2_),null,false,30,40,84);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 372;
         var _temp_32:* = _actionButton;
         var _temp_31:* = "ui.popups.topoffresources.confirm";
         var _loc55_:int = _requiredGold;
         var _loc56_:String = _temp_31;
         _temp_32.label = peak.i18n.PText.INSTANCE.getText1(_loc56_,_loc55_);
         _actionButton.rightLabel = _requiredGold + "";
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,5,_windowHeight - 18 - _imageAsset.height);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,188,52);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - _actionButton.height / 2 - 6);
      }
      
      public function get type() : String
      {
         return _type;
      }
      
      public function get missingResourcesArray() : Array
      {
         return _missingResourcesArray;
      }
      
      public function get requiredGold() : int
      {
         return _requiredGold;
      }
      
      public function set requiredGold(param1:int) : void
      {
         _requiredGold = param1;
      }
   }
}

