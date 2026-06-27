package wom.view.screen.windows.event
{
   import fl.controls.ProgressBar;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.component.progressbar.ProgressBar30;
   import wom.view.util.GenericWindow;
   
   public class BaseEventStoreItemWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 639;
      
      private static const WINDOW_HEIGHT:int = 450;
      
      protected var itemDetailsBackground:DisplayObject;
      
      protected var _itemAsset:AssetDisplayObject;
      
      protected var itemNameTextField:TextField;
      
      protected var itemDescriptionTextField:TextField;
      
      protected var _unlockButton:WomButton;
      
      protected var _storeItemInfo:EventStoreItemInfo;
      
      public function BaseEventStoreItemWindow(param1:EventStoreItemInfo, param2:Vector.<WindowEnumeration> = null)
      {
         super(639,450,param2);
         _storeItemInfo = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         initWindowLayout();
         drawLayout();
      }
      
      protected function initWindowLayout() : void
      {
         var _loc1_:String = "ui.windows.eventstore.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _itemAsset = assetRepository.getDisplayObject(_storeItemInfo.assetLarge);
         addChild(_itemAsset);
         itemDetailsBackground = assetRepository.getDisplayObject("BackgroundLight");
         itemDetailsBackground.width = 346;
         itemDetailsBackground.height = 302;
         itemDetailsBackground.x = 304;
         itemDetailsBackground.y = 101;
         addChild(itemDetailsBackground);
         itemNameTextField = new CaptionTextField();
         itemNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         itemNameTextField.autoSize = "left";
         itemNameTextField.text = _storeItemInfo.name;
         addChild(itemNameTextField);
         itemDescriptionTextField = new WomTextField();
         itemDescriptionTextField.wordWrap = true;
         itemDescriptionTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         itemDescriptionTextField.autoSize = "left";
         itemDescriptionTextField.width = 300;
         itemDescriptionTextField.text = _storeItemInfo.description;
         addChild(itemDescriptionTextField);
         _unlockButton = new WomGreenLargeButton();
         var _temp_7:* = _unlockButton;
         var _loc2_:String = "ui.windows.eventstore.unlock";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _unlockButton.setStyle("icon",assetRepository.getDisplayObject("EventPointIcon"));
         _unlockButton.rightLabel = _storeItemInfo.unlockCost + "";
         _unlockButton.width = 288;
         addChild(_unlockButton);
      }
      
      protected function createLabel(param1:String) : TextField
      {
         var _loc2_:TextField = new CaptionTextField();
         _loc2_.defaultTextFormat = WomTextFormats.RIGHT_16;
         _loc2_.width = 145;
         _loc2_.height = 17;
         var _temp_1:* = _loc2_;
         var _loc3_:String = "ui.windows.eventstore." + param1;
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_loc2_);
         return _loc2_;
      }
      
      protected function createProgressBar() : ProgressBar
      {
         var _loc1_:ProgressBar = new ProgressBar30();
         _loc1_.width = 130;
         addChild(_loc1_);
         return _loc1_;
      }
      
      protected function createProgressBarTextField() : TextField
      {
         var _loc1_:TextField = new CaptionTextField();
         _loc1_.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         _loc1_.width = 87;
         _loc1_.height = 17;
         addChild(_loc1_);
         return _loc1_;
      }
      
      public function drawLayout() : void
      {
         _itemAsset.visible = _itemAsset.width > 0;
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_itemAsset,_background,250 - _itemAsset.width);
         AlignmentUtil.alignAccordingToPositionOf(itemNameTextField,_background,263,43);
         AlignmentUtil.alignAccordingToPositionOf(itemDetailsBackground,_background,263,99);
         AlignmentUtil.alignAccordingToPositionOf(itemDescriptionTextField,itemDetailsBackground,25,20);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unlockButton,_background,_windowHeight - (_unlockButton.height >> 1));
      }
      
      public function get unlockButton() : WomButton
      {
         return _unlockButton;
      }
      
      public function get storeItemInfo() : EventStoreItemInfo
      {
         return _storeItemInfo;
      }
      
      public function get itemAsset() : AssetDisplayObject
      {
         return _itemAsset;
      }
   }
}

