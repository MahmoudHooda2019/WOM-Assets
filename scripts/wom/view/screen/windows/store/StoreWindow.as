package wom.view.screen.windows.store
{
   import fl.controls.Button;
   import fl.data.DataProvider;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.WomTabBar;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.util.GenericWindow;
   
   public class StoreWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 732;
      
      private static const WINDOW_HEIGHT:int = 555;
      
      private var _tabBar:WomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var _currentReconPointsView:CurrentProgressView;
      
      private var _currentAmountOfGoldView:CurrentProgressView;
      
      private var _addGoldButton:Button;
      
      private var _instanceId:int;
      
      private var _initialTabIndex:int;
      
      private var _initialPageIndex:int;
      
      public function StoreWindow(param1:int = -1, param2:int = 0, param3:int = -1, param4:Vector.<WindowEnumeration> = null, param5:int = 732, param6:int = 555)
      {
         super(param5,param6,param4);
         this._instanceId = param1;
         _tabPanels = new Dictionary();
         _initialTabIndex = param2;
         _initialPageIndex = param3;
      }
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.x = 21;
         param2.y = 80;
         param2.visible = false;
         addChild(param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.store.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _tabBar = new WomTabBar();
         addTab(0,new StoreConstructionPanel());
         addTab(1,new StoreResourcesPanel());
         addTab(2,new StoreSpeedupsPanel(_instanceId));
         addTab(3,new StoreCombatPanel());
         addTab(4,new StoreSpeedupsPanel(_instanceId,true));
         _tabBar.x = 34;
         _tabBar.y = 37;
         var _temp_7:* = _tabBar;
         var _temp_6:* = §§findproperty(DataProvider);
         var _loc2_:String = "ui.windows.store.construction.header";
         var _temp_5:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         var _loc3_:String = "ui.windows.store.resources.header";
         var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc4_:String = "ui.windows.store.speedups.header";
         var _temp_3:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc5_:String = "ui.windows.store.combat.header";
         _temp_7.dataProvider = new DataProvider([_temp_5,_temp_4,_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc5_)]);
         addChild(_tabBar);
         _currentReconPointsView = new CurrentReconPointsView();
         addChild(_currentReconPointsView);
         _currentAmountOfGoldView = new CurrentAmountOfGoldView();
         addChild(_currentAmountOfGoldView);
         _addGoldButton = new WomBlueSmallButton();
         var _temp_11:* = _addGoldButton;
         var _loc6_:String = "ui.windows.store.addgold";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _addGoldButton.width = 140;
         addChild(_addGoldButton);
         drawLayout();
      }
      
      public function activateTabByIndex(param1:int, param2:int = -1) : void
      {
         _tabBar.selectedIndex = param1;
         activatePanel(_tabPanels[param1],param2);
      }
      
      public function activatePanel(param1:Sprite, param2:int = -1) : void
      {
         if(_activePanel != null)
         {
            _activePanel.visible = false;
         }
         _activePanel = param1;
         _activePanel.visible = true;
         if(param2 != -1)
         {
            (_activePanel as StoreCategoryPanel).update(param2);
         }
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_currentReconPointsView,_background,21,500);
         AlignmentUtil.alignAccordingToPositionOf(_addGoldButton,_background,_background.width - _addGoldButton.width - 21,500);
         AlignmentUtil.alignLeftOf(_currentAmountOfGoldView,_addGoldButton,25);
      }
      
      public function get tabBar() : WomTabBar
      {
         return _tabBar;
      }
      
      public function get addGoldButton() : Button
      {
         return _addGoldButton;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
      
      public function get initialPageIndex() : int
      {
         return _initialPageIndex;
      }
      
      public function get activePanel() : Sprite
      {
         return _activePanel;
      }
   }
}

