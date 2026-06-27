package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVIncompleteView extends MobileConstructableOptionsView
   {
      
      private var _askFriendsButton:MobileWomButton;
      
      public function MCOVIncompleteView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _askFriendsButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _askFriendsButton.width = 145;
         var _temp_2:* = _askFriendsButton;
         var _loc1_:String = "m.ui.windows.constructionsite.askfriends";
         _temp_2.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _askFriendsButton.defaultIcon = assetRepository.getDisplayObject("IconSocialM");
         addChild(_askFriendsButton);
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_askFriendsButton);
         return _loc1_;
      }
      
      public function get askFriendsButton() : MobileWomButton
      {
         return _askFriendsButton;
      }
      
      public function updateFinishNowPrice(param1:int) : void
      {
         _askFriendsButton.rightLabel = param1 + "";
      }
   }
}

