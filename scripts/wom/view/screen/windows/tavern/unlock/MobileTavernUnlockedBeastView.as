package wom.view.screen.windows.tavern.unlock
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTavernUnlockedBeastView extends MobileBaseTavernUnlockedCardView
   {
      
      public static const WIDTH:int = 93;
      
      public static const HEIGHT:int = 93;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _beastAsset:DisplayObject;
      
      private var _beastNameTextField:MPTextField;
      
      public function MobileTavernUnlockedBeastView()
      {
         super(93,93);
         _beastDIO = null;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         resetBackgroundWithAsset(assetRepository.getDisplayObject("BeigeLargeBackground"));
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_beastAsset)
         {
            _beastAsset.visible = _beastAsset.width > 0;
            MobileAlignmentUtil.alignMiddleOf(_beastAsset,background);
         }
         if(_beastNameTextField)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastNameTextField,background,92);
         }
      }
      
      private function clear() : void
      {
         if(_beastAsset && contains(_beastAsset))
         {
            removeChild(_beastAsset);
         }
         if(_beastNameTextField && contains(_beastNameTextField))
         {
            removeChild(_beastNameTextField);
         }
      }
      
      public function update(param1:BeastTypeDIO) : void
      {
         if(param1 == null)
         {
            return;
         }
         _beastDIO = param1;
         clear();
         _beastAsset = assetRepository.getDisplayObject(_beastDIO.assetName + "Portrait6");
         addChild(_beastAsset);
         _beastAsset.addEventListener("change",onAssetChanged);
         _beastNameTextField = new MobileCaptionTextField();
         _beastNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         _beastNameTextField.textRendererProperties.autoSize = "vertical";
         addChild(_beastNameTextField);
         var _temp_4:* = _beastNameTextField;
         var _loc2_:String = "domain.beasts." + _beastDIO.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         drawLayout();
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         drawLayout();
      }
   }
}

