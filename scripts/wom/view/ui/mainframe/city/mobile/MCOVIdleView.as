package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVIdleView extends MobileConstructableOptionsView
   {
      
      private var _upgradeButton:MobileWomButton;
      
      private var _fortifyButton:MobileWomButton;
      
      public function MCOVIdleView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _upgradeButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _upgradeButton.visible = false;
         _upgradeButton.width = 145;
         var _temp_2:* = _upgradeButton;
         var _loc1_:String = "ui.mainframe.city.menupanel.upgrade";
         _temp_2.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _upgradeButton.defaultIcon = assetRepository.getDisplayObject("IconUpgradeM");
         _upgradeButton.yMargin = -8;
         addChild(_upgradeButton);
         _fortifyButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _fortifyButton.visible = false;
         _fortifyButton.width = 140;
         var _temp_4:* = _fortifyButton;
         var _loc2_:String = "ui.menupanel.fortify";
         _temp_4.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _fortifyButton.defaultIcon = assetRepository.getDisplayObject("IconFortifyMBordered");
         _fortifyButton.yMargin = -8;
         addChild(_fortifyButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_upgradeButton);
         _loc1_.push(_fortifyButton);
         return _loc1_;
      }
      
      public function determineButtonStatus(param1:Boolean, param2:Boolean) : void
      {
         _upgradeButton.visible = param1;
         _fortifyButton.visible = param2;
         drawLayout();
      }
      
      public function get upgradeButton() : MPButton
      {
         return _upgradeButton;
      }
      
      public function get fortifyButton() : MPButton
      {
         return _fortifyButton;
      }
   }
}

