package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVUpgradeView extends MCOVConstructView
   {
      
      private var _askFriendsButton:MobileWomButton;
      
      private var _abandonButton:MobileWomButton;
      
      public function MCOVUpgradeView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _askFriendsButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _askFriendsButton.width = 160;
         var _temp_2:* = _askFriendsButton;
         var _loc1_:String = "ui.mainframe.city.mobile.askfriends";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_askFriendsButton);
         _abandonButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _abandonButton.width = 145;
         var _temp_4:* = _abandonButton;
         var _loc2_:String = "ui.mainframe.city.mobile.abandon";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_abandonButton);
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_askFriendsButton);
         _loc1_.push(_abandonButton);
         return _loc1_;
      }
      
      public function get abandonButton() : MobileWomButton
      {
         return _abandonButton;
      }
      
      public function updateButtonStatus(param1:Boolean) : void
      {
         var _loc2_:Boolean = _askFriendsButton.visible;
         _askFriendsButton.visible = param1;
         _cut30Button.visible = !param1;
         drawLayout();
      }
      
      public function get askFriendsButton() : MobileWomButton
      {
         return _askFriendsButton;
      }
   }
}

