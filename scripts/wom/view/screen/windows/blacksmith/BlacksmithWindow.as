package wom.view.screen.windows.blacksmith
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.GenericWindow;
   
   public class BlacksmithWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 709;
      
      private static const WINDOW_HEIGHT:int = 594;
      
      private var _selectEventItemPanel:BlacksmithSelectEventItemPanel;
      
      private var _inventoryPanel:BlacksmithInventoryPanel;
      
      public function BlacksmithWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(709,594,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.blacksmith.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _selectEventItemPanel = new BlacksmithSelectEventItemPanel();
         addChild(_selectEventItemPanel);
         _inventoryPanel = new BlacksmithInventoryPanel();
         addChild(_inventoryPanel);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_selectEventItemPanel,_background,47,37);
         AlignmentUtil.alignAccordingToPositionOf(_inventoryPanel,_background,45,265);
      }
   }
}

