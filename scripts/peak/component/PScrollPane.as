package peak.component
{
   import fl.containers.ScrollPane;
   import fl.controls.UIScrollBar;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class PScrollPane extends ScrollPane
   {
      
      private static const LINE_SCROLL_SIZE:int = 20;
      
      public function PScrollPane()
      {
         super();
         this.focusEnabled = false;
         this.tabEnabled = false;
      }
      
      protected function createScrollBar() : UIScrollBar
      {
         return new PScrollBar();
      }
      
      override protected function configUI() : void
      {
         isLivePreview = checkLivePreview();
         var _loc3_:Number = rotation;
         rotation = 0;
         var _loc1_:Number = super.width;
         var _loc4_:Number = super.height;
         super.scaleX = super.scaleY = 1;
         setSize(_loc1_,_loc4_);
         move(super.x,super.y);
         rotation = _loc3_;
         startWidth = _loc1_;
         startHeight = _loc4_;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         contentScrollRect = new Rectangle(0,0,85,85);
         _verticalScrollBar = createScrollBar();
         _verticalScrollBar.addEventListener("scroll",handleScroll,false,0,true);
         _verticalScrollBar.visible = false;
         _verticalScrollBar.lineScrollSize = 20;
         addChild(_verticalScrollBar);
         copyStylesToChild(_verticalScrollBar,SCROLL_BAR_STYLES);
         _horizontalScrollBar = createScrollBar();
         _horizontalScrollBar.direction = "horizontal";
         _horizontalScrollBar.addEventListener("scroll",handleScroll,false,0,true);
         _horizontalScrollBar.visible = false;
         _horizontalScrollBar.lineScrollSize = 20;
         addChild(_horizontalScrollBar);
         copyStylesToChild(_horizontalScrollBar,SCROLL_BAR_STYLES);
         disabledOverlay = new Shape();
         var _loc2_:Graphics = disabledOverlay.graphics;
         _loc2_.beginFill(16777215);
         _loc2_.drawRect(0,0,isNaN(_loc1_) ? 85 : _loc1_,isNaN(_loc4_) ? 85 : _loc4_);
         _loc2_.endFill();
         addEventListener("mouseWheel",handleWheel,false,0,true);
         contentClip = new Sprite();
         addChild(contentClip);
         contentClip.scrollRect = contentScrollRect;
         _horizontalScrollPolicy = "auto";
         _verticalScrollPolicy = "auto";
      }
   }
}

