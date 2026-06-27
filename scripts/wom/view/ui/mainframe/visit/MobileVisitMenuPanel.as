package wom.view.ui.mainframe.visit
{
   import peak.component.mobile.MPButton;
   import peak.display.View;
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileVisitMenuPanel extends Sprite implements View
   {
      
      private var _friendsMenuButton:MPButton;
      
      private var _returnMenuButton:MPButton;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      public function MobileVisitMenuPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _friendsMenuButton = MobileWomUIComponentFactory.createMenuButton("White","Small","IconSocialM",5,-1);
         _friendsMenuButton.width = 70;
         var _temp_2:* = _friendsMenuButton;
         var _loc1_:String = "ui.mainframe.city.menupanel.friends";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_friendsMenuButton);
         _returnMenuButton = MobileWomUIComponentFactory.createMenuButton("Blue","Large","IconReturnLBordered",15,-3);
         _returnMenuButton.width = 125;
         var _temp_4:* = _returnMenuButton;
         var _loc2_:String = "ui.menupanel.home";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_returnMenuButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _friendsMenuButton.x = 10;
         _friendsMenuButton.y = visibleHeight - 215;
         _returnMenuButton.x = visibleWidth - _returnMenuButton.width - 10;
         _returnMenuButton.y = visibleHeight - _returnMenuButton.height - 10;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function get friendsMenuButton() : MPButton
      {
         return _friendsMenuButton;
      }
      
      public function get returnMenuButton() : MPButton
      {
         return _returnMenuButton;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
   }
}

