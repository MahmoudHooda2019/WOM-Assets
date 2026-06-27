package wom.view.screen.windows
{
   import flash.geom.Rectangle;
   import flash.media.StageWebView;
   import starling.core.Starling;
   import wom.Environment;
   import wom.view.util.MobileFullScreenWindow;
   
   public class MobileWebViewWindow extends MobileFullScreenWindow
   {
      
      private static const MARGIN_Y:int = 79;
      
      private var _title:String;
      
      private var _url:String;
      
      private var _webView:StageWebView;
      
      public function MobileWebViewWindow(param1:String, param2:String)
      {
         super(true);
         _title = param1;
         _url = param2;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         setHeader(_title);
         var _loc1_:Number = Starling.contentScaleFactor;
         _webView = new StageWebView();
         _webView.stage = Environment.stage;
         _webView.viewPort = new Rectangle(0,79 * _loc1_,Environment.starling.stage.stageWidth * _loc1_,(Environment.starling.stage.stageHeight - 79) * _loc1_);
         _webView.loadURL(_url);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
      }
      
      public function get webView() : StageWebView
      {
         return _webView;
      }
   }
}

