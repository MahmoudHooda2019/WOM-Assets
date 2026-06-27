package wom.view.screen.windows.activate
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueSmallButton;
   import wom.view.component.button.colored.WomGreenSmallButton;
   import wom.view.component.button.colored.WomOrangeSmallButton;
   import wom.view.ui.common.OrView;
   
   public class RequiredItemView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var background:DisplayObject;
      
      private var _itemAsset:DisplayObject;
      
      private var itemNameHeader:TextField;
      
      private var itemCountTextField:TextField;
      
      private var _partItemDTO:PartInfoDTO;
      
      private var _inventoryItemDTO:InventoryItemDTO;
      
      private var _partTypeDIO:PartTypeDIO;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _askAFriendButton:WomButton;
      
      private var _buyWithGoldButton:WomGreenSmallButton;
      
      private var _buyWithRPButton:WomBlueSmallButton;
      
      private var completeIcon:DisplayObject;
      
      private var orIcon:DisplayObject;
      
      private var _askForMore:Boolean;
      
      public function RequiredItemView(param1:PartInfoDTO, param2:BuildingTypeDIO, param3:Boolean = false)
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
         background = assetRepository.getDisplayObject("ShinyBackgroundSmall");
         addChild(background);
         itemNameHeader = new CaptionTextField();
         itemNameHeader.wordWrap = true;
         itemNameHeader.multiline = true;
         itemNameHeader.defaultTextFormat = WomTextFormats.CENTER_20;
         itemNameHeader.width = 195;
         itemNameHeader.height = 25;
         addChild(itemNameHeader);
         itemCountTextField = new WomTextField();
         itemCountTextField.defaultTextFormat = WomTextFormats.CENTER_18;
         itemCountTextField.width = itemNameHeader.width;
         itemCountTextField.height = 25;
         addChild(itemCountTextField);
         _itemAsset = assetRepository.getDisplayObject(_inventoryItemDTO.visual);
         addChild(_itemAsset);
         var _temp_5:* = itemNameHeader;
         var _loc3_:String = "domain.parts." + _inventoryItemDTO.id + ".name2";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         itemNameHeader.height = itemNameHeader.textHeight + 4;
         if(!_askForMore)
         {
            _askAFriendButton = new WomBlueSmallButton();
            var _temp_7:* = _askAFriendButton;
            var _loc4_:String = "ui.windows.activate.askafriend";
            _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else
         {
            _askAFriendButton = new WomOrangeSmallButton();
            var _temp_9:* = _askAFriendButton;
            var _loc5_:String = "ui.windows.activate.askformore";
            _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         _askAFriendButton.width = background.width;
         addChild(_askAFriendButton);
         _buyWithGoldButton = new WomGreenSmallButton();
         var _loc2_:AssetDisplayObject = assetRepository.getDisplayObject("Gold");
         _loc2_.scaleX = _loc2_.scaleY = 0.5;
         _buyWithGoldButton.setStyle("icon",_loc2_);
         addChild(_buyWithGoldButton);
         _buyWithRPButton = new WomBlueSmallButton();
         var _temp_12:* = _buyWithRPButton;
         var _loc6_:String = "ui.windows.activate.buy";
         _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         _buyWithRPButton.width = 91;
         var _loc1_:AssetDisplayObject = assetRepository.getDisplayObject("Rp");
         _loc1_.scaleX = _loc1_.scaleY = 0.7;
         _buyWithRPButton.setStyle("icon",_loc1_);
         addChild(_buyWithRPButton);
         orIcon = new OrView();
         orIcon.scaleX = orIcon.scaleY = 0.7;
         addChild(orIcon);
         completeIcon = assetRepository.getDisplayObject("Check");
         completeIcon.visible = false;
         addChild(completeIcon);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         background.x = 27;
         itemNameHeader.y = int(-itemNameHeader.height / 2);
         itemCountTextField.y = background.height - itemCountTextField.height - 4;
         _itemAsset.x = background.x + int((background.width - _itemAsset.width) / 2);
         _itemAsset.y = int(itemNameHeader.height / 2) + 15;
         itemCountTextField.text = _inventoryItemDTO.amount + "/" + _partItemDTO.amount;
         AlignmentUtil.alignBelowOf(_askAFriendButton,background);
         AlignmentUtil.alignBelowOf(_buyWithGoldButton,_askAFriendButton);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(completeIcon,background,background.height - 8);
         var _loc3_:int = _inventoryItemDTO.amount < _partItemDTO.amount ? _partItemDTO.amount - _inventoryItemDTO.amount : 0;
         var _loc1_:int = _partTypeDIO.buyingRPPrice;
         var _loc2_:int = _partTypeDIO.buyingGoldPrice;
         if(_loc1_ != 0)
         {
            var _temp_1:* = _buyWithGoldButton;
            var _loc4_:String = "ui.windows.activate.buy";
            _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            _buyWithGoldButton.width = 91;
            _buyWithGoldButton.rightLabel = _loc2_ + "";
            _buyWithRPButton.rightLabel = _loc1_ + "";
            _buyWithGoldButton.visible = orIcon.visible = _buyWithRPButton.visible = true;
            _buyWithGoldButton.x = 0;
            AlignmentUtil.alignRightWithYMarginOf(orIcon,_buyWithGoldButton,3,-6);
            AlignmentUtil.alignRightOf(_buyWithRPButton,_buyWithGoldButton,13);
         }
         else if(_loc2_ != 0)
         {
            var _temp_3:* = _buyWithGoldButton;
            var _loc5_:String = "ui.windows.activate.buyfor";
            _temp_3.label = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            _buyWithGoldButton.width = background.width;
            _buyWithGoldButton.rightLabel = _loc2_ + "";
            _buyWithGoldButton.visible = true;
            orIcon.visible = _buyWithRPButton.visible = false;
         }
         else
         {
            _buyWithGoldButton.visible = orIcon.visible = _buyWithRPButton.visible = false;
         }
         _askAFriendButton.visible = _loc3_ != 0;
         if(_loc3_ == 0)
         {
            orIcon.visible = _buyWithGoldButton.visible = _buyWithRPButton.visible = false;
         }
         completeIcon.visible = _loc3_ == 0;
      }
      
      public function get partItemDTO() : PartInfoDTO
      {
         return _partItemDTO;
      }
      
      public function set inventoryItemDTO(param1:InventoryItemDTO) : void
      {
         _inventoryItemDTO = param1;
      }
      
      public function get inventoryItemDTO() : InventoryItemDTO
      {
         return _inventoryItemDTO;
      }
      
      public function set partTypeDIO(param1:PartTypeDIO) : void
      {
         _partTypeDIO = param1;
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      public function get buyWithGoldButton() : WomGreenSmallButton
      {
         return _buyWithGoldButton;
      }
      
      public function get buyWithRPButton() : WomBlueSmallButton
      {
         return _buyWithRPButton;
      }
      
      public function get partTypeDIO() : PartTypeDIO
      {
         return _partTypeDIO;
      }
      
      public function get askAFriendButton() : WomButton
      {
         return _askAFriendButton;
      }
      
      public function get askForMore() : Boolean
      {
         return _askForMore;
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
   }
}

