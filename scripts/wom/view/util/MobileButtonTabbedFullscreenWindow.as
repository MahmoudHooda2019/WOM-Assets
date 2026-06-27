package wom.view.util
{
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import wom.Environment;
   import wom.model.game.window.WindowEnumeration;
   
   public class MobileButtonTabbedFullscreenWindow extends MobileButtonTabbedWindow
   {
      
      private var _headerBackgroundEnabled:Boolean;
      
      protected var _headerBackground:DisplayObject;
      
      public function MobileButtonTabbedFullscreenWindow(param1:Boolean = true, param2:Vector.<WindowEnumeration> = null)
      {
         super(Environment.starling.stage.stageWidth,Environment.starling.stage.stageHeight,param2);
         _headerBackgroundEnabled = param1;
      }
      
      override public function setHeader(param1:String) : void
      {
         super.setHeader(param1);
         _windowHeader.y = 15;
      }
      
      override protected function drawBackground() : void
      {
         if(_background == null)
         {
            _background = new Quad(1,1,9136202);
         }
         _background.width = _windowWidth;
         _background.height = _windowHeight;
         if(!contains(_background))
         {
            addChildAt(_background,0);
         }
         if(_headerBackgroundEnabled)
         {
            if(_headerBackground == null)
            {
               _headerBackground = assetRepository.getDisplayObject("FullScreenHeaderBackground");
            }
            _headerBackground.width = _windowWidth;
            _staticLayer.addChild(_headerBackground);
         }
         _staticLayer.flatten();
      }
      
      override protected function alignHeader() : void
      {
         _windowHeader.x = _windowWidth / 2 - _windowHeader.width / 2;
         _windowHeader.y = 15;
         _closeButton.x = _windowWidth - _closeButton.width - 10;
         _closeButton.y = 10;
         _staticLayer.flatten();
      }
   }
}

