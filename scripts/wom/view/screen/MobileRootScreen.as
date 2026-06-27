package wom.view.screen
{
   import flash.media.StageWebView;
   import starling.core.Starling;
   import starling.display.Sprite;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.WomScreenType;
   import wom.view.screen.popups.MobileLeaveGamePopUp;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsWindow;
   import wom.view.screen.windows.gold.MobileGetGoldWindow;
   import wom.view.ui.MobileCombatHelpTextLayer;
   import wom.view.ui.MobileFloatingTextLayer;
   import wom.view.ui.MobileLoadingLayer;
   import wom.view.ui.MobileModalLayer;
   import wom.view.ui.MobilePopupLayer;
   import wom.view.ui.mainframe.MobileUILayer;
   import wom.view.ui.mainframe.city.MobileCityPlannerUILayer;
   import wom.view.ui.mainframe.city.MobileCityUILayer;
   import wom.view.ui.mainframe.combat.MobileCombatUILayer;
   import wom.view.ui.mainframe.defend.MobileNPCAttackUILayer;
   import wom.view.ui.mainframe.visit.MobileVisitUILayer;
   import wom.view.ui.tooltip.MobileTooltipLayer;
   import wom.view.ui.tutorial.mobile.MobileTutorialLayer;
   
   public class MobileRootScreen extends Sprite
   {
      
      private var _uiLayer:MobileUILayer;
      
      private var _modalLayer:MobileModalLayer;
      
      private var _combatHelpTextLayer:MobileCombatHelpTextLayer;
      
      private var _popupLayer:MobilePopupLayer;
      
      private var _floatingTextLayer:MobileFloatingTextLayer;
      
      private var _secondaryPopUpModalLayer:MobileModalLayer;
      
      private var _secondaryPopupLayer:MobilePopupLayer;
      
      private var _tutorialLayer:MobileTutorialLayer;
      
      private var _currentScreen:MobileBaseScreen;
      
      private var _previousScreenType:WomScreenType = null;
      
      private var _selectFriendsWindow:MobileSelectFriendsWindow;
      
      private var _getGoldWindow:MobileGetGoldWindow;
      
      private var _leaveGamePopUp:MobileLeaveGamePopUp;
      
      private var _popups:Vector.<MobilePopUpWindowEvent>;
      
      private var _tooltipLayer:MobileTooltipLayer;
      
      private var _loadingLayer:MobileLoadingLayer;
      
      private var _webView:StageWebView;
      
      public function MobileRootScreen()
      {
         super();
         _popups = new Vector.<MobilePopUpWindowEvent>();
         init();
      }
      
      private function init() : void
      {
         var _loc1_:int = Starling.current.stage.stageWidth;
         var _loc2_:int = Starling.current.stage.stageHeight;
         _uiLayer = new MobileCityUILayer();
         _uiLayer.visible = false;
         addChild(_uiLayer);
         _tooltipLayer = new MobileTooltipLayer();
         addChild(_tooltipLayer);
         _modalLayer = new MobileModalLayer();
         _modalLayer.resizeLayer(_loc1_,_loc2_);
         _modalLayer.visible = false;
         addChild(_modalLayer);
         _combatHelpTextLayer = new MobileCombatHelpTextLayer();
         addChild(_combatHelpTextLayer);
         _popupLayer = new MobilePopupLayer();
         _popupLayer.visibleWidth = _loc1_;
         _popupLayer.visibleHeight = _loc2_;
         addChild(_popupLayer);
         _secondaryPopUpModalLayer = new MobileModalLayer();
         _secondaryPopUpModalLayer.resizeLayer(_loc1_,_loc2_);
         _secondaryPopUpModalLayer.visible = false;
         addChild(_secondaryPopUpModalLayer);
         _secondaryPopupLayer = new MobilePopupLayer();
         _secondaryPopupLayer.visibleWidth = _loc1_;
         _secondaryPopupLayer.visibleHeight = _loc2_;
         addChild(_secondaryPopupLayer);
         _floatingTextLayer = new MobileFloatingTextLayer();
         addChild(_floatingTextLayer);
         _loadingLayer = new MobileLoadingLayer();
         _loadingLayer.visible = false;
         addChild(_loadingLayer);
         _tutorialLayer = new MobileTutorialLayer();
         _tutorialLayer.visible = false;
         addChild(_tutorialLayer);
      }
      
      public function changeScreen(param1:MobileBaseScreen) : void
      {
         if(_uiLayer)
         {
            _uiLayer.visible = !(param1 is MobileLoadingScreen || param1 is MobileManualAuthenticationScreen);
         }
         _modalLayer.visible = false;
         _secondaryPopUpModalLayer.visible = false;
         if(_currentScreen != null && contains(_currentScreen))
         {
            _previousScreenType = WomScreenType.CITY;
            removeChild(_currentScreen);
            _currentScreen = null;
         }
         _currentScreen = param1;
         addChildAt(_currentScreen,0);
      }
      
      public function clearPopupLayers() : void
      {
         if(_popupLayer != null && contains(_popupLayer))
         {
            while(_popupLayer.numChildren > 0)
            {
               _popupLayer.removeChildAt(0);
            }
         }
         if(_secondaryPopupLayer != null && contains(_secondaryPopupLayer))
         {
            while(_secondaryPopupLayer.numChildren > 0)
            {
               _secondaryPopupLayer.removeChildAt(0);
            }
         }
      }
      
      public function get currentScreen() : MobileBaseScreen
      {
         return _currentScreen;
      }
      
      public function get popupLayer() : MobilePopupLayer
      {
         return _popupLayer;
      }
      
      public function get modalLayer() : MobileModalLayer
      {
         return _modalLayer;
      }
      
      public function get secondaryPopUpModalLayer() : MobileModalLayer
      {
         return _secondaryPopUpModalLayer;
      }
      
      public function get secondaryPopupLayer() : MobilePopupLayer
      {
         return _secondaryPopupLayer;
      }
      
      public function get uiLayer() : MobileUILayer
      {
         return _uiLayer;
      }
      
      public function initCombatUI() : void
      {
         removeChild(_uiLayer);
         _uiLayer = new MobileCombatUILayer();
         addChildAt(_uiLayer,1);
      }
      
      public function initCityUI() : void
      {
         removeChild(_uiLayer);
         _uiLayer = new MobileCityUILayer();
         addChildAt(_uiLayer,1);
      }
      
      public function initVisitUI() : void
      {
         removeChild(_uiLayer);
         _uiLayer = new MobileVisitUILayer();
         addChildAt(_uiLayer,1);
      }
      
      public function initNPCAttackUI() : void
      {
         removeChild(_uiLayer);
         _uiLayer = new MobileNPCAttackUILayer();
         addChildAt(_uiLayer,1);
      }
      
      public function initCityPlannerUI() : void
      {
         removeChild(_uiLayer);
         _uiLayer = new MobileCityPlannerUILayer();
         addChildAt(_uiLayer,1);
      }
      
      public function get popups() : Vector.<MobilePopUpWindowEvent>
      {
         return _popups;
      }
      
      public function get previousScreenType() : WomScreenType
      {
         return _previousScreenType;
      }
      
      public function get tutorialLayer() : MobileTutorialLayer
      {
         return _tutorialLayer;
      }
      
      public function get loadingLayer() : MobileLoadingLayer
      {
         return _loadingLayer;
      }
      
      public function get selectFriendsWindow() : MobileSelectFriendsWindow
      {
         return _selectFriendsWindow;
      }
      
      public function set selectFriendsWindow(param1:MobileSelectFriendsWindow) : void
      {
         _selectFriendsWindow = param1;
      }
      
      public function get getGoldWindow() : MobileGetGoldWindow
      {
         return _getGoldWindow;
      }
      
      public function set getGoldWindow(param1:MobileGetGoldWindow) : void
      {
         _getGoldWindow = param1;
      }
      
      public function get leaveGamePopUp() : MobileLeaveGamePopUp
      {
         return _leaveGamePopUp;
      }
      
      public function set leaveGamePopUp(param1:MobileLeaveGamePopUp) : void
      {
         _leaveGamePopUp = param1;
      }
      
      public function showLoadingLayer(param1:Function) : void
      {
         _loadingLayer.show(param1);
      }
      
      public function hideLoadingLayer() : void
      {
         _loadingLayer.hide();
      }
   }
}

