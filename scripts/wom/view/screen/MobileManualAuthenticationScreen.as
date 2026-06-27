package wom.view.screen
{
   import feathers.controls.List;
   import feathers.controls.renderers.IListItemRenderer;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import peak.component.mobile.MPList;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileManualAuthenticationScreen extends MobileBaseScreen
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _list:List;
      
      private var users:Vector.<String>;
      
      public function MobileManualAuthenticationScreen(param1:Vector.<String>)
      {
         super();
         this.users = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      protected function initLayout() : void
      {
         var userId:String;
         _list = new MPList();
         var layout:TiledRowsLayout = new TiledRowsLayout();
         layout.gap = 2;
         layout.useSquareTiles = false;
         layout.padding = 5;
         _list.layout = layout;
         _list.itemRendererFactory = function():IListItemRenderer
         {
            var _loc1_:MobileManualAuthenticationItemRenderer = new MobileManualAuthenticationItemRenderer();
            _loc1_.labelOffsetX = 10;
            _loc1_.labelField = "username";
            _loc1_.width = 150;
            _loc1_.height = 60;
            return _loc1_;
         };
         _list.dataProvider = new ListCollection();
         for each(userId in users)
         {
            _list.dataProvider.addItem({
               "id":userId,
               "username":""
            });
         }
         addChild(_list);
      }
      
      private function drawLayout() : void
      {
         _list.width = visibleWidth;
         _list.height = visibleHeight;
      }
      
      public function resizeScreen() : void
      {
         drawLayout();
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth < 760 ? 760 : _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight < 620 ? 620 : _visibleHeight;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function get list() : List
      {
         return _list;
      }
   }
}

