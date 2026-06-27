package wom.view.screen.windows.cityplanner
{
   import flash.display.DisplayObject;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.WomTextInput;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.util.GenericWindow;
   
   public class CityPlannerSaveWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 520;
      
      private static const WINDOW_HEIGHT:int = 550;
      
      private static const MAX_SLOT_COUNT:int = 10;
      
      private var _layoutNameInputs:Array;
      
      private var _layoutSaveButtons:Array;
      
      private var _buyWithGoldButtons:Array;
      
      private var _orIcons:Array;
      
      private var _buyWithRPButtons:Array;
      
      public function CityPlannerSaveWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(520,550,param1);
         _layoutNameInputs = [];
         _layoutSaveButtons = [];
         _buyWithGoldButtons = [];
         _orIcons = [];
         _buyWithRPButtons = [];
      }
      
      [PostConstruct]
      override public function init() : void
      {
         super.init();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.cityplanner.savelayout";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
      }
      
      public function updateButtons(param1:int) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         _loc3_ = 1;
         while(_loc3_ < 10 + 1)
         {
            _loc2_ = _loc3_ > param1;
            if(_layoutNameInputs[_loc3_])
            {
               _layoutNameInputs[_loc3_].enabled = !_loc2_;
            }
            if(_buyWithGoldButtons[_loc3_])
            {
               _buyWithGoldButtons[_loc3_].visible = _loc2_;
               _buyWithGoldButtons[_loc3_].enabled = _loc3_ <= param1 + 1;
            }
            if(_orIcons[_loc3_])
            {
               _orIcons[_loc3_].visible = _loc2_;
            }
            if(_buyWithRPButtons[_loc3_])
            {
               _buyWithRPButtons[_loc3_].visible = _loc2_;
               _buyWithRPButtons[_loc3_].enabled = _loc3_ <= param1 + 1;
            }
            if(_layoutSaveButtons[_loc3_])
            {
               _layoutSaveButtons[_loc3_].visible = !_loc2_;
            }
            _loc3_++;
         }
      }
      
      public function updateWithCityInfo(param1:Dictionary, param2:int, param3:Vector.<int>, param4:Vector.<int>) : void
      {
         var _loc10_:Boolean = false;
         var _loc12_:AssetDisplayObject = null;
         var _loc9_:CaptionTextField = null;
         var _loc16_:WomTextInput = null;
         var _loc6_:WomBlueSmallButton = null;
         var _loc18_:WomButton = null;
         var _loc19_:DisplayObject = null;
         var _loc11_:WomButton = null;
         var _loc22_:int = 0;
         var _loc14_:int = 0;
         var _loc17_:DisplayObject = null;
         var _loc23_:DisplayObject = null;
         var _loc25_:int = 42;
         var _loc20_:int = 20;
         var _loc8_:int = 477;
         var _loc13_:int = 40;
         var _loc21_:int = 142;
         var _loc5_:int = 30;
         var _loc24_:int = 76;
         var _loc7_:int = 77;
         var _loc26_:int = 12;
         var _loc15_:int = 55;
         var _loc27_:int = 7;
         _loc22_ = 1;
         while(_loc22_ < 10 + 1)
         {
            _loc10_ = _loc22_ > param2;
            _loc14_ = _loc22_ - 1;
            _loc12_ = assetRepository.getDisplayObject("BackgroundLight");
            _loc12_.width = _loc8_;
            _loc12_.height = _loc13_;
            _loc12_.x = _loc20_;
            _loc12_.y = _loc25_ + _loc14_ * _loc27_ + _loc14_ * _loc13_;
            addChild(_loc12_);
            _loc9_ = new CaptionTextField();
            _loc9_.width = _loc15_;
            _loc9_.defaultTextFormat = WomTextFormats.CENTER_18;
            _loc9_.text = "SLOT " + _loc22_;
            AlignmentUtil.alignBelowWithXMarginOf(_loc9_,_loc12_,_loc26_,-30);
            addChild(_loc9_);
            _loc16_ = new WomTextInput();
            _loc16_.width = _loc21_;
            _loc16_.height = _loc5_;
            if(param1 && param1[_loc22_])
            {
               _loc16_.text = param1[_loc22_].name;
            }
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc16_,_loc12_,_loc24_);
            if(_loc10_)
            {
               _loc16_.enabled = false;
            }
            _layoutNameInputs[_loc22_] = _loc16_;
            addChild(_loc16_);
            _loc18_ = new WomBlueSmallButton();
            var _temp_6:* = _loc18_;
            var _loc28_:String = "ui.windows.cityplanner.buy";
            _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc28_);
            _loc17_ = assetRepository.getDisplayObject("Gold");
            _loc17_.height = _loc17_.height * (24 / _loc17_.width) >> 0;
            _loc17_.width = 24;
            _loc18_.setStyle("icon",_loc17_);
            _loc18_.rightLabel = param3[_loc14_] + "";
            _loc18_.width = 116;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc18_,_loc12_,224);
            _loc18_.data = _loc22_;
            _loc18_.visible = _loc10_;
            _buyWithGoldButtons[_loc22_] = _loc18_;
            addChild(_loc18_);
            _loc11_ = new WomGreenSmallButton();
            var _temp_9:* = _loc11_;
            var _loc29_:String = "ui.windows.cityplanner.buy";
            _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc29_);
            _loc23_ = assetRepository.getDisplayObject("Rp");
            _loc23_.height = _loc23_.height * (21 / _loc23_.width) >> 0;
            _loc23_.width = 21;
            _loc11_.setStyle("icon",_loc23_);
            _loc11_.rightLabel = param4[_loc14_] + "";
            _loc11_.width = 116;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc11_,_loc12_,352);
            _loc11_.data = _loc22_;
            _loc11_.visible = _loc10_;
            _buyWithRPButtons[_loc22_] = _loc11_;
            addChild(_loc11_);
            var _temp_11:* = assetRepository;
            var _loc30_:String = "ui.windows.cityplanner.or";
            _loc19_ = _temp_11.getDisplayObject(peak.i18n.PText.INSTANCE.getText0(_loc30_));
            _loc19_.width = 24;
            _loc19_.height = 24;
            _loc19_.visible = _loc10_;
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc19_,_loc12_,335);
            _orIcons[_loc22_] = _loc19_;
            addChild(_loc19_);
            if(_loc22_ > param2 + 1)
            {
               _loc18_.enabled = false;
               _loc11_.enabled = false;
            }
            _loc6_ = new WomBlueSmallButton();
            _loc6_.width = _loc7_;
            var _temp_14:* = _loc6_;
            var _loc31_:String = "ui.windows.cityplanner.save";
            _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc31_);
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_loc6_,_loc12_,392);
            _loc6_.data = _loc22_;
            _loc6_.visible = !_loc10_;
            _layoutSaveButtons[_loc22_] = _loc6_;
            addChild(_loc6_);
            _loc22_++;
         }
      }
      
      public function get layoutNameInputs() : Array
      {
         return _layoutNameInputs;
      }
      
      public function get layoutSaveButtons() : Array
      {
         return _layoutSaveButtons;
      }
      
      public function get buyWithGoldButtons() : Array
      {
         return _buyWithGoldButtons;
      }
      
      public function get buyWithRPButtons() : Array
      {
         return _buyWithRPButtons;
      }
   }
}

