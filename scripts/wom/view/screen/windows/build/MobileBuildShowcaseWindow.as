package wom.view.screen.windows.build
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.Sprite;
   import wom.model.game.building.BuildMenuCategory;
   import wom.view.ui.mainframe.city.MobileResourcePanel;
   import wom.view.util.MobileButtonTabbedFullscreenWindow;
   
   public class MobileBuildShowcaseWindow extends MobileButtonTabbedFullscreenWindow
   {
      
      private static const PANEL_MARGIN:int = 12;
      
      private var resourcePanel:MobileResourcePanel;
      
      private var _initialTabIndex:int;
      
      private var _addResourceAction:Function = null;
      
      public function MobileBuildShowcaseWindow(param1:int = 0)
      {
         super(true);
         this._initialTabIndex = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc4_:String = "ui.windows.buildshowcase.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc4_));
         resourcePanel = new MobileResourcePanel(false,true,_addResourceAction);
         addChild(resourcePanel);
         for each(var _loc1_ in BuildMenuCategory.buildMenuCategories)
         {
            if(_loc1_ != BuildMenuCategory.UNKNOWN)
            {
               createTab(_loc1_);
            }
         }
         alignHeader();
         drawLayout();
         activateTabByButton(tabButtons[_initialTabIndex]);
      }
      
      protected function drawLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MPButton = null;
         _loc2_ = 0;
         while(_loc2_ < tabButtons.length)
         {
            _loc1_ = tabButtons[_loc2_];
            if(_loc2_ == 0)
            {
               _loc1_.x = 8;
               _loc1_.y = 94;
            }
            else
            {
               MobileAlignmentUtil.alignRightOf(_loc1_,tabButtons[_loc2_ - 1],12);
            }
            _loc2_++;
         }
      }
      
      private function createTab(param1:BuildMenuCategory) : void
      {
         var _loc3_:Sprite = null;
         if(param1 == BuildMenuCategory.DECORATORS)
         {
            _loc3_ = new MobileDecorationCategoryTab(_windowWidth - 12 * 2);
         }
         else
         {
            _loc3_ = new MobileBuildCategoryPanel(param1,_windowWidth - 12 * 2);
         }
         var _temp_1:* = this;
         var _loc4_:String = "ui.windows.buildshowcase." + param1.name;
         var _loc2_:MPButton = createTabButton(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_));
         addTab(this,_loc2_,_loc3_,12,175);
      }
      
      override protected function alignHeader() : void
      {
         if(resourcePanel)
         {
            _windowHeader.x = 15;
            _windowHeader.y = 15;
            resourcePanel.x = _windowWidth - resourcePanel.width >> 1;
            resourcePanel.y = _headerBackground.height - resourcePanel.height >> 1;
            _closeButton.x = _windowWidth - _closeButton.width - 10;
            _closeButton.y = 10;
            _staticLayer.flatten();
         }
      }
      
      public function get addResourceAction() : Function
      {
         return _addResourceAction;
      }
      
      public function set addResourceAction(param1:Function) : void
      {
         _addResourceAction = param1;
      }
      
      public function get initialTabIndex() : int
      {
         return _initialTabIndex;
      }
   }
}

