package feathers.layout
{
   import feathers.core.IFeathersControl;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   public class VerticalLayout extends EventDispatcher implements IVariableVirtualLayout, ITrimmedVirtualLayout
   {
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const HORIZONTAL_ALIGN_JUSTIFY:String = "justify";
      
      protected var _heightCache:Array = [];
      
      protected var _discoveredItemsCache:Vector.<DisplayObject> = new Vector.<DisplayObject>(0);
      
      protected var _gap:Number = 0;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      protected var _verticalAlign:String = "top";
      
      protected var _horizontalAlign:String = "left";
      
      protected var _useVirtualLayout:Boolean = true;
      
      protected var _hasVariableItemDimensions:Boolean = false;
      
      public var manageVisibility:Boolean = false;
      
      protected var _beforeVirtualizedItemCount:int = 0;
      
      protected var _afterVirtualizedItemCount:int = 0;
      
      protected var _typicalItem:DisplayObject;
      
      protected var _resetTypicalItemDimensionsOnMeasure:Boolean = false;
      
      protected var _typicalItemWidth:Number = NaN;
      
      protected var _typicalItemHeight:Number = NaN;
      
      protected var _scrollPositionVerticalAlign:String = "middle";
      
      public function VerticalLayout()
      {
         super();
      }
      
      public function get gap() : Number
      {
         return this._gap;
      }
      
      public function set gap(param1:Number) : void
      {
         if(this._gap == param1)
         {
            return;
         }
         this._gap = param1;
         this.dispatchEventWith("change");
      }
      
      public function get padding() : Number
      {
         return this._paddingTop;
      }
      
      public function set padding(param1:Number) : void
      {
         this.paddingTop = param1;
         this.paddingRight = param1;
         this.paddingBottom = param1;
         this.paddingLeft = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         if(this._paddingTop == param1)
         {
            return;
         }
         this._paddingTop = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         if(this._paddingRight == param1)
         {
            return;
         }
         this._paddingRight = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         if(this._paddingBottom == param1)
         {
            return;
         }
         this._paddingBottom = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         if(this._paddingLeft == param1)
         {
            return;
         }
         this._paddingLeft = param1;
         this.dispatchEventWith("change");
      }
      
      public function get verticalAlign() : String
      {
         return this._verticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void
      {
         if(this._verticalAlign == param1)
         {
            return;
         }
         this._verticalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      public function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      public function set horizontalAlign(param1:String) : void
      {
         if(this._horizontalAlign == param1)
         {
            return;
         }
         this._horizontalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      public function get useVirtualLayout() : Boolean
      {
         return this._useVirtualLayout;
      }
      
      public function set useVirtualLayout(param1:Boolean) : void
      {
         if(this._useVirtualLayout == param1)
         {
            return;
         }
         this._useVirtualLayout = param1;
         this.dispatchEventWith("change");
      }
      
      public function get hasVariableItemDimensions() : Boolean
      {
         return this._hasVariableItemDimensions;
      }
      
      public function set hasVariableItemDimensions(param1:Boolean) : void
      {
         if(this._hasVariableItemDimensions == param1)
         {
            return;
         }
         this._hasVariableItemDimensions = param1;
         this.dispatchEventWith("change");
      }
      
      public function get beforeVirtualizedItemCount() : int
      {
         return this._beforeVirtualizedItemCount;
      }
      
      public function set beforeVirtualizedItemCount(param1:int) : void
      {
         if(this._beforeVirtualizedItemCount == param1)
         {
            return;
         }
         this._beforeVirtualizedItemCount = param1;
         this.dispatchEventWith("change");
      }
      
      public function get afterVirtualizedItemCount() : int
      {
         return this._afterVirtualizedItemCount;
      }
      
      public function set afterVirtualizedItemCount(param1:int) : void
      {
         if(this._afterVirtualizedItemCount == param1)
         {
            return;
         }
         this._afterVirtualizedItemCount = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItem() : DisplayObject
      {
         return this._typicalItem;
      }
      
      public function set typicalItem(param1:DisplayObject) : void
      {
         if(this._typicalItem == param1)
         {
            return;
         }
         this._typicalItem = param1;
         this.dispatchEventWith("change");
      }
      
      public function get resetTypicalItemDimensionsOnMeasure() : Boolean
      {
         return this._resetTypicalItemDimensionsOnMeasure;
      }
      
      public function set resetTypicalItemDimensionsOnMeasure(param1:Boolean) : void
      {
         if(this._resetTypicalItemDimensionsOnMeasure == param1)
         {
            return;
         }
         this._resetTypicalItemDimensionsOnMeasure = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItemWidth() : Number
      {
         return this._typicalItemWidth;
      }
      
      public function set typicalItemWidth(param1:Number) : void
      {
         if(this._typicalItemWidth == param1)
         {
            return;
         }
         this._typicalItemWidth = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItemHeight() : Number
      {
         return this._typicalItemHeight;
      }
      
      public function set typicalItemHeight(param1:Number) : void
      {
         if(this._typicalItemHeight == param1)
         {
            return;
         }
         this._typicalItemHeight = param1;
         this.dispatchEventWith("change");
      }
      
      public function get scrollPositionVerticalAlign() : String
      {
         return this._scrollPositionVerticalAlign;
      }
      
      public function set scrollPositionVerticalAlign(param1:String) : void
      {
         this._scrollPositionVerticalAlign = param1;
      }
      
      public function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult
      {
         var _loc32_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc21_:int = 0;
         var _loc26_:DisplayObject = null;
         var _loc19_:int = 0;
         var _loc30_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc10_:Number = param2 ? param2.scrollX : 0;
         var _loc8_:Number = param2 ? param2.scrollY : 0;
         var _loc28_:Number = param2 ? param2.x : 0;
         var _loc33_:Number = param2 ? param2.y : 0;
         var _loc5_:Number = param2 ? param2.minWidth : 0;
         var _loc22_:Number = param2 ? param2.minHeight : 0;
         var _loc17_:Number = param2 ? param2.maxWidth : Infinity;
         var _loc27_:Number = param2 ? param2.maxHeight : Infinity;
         var _loc9_:Number = param2 ? param2.explicitWidth : NaN;
         var _loc18_:Number = param2 ? param2.explicitHeight : NaN;
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(_loc9_ - this._paddingLeft - this._paddingRight);
            _loc32_ = this._typicalItem ? this._typicalItem.width : 0;
            _loc15_ = this._typicalItem ? this._typicalItem.height : 0;
         }
         if(!this._useVirtualLayout || this._hasVariableItemDimensions || this._horizontalAlign != "justify" || isNaN(_loc9_))
         {
            this.validateItems(param1,_loc9_ - this._paddingLeft - this._paddingRight);
         }
         this._discoveredItemsCache.length = 0;
         var _loc4_:Number = this._useVirtualLayout ? _loc32_ : 0;
         var _loc6_:Number = _loc33_ + this._paddingTop;
         var _loc23_:int = 0;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc23_ = this._beforeVirtualizedItemCount;
            _loc6_ += this._beforeVirtualizedItemCount * (_loc15_ + this._gap);
         }
         var _loc31_:int = int(param1.length);
         var _loc29_:int = 0;
         _loc21_ = 0;
         while(_loc21_ < _loc31_)
         {
            _loc26_ = param1[_loc21_];
            _loc19_ = _loc21_ + _loc23_;
            if(this._useVirtualLayout && this._hasVariableItemDimensions)
            {
               _loc30_ = Number(this._heightCache[_loc19_]);
            }
            if(this._useVirtualLayout && !_loc26_)
            {
               if(!this._hasVariableItemDimensions || isNaN(_loc30_))
               {
                  _loc6_ += _loc15_ + this._gap;
               }
               else
               {
                  _loc6_ += _loc30_ + this._gap;
               }
            }
            else if(!(_loc26_ is ILayoutDisplayObject && !ILayoutDisplayObject(_loc26_).includeInLayout))
            {
               _loc26_.y = _loc6_;
               _loc7_ = _loc26_.width;
               _loc20_ = _loc26_.height;
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc30_ != _loc20_)
                     {
                        this._heightCache[_loc19_] = _loc20_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc15_ >= 0)
                  {
                     _loc26_.height = _loc20_ = _loc15_;
                  }
               }
               _loc6_ += _loc20_ + this._gap;
               if(_loc7_ > _loc4_)
               {
                  _loc4_ = _loc7_;
               }
               if(this._useVirtualLayout)
               {
                  this._discoveredItemsCache[_loc29_] = _loc26_;
                  _loc29_++;
               }
            }
            _loc21_++;
         }
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc6_ += this._afterVirtualizedItemCount * (_loc15_ + this._gap);
         }
         var _loc14_:Vector.<DisplayObject> = this._useVirtualLayout ? this._discoveredItemsCache : param1;
         var _loc13_:Number = _loc4_ + this._paddingLeft + this._paddingRight;
         var _loc24_:Number = _loc9_;
         if(isNaN(_loc24_))
         {
            _loc24_ = _loc13_;
            if(_loc24_ < _loc5_)
            {
               _loc24_ = _loc5_;
            }
            else if(_loc24_ > _loc17_)
            {
               _loc24_ = _loc17_;
            }
         }
         var _loc12_:int = int(_loc14_.length);
         var _loc11_:Number = _loc6_ - this._gap + this._paddingBottom - _loc33_;
         var _loc16_:Number = _loc18_;
         if(isNaN(_loc16_))
         {
            _loc16_ = _loc11_;
            if(_loc16_ < _loc22_)
            {
               _loc16_ = _loc22_;
            }
            else if(_loc16_ > _loc27_)
            {
               _loc16_ = _loc27_;
            }
         }
         if(_loc11_ < _loc16_)
         {
            _loc25_ = 0;
            if(this._verticalAlign == "bottom")
            {
               _loc25_ = _loc16_ - _loc11_;
            }
            else if(this._verticalAlign == "middle")
            {
               _loc25_ = (_loc16_ - _loc11_) / 2;
            }
            if(_loc25_ != 0)
            {
               _loc21_ = 0;
               while(_loc21_ < _loc12_)
               {
                  _loc26_ = _loc14_[_loc21_];
                  if(!(_loc26_ is ILayoutDisplayObject && !ILayoutDisplayObject(_loc26_).includeInLayout))
                  {
                     _loc26_.y += _loc25_;
                  }
                  _loc21_++;
               }
            }
         }
         _loc21_ = 0;
         while(_loc21_ < _loc12_)
         {
            _loc26_ = _loc14_[_loc21_];
            if(!(_loc26_ is ILayoutDisplayObject && !ILayoutDisplayObject(_loc26_).includeInLayout))
            {
               switch(this._horizontalAlign)
               {
                  case "right":
                     _loc26_.x = _loc28_ + _loc24_ - this._paddingRight - _loc26_.width;
                     break;
                  case "center":
                     _loc26_.x = _loc28_ + this._paddingLeft + (_loc24_ - this._paddingLeft - this._paddingRight - _loc26_.width) / 2;
                     break;
                  case "justify":
                     _loc26_.x = _loc28_ + this._paddingLeft;
                     _loc26_.width = _loc24_ - this._paddingLeft - this._paddingRight;
                     break;
                  default:
                     _loc26_.x = _loc28_ + this._paddingLeft;
               }
               if(this.manageVisibility)
               {
                  _loc26_.visible = _loc26_.y + _loc26_.height >= _loc33_ + _loc8_ && _loc26_.y < _loc8_ + _loc16_;
               }
            }
            _loc21_++;
         }
         this._discoveredItemsCache.length = 0;
         if(!param3)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentWidth = this._horizontalAlign == "justify" ? _loc24_ : _loc13_;
         param3.contentHeight = _loc11_;
         param3.viewPortWidth = _loc24_;
         param3.viewPortHeight = _loc16_;
         return param3;
      }
      
      public function measureViewPort(param1:int, param2:ViewPortBounds = null, param3:Point = null) : Point
      {
         var _loc10_:int = 0;
         var _loc8_:Number = NaN;
         var _loc18_:Number = NaN;
         if(!param3)
         {
            param3 = new Point();
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
         }
         var _loc9_:Number = param2 ? param2.explicitWidth : NaN;
         var _loc4_:Number = param2 ? param2.explicitHeight : NaN;
         var _loc11_:Boolean = isNaN(_loc9_);
         var _loc16_:Boolean = isNaN(_loc4_);
         if(!_loc11_ && !_loc16_)
         {
            param3.x = _loc9_;
            param3.y = _loc4_;
            return param3;
         }
         var _loc6_:Number = param2 ? param2.minWidth : 0;
         var _loc12_:Number = param2 ? param2.minHeight : 0;
         var _loc14_:Number = param2 ? param2.maxWidth : Infinity;
         var _loc15_:Number = param2 ? param2.maxHeight : Infinity;
         this.prepareTypicalItem(_loc9_ - this._paddingLeft - this._paddingRight);
         var _loc17_:Number = this._typicalItem ? this._typicalItem.width : 0;
         var _loc13_:Number = this._typicalItem ? this._typicalItem.height : 0;
         var _loc7_:Number = 0;
         var _loc5_:Number = _loc17_;
         if(!this._hasVariableItemDimensions)
         {
            _loc7_ += (_loc13_ + this._gap) * param1;
         }
         else
         {
            _loc10_ = 0;
            while(_loc10_ < param1)
            {
               if(isNaN(this._heightCache[_loc10_]))
               {
                  _loc7_ += _loc13_ + this._gap;
               }
               else
               {
                  _loc7_ += this._heightCache[_loc10_] + this._gap;
               }
               _loc10_++;
            }
         }
         if(_loc11_)
         {
            _loc8_ = _loc5_ + this._paddingLeft + this._paddingRight;
            if(_loc8_ < _loc6_)
            {
               _loc8_ = _loc6_;
            }
            else if(_loc8_ > _loc14_)
            {
               _loc8_ = _loc14_;
            }
            param3.x = _loc8_;
         }
         else
         {
            param3.x = _loc9_;
         }
         if(_loc16_)
         {
            _loc18_ = _loc7_ - this._gap + this._paddingTop + this._paddingBottom;
            if(_loc18_ < _loc12_)
            {
               _loc18_ = _loc12_;
            }
            else if(_loc18_ > _loc15_)
            {
               _loc18_ = _loc15_;
            }
            param3.y = _loc18_;
         }
         else
         {
            param3.y = _loc4_;
         }
         return param3;
      }
      
      public function resetVariableVirtualCache() : void
      {
         this._heightCache.length = 0;
      }
      
      public function resetVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         delete this._heightCache[param1];
         if(param2)
         {
            this._heightCache[param1] = param2.height;
            this.dispatchEventWith("change");
         }
      }
      
      public function addToVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         var _loc3_:* = param2 ? param2.height : undefined;
         this._heightCache.splice(param1,0,_loc3_);
      }
      
      public function removeFromVariableVirtualCacheAtIndex(param1:int) : void
      {
         this._heightCache.splice(param1,1);
      }
      
      public function getVisibleIndicesAtScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int> = null) : Vector.<int>
      {
         var _loc18_:int = 0;
         var _loc24_:Number = NaN;
         var _loc10_:int = 0;
         var _loc20_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc9_:int = 0;
         var _loc17_:int = 0;
         var _loc8_:int = 0;
         var _loc12_:int = 0;
         if(param6)
         {
            param6.length = 0;
         }
         else
         {
            param6 = new Vector.<int>(0);
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("getVisibleIndicesAtScrollPosition() may be called only if useVirtualLayout is true.");
         }
         this.prepareTypicalItem(param3 - this._paddingLeft - this._paddingRight);
         var _loc23_:Number = this._typicalItem ? this._typicalItem.width : 0;
         var _loc21_:Number = this._typicalItem ? this._typicalItem.height : 0;
         var _loc25_:int = 0;
         var _loc7_:int = Math.ceil(param4 / (_loc21_ + this._gap));
         if(!this._hasVariableItemDimensions)
         {
            _loc18_ = 0;
            _loc24_ = param5 * (_loc21_ + this._gap) - this._gap;
            if(_loc24_ < param4)
            {
               if(this._verticalAlign == "bottom")
               {
                  _loc18_ = Math.ceil((param4 - _loc24_) / (_loc21_ + this._gap));
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc18_ = Math.ceil((param4 - _loc24_) / (_loc21_ + this._gap) / 2);
               }
            }
            _loc10_ = (param2 - this._paddingTop) / (_loc21_ + this._gap);
            if(_loc10_ < 0)
            {
               _loc10_ = 0;
            }
            _loc10_ -= _loc18_;
            _loc20_ = _loc10_ + _loc7_;
            if(_loc20_ >= param5)
            {
               _loc20_ = param5 - 1;
            }
            _loc10_ = _loc20_ - _loc7_;
            if(_loc10_ < 0)
            {
               _loc10_ = 0;
            }
            _loc14_ = _loc10_;
            while(_loc14_ <= _loc20_)
            {
               param6[_loc25_] = _loc14_;
               _loc25_++;
               _loc14_++;
            }
            return param6;
         }
         var _loc16_:Number = param2 + param4;
         var _loc11_:Number = this._paddingTop;
         _loc14_ = 0;
         while(_loc14_ < param5)
         {
            if(isNaN(this._heightCache[_loc14_]))
            {
               _loc13_ = _loc21_;
            }
            else
            {
               _loc13_ = Number(this._heightCache[_loc14_]);
            }
            _loc22_ = _loc11_;
            _loc11_ += _loc13_ + this._gap;
            if(_loc11_ > param2 && _loc22_ < _loc16_)
            {
               param6[_loc25_] = _loc14_;
               _loc25_++;
            }
            if(_loc11_ >= _loc16_)
            {
               break;
            }
            _loc14_++;
         }
         var _loc19_:int = int(param6.length);
         var _loc15_:int = _loc7_ - _loc19_;
         if(_loc15_ > 0 && _loc19_ > 0)
         {
            _loc9_ = param6[0];
            _loc17_ = _loc9_ - _loc15_;
            if(_loc17_ < 0)
            {
               _loc17_ = 0;
            }
            _loc14_ = _loc9_ - 1;
            while(_loc14_ >= _loc17_)
            {
               param6.unshift(_loc14_);
               _loc14_--;
            }
         }
         _loc19_ = int(param6.length);
         _loc15_ = _loc7_ - _loc19_;
         _loc25_ = _loc19_;
         if(_loc15_ > 0)
         {
            _loc8_ = int(_loc19_ > 0 ? param6[_loc19_ - 1] + 1 : 0);
            _loc12_ = _loc8_ + _loc15_;
            if(_loc12_ > param5)
            {
               _loc12_ = param5;
            }
            _loc14_ = _loc8_;
            while(_loc14_ < _loc12_)
            {
               param6[_loc25_] = _loc14_;
               _loc25_++;
               _loc14_++;
            }
         }
         return param6;
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point
      {
         var _loc17_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc12_:int = 0;
         var _loc14_:DisplayObject = null;
         var _loc8_:int = 0;
         var _loc16_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!param7)
         {
            param7 = new Point();
         }
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(param5 - this._paddingLeft - this._paddingRight);
            _loc17_ = this._typicalItem ? this._typicalItem.width : 0;
            _loc15_ = this._typicalItem ? this._typicalItem.height : 0;
         }
         var _loc9_:Number = param4 + this._paddingTop;
         var _loc10_:int = 0;
         var _loc13_:Number = 0;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc10_ = this._beforeVirtualizedItemCount;
            _loc9_ += this._beforeVirtualizedItemCount * (_loc15_ + this._gap);
            _loc13_ = param1 - param2.length - this._beforeVirtualizedItemCount + 1;
            if(_loc13_ < 0)
            {
               _loc13_ = 0;
            }
            _loc9_ += _loc13_ * (_loc15_ + this._gap);
         }
         param1 -= _loc10_ + _loc13_;
         var _loc18_:Number = 0;
         _loc12_ = 0;
         while(_loc12_ <= param1)
         {
            _loc14_ = param2[_loc12_];
            _loc8_ = _loc12_ + _loc10_;
            if(this._useVirtualLayout && this._hasVariableItemDimensions)
            {
               _loc16_ = Number(this._heightCache[_loc8_]);
            }
            if(this._useVirtualLayout && !_loc14_)
            {
               if(!this._hasVariableItemDimensions || isNaN(_loc16_))
               {
                  _loc18_ = _loc15_;
               }
               else
               {
                  _loc18_ = _loc16_;
               }
            }
            else
            {
               _loc11_ = _loc14_.height;
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc11_ != _loc16_)
                     {
                        this._heightCache[_loc8_] = _loc11_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc15_ >= 0)
                  {
                     _loc14_.height = _loc11_ = _loc15_;
                  }
               }
               _loc18_ = _loc11_;
            }
            _loc9_ += _loc18_ + this._gap;
            _loc12_++;
         }
         _loc9_ -= _loc18_ + this._gap;
         if(this._scrollPositionVerticalAlign == "middle")
         {
            _loc9_ -= (param6 - _loc18_) / 2;
         }
         else if(this._scrollPositionVerticalAlign == "bottom")
         {
            _loc9_ -= param6 - _loc18_;
         }
         param7.x = 0;
         param7.y = _loc9_;
         return param7;
      }
      
      protected function validateItems(param1:Vector.<DisplayObject>, param2:Number) : void
      {
         var _loc6_:int = 0;
         var _loc4_:DisplayObject = null;
         var _loc3_:Boolean = this._horizontalAlign == "justify" && !isNaN(param2);
         var _loc5_:int = int(param1.length);
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = param1[_loc6_];
            if(!(!_loc4_ || _loc4_ is ILayoutDisplayObject && !ILayoutDisplayObject(_loc4_).includeInLayout))
            {
               if(_loc3_)
               {
                  _loc4_.width = param2;
               }
               if(_loc4_ is IFeathersControl)
               {
                  IFeathersControl(_loc4_).validate();
               }
            }
            _loc6_++;
         }
      }
      
      protected function prepareTypicalItem(param1:Number) : void
      {
         if(!this._typicalItem)
         {
            return;
         }
         if(this._horizontalAlign == "justify" && !isNaN(param1))
         {
            this._typicalItem.width = param1;
         }
         else if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.width = this._typicalItemWidth;
         }
         if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.height = this._typicalItemHeight;
         }
         if(this._typicalItem is IFeathersControl)
         {
            IFeathersControl(this._typicalItem).validate();
         }
      }
   }
}

