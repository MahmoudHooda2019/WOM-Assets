package wom.view.screen.windows.gift.mobile
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import peak.component.mobile.MPList;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.game.Profile;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileGiftPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _friendProfile:Profile;
      
      private var _giftItemViewsList:MPList;
      
      public function MobileGiftPanel()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:TiledRowsLayout = new TiledRowsLayout();
         _loc1_.useSquareTiles = false;
         _loc1_.paddingTop = 15;
         _loc1_.paddingBottom = _loc1_.paddingLeft = _loc1_.paddingRight = 0;
         _loc1_.horizontalGap = 9;
         _loc1_.verticalGap = 25;
         _giftItemViewsList = new MPList();
         _giftItemViewsList.layout = _loc1_;
         _giftItemViewsList.itemRendererFactory = giftItemViewRendererFactory;
         _giftItemViewsList.width = 796;
         _giftItemViewsList.height = 509;
         addChild(_giftItemViewsList);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _giftItemViewsList.x = 30;
         _giftItemViewsList.y = 0;
      }
      
      private function giftItemViewRendererFactory() : IListItemRenderer
      {
         var _loc1_:MobileGiftItemViewRenderer = new MobileGiftItemViewRenderer(assetRepository);
         _loc1_.isQuickHitAreaEnabled = true;
         _loc1_.width = 192;
         _loc1_.height = 149;
         return _loc1_;
      }
      
      public function update(param1:Vector.<InventoryItemDTO>) : void
      {
         _giftItemViewsList.dataProvider = new ListCollection(param1);
         _giftItemViewsList.validate();
      }
      
      public function get friendProfile() : Profile
      {
         return _friendProfile;
      }
      
      public function set friendProfile(param1:Profile) : void
      {
         _friendProfile = param1;
      }
      
      public function get giftItemViewsList() : MPList
      {
         return _giftItemViewsList;
      }
   }
}

