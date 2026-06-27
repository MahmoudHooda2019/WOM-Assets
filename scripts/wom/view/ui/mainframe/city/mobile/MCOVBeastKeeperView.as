package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVBeastKeeperView extends MCOVEnterView
   {
      
      private var _caveBeastButton:MobileWomButton;
      
      private var _beastExists:Boolean;
      
      public function MCOVBeastKeeperView(param1:int, param2:Boolean = false, param3:Object = null)
      {
         super(param1,param2,param3);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _caveBeastButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _caveBeastButton.width = 160;
         var _temp_2:* = _caveBeastButton;
         var _loc1_:String = "ui.windows.beast.keeper.cavebutton";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _caveBeastButton.visible = _beastExists;
         addChild(_caveBeastButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_caveBeastButton);
         return _loc1_;
      }
      
      public function get caveBeastButton() : MPButton
      {
         return _caveBeastButton;
      }
      
      public function get beastExists() : Boolean
      {
         return _beastExists;
      }
      
      public function set beastExists(param1:Boolean) : void
      {
         _beastExists = param1;
      }
   }
}

