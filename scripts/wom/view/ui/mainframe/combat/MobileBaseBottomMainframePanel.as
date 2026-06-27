package wom.view.ui.mainframe.combat
{
   import feathers.layout.HorizontalLayout;
   import peak.display.View;
   import starling.display.Sprite;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.MobileWomScrollPane;
   
   public class MobileBaseBottomMainframePanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      protected var _views:Vector.<Sprite>;
      
      protected var _scrollPane:MobileWomScrollPane;
      
      public function MobileBaseBottomMainframePanel()
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
         _views = new Vector.<Sprite>();
         _scrollPane = new MobileWomScrollPane();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.gap = 6;
         _loc1_.paddingLeft = 13;
         _loc1_.paddingRight = 13;
         _scrollPane.layout = _loc1_;
         _scrollPane.width = listWidth;
         _scrollPane.height = listHeight;
         _scrollPane.horizontalScrollPolicy = "on";
         _scrollPane.verticalScrollPolicy = "off";
         addChild(_scrollPane);
         drawLayout();
      }
      
      protected function get listWidth() : int
      {
         return 521;
      }
      
      protected function get listHeight() : int
      {
         return 115;
      }
      
      public function drawLayout() : void
      {
         _scrollPane.x = 0;
         _scrollPane.y = 13;
      }
      
      public function clearViews() : void
      {
         if(_views)
         {
            while(_views.length > 0)
            {
               removeChild(_views.pop());
            }
         }
         _views = new Vector.<Sprite>();
      }
   }
}

