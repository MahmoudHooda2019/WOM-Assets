package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVWallView extends MCOVIdleView
   {
      
      private var _upgradeAllButton:MobileWomButton;
      
      private var level:int;
      
      public function MCOVWallView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _upgradeAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _upgradeAllButton.width = 215;
         var _temp_2:* = _upgradeAllButton;
         var _loc1_:String = "m.ui.windows.upgrade.upgradeall";
         _temp_2.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _upgradeAllButton.defaultIcon = assetRepository.getDisplayObject("IconUpgradeM");
         _upgradeAllButton.yMargin = -8;
         _upgradeAllButton.iconAndRightLabelMargin -= 5;
         addChild(_upgradeAllButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override public function updateLevelAndName(param1:int, param2:String) : void
      {
         super.updateLevelAndName(param1,param2);
         this.level = param1;
         drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_upgradeAllButton);
         return _loc1_;
      }
      
      override public function determineButtonStatus(param1:Boolean, param2:Boolean) : void
      {
         _upgradeAllButton.visible = param1;
         super.determineButtonStatus(param1,param2);
      }
      
      public function get upgradeAllButton() : MobileWomButton
      {
         return _upgradeAllButton;
      }
   }
}

