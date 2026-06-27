package wom.view.ui.mainframe.visit
{
   import peak.component.mobile.MPRigidButton;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.MobileUILayer;
   import wom.view.ui.mainframe.city.MobileCurrencyPanel;
   import wom.view.ui.mainframe.city.MobileMainframeNotificationView;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   
   public class MobileVisitUILayer extends MobileUILayer
   {
      
      protected var topPanel:Sprite;
      
      private var _currencyPanel:MobileCurrencyPanel;
      
      private var _menuPanel:MobileVisitMenuPanel;
      
      private var _settingsView:MobileMainframeNotificationView;
      
      public function MobileVisitUILayer()
      {
         super();
      }
      
      override public function initLayout() : void
      {
         topPanel = new FlatteningSprite();
         addChild(topPanel);
         super.initLayout();
         _currencyPanel = new MobileCurrencyPanel(true);
         topPanel.addChild(_currencyPanel);
         _menuPanel = new MobileVisitMenuPanel();
         addChild(_menuPanel);
         _chatPanel.visible = true;
         var _temp_5:* = §§findproperty(MobileMainframeNotificationView);
         var _temp_4:* = new MPRigidButton("IconSettingM","IconSettingM");
         var _loc1_:String = "ui.mainframe.city.menupanel.settings";
         _settingsView = new MobileMainframeNotificationView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc1_),-19,getCaptionTextFormat(21));
         topPanel.addChild(_settingsView);
         _settingsView.drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         setChildIndex(_chatPanel,numChildren - 1);
         _chatPanel.drawLayout();
         _menuPanel.x = 0;
         _menuPanel.y = 0;
         _menuPanel.drawLayout();
         _landlordAvatar.x = 34;
         _landlordAvatar.y = 12;
         _currencyPanel.x = _visibleWidth - _currencyPanel.visibleWidth - 12;
         _currencyPanel.y = 12;
         MobileAlignmentUtil.alignAccordingToPositionOf(_settingsView,_currencyPanel,_currencyPanel.width - _settingsView.width,210);
      }
      
      public function get menuPanel() : MobileVisitMenuPanel
      {
         return _menuPanel;
      }
      
      override public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
         _menuPanel.visibleWidth = param1;
         (_chatPanel as MobileChatPanel).visibleWidth = param1;
      }
      
      override public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
         _menuPanel.visibleHeight = param1;
         (_chatPanel as MobileChatPanel).visibleHeight = param1;
      }
      
      public function get settingsView() : MobileMainframeNotificationView
      {
         return _settingsView;
      }
   }
}

