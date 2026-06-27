package wom.view.screen.windows.alliance.coa
{
   import fl.controls.RadioButtonGroup;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class VanityColorPaletteView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _colorViews:Vector.<VanityColorRadioButton>;
      
      private var _radioButtonGroup:RadioButtonGroup;
      
      private var _selectorId:int;
      
      public function VanityColorPaletteView(param1:int)
      {
         super();
         _selectorId = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function drawBackgroundsAndHeader() : void
      {
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("TooltipBackgroundSkin");
         _loc3_.width = 180;
         _loc3_.height = 111;
         addChild(_loc3_);
         var _loc4_:DisplayObject = assetRepository.getDisplayObject("TooltipsBottomPin");
         addChild(_loc4_);
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("TooltipInnerBackground");
         _loc1_.width = 165;
         _loc1_.height = 90;
         addChild(_loc1_);
         var _loc2_:WomTextField = new CaptionTextField();
         _loc2_.defaultTextFormat = WomTextFormats.CAPTION_16;
         _loc2_.autoSize = "left";
         var _temp_2:* = _loc2_;
         var _temp_1:* = "ui.windows.alliance.browse.create.colorpaletteheader";
         var _loc5_:int = _selectorId;
         var _loc6_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         addChild(_loc2_);
         AlignmentUtil.alignAccordingToPositionOf(_loc4_,_loc3_,11,_loc3_.height - _loc4_.height + 5);
         AlignmentUtil.alignAccordingToPositionOf(_loc1_,_loc3_,6,12);
         AlignmentUtil.alignAccordingToPositionOf(_loc2_,_loc3_,16,-8);
      }
      
      public function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:VanityColorRadioButton = null;
         drawBackgroundsAndHeader();
         _radioButtonGroup = new RadioButtonGroup("ColorGroup");
         _colorViews = new Vector.<VanityColorRadioButton>();
         var _loc2_:Array = VanityColorType.colorTypes;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new VanityColorRadioButton(_loc2_[_loc3_]);
            _loc1_.group = _radioButtonGroup;
            _loc1_.x = 10 + 25 * (_loc3_ % 6);
            _loc1_.y = 23 + 25 * (int(_loc3_ / 6));
            addChild(_loc1_);
            _colorViews.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function selectColor(param1:VanityColorType) : void
      {
         var _loc3_:int = 0;
         var _loc2_:VanityColorRadioButton = null;
         _loc3_ = 0;
         while(_loc3_ < _colorViews.length)
         {
            _loc2_ = _colorViews[_loc3_];
            if(param1 == _loc2_.colorType)
            {
               _loc2_.selected = true;
            }
            _loc3_++;
         }
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get colorViews() : Vector.<VanityColorRadioButton>
      {
         return _colorViews;
      }
      
      public function get selectorId() : int
      {
         return _selectorId;
      }
   }
}

