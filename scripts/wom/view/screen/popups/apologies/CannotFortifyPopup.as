package wom.view.screen.popups.apologies
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class CannotFortifyPopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      private var _workerTiredAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _okButton:Button;
      
      private var fortifiableBuildingViews:Vector.<Sprite>;
      
      public function CannotFortifyPopup(param1:int = 586, param2:int = 306)
      {
         super(param1,param2);
         fortifiableBuildingViews = new Vector.<Sprite>();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.popups.apologies.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _workerTiredAsset = assetRepository.getDisplayObject("WorkerTired");
         addChild(_workerTiredAsset);
         var _temp_4:* = fortifiableBuildingViews;
         var _loc3_:String = "domain.building.15.name";
         _temp_4.push(createFortifiableBuildingView(peak.i18n.PText.INSTANCE.getText0(_loc3_)));
         var _temp_6:* = fortifiableBuildingViews;
         var _loc4_:String = "ui.popups.apologies.defensetowers";
         _temp_6.push(createFortifiableBuildingView(peak.i18n.PText.INSTANCE.getText0(_loc4_)));
         var _temp_8:* = fortifiableBuildingViews;
         var _loc5_:String = "domain.building.10.name";
         _temp_8.push(createFortifiableBuildingView(peak.i18n.PText.INSTANCE.getText0(_loc5_)));
         _okButton = new WomBlueLargeButton();
         _okButton.width = 260;
         var _loc1_:String = "";
         var _loc6_:String = "ui.popups.apologies.cantfortifyunsuitablebuilding";
         _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         var _temp_10:* = _okButton;
         var _loc7_:String = "ui.popups.apologies.getoutofmysight";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         speechBubble = new SpeechBubbleView(_windowWidth - 255,_loc1_);
         addChild(speechBubble);
         addChild(_okButton);
         drawLayout();
      }
      
      private function createFortifiableBuildingView(param1:String) : Sprite
      {
         var _loc3_:Sprite = new Sprite();
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("BackgroundDark");
         _loc2_.width = 257;
         _loc2_.height = 43;
         _loc3_.addChild(_loc2_);
         var _loc4_:TextField = new WomTextField();
         _loc4_.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         _loc4_.autoSize = "left";
         _loc4_.text = param1;
         _loc3_.addChild(_loc4_);
         AlignmentUtil.alignAccordingToPositionOf(_loc4_,_loc3_,8,9);
         addChild(_loc3_);
         return _loc3_;
      }
      
      public function drawLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Sprite = null;
         _workerTiredAsset.x = -92;
         _workerTiredAsset.y = -20;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y = 27;
         var _loc2_:Sprite = speechBubble;
         _loc3_ = 0;
         while(_loc3_ < fortifiableBuildingViews.length)
         {
            _loc1_ = fortifiableBuildingViews[_loc3_];
            AlignmentUtil.alignBelowOf(_loc1_,_loc2_,_loc3_ == 0 ? 19 : 5);
            if(_loc3_ == 0)
            {
               _loc1_.x += 76;
            }
            _loc2_ = _loc1_;
            _loc3_++;
         }
         _okButton.x = 586 - _okButton.width >> 1;
         _okButton.y = 306 - _okButton.height / 2 << 0;
      }
      
      public function get workerTiredAsset() : AssetDisplayObject
      {
         return _workerTiredAsset;
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
   }
}

