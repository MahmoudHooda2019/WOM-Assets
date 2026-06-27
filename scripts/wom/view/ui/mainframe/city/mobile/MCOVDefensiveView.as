package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.model.game.store.StoreItemInfo;
   import wom.view.screen.MobileBoostButtonView;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MCOVDefensiveView extends MCOVIdleView
   {
      
      private var _boostButton:MobileBoostButtonView;
      
      private var _boostItem:StoreItemInfo;
      
      public function MCOVDefensiveView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = §§findproperty(MobileBoostButtonView);
         var _temp_1:* = "TowerDamageBoost";
         var _loc1_:String = "ui.mainframe.city.mobile.boost";
         _boostButton = new MobileBoostButtonView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),"","IconGoldS","25%",0.4,0.7);
         addChild(_boostButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc2_:Vector.<DisplayObject> = super.getActiveButtonList();
         var _loc1_:DisplayObject = _loc2_.pop();
         _loc2_.push(_boostButton);
         _loc2_.push(_loc1_);
         return _loc2_;
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

