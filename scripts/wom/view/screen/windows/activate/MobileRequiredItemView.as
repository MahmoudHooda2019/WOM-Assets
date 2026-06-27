package wom.view.screen.windows.activate
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileRequiredItemView extends Sprite implements View
   {
      
      private static const visibleWidth:int = 275;
      
      private static const visibleHeight:int = 254;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _itemAsset:DisplayObject;
      
      private var _itemNameHeader:MPTextField;
      
      private var itemCountTextField:MPTextField;
      
      private var _partItemDTO:PartInfoDTO;
      
      private var _inventoryItemDTO:InventoryItemDTO;
      
      private var _partTypeDIO:PartTypeDIO;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _askAFriendButton:MobileWomButton;
      
      private var _buyWithGoldButton:MobileWomButton;
      
      private var _buyWithRPButton:MobileWomButton;
      
      private var completeIcon:DisplayObject;
      
      private var _askForMore:Boolean;
      
      public function MobileRequiredItemView(param1:PartInfoDTO, param2:BuildingTypeDIO, param3:Boolean = false)
      {
         super();
         _partItemDTO = param1;
         _buildingTypeDIO = param2;
         _askForMore = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 275;
         background.height = 254;
         addChild(background);
         _itemNameHeader = new MobileWomTextField();
         _itemNameHeader.textRendererProperties.textFormat = getCaptionTextFormat(30);
         addChild(_itemNameHeader);
         var _temp_3:* = _itemNameHeader;
         var _loc1_:String = "domain.parts." + _inventoryItemDTO.id + ".name2";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _itemAsset = assetRepository.getDisplayObject(_inventoryItemDTO.visual);
         addChild(_itemAsset);
         itemCountTextField = new MobileWomTextField();
         itemCountTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         addChild(itemCountTextField);
         if(!_askForMore)
         {
            _askAFriendButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Small");
            var _temp_7:* = _askAFriendButton;
            var _loc2_:String = "ui.windows.activate.askafriend";
            _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         }
         else
         {
            _askAFriendButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Small");
            var _temp_9:* = _askAFriendButton;
            var _loc3_:String = "ui.windows.activate.askformore";
            _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         }
         _askAFriendButton.width = 185;
         addChild(_askAFriendButton);
         _buyWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Small");
         _buyWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldS");
         addChild(_buyWithGoldButton);
         _buyWithRPButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Small");
         var _temp_12:* = _buyWithRPButton;
         var _loc4_:String = "ui.windows.activate.buy";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _buyWithRPButton.defaultIcon = assetRepository.getDisplayObject("IconRPS");
         _buyWithRPButton.width = 105;
         addChild(_buyWithRPButton);
         completeIcon = assetRepository.getDisplayObject("SymbolTickApproved");
         addChild(completeIcon);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_itemNameHeader,background,15);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_itemAsset,background,_itemNameHeader.height + 15);
         itemCountTextField.text = _inventoryItemDTO.amount + "/" + _partItemDTO.amount;
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(completeIcon,background,186);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(itemCountTextField,background,150);
         MobileAlignmentUtil.alignAccordingToPositionOf(_askAFriendButton,background,47,175);
         var _loc3_:int = _inventoryItemDTO.amount < _partItemDTO.amount ? _partItemDTO.amount - _inventoryItemDTO.amount : 0;
         var _loc1_:int = _partTypeDIO.buyingRPPrice;
         var _loc2_:int = _partTypeDIO.buyingGoldPrice;
         if(_loc1_ != 0)
         {
            var _temp_1:* = _buyWithGoldButton;
            var _loc4_:String = "ui.windows.activate.buy";
            _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            _buyWithGoldButton.width = 105;
            _buyWithGoldButton.rightLabel = _loc2_ + "";
            _buyWithRPButton.rightLabel = _loc1_ + "";
            _buyWithGoldButton.visible = _buyWithRPButton.visible = true;
            MobileAlignmentUtil.alignAccordingToPositionOf(_buyWithGoldButton,background,25,226);
            MobileAlignmentUtil.alignRightOf(_buyWithRPButton,_buyWithGoldButton,20);
         }
         else if(_loc2_ != 0)
         {
            var _temp_2:* = _buyWithGoldButton;
            var _loc5_:String = "ui.windows.activate.buyfor";
            _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            _buyWithGoldButton.rightLabel = _loc2_ + "";
            _buyWithGoldButton.visible = true;
            _buyWithGoldButton.width = 185;
            _buyWithRPButton.visible = false;
            MobileAlignmentUtil.alignAccordingToPositionOf(_buyWithGoldButton,background,47,226);
         }
         else
         {
            _buyWithGoldButton.visible = _buyWithRPButton.visible = false;
         }
         _askAFriendButton.visible = _loc3_ != 0;
         if(_loc3_ == 0)
         {
            _buyWithGoldButton.visible = _buyWithRPButton.visible = false;
         }
         completeIcon.visible = _loc3_ == 0;
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      public function get itemNameHeader() : MPTextField
      {
         return _itemNameHeader;
      }
      
      public function get partItemDTO() : PartInfoDTO
      {
         return _partItemDTO;
      }
      
      public function get partTypeDIO() : PartTypeDIO
      {
         return _partTypeDIO;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get askAFriendButton() : MobileWomButton
      {
         return _askAFriendButton;
      }
      
      public function get buyWithGoldButton() : MobileWomButton
      {
         return _buyWithGoldButton;
      }
      
      public function get buyWithRPButton() : MobileWomButton
      {
         return _buyWithRPButton;
      }
      
      public function set partTypeDIO(param1:PartTypeDIO) : void
      {
         _partTypeDIO = param1;
      }
      
      public function get askForMore() : Boolean
      {
         return _askForMore;
      }
      
      public function get inventoryItemDTO() : InventoryItemDTO
      {
         return _inventoryItemDTO;
      }
      
      public function set inventoryItemDTO(param1:InventoryItemDTO) : void
      {
         _inventoryItemDTO = param1;
      }
   }
}

