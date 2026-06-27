package wom.view.screen.windows.tavern
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTavernGiftAssetNameView extends Sprite implements View
   {
      
      public static const WIDTH:int = 155;
      
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tavernItemDIO:TavernItemDIO;
      
      private var _tavernItemAsset:DisplayObject;
      
      private var _tavernItemNameTextField:MPTextField;
      
      public function MobileTavernGiftAssetNameView(param1:MobileWomAssetRepository, param2:TavernItemDIO)
      {
         super();
         _tavernItemDIO = param2;
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
         _tavernItemAsset = assetRepository.getDisplayObject(_tavernItemDIO.assetName);
         addChild(_tavernItemAsset);
         _tavernItemNameTextField = new MobileCaptionTextField();
         _tavernItemNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         _tavernItemNameTextField.textRendererProperties.wordWrap = true;
         _tavernItemNameTextField.width = 100;
         addChild(_tavernItemNameTextField);
         var _temp_3:* = _tavernItemNameTextField;
         var _loc1_:String = "domain.tavern.items." + _tavernItemDIO.id + ".name";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
      }
      
      public function drawLayout() : void
      {
         _tavernItemAsset.visible = _tavernItemAsset.width > 0;
         _tavernItemAsset.x = 155 - _tavernItemAsset.width >> 1;
         _tavernItemAsset.y = -_tavernItemAsset.height + 15;
         _tavernItemNameTextField.x = 155 - _tavernItemNameTextField.width >> 1;
         _tavernItemNameTextField.y = 8;
      }
      
      public function get tavernItemAsset() : DisplayObject
      {
         return _tavernItemAsset;
      }
   }
}

