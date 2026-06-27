package wom.view.screen.windows.beast.keeper
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastStatusType;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   
   public class BeastKeeperItemView extends Sprite implements View
   {
      
      private static const WIDTH:int = 157;
      
      private static const HEIGHT:int = 218;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _beastLevel:int;
      
      private var _beastStatusType:BeastStatusType;
      
      private var _background:DisplayObject;
      
      private var _beastAsset:DisplayObject;
      
      private var _chainAsset:DisplayObject;
      
      private var _lockAsset:DisplayObject;
      
      private var _beastNameTextField:TextField;
      
      private var _beastLevelTextField:TextField;
      
      private var _beastCaveInfoTextField:TextField;
      
      private var _actionButton:Button;
      
      public function BeastKeeperItemView(param1:BeastTypeDIO, param2:int, param3:BeastStatusType)
      {
         super();
         _beastDIO = param1;
         _beastLevel = param2;
         _beastStatusType = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("BackgroundLight");
         _background.width = 157;
         _background.height = 218;
         addChild(_background);
         _beastAsset = assetRepository.getDisplayObject(_beastDIO.assetName + _beastLevel);
         addChild(_beastAsset);
         _chainAsset = assetRepository.getDisplayObject("BeastKeeperCageChain");
         addChild(_chainAsset);
         _lockAsset = assetRepository.getDisplayObject("Lock");
         _lockAsset.alpha = 0.9;
         addChild(_lockAsset);
         _beastNameTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         _beastNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_20;
         _beastNameTextField.autoSize = "left";
         var _temp_6:* = _beastNameTextField;
         var _loc1_:String = "domain.beasts." + _beastDIO.id + ".name";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_beastNameTextField);
         _beastLevelTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _beastLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _beastLevelTextField.autoSize = "left";
         var _temp_9:* = _beastLevelTextField;
         var _temp_8:* = "ui.windows.beast.keeper.level";
         var _loc2_:int = _beastLevel;
         var _loc3_:String = _temp_8;
         _temp_9.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         addChild(_beastLevelTextField);
         _beastCaveInfoTextField = new WomTextField();
         _beastCaveInfoTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _beastCaveInfoTextField.multiline = true;
         _beastCaveInfoTextField.wordWrap = true;
         _beastCaveInfoTextField.width = 180;
         _beastCaveInfoTextField.autoSize = "left";
         var _temp_11:* = _beastCaveInfoTextField;
         var _loc4_:String = "ui.windows.beast.keeper.cavetooltip";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _beastCaveInfoTextField.visible = false;
         addChild(_beastCaveInfoTextField);
         if(_beastStatusType == BeastStatusType.IN_CAVE)
         {
            _actionButton = new WomBrownSmallButton();
            var _temp_13:* = _actionButton;
            var _loc5_:String = "ui.windows.beast.keeper.cavebutton";
            _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         else if(_beastStatusType == BeastStatusType.IN_KEEPER)
         {
            _actionButton = new WomBlueSmallButton();
            var _temp_15:* = _actionButton;
            var _loc6_:String = "ui.windows.beast.keeper.unleashbutton";
            _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         else
         {
            _actionButton = new WomGreenSmallButton();
            if(_beastDIO.unlocked)
            {
               var _temp_17:* = _actionButton;
               var _loc7_:String = "ui.windows.beast.keeper.raise";
               _temp_17.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
            }
            else
            {
               var _temp_18:* = _actionButton;
               var _loc8_:String = "ui.windows.beast.keeper.get";
               _temp_18.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            }
         }
         _actionButton.width = 121;
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:Number = NaN;
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            if(_beastAsset.width / _beastAsset.height > 0.7122641509433962)
            {
               _loc1_ = (157 - 6) / _beastAsset.width;
            }
            else
            {
               _loc1_ = (218 - 6) / _beastAsset.height;
            }
            _beastAsset.scaleX = _beastAsset.scaleY = _loc1_;
            AlignmentUtil.alignMiddleOf(_beastAsset,_background);
         }
         _chainAsset.visible = _chainAsset.width > 1;
         if(_chainAsset.visible)
         {
            AlignmentUtil.alignMiddleOf(_chainAsset,_background);
         }
         _lockAsset.visible = _lockAsset.width > 1;
         if(_lockAsset.visible)
         {
            AlignmentUtil.alignMiddleOf(_lockAsset,_background);
         }
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_background.height - _actionButton.height / 2);
         if(_beastStatusType == BeastStatusType.IN_CAVE)
         {
            _chainAsset.visible = false;
            _lockAsset.visible = false;
         }
         else if(_beastStatusType == BeastStatusType.IN_KEEPER)
         {
            _chainAsset.visible = true;
            _lockAsset.visible = false;
         }
         else
         {
            _chainAsset.visible = false;
            _lockAsset.visible = true;
         }
         AlignmentUtil.alignAccordingToPositionOf(_beastNameTextField,_background,12,-9);
         AlignmentUtil.alignBelowOf(_beastLevelTextField,_beastNameTextField,-7);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastCaveInfoTextField,_background,_background.height + _actionButton.height / 2 + 5);
      }
      
      public function showCaveTooltip(param1:Boolean) : void
      {
         _beastCaveInfoTextField.visible = param1;
      }
      
      public function get beastDIO() : BeastTypeDIO
      {
         return _beastDIO;
      }
      
      public function get beastStatusType() : BeastStatusType
      {
         return _beastStatusType;
      }
      
      public function get beastAsset() : DisplayObject
      {
         return _beastAsset;
      }
      
      public function get chainAsset() : DisplayObject
      {
         return _chainAsset;
      }
      
      public function get lockAsset() : DisplayObject
      {
         return _lockAsset;
      }
      
      public function get actionButton() : Button
      {
         return _actionButton;
      }
   }
}

