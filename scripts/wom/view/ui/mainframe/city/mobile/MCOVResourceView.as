package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.screen.MobileBoostButtonView;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MCOVResourceView extends MCOVIdleView
   {
      
      private var _boostButton:MobileBoostButtonView;
      
      private var _collectButton:MobileWomButton;
      
      private var _resourceAssetId:String;
      
      private var _boostItem:StoreItemInfo;
      
      public function MCOVResourceView(param1:int, param2:String)
      {
         super(param1);
         _resourceAssetId = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = §§findproperty(MobileBoostButtonView);
         var _temp_1:* = "ProductionBoost1";
         var _loc1_:String = "ui.mainframe.city.mobile.boost";
         _boostButton = new MobileBoostButtonView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),"","IconGoldS","X2",0.4,0.7);
         addChild(_boostButton);
         _collectButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _collectButton.width = 145;
         var _temp_5:* = _collectButton;
         var _loc2_:String = "ui.mainframe.city.mobile.collect";
         _temp_5.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _collectButton.defaultIcon = assetRepository.getDisplayObject(_resourceAssetId);
         _collectButton.iconAndRightLabelMargin -= 5;
         addChild(_collectButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_boostButton);
         _loc1_.push(_collectButton);
         return _loc1_;
      }
      
      public function activateEffectCooldown(param1:Number) : void
      {
         var _loc2_:String = LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1);
         var _temp_1:* = _boostButton;
         var _loc3_:String = "ui.mainframe.city.mobile.boostLeft";
         _temp_1.activateCooldownLabel(peak.i18n.PText.INSTANCE.getText0(_loc3_),_loc2_);
      }
      
      public function setCooldownText(param1:Number) : void
      {
         var _loc2_:String = LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(param1);
         _boostButton.setDurationText(_loc2_);
      }
      
      public function get boostButton() : MobileBoostButtonView
      {
         return _boostButton;
      }
      
      public function get collectButton() : MPButton
      {
         return _collectButton;
      }
      
      public function get boostItem() : StoreItemInfo
      {
         return _boostItem;
      }
      
      public function set boostItem(param1:StoreItemInfo) : void
      {
         _boostItem = param1;
      }
   }
}

