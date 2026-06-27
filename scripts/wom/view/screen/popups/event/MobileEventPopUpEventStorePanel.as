package wom.view.screen.popups.event
{
   import peak.util.MobileAlignmentUtil;
   import wom.view.screen.windows.event.MobileEventStorePanel;
   import wom.view.util.MobileBaseWindowPanel;
   
   public class MobileEventPopUpEventStorePanel extends MobileBaseWindowPanel
   {
      
      private static const WIDTH:int = 774;
      
      private static const HEIGHT:int = 595;
      
      private var _eventStorePanel:MobileEventStorePanel;
      
      public function MobileEventPopUpEventStorePanel()
      {
         super(774,595);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _eventStorePanel = new MobileEventStorePanel(false,868);
         _eventStorePanel.scaleX = _eventStorePanel.scaleY = 0.89;
         addChild(_eventStorePanel);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_eventStorePanel,bg);
         super.drawLayout();
      }
   }
}

