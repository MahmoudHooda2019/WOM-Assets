package wom.view.screen.windows.alliance.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileAllianceTipsPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 830;
      
      private static const WINDOW_HEIGHT:int = 661;
      
      private var _innerBackground:DisplayObject;
      
      private var _innerHeader:MPTextField;
      
      private var _imageAsset:DisplayObject;
      
      private var _tipList:Array;
      
      private var _tickList:Array;
      
      public function MobileAllianceTipsPopUp()
      {
         super(830,661);
      }
      
      override protected function initLayout() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:MPTextField = null;
         var _loc3_:int = 0;
         super.initLayout();
         var _loc4_:String = "ui.windows.alliance.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         _innerBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         _innerBackground.width = windowWidth - 110;
         _innerBackground.height = 483;
         addChild(_innerBackground);
         _innerHeader = new MobileCaptionTextField();
         _innerHeader.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(_innerHeader);
         var _temp_4:* = _innerHeader;
         var _loc5_:String = "ui.windows.alliance.help.title";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         _imageAsset = assetRepository.getDisplayObject("MPose5Left");
         addChild(_imageAsset);
         _tipList = [];
         _tickList = [];
         _loc3_ = 1;
         while(_loc3_ < 8)
         {
            _loc1_ = assetRepository.getDisplayObject("SymbolTickDisable");
            addChild(_loc1_);
            _tickList.push(_loc1_);
            _loc2_ = new MobileWomTextField();
            _loc2_.textRendererProperties.textFormat = getWomTextFormat(21,"left",16777215);
            _loc2_.width = 410;
            _loc2_.textRendererProperties.wordWrap = true;
            addChild(_loc2_);
            var _temp_8:* = _loc2_;
            var _loc6_:String = "ui.windows.alliance.help.tips." + _loc3_;
            _temp_8.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            _tipList.push(_loc2_);
            _loc3_++;
         }
         drawLayout();
         this.flatten();
         addEventListener("touch",onTouch);
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_innerBackground,_background,81);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_innerHeader,_innerBackground,-(_innerHeader.height >> 1));
         _innerHeader.y += 5;
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_innerBackground,-5,_innerBackground.height - _imageAsset.height - 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_tickList[0],_innerBackground,232,35);
         MobileAlignmentUtil.alignRightOf(_tipList[0],_tickList[0],10);
         _loc1_ = 2;
         while(_loc1_ < 8)
         {
            MobileAlignmentUtil.alignHeightSpecifiedBelowOf(_tickList[_loc1_ - 1],_tickList[_loc1_ - 2],20,_tipList[_loc1_ - 2].height);
            MobileAlignmentUtil.alignRightOf(_tipList[_loc1_ - 1],_tickList[_loc1_ - 1],10);
            _loc1_++;
         }
      }
      
      protected function onTouch(param1:TouchEvent) : void
      {
         var _loc3_:String = null;
         var _loc2_:Touch = param1.getTouch(this);
         if(_loc2_)
         {
            _loc3_ = _loc2_.phase;
            if(_loc3_ == "began")
            {
               flatten();
            }
            else if(_loc3_ == "ended" && stage)
            {
               flatten();
            }
         }
      }
   }
}

