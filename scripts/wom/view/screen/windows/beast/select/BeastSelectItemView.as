package wom.view.screen.windows.beast.select
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.component.PTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomBrownSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   
   public class BeastSelectItemView extends Sprite implements View
   {
      
      public static const WIDTH:int = 159;
      
      public static const HEIGHT:int = 419;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _alreadyRaised:Boolean;
      
      private var _background:DisplayObject;
      
      private var _beastAsset:AssetDisplayObject;
      
      private var _lockAsset:AssetDisplayObject;
      
      private var _beastNameTextField:TextField;
      
      private var _beastTitleTextField:TextField;
      
      private var _beastDescTextField:PTextField;
      
      private var _raiseButton:WomButton;
      
      public function BeastSelectItemView(param1:BeastTypeDIO, param2:Boolean = false)
      {
         super();
         _beastDIO = param1;
         _alreadyRaised = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("TransparentAsset");
         _background.width = 159;
         _background.height = 419;
         addChild(_background);
         _beastAsset = assetRepository.getDisplayObject(_beastDIO.assetName + "6");
         addChild(_beastAsset);
         if(!_beastDIO.unlocked)
         {
            _beastAsset.alpha = 0.5;
            _lockAsset = assetRepository.getDisplayObject("Lock");
            addChild(_lockAsset);
         }
         _beastNameTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _beastNameTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _beastNameTextField.autoSize = "left";
         addChild(_beastNameTextField);
         var _temp_5:* = _beastNameTextField;
         var _loc1_:String = "domain.beasts." + _beastDIO.id + ".name";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _beastTitleTextField = new CaptionTextField(WomTextFormats.DEFAULT_FILTER);
         _beastTitleTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         _beastTitleTextField.autoSize = "left";
         addChild(_beastTitleTextField);
         var _temp_7:* = _beastTitleTextField;
         var _loc2_:String = "domain.beasts." + _beastDIO.id + ".title";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         if(_alreadyRaised)
         {
            _raiseButton = new WomBrownSmallButton();
            var _temp_9:* = _raiseButton;
            var _loc3_:String = "ui.windows.beast.keeper.raised";
            _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            _raiseButton.enabled = false;
         }
         else if(!_beastDIO.unlocked)
         {
            _raiseButton = new WomGreenSmallButton();
            var _temp_11:* = _raiseButton;
            var _loc4_:String = "ui.windows.beast.keeper.get";
            _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else
         {
            _raiseButton = new WomBlueSmallButton();
            var _temp_13:* = _raiseButton;
            var _loc5_:String = "ui.windows.beast.keeper.raise";
            _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         _raiseButton.width = 76;
         addChild(_raiseButton);
         _beastDescTextField = new WomTextField();
         _beastDescTextField.defaultTextFormat = WomTextFormats.CENTER_16;
         _beastDescTextField.extraCharWidth = 1.5;
         _beastDescTextField.multiline = true;
         _beastDescTextField.wordWrap = true;
         _beastDescTextField.autoSize = "center";
         _beastDescTextField.width = 150;
         addChild(_beastDescTextField);
         var _temp_15:* = _beastDescTextField;
         var _loc6_:String = "domain.beasts." + _beastDIO.id + ".desc";
         _temp_15.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastNameTextField,_background,-9);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastTitleTextField,_background,9);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_raiseButton,_background,171);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastDescTextField,_background,210);
         _beastAsset.visible = _beastAsset.width > 1;
         if(_beastAsset.visible)
         {
            _beastAsset.scaleX = _beastAsset.scaleY = _beastDIO.selectViewScale;
            AlignmentUtil.alignAccordingToPositionOf(_beastAsset,_background,_beastDIO.selectViewOffset.x,_beastDIO.selectViewOffset.y);
            if(_lockAsset)
            {
               AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_lockAsset,_background,85);
            }
         }
      }
      
      public function get beastAsset() : AssetDisplayObject
      {
         return _beastAsset;
      }
      
      public function get raiseButton() : WomButton
      {
         return _raiseButton;
      }
      
      public function get beastDIO() : BeastTypeDIO
      {
         return _beastDIO;
      }
   }
}

