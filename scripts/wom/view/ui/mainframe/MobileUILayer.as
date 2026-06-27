package wom.view.ui.mainframe
{
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.ui.mainframe.city.MobileLandlordPanel;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   
   public class MobileUILayer extends Sprite implements View
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      public static const MAX_UI_ELEMENTS_WIDTH:int = 1234;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _visibleWidth:int;
      
      protected var _visibleHeight:int;
      
      protected var _landlordAvatar:MobileLandlordPanel;
      
      protected var _chatPanel:MobileChatPanel;
      
      public function MobileUILayer()
      {
         super();
         _visibleWidth = 760;
         _visibleHeight = 620;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         createAndAddLandlordPanel();
         createAndAddChatPanel();
      }
      
      public function drawLayout() : void
      {
         _landlordAvatar.x = 12;
         _landlordAvatar.y = 12;
      }
      
      protected function createAndAddLandlordPanel() : void
      {
         _landlordAvatar = new MobileLandlordPanel();
         addChild(_landlordAvatar);
      }
      
      protected function createAndAddChatPanel() : void
      {
         _chatPanel = new MobileChatPanel();
         _chatPanel.visible = true;
         addChild(_chatPanel);
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth < 760 ? 760 : _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight < 620 ? 620 : _visibleHeight;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function get chatPanel() : MobileChatPanel
      {
         return _chatPanel;
      }
   }
}

