package wom.view.screen.popups.finishnow
{
   import com.greensock.TweenMax;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileBasePopUp;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileFinishNowHiringPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 600;
      
      private static const WINDOW_HEIGHT:int = 250;
      
      public var level:int;
      
      private var _price:int;
      
      private var unitAmounts:Vector.<UnitTypeAmountDTO>;
      
      private var _buildingInstanceId:int;
      
      private var _centralHiring:Boolean;
      
      private var _highlightArrow:DisplayObject;
      
      private var _highlightVisible:Boolean;
      
      public function MobileFinishNowHiringPopUp(param1:int, param2:Vector.<UnitTypeAmountDTO>, param3:int, param4:Boolean, param5:Boolean = false, param6:int = 600, param7:int = 250)
      {
         super(param6,param7);
         _price = param1;
         _centralHiring = param4;
         this.unitAmounts = param2;
         _buildingInstanceId = param3;
         _highlightVisible = param5;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "";
         var _loc3_:Boolean = true;
         for each(var _loc1_ in unitAmounts)
         {
            if(!_loc3_)
            {
               _loc2_ += ", ";
            }
            else
            {
               _loc3_ = false;
            }
            var _temp_2:* = _loc2_;
            var _temp_1:* = _loc1_.amount + " ";
            var _loc6_:String = "domain.units." + _loc1_.id + ".name";
            _loc2_ += _temp_1 + peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         _imageAsset = assetRepository.getDisplayObject("MPose7Right");
         addChild(_imageAsset);
         var _temp_7:* = §§findproperty(MobileSpeechBubbleView);
         var _temp_6:* = 400;
         var _temp_5:* = "ui.popups.finishnowhiring.informationtext";
         var _temp_4:* = _loc2_;
         var _loc7_:int = _price;
         var _loc8_:String = _temp_4;
         var _loc9_:String = _temp_5;
         _speechBubble = new MobileSpeechBubbleView(_temp_6,peak.i18n.PText.INSTANCE.getText2(_loc9_,_loc8_,_loc7_),null,false,30,35);
         addChild(_speechBubble);
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 395;
         var _temp_10:* = _actionButton;
         var _loc10_:String = "ui.popups.finishnowhiring.finishnow";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
         _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _actionButton.iconOffsetY = 3;
         _actionButton.iconOffsetX = 15;
         _actionButton.invalidate("styles");
         _actionButton.rightLabel = _price + "";
         addChild(_actionButton);
         if(_highlightVisible)
         {
            _highlightArrow = assetRepository.getDisplayObject("TutorialArrowLeftRightM");
            addChild(_highlightArrow);
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,9,-7);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,170,60);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,200);
         _speechBubble.speechArrowVerticalPosition = (_speechBubble.height - _speechBubble.speechBubbleArrow.height) / 2;
         if(_highlightVisible)
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_highlightArrow,_actionButton,_actionButton.width);
            if(!TweenMax.isTweening(_highlightArrow))
            {
               TweenMax.to(_highlightArrow,0.55,{
                  "x":"25",
                  "repeat":-1,
                  "yoyo":true,
                  "overwrite":1
               });
            }
         }
      }
      
      public function get buildingInstanceId() : int
      {
         return _buildingInstanceId;
      }
      
      public function get price() : int
      {
         return _price;
      }
      
      public function get centralHiring() : Boolean
      {
         return _centralHiring;
      }
   }
}

