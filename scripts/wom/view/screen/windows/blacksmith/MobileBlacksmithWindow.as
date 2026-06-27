package wom.view.screen.windows.blacksmith
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileBlacksmithWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 841;
      
      private static const WINDOW_HEIGHT:int = 670;
      
      private var _selectEventItemPanel:MobileBlacksmithSelectEventItemPanel;
      
      private var _inventoryPanel:MobileBlacksmithInventoryPanel;
      
      private var _lastModifiedItemIndex:int;
      
      public function MobileBlacksmithWindow(param1:int, param2:Vector.<WindowEnumeration> = null)
      {
         super(841,670,param2);
         _lastModifiedItemIndex = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.blacksmith.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _selectEventItemPanel = new MobileBlacksmithSelectEventItemPanel();
         addChild(_selectEventItemPanel);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_selectEventItemPanel,_background,44);
         _inventoryPanel = new MobileBlacksmithInventoryPanel(_lastModifiedItemIndex);
         addChild(_inventoryPanel);
         MobileAlignmentUtil.alignBelowOf(_inventoryPanel,_selectEventItemPanel,12);
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get selectEventItemPanel() : MobileBlacksmithSelectEventItemPanel
      {
         return _selectEventItemPanel;
      }
      
      public function get inventoryPanel() : MobileBlacksmithInventoryPanel
      {
         return _inventoryPanel;
      }
   }
}

