package wom.view.screen.popups
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileLightAnimationView;
   import wom.view.ui.common.MobileSpeechBubbleView;
   
   public class MobileStoreItemPurchasedPopUp extends MobileBasePopUp
   {
      
      private static const WINDOW_WIDTH:int = 480;
      
      private static const WINDOW_HEIGHT:int = 406;
      
      private var _storeItemInfo:StoreItemInfo;
      
      private var _itemAsset:DisplayObject;
      
      private var _itemDescriptionTextField:MPTextField;
      
      private var _lightView:MobileLightAnimationView;
      
      public function MobileStoreItemPurchasedPopUp(param1:StoreItemInfo, param2:int = 480, param3:int = 406)
      {
         super(param2,param3);
         _storeItemInfo = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.storeitempurchased.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _lightView = new MobileLightAnimationView();
         _lightView.scaleX = _lightView.scaleY = 2;
         addChild(_lightView);
         _imageAsset = assetRepository.getDisplayObject("MPose4");
         addChild(_imageAsset);
         _speechBubble = new MobileSpeechBubbleView(245,_storeItemInfo.name,getCaptionTextFormat(25,"center"),null,27,161);
         addChild(_speechBubble);
         _speechBubble.speechBubbleArrow.visible = false;
         _itemAsset = assetRepository.getDisplayObject(_storeItemInfo.asset);
         _speechBubble.addChildAt(_itemAsset,_speechBubble.getChildIndex(_speechBubble.textField) - 1);
         _itemDescriptionTextField = new MobileWomTextField();
         _itemDescriptionTextField.width = 270;
         _itemDescriptionTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center",16777215);
         _itemDescriptionTextField.textRendererProperties.multiLine = true;
         _itemDescriptionTextField.textRendererProperties.wordWrap = true;
         addChild(_itemDescriptionTextField);
         _itemDescriptionTextField.text = _storeItemInfo.description;
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         _actionButton.width = 420;
         var _temp_8:* = _actionButton;
         var _loc2_:String = "ui.popups.storeitempurchased.boasttofriends";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_actionButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_imageAsset,_background,-4,windowHeight - _imageAsset.height - 8);
         MobileAlignmentUtil.alignMiddleOf(_itemAsset,_speechBubble);
         MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,188,42);
         _lightView.x = _speechBubble.x + (_speechBubble.width >> 1);
         _lightView.y = _speechBubble.y + (_speechBubble.height >> 1);
         _itemDescriptionTextField.validate();
         MobileAlignmentUtil.alignAccordingToPositionOf(_itemDescriptionTextField,_speechBubble,-10,230);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,windowHeight - (_actionButton.height >> 1) - 14);
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      public function get boastToFriendsButton() : MPButton
      {
         return _actionButton;
      }
      
      public function get storeItemInfo() : StoreItemInfo
      {
         return _storeItemInfo;
      }
      
      public function get lightView() : MobileLightAnimationView
      {
         return _lightView;
      }
   }
}

