package wom.view.ui.common
{
   import feathers.display.Scale3Image;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.ListColumnType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileListHeaderView extends Sprite implements View
   {
      
      public static const ASC:int = 1;
      
      public static const NOSORT:int = 0;
      
      public static const DESC:int = -1;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _headerBg:DisplayObject;
      
      private var _textField:MobileCaptionTextField;
      
      private var _descSortIcon:DisplayObject;
      
      private var _ascSortIcon:DisplayObject;
      
      private var _sortable:Boolean;
      
      private var _text:String;
      
      private var _iconAssetId:String;
      
      private var _icon:DisplayObject;
      
      private var _iconScale:Number = 1;
      
      private var _bgWidth:int;
      
      private var _columnType:ListColumnType;
      
      private var _textFormat:MPBitmapFontTextFormat;
      
      private var _sortingDirection:int;
      
      public function MobileListHeaderView(param1:Boolean, param2:String, param3:int, param4:ListColumnType, param5:int = 0, param6:String = null, param7:Number = 1, param8:MPBitmapFontTextFormat = null)
      {
         super();
         _sortable = param1;
         _text = param2;
         _iconAssetId = param6;
         _iconScale = param7;
         _bgWidth = param3;
         _columnType = param4;
         _sortingDirection = param5;
         _textFormat = param8 ? param8 : getCaptionTextFormat(21,"left");
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         drawBG();
         _descSortIcon = assetRepository.getDisplayObject("IconSortDown");
         _ascSortIcon = assetRepository.getDisplayObject("IconSortUp");
         _textField = new MobileCaptionTextField();
         _textField.textRendererProperties.textFormat = _textFormat;
         _textField.textRendererProperties.wordWrap = true;
         addChild(_textField);
         _textField.text = _text;
         if(_iconAssetId != null)
         {
            _icon = assetRepository.getDisplayObject(_iconAssetId);
            _icon.scaleX = _icon.scaleY = _iconScale;
            addChild(_icon);
         }
         addChild(_descSortIcon);
         addChild(_ascSortIcon);
         drawLayout();
      }
      
      private function drawBG() : void
      {
         if(_headerBg && contains(_headerBg))
         {
            removeChild(_headerBg);
         }
         _headerBg = assetRepository.getDisplayObject(_sortingDirection == 0 ? "ListHeaderPassiveBackground" : "ListHeaderActiveBackground");
         (_headerBg as Scale3Image).smoothing = "none";
         _headerBg.width = _bgWidth;
         addChildAt(_headerBg,0);
      }
      
      public function drawLayout() : void
      {
         if(_icon)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_icon,_headerBg,_headerBg.width - _icon.width - _textField.width - 7 >> 1,47 - _icon.height >> 1);
            MobileAlignmentUtil.alignRightOf(_textField,_icon,7);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleOf(_textField,_headerBg);
         }
         _textField.x -= 8;
         _textField.y = _textField.height > 35 ? 7 : 15;
         if(_descSortIcon.visible && _ascSortIcon.visible)
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_ascSortIcon,_headerBg,_headerBg.width - _descSortIcon.width - 6,13);
            MobileAlignmentUtil.alignBelowOf(_descSortIcon,_ascSortIcon,1);
         }
         else
         {
            MobileAlignmentUtil.alignAccordingToPositionOf(_descSortIcon,_headerBg,_headerBg.width - _descSortIcon.width - 6,20);
            MobileAlignmentUtil.alignAccordingToPositionOf(_ascSortIcon,_headerBg,_headerBg.width - _ascSortIcon.width - 6,20);
         }
      }
      
      public function sortingTypeUpdated(param1:Boolean) : void
      {
         _sortingDirection = !param1 ? 0 : (_sortingDirection == 1 ? -1 : 1);
         _descSortIcon.visible = _sortable && (_sortingDirection == -1 || _sortingDirection == 0);
         _ascSortIcon.visible = _sortable && (_sortingDirection == 1 || _sortingDirection == 0);
         drawBG();
         drawLayout();
      }
      
      public function updateSortingDirection(param1:int) : void
      {
         _sortingDirection = param1;
         _descSortIcon.visible = _sortable && (_sortingDirection == -1 || _sortingDirection == 0);
         _ascSortIcon.visible = _sortable && (_sortingDirection == 1 || _sortingDirection == 0);
         drawBG();
         drawLayout();
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
      
      public function updateListHeaderViewText(param1:String, param2:int = 0) : void
      {
         _textField.text = param1;
         if(param2 != 0)
         {
            _textField.width;
         }
         drawBG();
         drawLayout();
      }
      
      public function set columnType(param1:ListColumnType) : void
      {
         _columnType = param1;
      }
   }
}

