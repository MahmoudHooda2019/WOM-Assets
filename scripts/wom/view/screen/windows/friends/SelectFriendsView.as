package wom.view.screen.windows.friends
{
   import fl.controls.List;
   import fl.data.DataProvider;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import peak.display.View;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.friend.FriendInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.SearchTextInput;
   import wom.view.component.WomTextFormats;
   
   public class SelectFriendsView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _unselectedWidth:Number;
      
      private var _unselectedHeight:Number;
      
      private var _unselectedMarginX:Number;
      
      private var _unselectedMarginY:Number;
      
      private var _selectedWidth:Number;
      
      private var _selectedHeight:Number;
      
      private var _selectedMarginX:Number;
      
      private var _selectedMarginY:Number;
      
      private var _searchWidth:Number;
      
      private var _searchMarginX:Number;
      
      private var _searchMarginY:Number;
      
      private var _searchBackgroundAssetName:String;
      
      private var _unselectedData:DataProvider;
      
      private var _selectedData:DataProvider;
      
      private var _hiddenData:DataProvider;
      
      private var _unselectedList:List;
      
      private var _selectedList:List;
      
      private var _searchBackground:DisplayObject;
      
      private var _searchTextInput:SearchTextInput;
      
      private var _initialFriendCount:int = 0;
      
      private var _maxSelectable:int;
      
      public function SelectFriendsView(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number, param9:Number, param10:Number, param11:Number, param12:String = null, param13:uint = 50)
      {
         super();
         _unselectedWidth = param1;
         _unselectedHeight = param2;
         _unselectedMarginX = param3;
         _unselectedMarginY = param4;
         _selectedWidth = param5;
         _selectedHeight = param6;
         _selectedMarginX = param7;
         _selectedMarginY = param8;
         _searchWidth = param9;
         _searchMarginX = param10;
         _searchMarginY = param11;
         _searchBackgroundAssetName = param12;
         _maxSelectable = param13;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:TextFormat = WomTextFormats.getSystemFontTextFormat();
         if(_searchBackgroundAssetName != null)
         {
            _searchBackground = assetRepository.getDisplayObject(_searchBackgroundAssetName);
            _searchBackground.width = _searchWidth;
            _searchBackground.height = 32;
            addChild(_searchBackground);
         }
         _searchTextInput = new SearchTextInput();
         _searchTextInput.width = _searchWidth;
         _searchTextInput.setStyle("embedFonts",false);
         _searchTextInput.setStyle("textFormat",_loc1_);
         addChild(_searchTextInput);
         _unselectedData = new DataProvider();
         _selectedData = new DataProvider();
         _hiddenData = new DataProvider();
         _unselectedList = new List();
         _unselectedList.setRendererStyle("embedFonts",false);
         _unselectedList.setRendererStyle("textFormat",_loc1_);
         _unselectedList.setSize(_unselectedWidth,_unselectedHeight);
         _unselectedList.dataProvider = _unselectedData;
         _unselectedList.labelFunction = myLabelFunction;
         _unselectedList.selectable = false;
         addChild(_unselectedList);
         _selectedList = new List();
         _selectedList.setRendererStyle("embedFonts",false);
         _selectedList.setRendererStyle("textFormat",_loc1_);
         _selectedList.setSize(_selectedWidth,_selectedHeight);
         _selectedList.dataProvider = _selectedData;
         _selectedList.labelFunction = myLabelFunction;
         _selectedList.selectable = false;
         addChild(_selectedList);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_searchBackgroundAssetName != null)
         {
            _searchBackground.x = _searchMarginX;
            _searchBackground.y = _searchMarginY;
         }
         _searchTextInput.x = _searchMarginX;
         _searchTextInput.y = _searchMarginY;
         _unselectedList.x = _unselectedMarginX;
         _unselectedList.y = _unselectedMarginY;
         _unselectedList.enabled = _selectedData.length < _maxSelectable;
         _selectedList.x = _selectedMarginX;
         _selectedList.y = _selectedMarginY;
         dispatchEvent(new ModelUpdateEvent("selectFriendViewUpdated"));
      }
      
      private function myLabelFunction(param1:Object) : String
      {
         return param1.name;
      }
      
      public function updateFriends(param1:Vector.<FriendInfo>, param2:Dictionary = null) : void
      {
         if(param2 == null)
         {
            param2 = new Dictionary();
         }
         _searchTextInput.text = "";
         _selectedData.removeAll();
         _hiddenData.removeAll();
         _unselectedData.removeAll();
         for each(var _loc3_ in param1)
         {
            if(!(_loc3_.profile.toString() in param2))
            {
               _unselectedData.addItem({
                  "id":(_loc3_.profile.platformId != null ? _loc3_.profile.platformId : _loc3_.profile.avatar),
                  "name":_loc3_.name,
                  "searchAttr":_loc3_.name.toLowerCase()
               });
            }
         }
         _initialFriendCount = _unselectedData.length;
         drawLayout();
      }
      
      public function get searchTextInput() : SearchTextInput
      {
         return _searchTextInput;
      }
      
      public function get unselectedData() : DataProvider
      {
         return _unselectedData;
      }
      
      public function get selectedData() : DataProvider
      {
         return _selectedData;
      }
      
      public function get hiddenData() : DataProvider
      {
         return _hiddenData;
      }
      
      public function get unselectedList() : List
      {
         return _unselectedList;
      }
      
      public function get selectedList() : List
      {
         return _selectedList;
      }
      
      public function get initialFriendCount() : int
      {
         return _initialFriendCount;
      }
      
      public function get maxSelectable() : int
      {
         return _maxSelectable;
      }
      
      public function set maxSelectable(param1:int) : void
      {
         _maxSelectable = param1;
         while(_selectedData.length > _maxSelectable)
         {
            _unselectedData.addItem(_selectedData.removeItemAt(_selectedData.length - 1));
         }
         _unselectedList.enabled = _selectedData.length < _maxSelectable;
      }
   }
}

