package wom.view.screen.windows.friends.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPList;
   import peak.component.mobile.MPTextField;
   import peak.component.mobile.MPTextInput;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.friend.FriendInfo;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getWomTextFormat;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileSelectFriendsWindow extends MobileGenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 859;
      
      private static const WINDOW_HEIGHT:int = 668;
      
      public static const MAX_SELECTABLE:int = 50;
      
      private var _requestType:int;
      
      private var _subType:int;
      
      private var _friendsList:MPList;
      
      private var _selectAllButton:MPButton;
      
      private var _selectedAmountTextField:MPTextField;
      
      private var _searchTextInput:MPTextInput;
      
      private var _sendButton:MPButton;
      
      private var _hiddenFriends:ListCollection;
      
      public function MobileSelectFriendsWindow(param1:int, param2:int = 0, param3:Object = null)
      {
         super(859,668,null,null,param3);
         _requestType = param1;
         _subType = param2;
         _hiddenFriends = new ListCollection();
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.windows.friends.select." + _requestType + ".title";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _selectAllButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Medium");
         _selectAllButton.width = 178;
         _selectAllButton.label = "SELECT ALL";
         addChild(_selectAllButton);
         _selectedAmountTextField = new MobileWomTextField();
         _selectedAmountTextField.textRendererProperties.textFormat = getWomTextFormat(23,null,16777215);
         addChild(_selectedAmountTextField);
         _searchTextInput = new MobileWomTextInput();
         _searchTextInput.maxChars = 20;
         _searchTextInput.width = 504;
         addChild(_searchTextInput);
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         _loc1_.horizontalGap = 10;
         _loc1_.verticalGap = 7;
         _friendsList = new MPList();
         _friendsList.layout = _loc1_;
         _friendsList.itemRendererFactory = friendViewRendererFactory;
         _friendsList.allowMultipleSelection = true;
         _friendsList.width = 798;
         _friendsList.height = 526;
         addChild(_friendsList);
         _sendButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _sendButton.width = 185;
         _sendButton.label = "SEND";
         addChild(_sendButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_friendsList,_background,109);
         MobileAlignmentUtil.alignAccordingToPositionOf(_selectAllButton,_background,29,32);
         MobileAlignmentUtil.alignRightOf(_searchTextInput,_selectAllButton,9);
         drawSelectedAmountTextField();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_sendButton,_background,614);
      }
      
      public function drawSelectedAmountTextField() : void
      {
         MobileAlignmentUtil.alignRightWithYMarginOf(_selectedAmountTextField,_searchTextInput,20,107 - _selectedAmountTextField.width);
      }
      
      private function friendViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileSelectFriendsItemRenderer = new MobileSelectFriendsItemRenderer(assetRepository);
         _loc1_.isQuickHitAreaEnabled = true;
         _loc1_.width = 394;
         _loc1_.height = 96;
         return _loc1_;
      }
      
      public function update(param1:Vector.<FriendInfo>) : void
      {
         _friendsList.selectedIndex = -1;
         _friendsList.dataProvider = new ListCollection(param1);
         _friendsList.validate();
         updateSelectedAmountTextField();
      }
      
      public function get requestType() : int
      {
         return _requestType;
      }
      
      public function get friendsList() : MPList
      {
         return _friendsList;
      }
      
      public function updateSelectedAmountTextField() : void
      {
         var _temp_3:* = _selectedAmountTextField;
         var _temp_2:* = "m.ui.windows.friends.select.selectallcount";
         var _temp_1:* = NumberUtil.numberFormat(_friendsList.selectedIndices.length);
         var _loc1_:String = NumberUtil.numberFormat(_friendsList.dataProvider.length);
         var _loc2_:String = _temp_1;
         var _loc3_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc3_,_loc2_,_loc1_);
         drawSelectedAmountTextField();
      }
      
      public function get sendButton() : MPButton
      {
         return _sendButton;
      }
      
      public function get subType() : int
      {
         return _subType;
      }
      
      public function get selectAllButton() : MPButton
      {
         return _selectAllButton;
      }
      
      public function get searchTextInput() : MPTextInput
      {
         return _searchTextInput;
      }
      
      public function get hiddenFriends() : ListCollection
      {
         return _hiddenFriends;
      }
   }
}

