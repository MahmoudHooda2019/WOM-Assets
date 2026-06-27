package wom.view.screen.windows.event
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.view.component.MobileWomTextField;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileEventStoreWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 828;
      
      private static const WINDOW_HEIGHT:int = 622;
      
      private var eventStorePanel:MobileEventStorePanel;
      
      private var limitedUsageTextField:MobileWomTextField;
      
      private var epWarningTextField:MobileWomTextField;
      
      public function MobileEventStoreWindow(param1:int = 828, param2:int = 622)
      {
         super(param1,param2);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.eventstore.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         eventStorePanel = new MobileEventStorePanel(true);
         addChild(eventStorePanel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(eventStorePanel,_background,41);
      }
   }
}

