package wom.view.screen.windows.inventory
{
   import fl.data.DataProvider;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.view.component.WomTabBar;
   import wom.view.util.GenericWindow;
   
   public class InventoryWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 736;
      
      private static const WINDOW_HEIGHT:int = 516;
      
      private var _tabBar:WomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _tabBarDataProvider:Array;
      
      private var _activePanel:Sprite;
      
      private var _initialTabIndex:int;
      
      private var _tabsCreated:Boolean;
      
      public function InventoryWindow(param1:int = 0, param2:int = 736, param3:int = 516)
      {
         super(param2,param3);
         _initialTabIndex = param1;
         _tabBarDataProvider = [];
         _tabPanels = new Dictionary();
         _tabsCreated = false;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.inventory.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _tabBar = new WomTabBar();
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         _tabBar.selectedIndex = param1;
         activatePanel(_tabPanels[param1]);
      }
      
      public function activatePanel(param1:Sprite) : void
      {
         if(_activePanel != null)
         {
            _activePanel.visible = false;
         }
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function drawLayout() : void
      {
      }
      
      public function createTab(param1:InventoryItemCategory) : void
      {
         var _loc2_:InventoryCategoryPanel = new InventoryCategoryPanel(param1);
         var _temp_1:* = _tabBarDataProvider;
         var _loc3_:String = "ui.windows.inventory." + param1.name;
         _temp_1.push(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         _tabPanels[param1.tabIndex] = _loc2_;
         _loc2_.x = 23;
         _loc2_.y = 80;
         _loc2_.visible = false;
         addChild(_loc2_);
      }
      
      public function initTabBar() : void
      {
         _tabBar.x = 34;
         _tabBar.y = 37;
         _tabBar.dataProvider = new DataProvider(_tabBarDataProvider);
         addChild(_tabBar);
      }
      
      public function get tabBar() : WomTabBar
      {
         return _tabBar;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
      
      public function get tabsCreated() : Boolean
      {
         return _tabsCreated;
      }
      
      public function set tabsCreated(param1:Boolean) : void
      {
         _tabsCreated = param1;
      }
   }
}

