package wom.view.screen.windows.league
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class LeagueBonusAndRewardView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _bonusAndRewardDTO:LeagueBonusAndRewardDTO;
      
      private var _prefixTextField:TextField;
      
      private var _asset:DisplayObject;
      
      private var _suffixTextField:TextField;
      
      public function LeagueBonusAndRewardView(param1:LeagueBonusAndRewardDTO)
      {
         super();
         _bonusAndRewardDTO = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _prefixTextField = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
         _prefixTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _prefixTextField.autoSize = "left";
         addChild(_prefixTextField);
         _prefixTextField.text = _bonusAndRewardDTO.prefix;
         _asset = assetRepository.getDisplayObject(_bonusAndRewardDTO.assetId);
         addChild(_asset);
         _suffixTextField = new CaptionTextField(WomTextFormats.RED_BUTTON_FILTER);
         _suffixTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _suffixTextField.autoSize = "left";
         addChild(_suffixTextField);
         _suffixTextField.text = _bonusAndRewardDTO.suffix;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _prefixTextField.x = 0;
         _prefixTextField.y = 5;
         _asset.x = _prefixTextField.x + _prefixTextField.width + 2;
         _asset.y = 0;
         _suffixTextField.x = _asset.x + _asset.width + 2;
         _suffixTextField.y = 5;
      }
      
      public function get asset() : DisplayObject
      {
         return _asset;
      }
   }
}

