package wom.view.screen.windows.beast.cave
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileWomTabBar;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBeastCaveWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 829;
      
      private static const WINDOW_HEIGHT:int = 622;
      
      private var _beastKeeperBuildingTypeDIO:BuildingTypeDIO;
      
      private var _initialTabIndex:int;
      
      private var _tabBar:MobileWomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var contentContainer:Sprite;
      
      public function MobileBeastCaveWindow(param1:BuildingTypeDIO, param2:int = 0, param3:Vector.<WindowEnumeration> = null)
      {
         super(829,622,param3);
         _beastKeeperBuildingTypeDIO = param1;
         _initialTabIndex = param2;
         _tabPanels = new Dictionary();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.beast.cave.beast.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         contentContainer = new Sprite();
         addChild(contentContainer);
         _tabBar = new MobileWomTabBar();
         addTab(0,new MobileBeastPanel());
         addTab(1,new MobileEvolutionPanel());
         addTab(2,new MobileBeastCaveBeastKeeperPanel());
         addTab(3,new MobileDailyFeedPanel());
         _tabBar.x = 39;
         _tabBar.y = 36;
         contentContainer.addChild(_tabBar);
         drawLayout();
      }
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.x = 27;
         param2.y = 80;
         param2.visible = false;
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
         if(!contains(param1))
         {
            contentContainer.addChildAt(param1,0);
         }
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      public function drawLayout() : void
      {
      }
      
      public function toggleHint(param1:Boolean) : void
      {
         if(!contains(contentContainer))
         {
            addChild(contentContainer);
         }
         contentContainer.visible = !param1;
      }
      
      public function get tabBar() : MobileWomTabBar
      {
         return _tabBar;
      }
      
      public function get tabPanels() : Dictionary
      {
         return _tabPanels;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
      
      public function updateTabs(param1:BeastInfo, param2:BeastTypeDIO) : void
      {
         var _loc3_:Array = [];
         if(param1 != null)
         {
            var _temp_1:* = _loc3_;
            var _loc4_:String = "ui.windows.beast.cave.beast.tab.beast";
            _temp_1.push(peak.i18n.PText.INSTANCE.getText0(_loc4_));
            if(param1.level < param2.maxLevels)
            {
               var _temp_2:* = _loc3_;
               var _loc5_:String = "ui.windows.beast.cave.beast.tab.evolution";
               _temp_2.push(peak.i18n.PText.INSTANCE.getText0(_loc5_));
               if(_tabPanels[1] is MobileDailyFeedPanel)
               {
                  swapPanels(1,3);
               }
            }
            else
            {
               var _temp_3:* = _loc3_;
               var _loc6_:String = "ui.windows.beast.cave.beast.tab.dailyfeed";
               _temp_3.push(peak.i18n.PText.INSTANCE.getText0(_loc6_));
               if(_tabPanels[1] is MobileEvolutionPanel)
               {
                  swapPanels(1,3);
               }
            }
            if(!(_tabPanels[0] is MobileBeastPanel))
            {
               swapPanels(0,2);
            }
         }
         else if(!(_tabPanels[0] is MobileBeastCaveBeastKeeperPanel))
         {
            swapPanels(0,2);
         }
         var _temp_4:* = _loc3_;
         var _loc7_:String = "ui.windows.beast.cave.beast.tab.change";
         _temp_4.push(peak.i18n.PText.INSTANCE.getText0(_loc7_));
         _tabBar.dataProvider = new ListCollection(_loc3_);
         if(param1 == null)
         {
            _tabBar.selectedIndex = 0;
         }
         if(_tabBar.selectedIndex != -1)
         {
            activateTabByIndex(_tabBar.selectedIndex);
         }
         drawLayout();
      }
      
      private function swapPanels(param1:int, param2:int) : void
      {
         var _loc3_:Sprite = _tabPanels[param1];
         _tabPanels[param1] = _tabPanels[param2];
         _tabPanels[param2] = _loc3_;
      }
   }
}

