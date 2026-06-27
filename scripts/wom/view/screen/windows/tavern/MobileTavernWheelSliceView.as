package wom.view.screen.windows.tavern
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTavernWheelSliceView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tavernItemDIO:TavernItemDIO;
      
      private var _background:DisplayObject;
      
      private var _tavernItemAsset:DisplayObject;
      
      private var _tavernItemNameTF:MPTextField;
      
      public function MobileTavernWheelSliceView(param1:TavernItemDIO)
      {
         super();
         _tavernItemDIO = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("TavernWheelSlice");
         addChild(_background);
         _tavernItemAsset = assetRepository.getDisplayObject(_tavernItemDIO.assetName);
         addChild(_tavernItemAsset);
         _tavernItemAsset.scaleX = _tavernItemDIO.scale;
         _tavernItemAsset.scaleY = _tavernItemDIO.scale;
         _tavernItemNameTF = new MobileCaptionTextField();
         _tavernItemNameTF.textRendererProperties.textFormat = getCaptionTextFormat(17,"right");
         _tavernItemNameTF.width = 75;
         _tavernItemNameTF.textRendererProperties.wordWrap = true;
         addChild(_tavernItemNameTF);
         var _temp_4:* = _tavernItemNameTF;
         var _loc1_:String = "domain.tavern.items." + _tavernItemDIO.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_tavernItemAsset,_background,_background.width - _tavernItemAsset.width - 3);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_tavernItemNameTF,_background,18);
      }
      
      public function get tavernItemAsset() : DisplayObject
      {
         return _tavernItemAsset;
      }
   }
}

