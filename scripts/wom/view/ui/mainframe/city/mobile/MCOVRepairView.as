package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MCOVRepairView extends MobileConstructableOptionsView
   {
      
      private var _repairAllButton:MobileCondenseButtonView;
      
      private var _speedUpButton:MobileWomButton;
      
      public function MCOVRepairView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = §§findproperty(MobileCondenseButtonView);
         var _temp_1:* = null;
         var _loc1_:String = "ui.popups.repairsite.repairall";
         _repairAllButton = new MobileCondenseButtonView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),"","IconGoldS",1,0.8,"Yellow");
         addChild(_repairAllButton);
         _speedUpButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Medium");
         _speedUpButton.width = 134;
         var _temp_5:* = _speedUpButton;
         var _loc2_:String = "ui.popups.repairsite.speedup";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_speedUpButton);
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_repairAllButton);
         _loc1_.push(_speedUpButton);
         return _loc1_;
      }
      
      public function get repairAllButton() : MPButton
      {
         return _repairAllButton.button;
      }
      
      public function get speedUpButton() : MobileWomButton
      {
         return _speedUpButton;
      }
      
      public function changeRepairGoldAmount(param1:String) : void
      {
         _repairAllButton.subLabel = param1;
      }
   }
}

