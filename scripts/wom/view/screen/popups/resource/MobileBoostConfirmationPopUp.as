package wom.view.screen.popups.resource
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.store.StoreInfo;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   
   public class MobileBoostConfirmationPopUp extends MobileClementineChangableActionPopUp
   {
      
      private static const WINDOW_WIDTH:int = 592;
      
      private static const WINDOW_HEIGHT:int = 271;
      
      private var _itemId:int;
      
      private var _upgradeJob:BuildingUpgradeJob;
      
      private var _storeItem:StoreItemInfo;
      
      private var _instanceId:int;
      
      private var _isFinishNowButton:Boolean;
      
      private var _finishNowPrice:int;
      
      public function MobileBoostConfirmationPopUp(param1:int, param2:BuildingUpgradeJob = null, param3:int = -1, param4:int = -1, param5:String = null)
      {
         _itemId = param1;
         _upgradeJob = param2;
         _instanceId = param3;
         _finishNowPrice = param4;
         _isFinishNowButton = _upgradeJob != null && _instanceId != -1 && _finishNowPrice != -1;
         var _loc7_:String;
         var _loc8_:String;
         var _loc6_:String = _isFinishNowButton ? (_loc7_ = "m.ui.popups.finishNowConstruction.header",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_loc8_ = "m.ui.popups.boostConfirmation.header",peak.i18n.PText.INSTANCE.getText0(_loc8_));
         if(param5 == null)
         {
            var _loc9_:String = "ui.windows.store.items." + param1 + ".desc";
            param5 = peak.i18n.PText.INSTANCE.getText0(_loc9_);
         }
         super(1,_loc6_,param5,null,592,271);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _actionButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _actionButton.width = 280;
         addChild(_actionButton);
         var _temp_2:* = _actionButton;
         var _loc1_:String = "m.ui.popups.boostConfirmation.buy";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         if(_isFinishNowButton)
         {
            _actionButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
            _actionButton.rightLabel = String(_finishNowPrice);
         }
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         if(_actionButton)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_actionButton,_background,_windowHeight - (_actionButton.height >> 1) - 7);
         }
         if(_isFinishNowButton)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_speechBubble,_background,getSpeechBubbleXIndent(),90);
         }
      }
      
      override protected function getDescTextFieldWidth() : Number
      {
         return 368;
      }
      
      override protected function getSpeechBubbleXIndent() : int
      {
         return 189;
      }
      
      override protected function getSpeechBubbleArrowYMargin() : int
      {
         if(_isFinishNowButton)
         {
            return 40;
         }
         return 65;
      }
      
      public function storeItemReady(param1:Vector.<StoreItemInfo>, param2:StoreInfo) : void
      {
         var _loc3_:String = null;
         for each(var _loc4_ in param1)
         {
            if(_loc4_.id == _itemId)
            {
               _storeItem = _loc4_;
               _loc3_ = _storeItem.currency == StoreItemCurrencyType.GOLD ? "IconGoldL" : "IconRPL";
               _actionButton.defaultIcon = assetRepository.getDisplayObject(_loc3_);
               _actionButton.rightLabel = String(_storeItem.getPrice(param2.discount) >> 0);
               _actionButton.validate();
               drawLayout();
               return;
            }
         }
      }
      
      public function get itemId() : int
      {
         return _itemId;
      }
      
      public function get storeItem() : StoreItemInfo
      {
         return _storeItem;
      }
      
      public function get upgradeJob() : BuildingUpgradeJob
      {
         return _upgradeJob;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get isFinishNowButton() : Boolean
      {
         return _isFinishNowButton;
      }
      
      public function get finishNowPrice() : int
      {
         return _finishNowPrice;
      }
   }
}

