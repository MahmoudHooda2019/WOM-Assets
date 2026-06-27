package wom.view.screen.windows.build
{
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledColumnsLayout;
   import peak.component.mobile.MPList;
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileBuildDecorationCategoryPanel extends Sprite implements View
   {
      
      protected static const HEIGHT:int = 535;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _category:BuildMenuDecorationCategory;
      
      private var background:DisplayObject;
      
      private var _decorationViewList:MPList;
      
      private var items:Vector.<Object>;
      
      private var initialized:Boolean = false;
      
      private var panelWidth:int;
      
      public function MobileBuildDecorationCategoryPanel(param1:BuildMenuDecorationCategory, param2:int)
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
         background.height = 535;
         addChild(background);
         var _loc1_:TiledColumnsLayout = new TiledColumnsLayout();
         _loc1_.horizontalGap = 10;
         _loc1_.verticalGap = 8;
         _loc1_.useSquareTiles = false;
         _loc1_.paddingBottom = 0;
         _loc1_.tileHorizontalAlign = "left";
         _decorationViewList = new MPList();
         _decorationViewList.layout = _loc1_;
         _decorationViewList.itemRendererFactory = itemRenderer;
         _decorationViewList.height = 535 - 25;
         _decorationViewList.width = panelWidth - 50;
         _decorationViewList.horizontalScrollPolicy = "on";
         _decorationViewList.verticalScrollPolicy = "off";
         addChild(_decorationViewList);
      }
      
      public function drawLayout() : void
      {
         _decorationViewList.x = 25;
         _decorationViewList.y = 25;
      }
      
      private function itemRenderer() : IListItemRenderer
      {
         var _loc1_:MobileBuildShowcaseConstructableItemRenderer = new MobileBuildShowcaseConstructableItemRenderer(assetRepository,true);
         _loc1_.width = 280;
         _loc1_.height = 241;
         return _loc1_;
      }
      
      public function updateWithItemList(param1:Vector.<Object>) : void
      {
         this.items = param1;
      }
      
      public function get category() : BuildMenuDecorationCategory
      {
         return _category;
      }
      
      public function get decorationViewList() : MPList
      {
         return _decorationViewList;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(param1 && !initialized && _decorationViewList)
         {
            _decorationViewList.dataProvider = new ListCollection(items);
            _decorationViewList.validate();
         }
         super.visible = param1;
      }
   }
}

