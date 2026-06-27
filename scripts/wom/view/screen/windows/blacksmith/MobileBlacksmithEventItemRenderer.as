package wom.view.screen.windows.blacksmith
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPItemRenderer;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileBlacksmithEventItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _eventItemData:Object;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _eventItemButton:MobileWomButton;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var lockIcon:DisplayObject;
      
      private var _isLocked:Boolean;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _levelShield:DisplayObject;
      
      private var _levelInfoTextField:MobileCaptionTextField;
      
      public function MobileBlacksmithEventItemRenderer(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
      }
      
      override protected function initialize() : void
      {
         if(!this._eventItemButton)
         {
            _eventItemButton = MobileWomUIComponentFactory.createMobileColoredButton("Beige","Large");
            _eventItemButton.width = 92;
            addChild(_eventItemButton);
            lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
            lockIcon.touchable = false;
            addChild(lockIcon);
            _levelShield = assetRepository.getDisplayObject("IconLevelBeastMBordered");
            _levelShield.touchable = false;
            _levelShield.visible = false;
            addChild(_levelShield);
            _levelInfoTextField = new MobileCaptionTextField();
            _levelInfoTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
            _levelInfoTextField.touchable = false;
            _levelInfoTextField.visible = false;
            addChild(_levelInfoTextField);
            drawLayout();
         }
      }
      
      public function drawLayout() : void
      {
         _eventItemButton.x = 16;
         _eventItemButton.y = 13;
         MobileAlignmentUtil.alignMiddleOf(lockIcon,_eventItemButton);
         _levelShield.x = 0;
         _levelShield.y = 0;
         MobileAlignmentUtil.alignAccordingToPositionOf(_levelInfoTextField,_levelShield,20,10);
      }
      
      override public function get data() : Object
      {
         return _eventItemData;
      }
      
      override public function set data(param1:Object) : void
      {
         if(param1)
         {
            _eventItemData = param1;
            _eventItemDIO = param1.eventItemDIO;
            _isLocked = param1.isLocked;
            _unitTypeInfo = "unitTypeInfo" in param1 ? param1.unitTypeInfo : null;
            updateRenderer();
            drawLayout();
         }
      }
      
      private function updateRenderer() : void
      {
         var _loc1_:DisplayObject = null;
         if(isEmpty())
         {
            _eventItemButton.label = "?";
            _eventItemButton.defaultIcon = null;
            _eventItemButton.isSelected = true;
         }
         else
         {
            _eventItemButton.label = "";
            _loc1_ = assetRepository.getDisplayObject(_eventItemDIO.assetName.substring(0,_eventItemDIO.assetName.length - 4) + "Portrait");
            _loc1_.alpha = _isLocked ? 0.6 : 1;
            _eventItemButton.defaultIcon = _loc1_;
            _eventItemButton.isSelected = false;
         }
         lockIcon.visible = _isLocked;
         _levelShield.visible = _levelInfoTextField.visible = _unitTypeInfo;
         if(_unitTypeInfo)
         {
            _levelInfoTextField.text = "" + _unitTypeInfo.currentLevel;
         }
      }
      
      private function isEmpty() : Boolean
      {
         return _eventItemDIO == null;
      }
      
      public function get eventItemButton() : MobileWomButton
      {
         return _eventItemButton;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
   }
}

