package wom.view.screen.windows.store
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileStoreItemView extends Sprite
   {
      
      public static const LOCKED_ALPHA:Number = 0.6;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var storeInfo:StoreInfo;
      
      private var _storeItem:StoreItemInfo;
      
      private var background:DisplayObject;
      
      private var lockedIcon:DisplayObject;
      
      private var itemNameTF:MPTextField;
      
      private var itemAsset:DisplayObject;
      
      private var _buyButton:MobileWomButton;
      
      private var _hintButton:MPRigidButton;
      
      private var _cooldownTF:MPTextField;
      
      private var _discountedBuyButton:MobileWomButton;
      
      private var _cooldownButton:MobileWomButton;
      
      private var discountedBuyTF:MobileCaptionTextField;
      
      private var originalPriceTF:MobileCaptionTextField;
      
      private var discountedPriceTF:MobileCaptionTextField;
      
      private var originalCurrencyIcon:DisplayObject;
      
      private var discountedCurrencyIcon:DisplayObject;
      
      private var xIcon:DisplayObject;
      
      private var shouldCallOnTick:Boolean;
      
      public function MobileStoreItemView(param1:MobileWomAssetRepository, param2:StoreInfo)
      {
         super();
         this.assetRepository = param1;
         this.storeInfo = param2;
         this.shouldCallOnTick = true;
         initLayout();
      }
      
      private function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 260;
         background.height = 216;
         addChild(background);
         itemNameTF = new MobileCaptionTextField();
         itemNameTF.textRendererProperties.textFormat = getCaptionTextFormat(27,"center");
         itemNameTF.textRendererProperties.wordWrap = true;
         itemNameTF.width = 240;
         itemNameTF.touchable = false;
         addChild(itemNameTF);
         _buyButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         var _temp_4:* = _buyButton;
         var _loc1_:String = "ui.windows.store.buy";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _buyButton.width = 170;
         _buyButton.setPaddings(30,30,160);
         addChild(_buyButton);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.setPaddings(18,5,5,18);
         addChild(_hintButton);
         lockedIcon = assetRepository.getDisplayObject("IconLockMBordered");
         addChild(lockedIcon);
         _cooldownButton = MobileWomUIComponentFactory.createMobileColoredButton("Gray","Small");
         _cooldownButton.width = 200;
         _cooldownButton.visible = false;
         _cooldownButton.isEnabled = false;
         addChild(_cooldownButton);
         _cooldownTF = new MPTextField();
         _cooldownTF.width = 165;
         _cooldownTF.textRendererProperties.textFormat = getWomTextFormat(27,"center");
         _cooldownTF.visible = false;
         addChild(_cooldownTF);
         _discountedBuyButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         _discountedBuyButton.width = 235;
         _discountedBuyButton.visible = false;
         addChild(_discountedBuyButton);
         discountedBuyTF = new MobileCaptionTextField();
         discountedBuyTF.textRendererProperties.textFormat = getCaptionTextFormat(23,"center");
         var _temp_11:* = discountedBuyTF;
         var _loc2_:String = "ui.windows.store.buy";
         _temp_11.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         discountedBuyTF.width = 84;
         discountedBuyTF.visible = false;
         discountedBuyTF.touchable = false;
         addChild(discountedBuyTF);
         xIcon = assetRepository.getDisplayObject("SymbolDiscountPrice");
         xIcon.visible = false;
         xIcon.touchable = false;
         addChild(xIcon);
      }
      
      public function updateStoreItemInfo(param1:StoreItemInfo) : void
      {
         _storeItem = param1;
         itemNameTF.text = _storeItem.name;
         if(itemAsset != null && contains(itemAsset))
         {
            removeChild(itemAsset);
         }
         if(lockedIcon != null && contains(lockedIcon))
         {
            removeChild(lockedIcon);
         }
         itemAsset = assetRepository.getDisplayObject(_storeItem.asset);
         itemAsset.touchable = false;
         addChildAt(itemAsset,getChildIndex(background) + 1);
         var _loc3_:Boolean = isCostVisible();
         var _loc2_:String = _storeItem.currency == StoreItemCurrencyType.GOLD ? "IconGoldS" : "IconRPS";
         _buyButton.defaultIcon = assetRepository.getDisplayObject(_loc2_);
         _buyButton.rightLabel = String(_storeItem.getOriginalPrice());
         _buyButton.visible = _loc3_;
         if(_storeItem.locked)
         {
            lockedIcon = assetRepository.getDisplayObject("IconLockMBordered");
            addChild(lockedIcon);
         }
         itemNameTF.alpha = _storeItem.locked ? 0.6 : 1;
         itemAsset.alpha = _storeItem.locked ? 0.6 : 1;
         setCooldownVisibility();
         removeIfPresent(originalCurrencyIcon);
         originalCurrencyIcon = null;
         originalCurrencyIcon = assetRepository.getDisplayObject(_loc2_);
         originalCurrencyIcon.scaleX = 0.7;
         originalCurrencyIcon.scaleY = 0.7;
         originalCurrencyIcon.visible = false;
         originalCurrencyIcon.touchable = false;
         addChild(originalCurrencyIcon);
         removeIfPresent(discountedCurrencyIcon);
         discountedCurrencyIcon = null;
         discountedCurrencyIcon = assetRepository.getDisplayObject(_loc2_);
         discountedCurrencyIcon.visible = false;
         discountedCurrencyIcon.touchable = false;
         addChild(discountedCurrencyIcon);
         removeIfPresent(originalPriceTF);
         originalPriceTF = null;
         originalPriceTF = new MobileCaptionTextField();
         originalPriceTF.textRendererProperties.textFormat = getCaptionTextFormat(19);
         originalPriceTF.text = String(_storeItem.getPrice(null));
         originalPriceTF.visible = false;
         originalPriceTF.touchable = false;
         addChild(originalPriceTF);
         removeIfPresent(discountedPriceTF);
         discountedPriceTF = null;
         discountedPriceTF = new MobileCaptionTextField();
         discountedPriceTF.textRendererProperties.textFormat = getCaptionTextFormat(23);
         discountedPriceTF.text = originalPriceTF.text;
         discountedPriceTF.visible = false;
         discountedPriceTF.touchable = false;
         addChild(discountedPriceTF);
         removeIfPresent(xIcon);
         xIcon = null;
         xIcon = assetRepository.getDisplayObject("SymbolDiscountPrice");
         xIcon.visible = false;
         xIcon.touchable = false;
         addChild(xIcon);
         updateCost(_storeItem.getPrice(storeInfo.discount));
         drawLayout();
      }
      
      private function setCooldownVisibility() : void
      {
         var _loc1_:Boolean = isCooldownVisible();
         _cooldownButton.visible = _loc1_;
         _cooldownTF.visible = _loc1_;
      }
      
      public function isCooldownVisible() : Boolean
      {
         return _storeItem != null && _storeItem.locked && (_storeItem.effectCooldown != null || _storeItem.buyCooldown != null);
      }
      
      private function isCostVisible() : Boolean
      {
         return !_storeItem.locked && (_storeItem.currency == StoreItemCurrencyType.RECON_POINTS || _storeItem.currency == StoreItemCurrencyType.GOLD);
      }
      
      private function removeIfPresent(param1:DisplayObject) : void
      {
         if(param1 && contains(param1))
         {
            removeChild(param1);
         }
      }
      
      public function drawLayout() : void
      {
         background.y = 10;
         itemAsset.x = (background.width - itemAsset.width) / 2;
         itemAsset.y = background.y + (background.height - itemAsset.height) / 2;
         if(lockedIcon)
         {
            lockedIcon.x = (background.width - lockedIcon.width) / 2;
            lockedIcon.y = background.y + (background.height - lockedIcon.height) / 2;
         }
         MobileAlignmentUtil.alignAccordingToPositionOf(_buyButton,background,50,184);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,234,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_cooldownButton,background,184);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_cooldownTF,background,192);
         MobileAlignmentUtil.alignAccordingToPositionOf(_discountedBuyButton,background,12,184);
         MobileAlignmentUtil.alignAccordingToPositionOf(discountedBuyTF,_discountedBuyButton,0,9);
         MobileAlignmentUtil.alignAccordingToPositionOf(originalCurrencyIcon,_discountedBuyButton,84,7);
         MobileAlignmentUtil.alignAccordingToPositionOf(xIcon,originalCurrencyIcon,-2,-1);
         MobileAlignmentUtil.alignAccordingToPositionOf(originalPriceTF,_discountedBuyButton,100,11);
         MobileAlignmentUtil.alignAccordingToPositionOf(discountedCurrencyIcon,_discountedBuyButton,142,3);
         MobileAlignmentUtil.alignAccordingToPositionOf(discountedPriceTF,_discountedBuyButton,165,9);
      }
      
      public function get buyButton() : MobileWomButton
      {
         return _buyButton;
      }
      
      public function get cooldownTF() : MPTextField
      {
         return _cooldownTF;
      }
      
      public function get storeItem() : StoreItemInfo
      {
         return _storeItem;
      }
      
      public function updateCost(param1:int) : void
      {
         discountedPriceTF.text = String(param1);
         var _loc2_:Boolean = isCostVisible() && param1 < _storeItem.getOriginalPrice();
         _buyButton.visible = !_loc2_ && isCostVisible();
         _discountedBuyButton.visible = _loc2_;
         discountedBuyTF.visible = _loc2_;
         originalCurrencyIcon.visible = _loc2_;
         originalPriceTF.visible = _loc2_;
         discountedCurrencyIcon.visible = _loc2_;
         discountedPriceTF.visible = _loc2_;
         xIcon.visible = _loc2_;
         setCooldownVisibility();
      }
      
      public function setCooldownText(param1:String) : void
      {
         _cooldownTF.text = param1;
         setCooldownVisibility();
         drawLayout();
      }
      
      public function get discountedBuyButton() : MobileWomButton
      {
         return _discountedBuyButton;
      }
      
      public function onStoreItemDiscountUpdated(param1:ModelUpdateEvent) : void
      {
         if(storeItem != null)
         {
            checkOnTick();
         }
      }
      
      private function checkOnTick() : void
      {
         var _loc1_:Boolean = storeInfo.discount != null && _storeItem != null && storeInfo.discount.currency == _storeItem.currency && !(_storeItem.id in storeInfo.discount.excludedStoreItemIds);
         if(isCooldownVisible() || _loc1_)
         {
            if(_loc1_)
            {
               checkDiscount();
            }
         }
         else if(_storeItem != null)
         {
            shouldCallOnTick = false;
         }
      }
      
      public function onTick(param1:GameTickEvent) : void
      {
         if(shouldCallOnTick)
         {
            checkCooldown();
            checkDiscount();
         }
      }
      
      private function checkDiscount() : void
      {
         var _loc1_:int = 0;
         if(_storeItem != null)
         {
            _loc1_ = _storeItem.getPrice(storeInfo.discount);
            if(_loc1_ != _storeItem.getOriginalPrice())
            {
               updateCost(_loc1_);
            }
         }
      }
      
      private function checkCooldown() : void
      {
         var _loc2_:StoreItemInfo = null;
         var _loc1_:String = null;
         if(isCooldownVisible())
         {
            _loc2_ = _storeItem;
            if(_loc2_.effectCooldown)
            {
               _loc1_ = LocalizedDateTimeUtil.getUserFriendlyTime(_loc2_.effectCooldown.creationDate + _loc2_.effectCooldown.durationRemaining - new Date().getTime());
               setCooldownText(_loc1_);
            }
            else if(_loc2_.buyCooldown)
            {
               _loc1_ = LocalizedDateTimeUtil.getUserFriendlyTime(_loc2_.buyCooldown.infoCreationTime + _loc2_.buyCooldown.cooldownDuration - new Date().getTime());
               setCooldownText(_loc1_);
            }
         }
      }
      
      public function get hintButton() : MPRigidButton
      {
         return _hintButton;
      }
   }
}

