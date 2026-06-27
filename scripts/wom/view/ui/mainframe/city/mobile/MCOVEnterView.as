package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVEnterView extends MCOVIdleView
   {
      
      protected var _enterButton:MobileWomButton;
      
      private var _enterOnRegister:Boolean;
      
      private var _windowSpecificAttributes:Object;
      
      public function MCOVEnterView(param1:int, param2:Boolean = false, param3:Object = null)
      {
         super(param1);
         _enterOnRegister = param2;
         _windowSpecificAttributes = param3 ? param3 : {};
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _enterButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _enterButton.width = 145;
         var _temp_2:* = _enterButton;
         var _loc1_:String = "ui.mainframe.city.mobile.enter";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_enterButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_enterButton);
         return _loc1_;
      }
      
      public function get enterButton() : MPButton
      {
         return _enterButton;
      }
      
      public function get enterOnRegister() : Boolean
      {
         return _enterOnRegister;
      }
      
      public function get windowSpecificAttributes() : Object
      {
         return _windowSpecificAttributes;
      }
   }
}

