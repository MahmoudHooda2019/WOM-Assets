package wom.view.screen.windows.social
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.Profile;
   import wom.view.screen.popups.facebook.MobileFBConnectToSendGiftPanel;
   import wom.view.screen.windows.gift.mobile.MobileGiftPanel;
   import wom.view.ui.mainframe.city.friends.mobile.MobileFriendsPanel;
   import wom.view.util.MobileButtonTabbedWindow;
   
   public class MobileSocialMainWindow extends MobileButtonTabbedWindow
   {
      
      public static const WINDOW_WIDTH:Number = 859;
      
      public static const WINDOW_HEIGHT:Number = 668;
      
      public static const MARGIN_X:Number = 0;
      
      public static const MARGIN_Y:Number = 109;
      
      private var _tabButtonSendGift:MPButton;
      
      private var _tabButtonInviteFriends:MPButton;
      
      private var _friendsPanel:MobileFriendsPanel;
      
      private var _giftPanel:MobileGiftPanel;
      
      private var _connectFBToSendGiftPanel:MobileFBConnectToSendGiftPanel;
      
      private var _highlightThorzain:Boolean;
      
      public function MobileSocialMainWindow(param1:Boolean = false)
      {
         super(859,668);
         _highlightThorzain = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = this;
         var _loc1_:String = "ui.mainframe.city.friend.mgift";
         _tabButtonSendGift = createTabButton(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),null,true);
         var _temp_4:* = this;
         var _loc2_:String = "ui.popups.invitefriends.buttonlabel";
         _tabButtonInviteFriends = createTabButton(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),null,true);
         _friendsPanel = new MobileFriendsPanel(_highlightThorzain);
         addChild(_friendsPanel);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_tabButtonSendGift,_background,29,32);
         MobileAlignmentUtil.alignRightOf(_tabButtonInviteFriends,_tabButtonSendGift,8);
         MobileAlignmentUtil.alignAccordingToPositionOf(_friendsPanel,_background,0,109);
         if(_connectFBToSendGiftPanel)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_connectFBToSendGiftPanel,_background,219);
         }
      }
      
      public function get tabButtonSendGift() : MPButton
      {
         return _tabButtonSendGift;
      }
      
      public function get tabButtonInviteFriends() : MPButton
      {
         return _tabButtonInviteFriends;
      }
      
      public function updateGiftPanel(param1:Profile) : void
      {
         if(_friendsPanel)
         {
            if(contains(_friendsPanel))
            {
               removeChild(_friendsPanel);
            }
            _friendsPanel = null;
         }
         if(!_giftPanel)
         {
            _giftPanel = new MobileGiftPanel();
            addTab(this,_tabButtonSendGift,_giftPanel,0,109);
         }
         _giftPanel.friendProfile = param1;
      }
      
      public function showFBConnectPanel() : void
      {
         if(!_connectFBToSendGiftPanel)
         {
            _connectFBToSendGiftPanel = new MobileFBConnectToSendGiftPanel();
            addChild(_connectFBToSendGiftPanel);
         }
         _connectFBToSendGiftPanel.visible = true;
         drawLayout();
      }
      
      public function isConnectToFBToSendGiftPanelVisible() : Boolean
      {
         return _connectFBToSendGiftPanel != null && _connectFBToSendGiftPanel.visible;
      }
   }
}

