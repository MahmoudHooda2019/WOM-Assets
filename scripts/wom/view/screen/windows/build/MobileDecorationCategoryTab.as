package wom.view.screen.windows.build
{
   import feathers.data.ListCollection;
   import peak.component.mobile.MPTabBar;
   import peak.display.View;
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.view.component.MobileWomTabBar;
   
   public class MobileDecorationCategoryTab extends Sprite implements View
   {
      
      private var _tabBar:MPTabBar;
      
      private var _activePanel:MobileBuildDecorationCategoryPanel;
      
      private var _tabPanels:Vector.<MobileBuildDecorationCategoryPanel>;
      
      private var _initialTabIndex:int;
      
      private var initialized:Boolean = false;
      
      private var panelWidth:int;
      
      public function MobileDecorationCategoryTab(param1:int, param2:int = 0)
      {
         super();
         this.panelWidth = param1;
         _initialTabIndex = param2;
         init();
      }
      
      private static function deactivateCurrentPanel(param1:Sprite) : void
      {
         if(param1 != null)
         {
            param1.visible = false;
         }
      }
      
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _tabPanels = new Vector.<MobileBuildDecorationCategoryPanel>();
         _tabBar = new MobileWomTabBar();
         addChild(_tabBar);
         drawLayout();
      }
      
      private function createTab(param1:BuildMenuDecorationCategory) : void
      {
         var _loc2_:MobileBuildDecorationCategoryPanel = new MobileBuildDecorationCategoryPanel(param1,panelWidth);
         _loc2_.y = 44;
         _loc2_.visible = false;
         _tabPanels.push(_loc2_);
         addChildAt(_loc2_,0);
      }
      
      public function drawLayout() : void
      {
         _tabBar.x = 8;
      }
      
      public function get tabBar() : MPTabBar
      {
         return _tabBar;
      }
      
      public function activateTabByIndex(param1:int) : void
      {
         activatePanel(_tabPanels[param1]);
      }
      
      public function activatePanel(param1:MobileBuildDecorationCategoryPanel) : void
      {
         deactivateCurrentPanel(_activePanel);
         _activePanel = param1;
         _activePanel.visible = true;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         var _loc3_:ListCollection = null;
         if(param1 && !initialized && _tabBar)
         {
            initialized = true;
            _loc3_ = new ListCollection();
            for each(var _loc2_ in BuildMenuDecorationCategory.categories)
            {
               if(_loc2_ != BuildMenuDecorationCategory.UNKNOWN)
               {
                  createTab(_loc2_);
                  var _temp_5:* = _loc3_;
                  var _temp_4:* = "label";
                  var _loc6_:String = "ui.windows.buildshowcase.decorations." + _loc2_.name;
                  _temp_5.push({_temp_4:peak.i18n.PText.INSTANCE.getText0(_loc6_)});
               }
            }
            _tabBar.dataProvider = _loc3_;
            _tabBar.selectedIndex = _initialTabIndex;
            activateTabByIndex(_initialTabIndex);
         }
         super.visible = param1;
      }
   }
}

