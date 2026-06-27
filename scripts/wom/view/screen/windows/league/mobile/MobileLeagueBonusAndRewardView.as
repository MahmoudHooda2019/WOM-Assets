package wom.view.screen.windows.league.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.league.LeagueBonusAndRewardDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLeagueBonusAndRewardView extends Sprite implements View
   {
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var _bonusAndRewardDTO:LeagueBonusAndRewardDTO;
      
      private var _prefixTextField:MPTextField;
      
      private var _asset:DisplayObject;
      
      private var _suffixTextField:MPTextField;
      
      public function MobileLeagueBonusAndRewardView(param1:MobileWomAssetRepository, param2:LeagueBonusAndRewardDTO)
      {
         super();
         _bonusAndRewardDTO = param2;
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _prefixTextField = new MobileWomTextField();
         _prefixTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_prefixTextField);
         _prefixTextField.text = _bonusAndRewardDTO.prefix;
         _asset = assetRepository.getDisplayObject(_bonusAndRewardDTO.assetId);
         addChild(_asset);
         _suffixTextField = new MobileWomTextField();
         _suffixTextField.textRendererProperties.textFormat = getCaptionTextFormat(25);
         addChild(_suffixTextField);
         _suffixTextField.text = _bonusAndRewardDTO.suffix;
      }
      
      public function drawLayout() : void
      {
         _prefixTextField.validate();
         _suffixTextField.validate();
         _asset.x = _prefixTextField.text != "" ? _prefixTextField.x + _prefixTextField.width + 5 : 0;
         _asset.y = 0;
         MobileAlignmentUtil.alignMiddleYAxisOf(_prefixTextField,_asset);
         MobileAlignmentUtil.alignMiddleYAxisOf(_suffixTextField,_asset);
         _suffixTextField.x = _asset.x + _asset.width - 15;
      }
      
      public function get asset() : DisplayObject
      {
         return _asset;
      }
   }
}

