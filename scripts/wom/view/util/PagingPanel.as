package wom.view.util
{
   import fl.controls.Button;
   import wom.view.component.button.rigid.SlideArrowButtonLeft;
   import wom.view.component.button.rigid.SlideArrowButtonRight;
   
   public class PagingPanel extends BaseWindowPanel
   {
      
      protected const ROW_COUNT:int = 2;
      
      protected const COLUMN_COUNT:int = 4;
      
      protected var _currentPageNumber:int = 0;
      
      protected var _previousButton:Button;
      
      protected var _nextButton:Button;
      
      protected var _rowCount:int;
      
      protected var _columnCount:int;
      
      public function PagingPanel(param1:int, param2:int, param3:int = 2, param4:int = 4)
      {
         super(param1,param2);
         _rowCount = param3;
         _columnCount = param4;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _previousButton = new SlideArrowButtonLeft();
         _nextButton = new SlideArrowButtonRight();
         addChild(_previousButton);
         addChild(_nextButton);
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
      }
      
      protected function alignSlideArrowButtons() : void
      {
         _previousButton.x = (-_previousButton.width / 2 << 0) - 16;
         _previousButton.y = ((_visibleHeight - _previousButton.height) / 2 << 0) + 3;
         _nextButton.x = (_visibleWidth - _nextButton.width / 2 << 0) + 16;
         _nextButton.y = ((_visibleHeight - _nextButton.height) / 2 << 0) + 3;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         alignSlideArrowButtons();
         setChildIndex(_nextButton,numChildren - 1);
         setChildIndex(_previousButton,numChildren - 2);
      }
      
      public function setPagingButtonsVisibility(param1:int) : void
      {
         _previousButton.visible = _currentPageNumber != 0;
         _nextButton.visible = _currentPageNumber * itemCountPerPage() + itemCountPerPage() < param1;
      }
      
      public function get currentPageNumber() : int
      {
         return _currentPageNumber;
      }
      
      public function get previousButton() : Button
      {
         return _previousButton;
      }
      
      public function get nextButton() : Button
      {
         return _nextButton;
      }
      
      public function get rowCount() : int
      {
         return _rowCount;
      }
      
      public function get columnCount() : int
      {
         return _columnCount;
      }
      
      public function itemCountPerPage() : int
      {
         return _rowCount * _columnCount;
      }
   }
}

