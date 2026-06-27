package wom.view.screen.windows.build
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBuildCategoryPanel extends Sprite implements View
   {
      
      protected static const HEIGHT:int = 580;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _category:BuildMenuCategory;
      
      private var background:DisplayObject;
      
      private var _buildingViewList:MPList;
      
      private var items:Vector.<Object>;
      
      protected var panelWidth:int;
      
      private var initialized:Boolean = false;
      
      public function MobileBuildCategoryPanel(param1:BuildMenuCategory, param2:int)
      {
         super();
         _category = param1;
         this.panelWidth = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileDarkBackground");
         background.width = panelWidth;
         background.height = 580;
         addChild(background);
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.horizontalGap = 10;
         _loc1_.verticalGap = 27;
         _loc1_.useSquareTiles = false;
         _loc1_.paddingBottom = 0;
         _loc1_.tileHorizontalAlign = "left";
         _buildingViewList = new MPList();
         _buildingViewList.layout = _loc1_;
         _buildingViewList.itemRendererFactory = itemRenderer;
         _buildingViewList.height = 580 - 25;
         _buildingViewList.width = panelWidth - 50;
         _buildingViewList.horizontalScrollPolicy = "on";
         _buildingViewList.verticalScrollPolicy = "off";
         addChild(_buildingViewList);
      }
      
      public function drawLayout() : void
      {
         _buildingViewList.x = 25;
         _buildingViewList.y = 25;
      }
      
      private function itemRenderer() : IListItemRenderer
      {
         var _loc1_:MobileBuildShowcaseConstructableItemRenderer = new MobileBuildShowcaseConstructableItemRenderer(assetRepository);
         _loc1_.width = 280;
         _loc1_.height = 241;
         return _loc1_;
      }
      
      public function updateWithItemList(param1:Vector.<Object>, param2:Boolean = false) : void
      {
         this.items = param1;
         if(param2 && visible)
         {
            initItemListDataProvider();
         }
      }
      
      private function initItemListDataProvider() : void
      {
         _buildingViewList.dataProvider = new ListCollection(items);
         _buildingViewList.validate();
      }
      
      public function get category() : BuildMenuCategory
      {
         return _category;
      }
      
      public function get buildingViewList() : MPList
      {
         return _buildingViewList;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && !initialized && _buildingViewList)
         {
            initialized = true;
            initItemListDataProvider();
         }
         super.visible = param1;
      }
   }
}

