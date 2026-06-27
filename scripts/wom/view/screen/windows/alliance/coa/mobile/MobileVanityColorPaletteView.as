package wom.view.screen.windows.alliance.coa.mobile
{
   import feathers.core.ToggleGroup;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.alliance.coa.VanityColorType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileVanityColorPaletteView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _closeButton:MPButton;
      
      private var _colorBG:DisplayObject;
      
      private var _colorViews:Vector.<MobileVanityColorRadioButton>;
      
      private var _radioButtonGroup:ToggleGroup;
      
      private var _selectorId:int;
      
      public function MobileVanityColorPaletteView(param1:int)
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
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("MobileTransparentBackground");
         _loc2_.width = 494;
         _loc2_.height = 312;
         addChild(_loc2_);
         _colorBG = assetRepository.getDisplayObject("MobileBeigeBackground");
         _colorBG.width = 458;
         _colorBG.height = 237;
         _colorBG.x = 17;
         _colorBG.y = 54;
         addChild(_colorBG);
         var _loc1_:MobileWomTextField = new MobileCaptionTextField();
         _loc1_.textRendererProperties.textFormat = getCaptionTextFormat(27);
         var _temp_3:* = _loc1_;
         var _temp_2:* = "ui.windows.alliance.browse.create.colorpaletteheader";
         var _loc3_:int = _selectorId;
         var _loc4_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         addChild(_loc1_);
         MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,_loc2_,22,16);
         _closeButton = new MPRigidButton("ButtonClose","ButtonCloseHover");
         addChild(_closeButton);
         MobileAlignmentUtil.alignAccordingToPositionOf(_closeButton,_loc2_,_loc2_.width - _closeButton.width + 11,-10);
      }
      
      public function initLayout() : void
      {
         var _loc3_:int = 0;
         var _loc1_:MobileVanityColorRadioButton = null;
         drawBackgroundsAndHeader();
         _radioButtonGroup = new ToggleGroup();
         _radioButtonGroup.isSelectionRequired = true;
         _colorViews = new Vector.<MobileVanityColorRadioButton>();
         var _loc2_:Array = VanityColorType.colorTypes;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = new MobileVanityColorRadioButton(_loc2_[_loc3_]);
            _loc1_.toggleGroup = _radioButtonGroup;
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,_colorBG,22 + 71 * (_loc3_ % 6),20 + 68 * (int(_loc3_ / 6)));
            addChild(_loc1_);
            _colorViews.push(_loc1_);
            _loc3_++;
         }
      }
      
      public function selectColor(param1:VanityColorType) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MobileVanityColorRadioButton = null;
         _loc3_ = 0;
         while(_loc3_ < _colorViews.length)
         {
            _loc2_ = _colorViews[_loc3_];
            if(param1 == _loc2_.colorType)
            {
               _loc2_.isSelected = true;
            }
            _loc3_++;
         }
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get selectorId() : int
      {
         return _selectorId;
      }
      
      public function get radioButtonGroup() : ToggleGroup
      {
         return _radioButtonGroup;
      }
      
      public function get closeButton() : MPButton
      {
         return _closeButton;
      }
   }
}

