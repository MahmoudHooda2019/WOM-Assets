package wom.view.component
{
   import feathers.layout.HorizontalLayout;
   import feathers.utils.math.roundToNearest;
   import peak.component.mobile.MPList;
   
   public class MobileWomCarousel extends MPList
   {
      
      private var _itemOffset:int;
      
      public function MobileWomCarousel()
      {
         super();
         this.snapToPages = true;
         _itemOffset = 0;
      }
      
      override protected function refreshScrollValues(param1:Boolean) : void
      {
         var _loc7_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc4_:Number = NaN;
         if(isNaN(this.explicitHorizontalScrollStep))
         {
            if(this._viewPort)
            {
               this.actualHorizontalScrollStep = this._viewPort.horizontalScrollStep;
            }
            else
            {
               this.actualHorizontalScrollStep = 1;
            }
         }
         else
         {
            this.actualHorizontalScrollStep = this.explicitHorizontalScrollStep;
         }
         if(isNaN(this.explicitVerticalScrollStep))
         {
            if(this._viewPort)
            {
               this.actualVerticalScrollStep = this._viewPort.verticalScrollStep;
            }
            else
            {
               this.actualVerticalScrollStep = 1;
            }
         }
         else
         {
            this.actualVerticalScrollStep = this.explicitVerticalScrollStep;
         }
         if(isNaN(this.explicitPageWidth))
         {
            this.actualPageWidth = this.actualWidth - (this._leftViewPortOffset + this._rightViewPortOffset);
         }
         if(isNaN(this.explicitPageHeight))
         {
            this.actualPageHeight = this.actualHeight - (this._topViewPortOffset + this._bottomViewPortOffset);
         }
         var _loc8_:Number = this._maxHorizontalScrollPosition;
         var _loc10_:Number = this._maxVerticalScrollPosition;
         if(this._viewPort)
         {
            this._minHorizontalScrollPosition = this._viewPort.contentX;
            this._maxHorizontalScrollPosition = this._viewPort.width - this.actualPageWidth - _itemOffset;
            if(this._maxHorizontalScrollPosition < this._minHorizontalScrollPosition)
            {
               this._maxHorizontalScrollPosition = this._minHorizontalScrollPosition;
            }
            this._minVerticalScrollPosition = this._viewPort.contentY;
            this._maxVerticalScrollPosition = this._viewPort.height - this.actualPageHeight - _itemOffset;
            if(this._maxVerticalScrollPosition < this._minVerticalScrollPosition)
            {
               this._maxVerticalScrollPosition = this._minVerticalScrollPosition;
            }
            if(this._snapScrollPositionsToPixels)
            {
               this._minHorizontalScrollPosition = Math.round(this._minHorizontalScrollPosition);
               this._minVerticalScrollPosition = Math.round(this._minVerticalScrollPosition);
               this._maxHorizontalScrollPosition = Math.round(this._maxHorizontalScrollPosition);
               this._maxVerticalScrollPosition = Math.round(this._maxVerticalScrollPosition);
            }
         }
         else
         {
            this._minHorizontalScrollPosition = 0;
            this._minVerticalScrollPosition = 0;
            this._maxHorizontalScrollPosition = 0;
            this._maxVerticalScrollPosition = 0;
         }
         if(this._snapToPages)
         {
            _loc7_ = this._maxHorizontalScrollPosition - this._minHorizontalScrollPosition;
            _loc2_ = this._maxVerticalScrollPosition - this._minVerticalScrollPosition;
            this._horizontalPageCount = Math.ceil(_loc7_ / this.actualPageWidth) + 1;
            this._verticalPageCount = Math.ceil(_loc2_ / this.actualPageHeight) + 1;
         }
         else
         {
            this._horizontalPageCount = 1;
            this._verticalPageCount = 1;
         }
         var _loc9_:Boolean = this._maxHorizontalScrollPosition != _loc8_ || this._maxVerticalScrollPosition != _loc10_;
         if(_loc9_)
         {
            if(this._touchPointID < 0 && !this._horizontalAutoScrollTween)
            {
               if(this._snapToPages)
               {
                  this._horizontalScrollPosition = roundToNearest(this._horizontalScrollPosition,this.actualPageWidth);
               }
               _loc5_ = this._horizontalScrollPosition;
               if(_loc5_ < this._minHorizontalScrollPosition)
               {
                  _loc5_ = this._minHorizontalScrollPosition;
               }
               else if(_loc5_ > this._maxHorizontalScrollPosition)
               {
                  _loc5_ = this._maxHorizontalScrollPosition;
               }
               this.horizontalScrollPosition = _loc5_;
            }
            if(this._touchPointID < 0 && !this._verticalAutoScrollTween)
            {
               if(this._snapToPages)
               {
                  this._verticalScrollPosition = roundToNearest(this._verticalScrollPosition,this.actualPageHeight);
               }
               _loc3_ = this._verticalScrollPosition;
               if(_loc3_ < this._minVerticalScrollPosition)
               {
                  _loc3_ = this._minVerticalScrollPosition;
               }
               else if(_loc3_ > this._maxVerticalScrollPosition)
               {
                  _loc3_ = this._maxVerticalScrollPosition;
               }
               this.verticalScrollPosition = _loc3_;
            }
         }
         if(this._snapToPages)
         {
            if(param1 && !this._isDraggingHorizontally && !this._horizontalAutoScrollTween && this.pendingHorizontalPageIndex < 0)
            {
               if(this._horizontalScrollPosition == this._maxHorizontalScrollPosition)
               {
                  this._horizontalPageIndex = this._horizontalPageCount - 1;
               }
               else
               {
                  _loc6_ = this._horizontalScrollPosition - this._minHorizontalScrollPosition;
                  this._horizontalPageIndex = Math.floor(_loc6_ / this.actualPageWidth);
               }
            }
            if(param1 && !this._isDraggingVertically && !this._verticalAutoScrollTween && this.pendingVerticalPageIndex < 0)
            {
               if(this._verticalScrollPosition == this._maxVerticalScrollPosition)
               {
                  this._verticalPageIndex = this._verticalPageCount - 1;
               }
               else
               {
                  _loc4_ = this._verticalScrollPosition - this._minVerticalScrollPosition;
                  this._verticalPageIndex = Math.floor(_loc4_ / this.actualPageHeight);
               }
            }
         }
         else
         {
            this._horizontalPageIndex = this._verticalPageIndex = 0;
         }
         if(_loc9_)
         {
            if(this._horizontalAutoScrollTween && this._targetHorizontalScrollPosition > this._maxHorizontalScrollPosition && _loc8_ > this._maxHorizontalScrollPosition)
            {
               this._targetHorizontalScrollPosition -= _loc8_ - this._maxHorizontalScrollPosition;
               this.throwTo(this._targetHorizontalScrollPosition,NaN,this._horizontalAutoScrollTween.totalTime - this._horizontalAutoScrollTween.currentTime);
            }
            if(this._verticalAutoScrollTween && this._targetVerticalScrollPosition > this._maxVerticalScrollPosition && _loc10_ > this._maxVerticalScrollPosition)
            {
               this._targetVerticalScrollPosition -= _loc10_ - this._maxVerticalScrollPosition;
               this.throwTo(NaN,this._targetVerticalScrollPosition,this._verticalAutoScrollTween.totalTime - this._verticalAutoScrollTween.currentTime);
            }
         }
      }
      
      public function get itemOffset() : int
      {
         return _itemOffset;
      }
      
      public function set itemOffset(param1:int) : void
      {
         _itemOffset = param1;
         this.invalidate("pendingScroll");
      }
      
      public function get selectedPageIndex() : int
      {
         return layout is HorizontalLayout ? _horizontalPageIndex : _verticalPageIndex;
      }
      
      override public function scrollToPageIndex(param1:int, param2:int, param3:Number = 0) : void
      {
         super.scrollToPageIndex(param1,param2,param3);
         _horizontalPageIndex = param1;
         _verticalPageIndex = param2;
      }
   }
}

