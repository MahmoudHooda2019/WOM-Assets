package wom.view.screen.windows.event
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileEventStoreItemView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var eventItemDIO:EventItemDIO;
      
      private var itemAsset:DisplayObject;
      
      private var itemNameHeader:MPTextField;
      
      private var isLocked:Boolean;
      
      private var _itemData:Object;
      
      private var lockIcon:DisplayObject;
      
      private var _hintButton:MPRigidButton;
      
      private var _unlockButton:MobileWomButton;
      
      private var _eventStoreItemInfo:EventStoreItemInfo;
      
      private var itemStateTextField:MobileCaptionTextField;
      
      public function MobileEventStoreItemView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 344;
         background.height = 502;
         background.y = 11;
         addChild(background);
         itemNameHeader = new MobileCaptionTextField();
         itemNameHeader.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         itemNameHeader.width = 344 - 80;
         addChild(itemNameHeader);
         lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
         lockIcon.visible = false;
         addChild(lockIcon);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         _unlockButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         var _temp_6:* = _unlockButton;
         var _loc1_:String = "ui.windows.eventstore.unlock";
         _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _unlockButton.defaultIcon = assetRepository.getDisplayObject("IconEPBig");
         _unlockButton.rightLabel = "    ";
         _unlockButton.width = 230;
         addChild(_unlockButton);
         _unlockButton.visible = false;
         itemStateTextField = new MobileCaptionTextField();
         itemStateTextField.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         itemStateTextField.width = background.width - 8;
         addChild(itemStateTextField);
         itemStateTextField.visible = false;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemNameHeader,background,-10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleOf(lockIcon,background);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unlockButton,background,502 - 45);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemStateTextField,background,502 - 60);
      }
      
      private function clearItem() : void
      {
         if(itemAsset)
         {
            if(contains(itemAsset))
            {
               removeChild(itemAsset);
            }
         }
      }
      
      public function updateItemData(param1:Object) : void
      {
         this.data = param1;
         clearItem();
         itemAsset = assetRepository.getDisplayObject(eventItemDIO.assetName.replace("Icon","").replace("LongBowman","Longbowman"));
         _unlockButton.rightLabel = "" + _eventStoreItemInfo.unlockCost;
         _unlockButton.validate();
         addChildAt(itemAsset,1);
         itemAsset.alpha = isLocked ? 0.5 : 1;
         lockIcon.visible = isLocked;
         itemNameHeader.text = eventItemDIO.name;
         MobileAlignmentUtil.alignMiddleOf(itemAsset,background);
         itemStateTextField.visible = !isLocked;
         _unlockButton.visible = isLocked;
         var _loc2_:String;
         var _loc3_:String;
         itemStateTextField.text = isLocked ? (_loc2_ = "ui.windows.eventstore.locked",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : (_loc3_ = "ui.windows.eventstore.unlocked",peak.i18n.PText.INSTANCE.getText0(_loc3_));
         drawLayout();
      }
      
      public function get data() : Object
      {
         return _itemData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            _itemData = param1;
            _eventStoreItemInfo = param1.eventStoreItemInfo;
            eventItemDIO = param1.eventItemDIO;
            isLocked = param1.isLocked;
         }
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileEventStoreItemViewRenderer).onHintButtonClicked();
      }
      
      public function get unlockButton() : MobileWomButton
      {
         return _unlockButton;
      }
      
      public function get eventStoreItemInfo() : EventStoreItemInfo
      {
         return _eventStoreItemInfo;
      }
   }
}

