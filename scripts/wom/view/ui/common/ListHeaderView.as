package wom.view.ui.common
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.model.resource.ListColumnType;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class ListHeaderView extends Sprite implements View
   {
      
      public static const ASC:int = 1;
      
      public static const NOSORT:int = 0;
      
      public static const DESC:int = -1;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _headerBg:DisplayObject;
      
      private var _textField:TextField;
      
      private var _descSortIcon:DisplayObject;
      
      private var _noSortIcon:DisplayObject;
      
      private var _ascSortIcon:DisplayObject;
      
      private var _sortable:Boolean;
      
      private var _text:String;
      
      private var _bgWidth:int;
      
      private var _bgHeight:int;
      
      private var _columnType:ListColumnType;
      
      private var _sortingDirection:int;
      
      public function ListHeaderView(param1:Boolean, param2:String, param3:int, param4:int, param5:ListColumnType, param6:int = 0)
      {
         super();
         _sortable = param1;
         _text = param2;
         _bgWidth = param3;
         _bgHeight = param4;
         _columnType = param5;
         _sortingDirection = param6;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         drawBG();
         _descSortIcon = assetRepository.getDisplayObject("MapFilterArrowDown");
         _noSortIcon = assetRepository.getDisplayObject("MapFilterArrowUnsorted");
         _ascSortIcon = assetRepository.getDisplayObject("MapFilterArrowUp");
         _textField = new WomTextField();
         _textField.width = _sortable ? _bgWidth - _descSortIcon.width - 6 : _bgWidth;
         _textField.height = _bgHeight;
         _textField.defaultTextFormat = WomTextFormats.CENTER;
         _textField.text = _text;
         addChild(_textField);
         addChild(_descSortIcon);
         addChild(_noSortIcon);
         addChild(_ascSortIcon);
         drawLayout();
      }
      
      private function drawBG() : void
      {
         if(_headerBg && contains(_headerBg))
         {
            removeChild(_headerBg);
         }
         _headerBg = assetRepository.getDisplayObject(_sortingDirection == 0 ? "MapFilter" : "MapFilterSorted");
         _headerBg.width = _bgWidth;
         _headerBg.height = _bgHeight;
         addChildAt(_headerBg,0);
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_descSortIcon,_headerBg,_headerBg.width - _descSortIcon.width - 6);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_noSortIcon,_headerBg,_headerBg.width - _noSortIcon.width - 6);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_ascSortIcon,_headerBg,_headerBg.width - _ascSortIcon.width - 6);
      }
      
      public function sortingTypeUpdated(param1:Boolean) : void
      {
         _sortingDirection = !param1 ? 0 : (_sortingDirection == 1 ? -1 : 1);
         _descSortIcon.visible = _sortable && _sortingDirection == -1;
         _noSortIcon.visible = _sortable && _sortingDirection == 0;
         _ascSortIcon.visible = _sortable && _sortingDirection == 1;
         drawBG();
      }
      
      public function updateSortingDirection(param1:int) : void
      {
         _sortingDirection = param1;
         _descSortIcon.visible = _sortable && _sortingDirection == -1;
         _noSortIcon.visible = _sortable && _sortingDirection == 0;
         _ascSortIcon.visible = _sortable && _sortingDirection == 1;
         drawBG();
      }
      
      public function resetSortingDirection() : void
      {
         _sortingDirection = 0;
      }
      
      public function getComperatorFunction() : Function
      {
         return _sortingDirection == -1 ? _columnType.dscComperator : _columnType.ascComperator;
      }
      
      public function get sortingDirection() : int
      {
         return _sortingDirection;
      }
      
      public function updateListHeaderViewText(param1:String) : void
      {
         _textField.text = param1;
      }
      
      public function set columnType(param1:ListColumnType) : void
      {
         _columnType = param1;
      }
   }
}

