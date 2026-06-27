package wom.view.screen.windows.store
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPTabBar;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTabBar;
   
   public class MobileInventoryPanel extends Sprite
   {
      
      private static const HEIGHT:int = 536;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _tabBar:MPTabBar;
      
      private var background:DisplayObject;
      
      private var _activePanel:MobileInventoryCategoryPanel;
      
      private var allPanel:MobileInventoryCategoryPanel;
      
      private var resourcePanel:MobileInventoryCategoryPanel;
      
      private var partsPanel:MobileInventoryCategoryPanel;
      
      private var tavernPanel:MobileInventoryCategoryPanel;
      
      private var _panelWidth:int;
      
      private var _openTab:int;
      
      public function MobileInventoryPanel(param1:int, param2:int = 0)
      {
         super();
         _panelWidth = param1;
         _openTab = param2;
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
         var _loc3_:String = "ui.windows.inventory.all";
         var _temp_8:* = {_temp_2:peak.i18n.PText.INSTANCE.getText0(_loc3_)};
         var _temp_3:* = "label";
         var _loc4_:String = "ui.windows.inventory.resource";
         var _temp_7:* = {_temp_3:peak.i18n.PText.INSTANCE.getText0(_loc4_)};
         var _temp_4:* = "label";
         var _loc5_:String = "ui.windows.inventory.parts";
         var _temp_6:* = {_temp_4:peak.i18n.PText.INSTANCE.getText0(_loc5_)};
         var _temp_5:* = "label";
         var _loc6_:String = "ui.windows.inventory.tavern";
         _temp_10.dataProvider = new ListCollection([_temp_8,_temp_7,_temp_6,{_temp_5:peak.i18n.PText.INSTANCE.getText0(_loc6_)}]);
         _tabBar.selectedIndex = _openTab;
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = _panelWidth;
         background.height = 536;
         addChild(background);
         var _loc2_:int = _panelWidth - 50;
         var _loc1_:int = 511;
         allPanel = new MobileInventoryCategoryPanel(InventoryItemCategory.ALL,_loc2_,_loc1_);
         allPanel.visible = false;
         addChild(allPanel);
         resourcePanel = new MobileInventoryCategoryPanel(InventoryItemCategory.RESOURCE,_loc2_,_loc1_);
         resourcePanel.visible = false;
         addChild(resourcePanel);
         partsPanel = new MobileInventoryCategoryPanel(InventoryItemCategory.PARTS,_loc2_,_loc1_);
         partsPanel.visible = false;
         addChild(partsPanel);
         tavernPanel = new MobileInventoryCategoryPanel(InventoryItemCategory.TAVERN,_loc2_,_loc1_);
         tavernPanel.visible = false;
         addChild(tavernPanel);
         addChild(_tabBar);
         drawLayout();
         if(_openTab == 0)
         {
            activatePanel(allPanel);
         }
         else if(_openTab == 2)
         {
            activatePanel(partsPanel);
         }
         else if(_openTab == 1)
         {
            activatePanel(resourcePanel);
         }
         else if(_openTab == 3)
         {
            activatePanel(tavernPanel);
         }
      }
      
      public function drawLayout() : void
      {
         _tabBar.x = 8;
         background.y = 44;
      }
      
      public function activatePanel(param1:MobileInventoryCategoryPanel) : void
      {
         deactivateCurrentPanel(_activePanel);
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function get tabBar() : MPTabBar
      {
         return _tabBar;
      }
      
      public function activateAllTab() : void
      {
         activatePanel(allPanel);
      }
      
      public function activateResourceTab() : void
      {
         activatePanel(resourcePanel);
      }
      
      public function activatePartsTab() : void
      {
         activatePanel(partsPanel);
      }
      
      public function activateTavernTab() : void
      {
         activatePanel(tavernPanel);
      }
   }
}

