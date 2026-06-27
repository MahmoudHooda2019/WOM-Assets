package wom.view.screen.windows.tavern.unlock
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.TavernItemDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTavernUnlockedCardView extends MobileBaseTavernUnlockedCardView
   {
      
      private var _probability:int;
      
      private var _probabilityTextField:MPTextField;
      
      private var _placeholderTextField:MPTextField;
      
      private var _tavernItemDIO:TavernItemDIO;
      
      private var _tavernItemAsset:DisplayObject;
      
      public function MobileTavernUnlockedCardView(param1:int)
      {
         super();
         _probability = param1;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _probabilityTextField = new MobileCaptionTextField();
         _probabilityTextField.textRendererProperties.textFormat = getCaptionTextFormat(19,"center");
         _probabilityTextField.textRendererProperties.multiline = true;
         _probabilityTextField.textRendererProperties.wordWrap = true;
         _probabilityTextField.width = 90 + 4;
         addChild(_probabilityTextField);
         var _temp_2:* = _probabilityTextField;
         var _loc1_:String = "domain.tavern.unlock.probability." + _probability;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_placeholderTextField)
         {
            MobileAlignmentUtil.alignMiddleOf(_placeholderTextField,background);
            _placeholderTextField.y += 5;
            _placeholderTextField.x -= 3;
         }
         if(_tavernItemAsset)
         {
            _tavernItemAsset.visible = _tavernItemAsset.width > 0;
            MobileAlignmentUtil.alignMiddleOf(_tavernItemAsset,background);
         }
         if(_probabilityTextField)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_probabilityTextField,background,background.height + 10);
         }
      }
      
      private function clear() : void
      {
         if(_placeholderTextField && contains(_placeholderTextField))
         {
            removeChild(_placeholderTextField);
            _placeholderTextField = null;
         }
         if(_tavernItemAsset && contains(_tavernItemAsset))
         {
            removeChild(_tavernItemAsset);
            _tavernItemAsset = null;
         }
      }
      
      public function update(param1:TavernItemDIO, param2:Boolean = false) : Boolean
      {
         var _loc3_:Boolean = param2 && _tavernItemDIO == null && param1 != null;
         _tavernItemDIO = param1;
         clear();
         if(_tavernItemDIO != null)
         {
            resetBackgroundWithAsset(assetRepository.getDisplayObject("MercEmptyBackground"));
            _tavernItemAsset = assetRepository.getDisplayObject(_tavernItemDIO.assetName);
            addChild(_tavernItemAsset);
            _tavernItemAsset.addEventListener("change",onAssetChanged);
         }
         else
         {
            _placeholderTextField = new MobileCaptionTextField();
            _placeholderTextField.textRendererProperties.textFormat = getCaptionTextFormat(42,"center");
            _placeholderTextField.textRendererProperties.autoSize = "horizontal";
            addChild(_placeholderTextField);
            _placeholderTextField.text = "?";
         }
         drawLayout();
         return _loc3_;
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         drawLayout();
      }
      
      public function get tavernItemDIO() : TavernItemDIO
      {
         return _tavernItemDIO;
      }
   }
}

