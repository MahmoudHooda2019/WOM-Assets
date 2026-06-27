package wom.view.screen.popups.event
{
   import feathers.data.ListCollection;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTabBar;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileEventPopUp extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 829;
      
      private static const WINDOW_HEIGHT:int = 700;
      
      public static const TAB_INDEX_EVENT:int = 0;
      
      public static const TAB_INDEX_STORE:int = 1;
      
      private var _tabBar:MobileWomTabBar;
      
      private var _tabPanels:Dictionary;
      
      private var _activePanel:Sprite;
      
      private var contentContainer:Sprite;
      
      private var currentEPProgressBar:MobileWomProgressBar;
      
      private var iconEP:DisplayObject;
      
      private var currentEPLabel:MobileCaptionTextField;
      
      public function MobileEventPopUp(param1:int = 829, param2:int = 700)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.popups.event.main.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         contentContainer = new Sprite();
         addChild(contentContainer);
         _tabPanels = new Dictionary();
         _tabBar = new MobileWomTabBar();
         addTab(0,new MobileEventOngoingPanel());
         addTab(1,new MobileEventPopUpEventStorePanel());
         initTabBar();
         contentContainer.addChild(_tabBar);
         currentEPLabel = new MobileCaptionTextField();
         currentEPLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(currentEPLabel);
         var _temp_6:* = currentEPLabel;
         var _loc2_:String = "ui.popups.event.main.currentep";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         currentEPProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         currentEPProgressBar.width = 223;
         currentEPProgressBar.height = 33;
         currentEPProgressBar.align = "center";
         currentEPProgressBar.minimum = 0;
         currentEPProgressBar.maximum = 2500;
         addChild(currentEPProgressBar);
         iconEP = assetRepository.getDisplayObject("IconEPBig");
         addChild(iconEP);
         activateTabByIndex(0);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(currentEPProgressBar,_background,575,35);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(iconEP,currentEPProgressBar,-iconEP.width >> 1);
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(currentEPLabel,iconEP,-currentEPLabel.width - 10);
      }
      
      public function updateEP(param1:int) : void
      {
         currentEPProgressBar.value = param1;
         currentEPProgressBar.label = param1 + "/" + currentEPProgressBar.maximum;
      }
      
      public function initTabBar() : void
      {
         _tabBar.x = 39;
         _tabBar.y = 36;
         var _loc1_:Array = [];
         var _temp_1:* = _loc1_;
         var _loc2_:String = "ui.popups.event.main.event";
         _temp_1.push(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         var _temp_2:* = _loc1_;
         var _loc3_:String = "ui.popups.event.main.store";
         _temp_2.push(peak.i18n.PText.INSTANCE.getText0(_loc3_));
         _tabBar.dataProvider = new ListCollection(_loc1_);
         addChild(_tabBar);
      }
      
      private function addTab(param1:int, param2:Sprite) : void
      {
         _tabPanels[param1] = param2;
         param2.x = 27;
         param2.y = 80;
         param2.visible = false;
         contentContainer.addChild(param2);
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
      
      public function get tabBar() : MobileWomTabBar
      {
         return _tabBar;
      }
   }
}

