package wom.view.ui.mainframe.combat
{
   import flash.geom.Point;
   import flash.utils.Timer;
   import peak.component.mobile.MPRigidButton;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.mainframe.MobileUILayer;
   import wom.view.ui.mainframe.city.MobileCurrencyPanel;
   import wom.view.ui.mainframe.city.MobileLandlordPanel;
   import wom.view.ui.mainframe.city.MobileMainframeNotificationView;
   import wom.view.ui.mainframe.city.MobileResourcePanel;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   
   public class MobileCombatUILayer extends MobileUILayer
   {
      
      protected var topPanel:Sprite;
      
      private var _victoryMeterPanel:MobileVictoryMeterPanel;
      
      private var _currencyPanel:MobileCurrencyPanel;
      
      private var _combatMenuPanel:MobileCombatMenuPanel;
      
      private var battleClockView:MobileBattleClockView;
      
      private var _resourcePanel:MobileResourcePanel;
      
      private var _settingsView:MobileMainframeNotificationView;
      
      private var _keepAliveTimer:Timer;
      
      public function MobileCombatUILayer()
      {
         super();
         _keepAliveTimer = new Timer(60000);
      }
      
      override public function initLayout() : void
      {
         topPanel = new FlatteningSprite();
         addChild(topPanel);
         super.initLayout();
         _currencyPanel = new MobileCurrencyPanel();
         topPanel.addChild(_currencyPanel);
         _combatMenuPanel = new MobileCombatMenuPanel();
         addChild(_combatMenuPanel);
         battleClockView = new MobileBattleClockView();
         addChild(battleClockView);
         _victoryMeterPanel = new MobileVictoryMeterPanel();
         addChild(_victoryMeterPanel);
         _resourcePanel = new MobileResourcePanel(true);
         addChild(_resourcePanel);
         var _temp_8:* = §§findproperty(MobileMainframeNotificationView);
         var _temp_7:* = new MPRigidButton("IconSettingM","IconSettingM");
         var _loc1_:String = "ui.mainframe.city.menupanel.settings";
         _settingsView = new MobileMainframeNotificationView(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc1_),-19,getCaptionTextFormat(21));
         topPanel.addChild(_settingsView);
         _settingsView.drawLayout();
         topPanel.flatten();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         setChildIndex(_chatPanel,numChildren - 1);
         _chatPanel.drawLayout();
         _combatMenuPanel.x = 0;
         _combatMenuPanel.y = 0;
         _combatMenuPanel.drawLayout();
         _currencyPanel.x = _visibleWidth - _currencyPanel.visibleWidth - 12;
         _currencyPanel.y = 12;
         MobileAlignmentUtil.alignAccordingToPositionOf(_settingsView,_currencyPanel,_currencyPanel.width - _settingsView.width,58);
         _landlordAvatar.x = 34;
         _landlordAvatar.y = 12;
         _resourcePanel.x = Math.max(int((visibleWidth - _resourcePanel.visibleWidth) / 2),113);
         _resourcePanel.y = 12;
         if(_resourcePanel.visible)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_victoryMeterPanel,_resourcePanel,_resourcePanel.visibleWidth - _victoryMeterPanel.visibleWidth >> 1,42);
            if(_victoryMeterPanel.visible && _victoryMeterPanel.tooltipContainer.visible)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(battleClockView,_victoryMeterPanel,_victoryMeterPanel.visibleWidth - battleClockView.visibleWidth >> 1,43);
            }
            else
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(battleClockView,_resourcePanel,_resourcePanel.visibleWidth - battleClockView.visibleWidth >> 1,42);
            }
         }
         else
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_victoryMeterPanel,_resourcePanel,_resourcePanel.visibleWidth - _victoryMeterPanel.visibleWidth >> 1,42);
            _victoryMeterPanel.y = 0;
            battleClockView.x = Math.max(int((visibleWidth - battleClockView.width) / 2),_landlordAvatar.x + 147);
            battleClockView.y = 0;
         }
      }
      
      override protected function createAndAddLandlordPanel() : void
      {
         _landlordAvatar = new MobileLandlordPanel();
         topPanel.addChild(_landlordAvatar);
      }
      
      public function get keepAliveTimer() : Timer
      {
         return _keepAliveTimer;
      }
      
      public function get combatMenuPanelPosition() : Point
      {
         return new Point(_combatMenuPanel.x,_combatMenuPanel.y);
      }
      
      public function attackMode() : void
      {
         _victoryMeterPanel.visible = true;
         _resourcePanel.visible = true;
         battleClockView.visible = true;
         _chatPanel.visible = false;
         _currencyPanel.updateWithScreenType(false);
         drawLayout();
      }
      
      public function tuskHornMode() : void
      {
         _victoryMeterPanel.visible = false;
         _resourcePanel.visible = true;
         battleClockView.visible = true;
         _chatPanel.visible = false;
         _currencyPanel.updateWithScreenType(false);
         drawLayout();
      }
      
      public function scoutMode() : void
      {
         _victoryMeterPanel.visible = true;
         _resourcePanel.visible = false;
         battleClockView.visible = false;
         _chatPanel.visible = true;
         _currencyPanel.updateWithScreenType(false);
         drawLayout();
      }
      
      override public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
         _combatMenuPanel.visibleWidth = param1;
         (_chatPanel as MobileChatPanel).visibleWidth = param1;
      }
      
      override public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
         _combatMenuPanel.visibleHeight = param1;
         (_chatPanel as MobileChatPanel).visibleHeight = param1;
      }
      
      public function get settingsView() : MobileMainframeNotificationView
      {
         return _settingsView;
      }
      
      public function get combatMenuPanel() : MobileCombatMenuPanel
      {
         return _combatMenuPanel;
      }
   }
}

