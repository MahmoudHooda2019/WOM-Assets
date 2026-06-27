package wom.view.screen.windows.store
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.util.MobileButtonTabbedFullscreenWindow;
   
   public class MobileStoreWindow extends MobileButtonTabbedFullscreenWindow
   {
      
      private static const PANEL_MARGIN:int = 12;
      
      public static const STORE_WINDOW:int = 0;
      
      public static const STASH_WINDOW:int = 1;
      
      public static const STORE_CONSTRUCTION_TAB:int = 0;
      
      public static const STORE_RESOURCE_TAB:int = 1;
      
      public static const STORE_SPEEDUPS_TAB:int = 2;
      
      public static const STORE_COMBAT_TAB:int = 3;
      
      public static const STORE_SPEEDUPS_ONLY_BUILDINGS_TAB:int = 4;
      
      public static const STASH_ALL_TAB:int = 0;
      
      public static const STASH_RESOURCE_TAB:int = 1;
      
      public static const STASH_PARTS_TAB:int = 2;
      
      public static const STASH_TAVERN_TAB:int = 3;
      
      private var currentGoldProgress:MobileCurrentProgressView = new MobileCurrentProgressView(true);
      
      private var currentRPProgress:MobileCurrentProgressView = new MobileCurrentProgressView(false);
      
      private var _addGoldButton:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
      
      private var _storeButton:MPButton;
      
      private var _stashButton:MPButton;
      
      private var _openWindow:int;
      
      private var _openTab:int;
      
      private var _instanceId:int;
      
      public function MobileStoreWindow(param1:int = 0, param2:int = 0, param3:int = -1, param4:Vector.<WindowEnumeration> = null)
      {
         super(true,param4);
         _openWindow = param1;
         _openTab = param2;
         _instanceId = param3;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:int = _windowWidth - 12 * 2;
         addChild(currentGoldProgress);
         addChild(currentRPProgress);
         addChild(_addGoldButton);
         var _temp_1:* = _addGoldButton;
         var _loc2_:String = "ui.windows.store.addgold";
         _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _addGoldButton.width = 187;
         var _temp_2:* = this;
         var _loc3_:String = "ui.windows.store.header";
         _storeButton = createTabButton(_temp_2,peak.i18n.PText.INSTANCE.getText0(_loc3_));
         var _temp_5:* = this;
         var _loc4_:String = "ui.windows.inventory.header";
         _stashButton = createTabButton(_temp_5,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         addTab(this,_storeButton,new MobileStorePanel(_loc1_,_openWindow == 0 ? _openTab : 0,_instanceId),12,175);
         addTab(this,_stashButton,new MobileInventoryPanel(_loc1_,_openWindow == 1 ? _openTab : 0),12,175);
         drawLayout();
         activateTabByButton(_openWindow == 0 ? _storeButton : _stashButton);
      }
      
      private function drawLayout() : void
      {
         currentGoldProgress.x = 15;
         currentGoldProgress.y = 10;
         MobileAlignmentUtil.alignRightOf(currentRPProgress,currentGoldProgress,30);
         MobileAlignmentUtil.alignRightOf(_addGoldButton,currentRPProgress,22);
         _storeButton.x = 8;
         _storeButton.y = 94;
         MobileAlignmentUtil.alignRightOf(_stashButton,_storeButton,12);
      }
      
      public function get addGoldButton() : MobileWomButton
      {
         return _addGoldButton;
      }
   }
}

