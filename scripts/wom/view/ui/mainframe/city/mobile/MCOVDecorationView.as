package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVDecorationView extends MobileConstructableOptionsView
   {
      
      private var _recycleButton:MobileWomButton;
      
      public function MCOVDecorationView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         levelTextField.visible = levelIcon.visible = false;
         _recycleButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _recycleButton.width = 145;
         var _temp_2:* = _recycleButton;
         var _loc2_:String = "ui.menupanel.sell";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _recycleButton.defaultIcon = assetRepository.getDisplayObject("IconRPM");
         addChild(_recycleButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         buildingNameTextField.x = background.width - buildingNameTextField.width >> 1;
      }
      
      public function get recycleButton() : MobileWomButton
      {
         return _recycleButton;
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_recycleButton);
         return _loc1_;
      }
      
      public function setPrice(param1:int) : void
      {
         _recycleButton.rightLabel = param1 + "";
      }
   }
}

