package wom.view.ui.mainframe.city.chat
{
   import feathers.data.ListCollection;
   import flash.utils.Timer;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTabBar;
   import peak.component.mobile.MPTextField;
   import peak.component.mobile.MPTextInput;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.Environment;
   import wom.controller.command.util.SwearFilter;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.chat.ChatMessage;
   import wom.model.game.chat.ChatMessageType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   
   public class MobileChatPanel extends Sprite implements View
   {
      
      public static const BAN_FOR_MINUTES:Number = 3;
      
      public static const TAB_WORLDCHAT:int = 0;
      
      public static const TAB_ALLIANCECHAT:int = 1;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _panelBackground:DisplayObject;
      
      private var _scrollBackground:DisplayObject;
      
      private var _chatInput:MPTextInput;
      
      private var _banTextField:MPTextField;
      
      private var _serverBanTextField:MPTextField;
      
      private var _sendButton:MPButton;
      
      private var _collapseButton:MPRigidButton;
      
      private var _expandButton:MPRigidButton;
      
      private var _worldChatPanel:MobileChatScrollPanel;
      
      private var _allianceChatPanel:MobileChatScrollPanel;
      
      private var _activePanel:MobileChatScrollPanel;
      
      private var _tabBar:MPTabBar;
      
      private var _banTimer:Timer;
      
      private var _banVisible:Boolean;
      
      private var _serverBanVisible:Boolean;
      
      private var lastSentMessagesForFlood:Vector.<ChatMessage>;
      
      private var floodLastMessagesNextIndex:int;
      
      private var lastSentMessagesForFilter:Vector.<ChatMessage>;
      
      private var filterLastMessagesNextIndex:int;
      
      protected const FLOOD_TIME_IN_MILLISECONDS:Number = 1000;
      
      protected const MESSAGE_COUNT_FOR_FLOOD:Number = 4;
      
      protected const BAN_TIMER_REPEAT_COUNT:Number = 180;
      
      private const MESSAGE_COUNT_FOR_FILTER_BAN:Number = 3;
      
      private const MESSAGE_COUNT_FOR_FILTER_CHECK:Number = 5;
      
      protected var _isOpen:Boolean = false;
      
      protected var _allianceExists:Boolean;
      
      private var _buttonBackground:DisplayObject;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      public function MobileChatPanel()
      {
         super();
      }
      
      private static function deactivateCurrentPanel(param1:Sprite) : void
      {
         if(param1 != null)
         {
            param1.visible = false;
         }
      }
      
      [PostConstruct]
      public function init() : void
      {
         _banVisible = false;
         initLayout();
      }
      
      public function initLayout() : void
      {
         _panelBackground = assetRepository.getDisplayObject("BackgroundYellowPanel");
         _panelBackground.width = 300;
         _panelBackground.height = Environment.screenHeight;
         addChild(_panelBackground);
         _buttonBackground = assetRepository.getDisplayObject("BackgroundYellowChat");
         addChild(_buttonBackground);
         _expandButton = new MPRigidButton("ButtonSidebarOpen","ButtonSidebarHover");
         _expandButton.defaultIcon = assetRepository.getDisplayObject("ButtonSidebarArrowRight");
         _expandButton.iconOffsetX = -1;
         _expandButton.iconOffsetY = -5;
         addChild(_expandButton);
         _collapseButton = new MPRigidButton("ButtonSidebarOpen","ButtonSidebarHover");
         _collapseButton.defaultIcon = assetRepository.getDisplayObject("ButtonSidebarArrowLeft");
         _collapseButton.iconOffsetX = -1;
         _collapseButton.iconOffsetY = -5;
         addChild(_collapseButton);
         _tabBar = new MobileWomTabBar();
         _tabBar.visible = false;
         var _temp_10:* = _tabBar;
         var _temp_9:* = §§findproperty(ListCollection);
         var _temp_6:* = "label";
         var _loc1_:String = "m.ui.mainframe.city.chat.world";
         var _temp_8:* = {_temp_6:peak.i18n.PText.INSTANCE.getText0(_loc1_)};
         var _temp_7:* = "label";
         var _loc2_:String = "m.ui.mainframe.city.chat.alliance";
         _temp_10.dataProvider = new ListCollection([_temp_8,{_temp_7:peak.i18n.PText.INSTANCE.getText0(_loc2_)}]);
         _tabBar.selectedIndex = 0;
         _scrollBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         _scrollBackground.width = 282;
         _scrollBackground.height = 694;
         addChild(_scrollBackground);
         _worldChatPanel = new MobileChatScrollPanel(ChatMessageType.WORLD);
         _activePanel = _worldChatPanel;
         addChild(_worldChatPanel);
         _allianceChatPanel = new MobileChatScrollPanel(ChatMessageType.ALLIANCE);
         _allianceChatPanel.visible = false;
         addChild(_allianceChatPanel);
         addChild(_tabBar);
         _chatInput = new MobileWomTextInput();
         _chatInput.width = 205;
         _chatInput.visible = false;
         _chatInput.promptProperties.textFormat = getWomTextFormat(33,"left");
         addChild(_chatInput);
         _banTextField = new MobileWomTextField();
         _banTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         _banTextField.width = _chatInput.width;
         _banTextField.height = 25;
         _banTextField.visible = _banVisible && !_serverBanVisible;
         addChild(_banTextField);
         _serverBanTextField = new MobileWomTextField();
         _serverBanTextField.textRendererProperties.textFormat = getWomTextFormat(21,"center");
         _serverBanTextField.width = _chatInput.width;
         _serverBanTextField.height = 25;
         _serverBanTextField.visible = _serverBanVisible;
         addChild(_serverBanTextField);
         _sendButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _sendButton.width = 63;
         _sendButton.defaultIcon = assetRepository.getDisplayObject("IconChat");
         _sendButton.iconOffsetY = -5;
         addChild(_sendButton);
         _banTimer = new Timer(1000,180);
         lastSentMessagesForFlood = new Vector.<ChatMessage>();
         floodLastMessagesNextIndex = 0;
         lastSentMessagesForFilter = new Vector.<ChatMessage>();
         filterLastMessagesNextIndex = 0;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_buttonBackground,_panelBackground,_panelBackground.width - 2);
         MobileAlignmentUtil.alignAccordingToPositionOf(_expandButton,_buttonBackground,1,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_collapseButton,_buttonBackground,1,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_scrollBackground,_panelBackground,7,61);
         MobileAlignmentUtil.alignAccordingToPositionOf(_tabBar,_panelBackground,15,17);
         MobileAlignmentUtil.alignAccordingToPositionOf(_worldChatPanel,_scrollBackground,16,88);
         MobileAlignmentUtil.alignAccordingToPositionOf(_allianceChatPanel,_worldChatPanel,0,0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_chatInput,_scrollBackground,15,15);
         MobileAlignmentUtil.alignAccordingToPositionOf(_banTextField,_panelBackground,_chatInput.x >> 0,_chatInput.y + 5 >> 0);
         MobileAlignmentUtil.alignAccordingToPositionOf(_serverBanTextField,_banTextField,0,0);
         MobileAlignmentUtil.alignRightOf(_sendButton,_chatInput,-10);
         MobileAlignmentUtil.alignMiddleYAxisOf(_sendButton,_chatInput);
      }
      
      public function collapse() : void
      {
         if(Starling.juggler.containsTweens(_panelBackground))
         {
            return;
         }
         var _loc1_:Tween = new Tween(_panelBackground,0.1);
         _loc1_.animate("x",-_panelBackground.width);
         _loc1_.onUpdate = drawLayout;
         _loc1_.onComplete = onCollapseTweenComplete;
         _isOpen = false;
         _expandButton.visible = true;
         _collapseButton.visible = false;
         Starling.juggler.add(_loc1_);
      }
      
      public function collapseElements() : void
      {
         _tabBar.visible = false;
         _banTextField.visible = false;
         _serverBanTextField.visible = false;
         _scrollBackground.visible = false;
         _sendButton.visible = false;
         _worldChatPanel.visible = false;
         _allianceChatPanel.visible = false;
      }
      
      private function collapseSubElements() : void
      {
      }
      
      private function onCollapseTweenComplete() : void
      {
         collapseElements();
         collapseTweenSubElements();
         drawLayout();
      }
      
      private function collapseTweenSubElements() : void
      {
      }
      
      public function expand() : void
      {
         if(Starling.juggler.containsTweens(_panelBackground))
         {
            return;
         }
         var _loc1_:Tween = new Tween(_panelBackground,0.1);
         _loc1_.animate("x",0);
         _loc1_.onUpdate = drawLayout;
         expandElements();
         Starling.juggler.add(_loc1_);
      }
      
      private function expandElements() : void
      {
         _isOpen = true;
         _tabBar.visible = true;
         _expandButton.visible = false;
         _banTextField.visible = _banVisible && !_serverBanVisible;
         _serverBanTextField.visible = _serverBanVisible;
         _collapseButton.visible = true;
         _scrollBackground.visible = true;
         _chatInput.visible = true;
         _sendButton.visible = true;
         _activePanel.visible = true;
      }
      
      protected function expandSubElements() : void
      {
      }
      
      public function activateWorldChatPanel() : void
      {
         activatePanel(_worldChatPanel);
         toggleChatInput();
      }
      
      public function activateAllianceChatPanel() : void
      {
         activatePanel(_allianceChatPanel);
         toggleChatInput();
      }
      
      private function toggleChatInput() : void
      {
         _chatInput.isEditable = !(_activePanel.chatMessageType == ChatMessageType.ALLIANCE && !_allianceExists);
      }
      
      public function updateWithAllianceInfo(param1:AllianceSummaryInfo) : void
      {
         _allianceExists = param1 != null;
         if(!_allianceExists)
         {
            _allianceChatPanel.clearMessages();
         }
         toggleChatInput();
      }
      
      public function activatePanel(param1:MobileChatScrollPanel) : void
      {
         deactivateCurrentPanel(_activePanel);
         _activePanel = param1;
         _activePanel.visible = _isOpen;
      }
      
      public function setFocusOnChatInput() : void
      {
      }
      
      public function checkFloodForMessage(param1:String) : Boolean
      {
         var _loc6_:int = 0;
         var _loc3_:ChatMessage = null;
         var _loc4_:ChatMessage = new ChatMessage(ChatMessageType.UNKNOWN,"","",param1,false,false,new Date());
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         _loc6_ = 0;
         while(_loc6_ < lastSentMessagesForFlood.length)
         {
            _loc3_ = lastSentMessagesForFlood[_loc6_];
            if(_loc3_.chatMessage == param1)
            {
               _loc5_++;
            }
            if(_loc4_.messageTime.getTime() - _loc3_.messageTime.getTime() <= 1000)
            {
               _loc2_++;
            }
            _loc6_++;
         }
         lastSentMessagesForFlood[floodLastMessagesNextIndex] = _loc4_;
         floodLastMessagesNextIndex = (floodLastMessagesNextIndex + 1) % 4;
         return _loc5_ == 4 || _loc2_ == 4;
      }
      
      public function checkFilterForMessage(param1:String, param2:SwearFilter) : Boolean
      {
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:ChatMessage = null;
         var _loc5_:ChatMessage = new ChatMessage(ChatMessageType.UNKNOWN,"","",param1,false,false,new Date());
         lastSentMessagesForFilter[filterLastMessagesNextIndex] = _loc5_;
         filterLastMessagesNextIndex = (filterLastMessagesNextIndex + 1) % 5;
         if(param2.checkCensoredWordExits(param1).length > 0)
         {
            _loc3_ = 0;
            _loc6_ = 0;
            while(_loc6_ < lastSentMessagesForFilter.length)
            {
               _loc4_ = lastSentMessagesForFilter[_loc6_];
               if(param2.checkCensoredWordExits(_loc4_.chatMessage).length > 0)
               {
                  _loc3_++;
               }
               _loc6_++;
            }
         }
         return _loc3_ >= 3;
      }
      
      public function startBanProcess() : void
      {
         _banVisible = true;
         _banTextField.visible = _banVisible && !_serverBanVisible;
         _banTextField.text = DateTimeUtil.getFormattedTime((180 - _banTimer.currentCount) * 1000);
         _chatInput.isEditable = false;
         _banTimer.reset();
         _banTimer.start();
      }
      
      public function onBanTimerTick() : void
      {
         if(_banTimer.currentCount < 180)
         {
            _banTextField.text = DateTimeUtil.getFormattedTime((180 - _banTimer.currentCount) * 1000);
         }
         else
         {
            _banTextField.visible = _banVisible = false;
            _chatInput.isEditable = true;
            lastSentMessagesForFlood.length = 0;
            floodLastMessagesNextIndex = 0;
            lastSentMessagesForFilter.length = 0;
            filterLastMessagesNextIndex = 0;
         }
      }
      
      public function updateServerBanField(param1:Number) : void
      {
         if(param1 <= 0)
         {
            _serverBanTextField.visible = false;
            _serverBanVisible = false;
            _chatInput.isEditable = true;
         }
         else
         {
            _chatInput.isEditable = false;
            _chatInput.text = "";
            _serverBanTextField.visible = _serverBanVisible = true;
            var _temp_4:* = _serverBanTextField;
            var _temp_3:* = "ui.mainframe.city.chat.banneduntil";
            var _loc2_:String = DateTimeUtil.getFormattedTimeWithoutCroppingHours(param1);
            var _loc3_:String = _temp_3;
            _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         }
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get chatInput() : MPTextInput
      {
         return _chatInput;
      }
      
      public function get banTimer() : Timer
      {
         return _banTimer;
      }
      
      public function get panelBackground() : DisplayObject
      {
         return _panelBackground;
      }
      
      public function get sendButton() : MPButton
      {
         return _sendButton;
      }
      
      public function get tabBar() : MPTabBar
      {
         return _tabBar;
      }
      
      public function get activePanel() : MobileChatScrollPanel
      {
         return _activePanel;
      }
      
      public function get collapseButton() : MPRigidButton
      {
         return _collapseButton;
      }
      
      public function get expandButton() : MPRigidButton
      {
         return _expandButton;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
         _panelBackground.height = _visibleHeight;
      }
   }
}

