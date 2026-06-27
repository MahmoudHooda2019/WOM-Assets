package wom.view.util
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPButton;
   import starling.display.Sprite;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileButtonTabbedWindow extends MobileGenericWindow
   {
      
      public static const WINDOW_WIDTH:Number = 880;
      
      public static const WINDOW_HEIGHT:Number = 668;
      
      private var tabContainer:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var _tabButtons:Vector.<MPButton>;
      
      public function MobileButtonTabbedWindow(param1:int = 880, param2:int = 668, param3:Vector.<WindowEnumeration> = null)
      {
         super(param1,param2,param3);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         tabContainer = new Dictionary();
         _tabButtons = new Vector.<MPButton>();
      }
      
      protected function createTabButton(param1:Sprite, param2:String, param3:Object = null, param4:Boolean = false, param5:Object = null) : MPButton
      {
         var _loc6_:MobileWomButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         if(!param4)
         {
            _loc6_.width = param3 ? int(param3) : 165;
         }
         _loc6_.label = param2;
         param1.addChild(_loc6_);
         if(param4)
         {
            _loc6_.validate();
            _loc6_.width += param5 ? int(param5) : 16;
         }
         _tabButtons.push(_loc6_);
         return _loc6_;
      }
      
      protected function addTab(param1:Sprite, param2:MPButton, param3:Sprite, param4:Object = null, param5:Object = null) : void
      {
         tabContainer[param2] = param3;
         param3.visible = false;
         param1.addChild(param3);
         determineTabPosition(param3,param4,param5);
      }
      
      protected function determineTabPosition(param1:Sprite, param2:Object = null, param3:Object = null) : void
      {
         param1.x = param2 != null ? int(param2) : 0;
         param1.y = param3 != null ? int(param3) : 0;
      }
      
      public function activateTabByButton(param1:MPButton) : void
      {
         if(param1 in tabContainer)
         {
            for each(var _loc2_ in _tabButtons)
            {
               _loc2_.isSelected = _loc2_ == param1;
            }
            activatePanel(tabContainer[param1]);
         }
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
      
      public function get tabButtons() : Vector.<MPButton>
      {
         return _tabButtons;
      }
      
      public function get activePanel() : Sprite
      {
         return _activePanel;
      }
   }
}

