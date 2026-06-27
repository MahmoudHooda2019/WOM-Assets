package wom.view.ui.mainframe.city
{
   import flash.geom.Point;
   import flash.utils.Timer;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.controller.event.ui.MobileUserNotificationViewEvent;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileSharingPermissionsView;
   import wom.view.ui.mainframe.*;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   import wom.view.ui.mainframe.city.mobile.MobileConstructableOptionsView;
   import wom.view.ui.mainframe.city.notification.MobileUserNotificationPanel;
   
   public class MobileCityUILayer extends MobileUILayer
   {
      
      public static const TUTORIAL_ALL:int = 0;
      
      public static const TUTORIAL_LANDLORD:int = 1;
      
      public static const TUTORIAL_CHAT:int = 2;
      
      public static const TUTORIAL_RESOURCE:int = 3;
      
      public static const TUTORIAL_CURRENCY:int = 4;
      
      public static const TUTORIAL_WORKER:int = 5;
      
      public static const TUTORIAL_MENU:int = 6;
      
      public static const TUTORIAL_SETTINGS:int = 7;
      
      public static const TUTORIAL_WOMKONG:int = 8;
      
      public static const TUTORIAL_SPECIAL_OFFER:int = 9;
      
      public static const TUTORIAL_EVENT:int = 10;
      
      public static const TUTORIAL_ITEMS:Array = [1,2,3,4,5,6,7,8,9,10];
      
      private var _protectionPanel:MobileProtectionPanel;
      
      protected var topPanel:Sprite;
      
      protected var _resourcePanel:MobileResourcePanel;
      
      protected var _currencyPanel:MobileCurrencyPanel;
      
      protected var _npcAttackCountDownPanel:MobileNPCAttackCountDownPanel;
      
      protected var _eventView:MobileMainframeNotificationView;
      
      protected var _eventAnnouncementView:MobileMainframeNotificationView;
      
      protected var _eventStoreView:MobileMainframeNotificationView;
      
      private var _workerPanel:MobileWorkerPanel;
      
      protected var _specialOfferPanel:MobileSpecialOfferPanel;
      
      protected var _userNotificationPanel:MobileUserNotificationPanel;
      
      protected var _menuPanel:MobileMenuPanel;
      
      private var _settingsView:MobileMainframeNotificationView;
      
      private var _constructableOptionsView:MobileConstructableOptionsView;
      
      private var _getWomkongPanel:MobileGetWomkongPanel;
      
      private var _sharingPermissionsView:MobileSharingPermissionsView;
      
      private var bottomBg:DisplayObject;
      
      private var _returnButton:MobileWomButton;
      
      private var _listViewButton:MobileWomButton;
      
      protected var _eventAnnouncementVisible:Boolean;
      
      protected var _eventVisible:Boolean;
      
      protected var _eventStoreVisible:Boolean;
      
      protected var _specialOfferPanelVisible:Boolean = false;
      
      protected var _inMap:Boolean;
      
      private var _gameIdTextField:MPTextField;
      
      private var _specialOfferTimer:Timer;
      
      public function MobileCityUILayer()
      {
         super();
      }
      
      override public function initLayout() : void
      {
         topPanel = new FlatteningSprite();
         addChild(topPanel);
         super.initLayout();
         createAndAddCurrencyPanel();
         _eventAnnouncementView = new MobileMainframeNotificationView(null,"",-25,getCaptionTextFormat(19,"center"),true);
         _eventAnnouncementView.visible = false;
         addChild(_eventAnnouncementView);
         _eventView = new MobileMainframeNotificationView(null,"",-25,getCaptionTextFormat(19,"center"),true);
         _eventView.visible = false;
         addChild(_eventView);
         _eventStoreView = new MobileMainframeNotificationView(new MPRigidButton("IconEPBig","IconEPBig"),"",-25,getCaptionTextFormat(19,"center"),true);
         _eventStoreView.visible = false;
         addChild(_eventStoreView);
         _chatPanel.visible = true;
         createAndAddMenuPanel();
         createAndAddWorkerPanel();
         createAndAddGetWomkongPanel();
         _specialOfferPanel = new MobileSpecialOfferPanel();
         _specialOfferPanel.visible = false;
         addChild(_specialOfferPanel);
         _specialOfferTimer = new Timer(0);
         createAndAddProtectionPanel();
         createAndAddResourcePanel();
         _npcAttackCountDownPanel = new MobileNPCAttackCountDownPanel();
         _npcAttackCountDownPanel.visible = false;
         topPanel.addChild(_npcAttackCountDownPanel);
         _userNotificationPanel = new MobileUserNotificationPanel();
         addChild(_userNotificationPanel);
         var _temp_10:* = §§findproperty(MobileMainframeNotificationView);
         var _temp_9:* = new MPRigidButton("IconSettingM","IconSettingM");
         var _loc1_:String = "ui.mainframe.city.menupanel.settings";
         _settingsView = new MobileMainframeNotificationView(_temp_9,peak.i18n.PText.INSTANCE.getText0(_loc1_),-19,getCaptionTextFormat(21));
         topPanel.addChild(_settingsView);
         _settingsView.drawLayout();
         bottomBg = assetRepository.getDisplayObject("MapListBackground");
         bottomBg.width = _visibleWidth;
         addChild(bottomBg);
         _returnButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _returnButton.width = 175;
         _returnButton.defaultIcon = assetRepository.getDisplayObject("IconReturnMBordered");
         var _temp_14:* = _returnButton;
         var _loc2_:String = "ui.mainframe.city.mappanel.home";
         _temp_14.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_returnButton);
         _listViewButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _listViewButton.width = 162;
         var _temp_16:* = _listViewButton;
         var _loc3_:String = "m.ui.campaign.listview";
         _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_listViewButton);
         _gameIdTextField = new MobileCaptionTextField();
         _gameIdTextField.textRendererProperties.textFormat = getCaptionTextFormat(17);
         _gameIdTextField.textRendererProperties.textColor = 3548944;
         _gameIdTextField.touchable = false;
         _gameIdTextField.x = 55;
         _gameIdTextField.y = 0;
         addChild(_gameIdTextField);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         setChildIndex(_chatPanel,numChildren - 1);
         _chatPanel.drawLayout();
         _menuPanel.x = 0;
         _menuPanel.y = 0;
         _menuPanel.drawLayout();
         _resourcePanel.x = Math.max(int((visibleWidth - _resourcePanel.visibleWidth) / 2),113);
         _resourcePanel.y = 12;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_protectionPanel,_resourcePanel,42);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_npcAttackCountDownPanel,_resourcePanel,94);
         _eventView.x = _eventStoreView.x = _eventAnnouncementView.x = 10;
         _eventView.y = _eventStoreView.y = _eventAnnouncementView.y = 150;
         _specialOfferPanel.x = 10;
         _specialOfferPanel.y = 330;
         _userNotificationPanel.x = visibleWidth - _userNotificationPanel.visibleWidth - 7;
         _userNotificationPanel.y = 267;
         _landlordAvatar.x = 34;
         _landlordAvatar.y = 12;
         _currencyPanel.x = _visibleWidth - _currencyPanel.visibleWidth - 12;
         _currencyPanel.y = 12;
         _getWomkongPanel.x = 10;
         _getWomkongPanel.y = 214;
         _workerPanel.x = _currencyPanel.x + 50;
         _workerPanel.y = _currencyPanel.y + 128;
         MobileAlignmentUtil.alignAccordingToPositionOf(_settingsView,_workerPanel,_workerPanel.width - _settingsView.width,60);
         MobileAlignmentUtil.alignAccordingToPositionOf(_specialOfferPanel,_settingsView,_settingsView.width - _specialOfferPanel.width - 10,60);
         if(_constructableOptionsView)
         {
            _constructableOptionsView.x = Math.max(int((visibleWidth - _constructableOptionsView.visibleWidth) / 2),113);
            _constructableOptionsView.y = visibleHeight - _constructableOptionsView.visibleHeight - 10;
         }
         if(_sharingPermissionsView)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_sharingPermissionsView,_resourcePanel,102);
         }
         bottomBg.y = _visibleHeight - bottomBg.height;
         MobileAlignmentUtil.alignAccordingToPositionOf(_returnButton,bottomBg,7,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_listViewButton,bottomBg,bottomBg.width - _listViewButton.width - 7,10);
         topPanel.flatten();
      }
      
      public function mapMode() : void
      {
         _inMap = true;
         _eventView.visible = false;
         _eventAnnouncementView.visible = false;
         _eventStoreView.visible = false;
         _specialOfferPanelVisible = false;
         _resourcePanel.visible = false;
         _menuPanel.visible = false;
         _chatPanel.visible = false;
         topPanel.visible = false;
         _specialOfferPanel.visible = false;
         bottomBg.visible = _returnButton.visible = _listViewButton.visible = true;
      }
      
      public function defaultMode() : void
      {
         _eventView.visible = _eventVisible;
         _eventAnnouncementView.visible = _eventAnnouncementVisible;
         _eventStoreView.visible = _eventStoreVisible;
         _resourcePanel.visible = true;
         _resourcePanel.updateScreenMode(false);
         _menuPanel.visible = true;
         _chatPanel.visible = true;
         topPanel.visible = true;
         bottomBg.visible = _returnButton.visible = _listViewButton.visible = false;
         _userNotificationPanel.visible = true;
         _inMap = false;
         dispatchEvent(new MobileUserNotificationViewEvent("mobileUserNotificationViewEventCompleted"));
         dispatchEvent(new MobileUserNotificationViewEvent("checkSpecialOfferStatus"));
      }
      
      public function get resourcePanelPosition() : Point
      {
         return new Point(_resourcePanel.x,_resourcePanel.y);
      }
      
      public function get menuPanelPosition() : Point
      {
         return new Point(_menuPanel.buildMenuButton.x,_menuPanel.buildMenuButton.y);
      }
      
      public function get workerPanelPosition() : Point
      {
         return new Point(_workerPanel.x,_workerPanel.y);
      }
      
      public function get protectionPanelPosition() : Point
      {
         return new Point(_protectionPanel.x,_protectionPanel.y);
      }
      
      public function get reconPointsBarPosition() : Point
      {
         return _currencyPanel.rpIcon.localToGlobal(new Point());
      }
      
      public function get menuPanel() : MobileMenuPanel
      {
         return _menuPanel;
      }
      
      public function checkSpecialOfferPanel(param1:Boolean) : void
      {
         _specialOfferPanel.visible = _specialOfferPanelVisible = param1;
      }
      
      public function get eventView() : MobileMainframeNotificationView
      {
         return _eventView;
      }
      
      public function get eventAnnouncementView() : MobileMainframeNotificationView
      {
         return _eventAnnouncementView;
      }
      
      public function get eventStoreView() : MobileMainframeNotificationView
      {
         return _eventStoreView;
      }
      
      public function set eventAnnouncementVisible(param1:Boolean) : void
      {
         _eventAnnouncementView.visible = _eventAnnouncementVisible = param1 && !_inMap;
      }
      
      public function set eventVisible(param1:Boolean) : void
      {
         _eventView.visible = _eventVisible = param1 && !_inMap;
      }
      
      public function set eventStoreVisible(param1:Boolean) : void
      {
         _eventStoreView.visible = _eventStoreVisible = param1 && !_inMap;
      }
      
      protected function createAndAddProtectionPanel() : void
      {
         _protectionPanel = new MobileProtectionPanel();
         topPanel.addChild(_protectionPanel);
      }
      
      override protected function createAndAddLandlordPanel() : void
      {
         _landlordAvatar = new MobileLandlordPanel();
         topPanel.addChild(_landlordAvatar);
      }
      
      protected function createAndAddResourcePanel() : void
      {
         _resourcePanel = new MobileResourcePanel(false);
         addChild(_resourcePanel);
      }
      
      protected function createAndAddCurrencyPanel() : void
      {
         _currencyPanel = new MobileCurrencyPanel();
         topPanel.addChild(_currencyPanel);
      }
      
      protected function createAndAddWorkerPanel() : void
      {
         _workerPanel = new MobileWorkerPanel();
         topPanel.addChild(_workerPanel);
      }
      
      protected function createAndAddGetWomkongPanel() : void
      {
         _getWomkongPanel = new MobileGetWomkongPanel();
         topPanel.addChild(_getWomkongPanel);
      }
      
      protected function createAndAddMenuPanel() : void
      {
         _menuPanel = new MobileMenuPanel();
         addChild(_menuPanel);
      }
      
      override public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
         _menuPanel.visibleWidth = param1;
         (_chatPanel as MobileChatPanel).visibleWidth = param1;
         bottomBg.width = param1;
         drawLayout();
      }
      
      override public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
         _menuPanel.visibleHeight = param1;
         (_chatPanel as MobileChatPanel).visibleHeight = param1;
         drawLayout();
      }
      
      public function get settingsView() : MobileMainframeNotificationView
      {
         return _settingsView;
      }
      
      public function set constructableOptionsView(param1:MobileConstructableOptionsView) : void
      {
         if(_constructableOptionsView)
         {
            removeChild(_constructableOptionsView);
         }
         _constructableOptionsView = param1;
         if(_constructableOptionsView)
         {
            addChild(_constructableOptionsView);
            drawLayout();
         }
      }
      
      public function set sharingPermissionsView(param1:MobileSharingPermissionsView) : void
      {
         if(_sharingPermissionsView)
         {
            removeChild(_sharingPermissionsView);
         }
         _sharingPermissionsView = param1;
         if(_sharingPermissionsView)
         {
            addChild(_sharingPermissionsView);
            drawLayout();
         }
      }
      
      public function get returnButton() : MobileWomButton
      {
         return _returnButton;
      }
      
      public function get listViewButton() : MobileWomButton
      {
         return _listViewButton;
      }
      
      private function setVisibleOfTutorialItem(param1:int, param2:Boolean) : void
      {
         switch(param1 - 1)
         {
            case 0:
               if(_landlordAvatar)
               {
                  _landlordAvatar.visible = param2;
               }
               break;
            case 1:
               if(_chatPanel)
               {
                  _chatPanel.visible = param2;
               }
               break;
            case 2:
               if(_resourcePanel)
               {
                  _resourcePanel.visible = param2;
               }
               break;
            case 3:
               if(_currencyPanel)
               {
                  _currencyPanel.visible = param2;
               }
               break;
            case 4:
               if(_workerPanel)
               {
                  _workerPanel.visible = param2;
               }
               break;
            case 5:
               if(_menuPanel)
               {
                  _menuPanel.visible = param2;
               }
               break;
            case 6:
               if(_settingsView)
               {
                  _settingsView.visible = param2;
               }
               break;
            case 7:
               if(_getWomkongPanel)
               {
                  _getWomkongPanel.visible = param2;
               }
               break;
            case 8:
               if(_specialOfferPanel)
               {
                  _specialOfferPanel.visible = param2 ? _specialOfferPanelVisible : false;
               }
               break;
            case 9:
               if(_eventAnnouncementView)
               {
                  _eventAnnouncementView.visible = param2 ? _eventAnnouncementVisible : false;
               }
               if(_eventView)
               {
                  _eventView.visible = param2 ? _eventVisible : false;
               }
               if(_eventStoreView)
               {
                  _eventStoreView.visible = param2 ? _eventStoreVisible : false;
               }
         }
      }
      
      public function updateVisibleOfTutorialItems(param1:Array) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            if(param1.indexOf(0) >= 0)
            {
               for each(_loc2_ in TUTORIAL_ITEMS)
               {
                  setVisibleOfTutorialItem(_loc2_,true);
               }
            }
            else
            {
               for each(_loc2_ in TUTORIAL_ITEMS)
               {
                  setVisibleOfTutorialItem(_loc2_,false);
               }
               for each(_loc2_ in param1)
               {
                  setVisibleOfTutorialItem(_loc2_,true);
               }
            }
            topPanel.flatten();
         }
      }
      
      public function updateEventButtonWithImageName(param1:String) : void
      {
         eventView.updateButton(new MPRigidButton(param1,param1,true));
      }
      
      public function updateEventAnnouncementButtonWithImageName(param1:String) : void
      {
         eventAnnouncementView.updateButton(new MPRigidButton(param1,param1,true));
      }
      
      public function get protectionPanel() : MobileProtectionPanel
      {
         return _protectionPanel;
      }
      
      public function get gameIdTextField() : MPTextField
      {
         return _gameIdTextField;
      }
      
      public function get specialOfferTimer() : Timer
      {
         return _specialOfferTimer;
      }
      
      public function set specialOfferTimer(param1:Timer) : void
      {
         _specialOfferTimer = param1;
      }
   }
}

