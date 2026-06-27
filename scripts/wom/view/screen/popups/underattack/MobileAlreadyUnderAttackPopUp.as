package wom.view.screen.popups.underattack
{
   import flash.geom.Rectangle;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileAlreadyUnderAttackPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 583;
      
      private static const WINDOW_HEIGHT:int = 240;
      
      private var _type:int;
      
      private var _visit:Boolean;
      
      private var sneakPeakHead:Sprite;
      
      private var sneakPeakBody:Sprite;
      
      public function MobileAlreadyUnderAttackPopUp(param1:int, param2:Boolean, param3:int = 583, param4:int = 240)
      {
         super(param3,param4);
         _type = param1;
         _visit = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.popups.underattack.already.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _imageAsset = assetRepository.getDisplayObject("SneakPeak");
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("SneakPeak");
         sneakPeakHead = new Sprite();
         sneakPeakHead.clipRect = new Rectangle(0,0,190,95);
         sneakPeakHead.addChild(_imageAsset);
         addChild(sneakPeakHead);
         sneakPeakBody = new Sprite();
         sneakPeakBody.clipRect = new Rectangle(60,95,175,119);
         sneakPeakBody.addChild(_loc1_);
         addChild(sneakPeakBody);
         _speechBubble = new MobileSpeechBubbleView(407,getMessageText(),null,false,20,40,50);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 235;
         var _temp_7:* = _actionButton;
         var _loc3_:String = "ui.popups.underattack.already.return";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(sneakPeakHead,_background,-44,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(sneakPeakBody,_background,-44,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,130,50);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,185);
         if(_speechBubble.height < 120)
         {
            _speechBubble.speechArrowVerticalPosition -= _speechBubble.textFieldMarginTop;
            _speechBubble.y += _speechBubble.textFieldMarginTop;
         }
      }
      
      private function getMessageText() : String
      {
         var _loc1_:String = "";
         if(!_visit)
         {
            switch(_type)
            {
               case 5:
               case 6:
               case 7:
               case 13:
               case 14:
               case 15:
               case 16:
               case 24:
               case 1000:
               case 26:
               case 29:
               case 30:
               case 32:
               case 33:
               case 31:
               case 35:
               case 36:
               case 40:
               case 41:
               case 42:
               case 43:
               case 44:
                  var _loc2_:String = "ui.popups.underattack.already.message." + _type;
                  _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc2_);
                  break;
               default:
                  var _loc3_:String = "ui.popups.underattack.already.badweather";
                  _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            }
         }
         else
         {
            switch(_type - 4)
            {
               case 0:
               case 2:
                  var _loc4_:String = "ui.popups.visiterror.message." + _type;
                  _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
                  break;
               default:
                  var _loc5_:String = "ui.popups.underattack.already.badweather";
                  _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            }
         }
         return _loc1_;
      }
   }
}

