package wom.view.screen.windows.store
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPTabBar;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTabBar;
   
   public class MobileStorePanel extends Sprite
   {
      
      private static const HEIGHT:int = 536;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tabBar:MPTabBar;
      
      private var background:DisplayObject;
      
      private var _activePanel:MobileStoreCategoryPanel;
      
      private var constructionPanel:MobileStoreCategoryPanel;
      
      private var resourcePanel:MobileStoreCategoryPanel;
      
      private var speedUpsPanel:MobileStoreCategoryPanel;
      
      private var combatPanel:MobileStoreCategoryPanel;
      
      private var speedUpsOnlyBuildingsPanel:MobileStoreCategoryPanel;
      
      private var _panelWidth:int;
      
      private var _openTab:int;
      
      private var _instanceId:int;
      
      public function MobileStorePanel(param1:int, param2:int = 0, param3:int = -1)
      {
         super();
         _panelWidth = param1;
         _openTab = param2;
         _instanceId = param3;
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
         initLayout();
      }
      
      public function initLayout() : void
      {
         _tabBar = new MobileWomTabBar();
         var _temp_10:* = _tabBar;
         var _temp_9:* = §§findproperty(ListCollection);
         var _temp_2:* = "label";
         var _loc3_:String = "ui.windows.store.construction.header";
         var _temp_8:* = {_temp_2:peak.i18n.PText.INSTANCE.getText0(_loc3_)};
         var _temp_3:* = "label";
         var _loc4_:String = "ui.windows.store.resources.header";
         var _temp_7:* = {_temp_3:peak.i18n.PText.INSTANCE.getText0(_loc4_)};
         var _temp_4:* = "label";
         var _loc5_:String = "ui.windows.store.speedups.header";
         var _temp_6:* = {_temp_4:peak.i18n.PText.INSTANCE.getText0(_loc5_)};
         var _temp_5:* = "label";
         var _loc6_:String = "ui.windows.store.combat.header";
         _temp_10.dataProvider = new ListCollection([_temp_8,_temp_7,_temp_6,{_temp_5:peak.i18n.PText.INSTANCE.getText0(_loc6_)}]);
         if(_openTab == 4)
         {
            _tabBar.selectedIndex = -1;
         }
         else
         {
            _tabBar.selectedIndex = _openTab;
         }
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = _panelWidth;
         background.height = 536;
         addChild(background);
         var _loc2_:int = _panelWidth - 50;
         var _loc1_:int = 511;
         constructionPanel = new MobileStoreCategoryPanel(StoreItemCategory.CONSTRUCTION,_loc2_,_loc1_,_instanceId);
         constructionPanel.visible = false;
         resourcePanel = new MobileStoreCategoryPanel(StoreItemCategory.RESOURCE,_loc2_,_loc1_,_instanceId);
         resourcePanel.visible = false;
         speedUpsPanel = new MobileStoreCategoryPanel(StoreItemCategory.SPEEDUPS,_loc2_,_loc1_,_instanceId);
         speedUpsPanel.visible = false;
         combatPanel = new MobileStoreCategoryPanel(StoreItemCategory.COMBAT,_loc2_,_loc1_,_instanceId);
         combatPanel.visible = false;
         speedUpsOnlyBuildingsPanel = new MobileStoreCategoryPanel(StoreItemCategory.BUILDING_SPEEDUPS,_loc2_,_loc1_,_instanceId);
         speedUpsOnlyBuildingsPanel.visible = false;
         addChild(_tabBar);
         drawLayout();
         if(_openTab == 0)
         {
            activatePanel(constructionPanel);
         }
         else if(_openTab == 3)
         {
            activatePanel(combatPanel);
         }
         else if(_openTab == 1)
         {
            activatePanel(resourcePanel);
         }
         else if(_openTab == 2)
         {
            activatePanel(speedUpsPanel);
         }
         else if(_openTab == 4)
         {
            activatePanel(speedUpsOnlyBuildingsPanel);
         }
      }
      
      public function drawLayout() : void
      {
         _tabBar.x = 8;
         background.y = 44;
      }
      
      public function activatePanel(param1:MobileStoreCategoryPanel) : void
      {
         deactivateCurrentPanel(_activePanel);
         if(!contains(param1))
         {
            addChild(param1);
         }
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function get tabBar() : MPTabBar
      {
         return _tabBar;
      }
      
      public function activateConstructionTab() : void
      {
         activatePanel(constructionPanel);
      }
      
      public function activateResourceTab() : void
      {
         activatePanel(resourcePanel);
      }
      
      public function activateSpeedUpsTab() : void
      {
         activatePanel(speedUpsPanel);
      }
      
      public function activateCombatTab() : void
      {
         activatePanel(combatPanel);
      }
      
      public function activateSpeedUpsOnlyBuildingsTab() : void
      {
         activatePanel(speedUpsOnlyBuildingsPanel);
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
   }
}

