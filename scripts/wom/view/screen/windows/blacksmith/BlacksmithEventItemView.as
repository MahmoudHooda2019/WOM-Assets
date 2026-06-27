package wom.view.screen.windows.blacksmith
{
   import flash.display.DisplayObject;
   import peak.display.CustomCursorAwareSprite;
   import peak.display.View;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class BlacksmithEventItemView extends CustomCursorAwareSprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var _index:int;
      
      private var lockIcon:DisplayObject;
      
      private var _eventItemAsset:AssetDisplayObject;
      
      private var reference:int = 0;
      
      private var emptyTextField:CaptionTextField;
      
      public function BlacksmithEventItemView(param1:EventItemDIO, param2:int)
      {
         super();
         _eventItemDIO = param1;
         _index = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         mouseChildren = false;
         _eventItemAsset = assetRepository.getDisplayObject(isEmpty ? "BackgroundDark" : _eventItemDIO.assetName);
         _eventItemAsset.width = 54;
         _eventItemAsset.height = 51;
         addChild(_eventItemAsset);
         emptyTextField = new CaptionTextField();
         emptyTextField.alpha = 0.8;
         emptyTextField.autoSize = "left";
         emptyTextField.defaultTextFormat = WomTextFormats.CENTER_32;
         emptyTextField.text = "?";
         emptyTextField.visible = isEmpty;
         _eventItemAsset.addChild(emptyTextField);
         lockIcon = assetRepository.getDisplayObject("Lock");
         lockIcon.scaleX = lockIcon.scaleY = 0.6;
         lockIcon.visible = false;
         addChild(lockIcon);
      }
      
      public function updateEventItemView(param1:EventItemDIO) : void
      {
         _eventItemDIO = param1;
         if(contains(_eventItemAsset))
         {
            removeChild(_eventItemAsset);
         }
         _eventItemAsset = assetRepository.getDisplayObject(param1 == null ? "BackgroundDark" : _eventItemDIO.assetName);
         _eventItemAsset.width = 54;
         _eventItemAsset.height = 51;
         addChild(_eventItemAsset);
      }
      
      public function drawLayout() : void
      {
         _eventItemAsset.x = _eventItemAsset.y = reference;
         AlignmentUtil.alignMiddleOf(emptyTextField,_eventItemAsset);
         AlignmentUtil.alignMiddleOf(lockIcon,_eventItemAsset);
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
      
      public function get eventItemAsset() : AssetDisplayObject
      {
         return _eventItemAsset;
      }
      
      public function enlargedView() : void
      {
         _eventItemAsset.scaleX = _eventItemAsset.scaleY = 1.08;
         reference = -2;
         drawLayout();
      }
      
      public function normalView() : void
      {
         _eventItemAsset.scaleX = _eventItemAsset.scaleY = 1;
         reference = 0;
         drawLayout();
      }
      
      public function get isEmpty() : Boolean
      {
         return _eventItemDIO == null;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function updateViewState(param1:Boolean) : void
      {
         if(!isEmpty)
         {
            lockIcon.visible = !param1;
            _eventItemAsset.alpha = param1 ? 1 : 0.6;
         }
      }
      
      public function isLocked() : Boolean
      {
         return lockIcon.visible;
      }
   }
}

