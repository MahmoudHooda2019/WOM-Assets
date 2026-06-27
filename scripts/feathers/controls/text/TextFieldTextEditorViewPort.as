package feathers.controls.text
{
   import feathers.controls.Scroller;
   import feathers.utils.geom.matrixToScaleX;
   import feathers.utils.geom.matrixToScaleY;
   import feathers.utils.math.roundToNearest;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import starling.core.Starling;
   import starling.utils.MatrixUtil;
   
   public class TextFieldTextEditorViewPort extends TextFieldTextEditor implements ITextEditorViewPort
   {
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private var _ignoreScrolling:Boolean = false;
      
      private var _minVisibleWidth:Number = 0;
      
      private var _maxVisibleWidth:Number = Infinity;
      
      private var _visibleWidth:Number = NaN;
      
      private var _minVisibleHeight:Number = 0;
      
      private var _maxVisibleHeight:Number = Infinity;
      
      private var _visibleHeight:Number = NaN;
      
      protected var _scrollStep:int = 0;
      
      private var _horizontalScrollPosition:Number = 0;
      
      private var _verticalScrollPosition:Number = 0;
      
      public function TextFieldTextEditorViewPort()
      {
         super();
         this.multiline = true;
         this.wordWrap = true;
         this.resetScrollOnFocusOut = false;
      }
      
      public function get minVisibleWidth() : Number
      {
         return this._minVisibleWidth;
      }
      
      public function set minVisibleWidth(param1:Number) : void
      {
         if(this._minVisibleWidth == param1)
         {
            return;
         }
         if(isNaN(param1))
         {
            throw new ArgumentError("minVisibleWidth cannot be NaN");
         }
         this._minVisibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get maxVisibleWidth() : Number
      {
         return this._maxVisibleWidth;
      }
      
      public function set maxVisibleWidth(param1:Number) : void
      {
         if(this._maxVisibleWidth == param1)
         {
            return;
         }
         if(isNaN(param1))
         {
            throw new ArgumentError("maxVisibleWidth cannot be NaN");
         }
         this._maxVisibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get visibleWidth() : Number
      {
         return this._visibleWidth;
      }
      
      public function set visibleWidth(param1:Number) : void
      {
         if(this._visibleWidth == param1 || isNaN(param1) && isNaN(this._visibleWidth))
         {
            return;
         }
         this._visibleWidth = param1;
         this.invalidate("size");
      }
      
      public function get minVisibleHeight() : Number
      {
         return this._minVisibleHeight;
      }
      
      public function set minVisibleHeight(param1:Number) : void
      {
         if(this._minVisibleHeight == param1)
         {
            return;
         }
         if(isNaN(param1))
         {
            throw new ArgumentError("minVisibleHeight cannot be NaN");
         }
         this._minVisibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get maxVisibleHeight() : Number
      {
         return this._maxVisibleHeight;
      }
      
      public function set maxVisibleHeight(param1:Number) : void
      {
         if(this._maxVisibleHeight == param1)
         {
            return;
         }
         if(isNaN(param1))
         {
            throw new ArgumentError("maxVisibleHeight cannot be NaN");
         }
         this._maxVisibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get visibleHeight() : Number
      {
         return this._visibleHeight;
      }
      
      public function set visibleHeight(param1:Number) : void
      {
         if(this._visibleHeight == param1 || isNaN(param1) && isNaN(this._visibleHeight))
         {
            return;
         }
         this._visibleHeight = param1;
         this.invalidate("size");
      }
      
      public function get contentX() : Number
      {
         return 0;
      }
      
      public function get contentY() : Number
      {
         return 0;
      }
      
      public function get horizontalScrollStep() : Number
      {
         return this._scrollStep;
      }
      
      public function get verticalScrollStep() : Number
      {
         return this._scrollStep;
      }
      
      public function get horizontalScrollPosition() : Number
      {
         return this._horizontalScrollPosition;
      }
      
      public function set horizontalScrollPosition(param1:Number) : void
      {
         if(this._horizontalScrollPosition == param1)
         {
            return;
         }
         this._horizontalScrollPosition = param1;
         this.invalidate("scroll");
      }
      
      public function get verticalScrollPosition() : Number
      {
         return this._verticalScrollPosition;
      }
      
      public function set verticalScrollPosition(param1:Number) : void
      {
         if(this._verticalScrollPosition == param1)
         {
            return;
         }
         this._verticalScrollPosition = param1;
         this.invalidate("scroll");
      }
      
      override protected function measure(param1:Point = null) : Point
      {
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc3_:Boolean = isNaN(this._visibleWidth);
         this.commitStylesAndData(this.measureTextField);
         var _loc4_:Number = this._visibleWidth;
         this.measureTextField.width = _loc4_;
         if(_loc3_)
         {
            _loc4_ = Math.max(this._minVisibleWidth,Math.min(this._maxVisibleWidth,this.measureTextField.textWidth + 4));
         }
         var _loc2_:Number = this.measureTextField.textHeight + 4;
         param1.x = _loc4_;
         param1.y = _loc2_;
         return param1;
      }
      
      override protected function refreshSnapshotParameters() : void
      {
         var _loc2_:Number = this._visibleWidth;
         if(isNaN(_loc2_))
         {
            if(this._maxVisibleWidth < Infinity)
            {
               _loc2_ = this._maxVisibleWidth;
            }
            else
            {
               _loc2_ = this._minVisibleWidth;
            }
         }
         var _loc1_:Number = this._visibleHeight;
         if(isNaN(_loc1_))
         {
            if(this._maxVisibleHeight < Infinity)
            {
               _loc1_ = this._maxVisibleHeight;
            }
            else
            {
               _loc1_ = this._minVisibleHeight;
            }
         }
         this._textFieldOffsetX = 0;
         this._textFieldOffsetY = 0;
         this._textFieldClipRect.x = 0;
         this._textFieldClipRect.y = 0;
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         this._textFieldClipRect.width = _loc2_ * Starling.contentScaleFactor * matrixToScaleX(HELPER_MATRIX);
         this._textFieldClipRect.height = _loc1_ * Starling.contentScaleFactor * matrixToScaleY(HELPER_MATRIX);
      }
      
      override protected function refreshTextFieldSize() : void
      {
         var _loc2_:Boolean = this._ignoreScrolling;
         this._ignoreScrolling = true;
         this.textField.width = this._visibleWidth;
         if(this.textField.height != this._visibleHeight)
         {
            this.textField.height = this._visibleHeight;
         }
         var _loc1_:Scroller = Scroller(this.parent);
         this.textField.scrollV = Math.round(1 + (this.textField.maxScrollV - 1) * (this._verticalScrollPosition / _loc1_.maxVerticalScrollPosition));
         this._ignoreScrolling = _loc2_;
      }
      
      override protected function commitStylesAndData(param1:TextField) : void
      {
         super.commitStylesAndData(param1);
         if(param1 == this.textField)
         {
            this._scrollStep = param1.getLineMetrics(0).height;
         }
      }
      
      override protected function positionTextField() : void
      {
         var _loc1_:Rectangle = null;
         HELPER_POINT.x = HELPER_POINT.y = 0;
         this.getTransformationMatrix(this.stage,HELPER_MATRIX);
         MatrixUtil.transformCoords(HELPER_MATRIX,0,0,HELPER_POINT);
         var _loc3_:Number = Math.round(this._horizontalScrollPosition);
         var _loc2_:Number = Math.round(this._verticalScrollPosition);
         if(HELPER_POINT.x != this._oldGlobalX || HELPER_POINT.y != this._oldGlobalY)
         {
            this._oldGlobalX = HELPER_POINT.x;
            this._oldGlobalY = HELPER_POINT.y;
            _loc1_ = Starling.current.viewPort;
            this.textField.x = _loc3_ + Math.round(_loc1_.x + HELPER_POINT.x * Starling.contentScaleFactor);
            this.textField.y = _loc2_ + Math.round(_loc1_.y + HELPER_POINT.y * Starling.contentScaleFactor);
         }
         if(this.textSnapshot)
         {
            this.textSnapshot.x = _loc3_ + Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx;
            this.textSnapshot.y = _loc2_ + Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty;
         }
      }
      
      override protected function checkIfNewSnapshotIsNeeded() : void
      {
         super.checkIfNewSnapshotIsNeeded();
         this._needsNewTexture ||= this.isInvalid("scroll");
      }
      
      override protected function textField_focusInHandler(param1:FocusEvent) : void
      {
         var _loc2_:Boolean = this._ignoreScrolling;
         this._ignoreScrolling = true;
         this.textField.height = this._visibleHeight;
         this._ignoreScrolling = _loc2_;
         this.textField.addEventListener("scroll",textField_scrollHandler);
         super.textField_focusInHandler(param1);
         this.invalidate("size");
      }
      
      override protected function textField_focusOutHandler(param1:FocusEvent) : void
      {
         this.textField.removeEventListener("scroll",textField_scrollHandler);
         super.textField_focusOutHandler(param1);
         this.invalidate("size");
      }
      
      protected function textField_scrollHandler(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = this.textField.scrollH;
         var _loc5_:Number = this.textField.scrollV;
         if(this._ignoreScrolling)
         {
            return;
         }
         var _loc2_:Scroller = Scroller(this.parent);
         if(_loc2_.maxVerticalScrollPosition > 0 && this.textField.maxScrollV > 1)
         {
            _loc3_ = _loc2_.maxVerticalScrollPosition * (_loc5_ - 1) / (this.textField.maxScrollV - 1);
            _loc2_.verticalScrollPosition = roundToNearest(_loc3_,this._scrollStep);
         }
      }
   }
}

