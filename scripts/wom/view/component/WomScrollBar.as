package wom.view.component
{
   import flash.display.Shape;
   import peak.component.PBaseButton;
   import peak.component.PButton;
   import peak.component.PScrollBar;
   
   public class WomScrollBar extends PScrollBar
   {
      
      public static const PWIDTH:int = 10;
      
      private var trackMask:Shape;
      
      public function WomScrollBar()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         isLivePreview = checkLivePreview();
         var _loc2_:Number = rotation;
         rotation = 0;
         var _loc1_:Number = super.width;
         var _loc3_:Number = super.height;
         super.scaleX = super.scaleY = 1;
         setSize(_loc1_,_loc3_);
         move(super.x,super.y);
         rotation = _loc2_;
         startWidth = _loc1_;
         startHeight = _loc3_;
         if(numChildren > 0)
         {
            removeChildAt(0);
         }
         track = new PBaseButton();
         track.move(0,0);
         track.useHandCursor = false;
         track.autoRepeat = true;
         track.focusEnabled = false;
         addChild(track);
         trackMask = new Shape();
         trackMask.y = 6;
         addChild(trackMask);
         downArrow = new PBaseButton();
         downArrow.setSize(10,6);
         downArrow.autoRepeat = true;
         downArrow.focusEnabled = false;
         addChild(downArrow);
         upArrow = new PBaseButton();
         upArrow.setSize(10,6);
         upArrow.move(0,0);
         upArrow.autoRepeat = true;
         upArrow.focusEnabled = false;
         addChild(upArrow);
         thumb = new PButton();
         thumb.label = "";
         thumb.setSize(10,15);
         thumb.move(0,13);
         thumb.focusEnabled = false;
         addChild(thumb);
         upArrow.addEventListener("buttonDown",scrollPressHandler,false,0,true);
         downArrow.addEventListener("buttonDown",scrollPressHandler,false,0,true);
         track.addEventListener("buttonDown",scrollPressHandler,false,0,true);
         thumb.addEventListener("mouseDown",thumbPressHandler,false,0,true);
         enabled = false;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Number = NaN;
         if(isInvalid("size"))
         {
            _loc1_ = super.height;
            downArrow.move(0,Math.max(upArrow.height,_loc1_ - downArrow.height));
            track.setSize(10,Math.max(0,_loc1_ - 1));
            if(!isNaN(_loc1_) && _loc1_ >= 0)
            {
               trackMask.graphics.beginFill(0,0);
               trackMask.graphics.drawRect(0,0,10,int(_loc1_ - (downArrow.height + upArrow.height)));
               track.mask = trackMask;
            }
            updateThumb();
         }
         if(isInvalid("styles","state"))
         {
            setStyles();
         }
         downArrow.drawNow();
         upArrow.drawNow();
         track.drawNow();
         thumb.drawNow();
         validate();
      }
   }
}

