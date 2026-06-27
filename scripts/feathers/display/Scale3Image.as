package feathers.display
{
   import feathers.textures.Scale3Textures;
   import flash.errors.IllegalOperationError;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.core.RenderSupport;
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.events.Event;
   import starling.utils.MatrixUtil;
   
   public class Scale3Image extends Sprite
   {
      
      private static var helperImage:Image;
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private var _propertiesChanged:Boolean = true;
      
      private var _renderingChanged:Boolean = true;
      
      private var _layoutChanged:Boolean = true;
      
      private var _frame:Rectangle;
      
      private var _textures:Scale3Textures;
      
      private var _width:Number = NaN;
      
      private var _height:Number = NaN;
      
      private var _textureScale:Number = 1;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _useSeparateBatch:Boolean = true;
      
      private var _hitArea:Rectangle;
      
      private var _batch:QuadBatch;
      
      private var _firstRegionImage:Image;
      
      private var _secondRegionImage:Image;
      
      private var _thirdRegionImage:Image;
      
      public function Scale3Image(param1:Scale3Textures, param2:Number = 1)
      {
         super();
         this.textures = param1;
         this._textureScale = param2;
         this._hitArea = new Rectangle();
         this.readjustSize();
         this.addEventListener("flatten",flattenHandler);
      }
      
      public function get textures() : Scale3Textures
      {
         return this._textures;
      }
      
      public function set textures(param1:Scale3Textures) : void
      {
         if(!param1)
         {
            throw new IllegalOperationError("Scale3Image textures cannot be null.");
         }
         if(this._textures == param1)
         {
            return;
         }
         this._textures = param1;
         this._frame = this._textures.texture.frame;
         this._layoutChanged = true;
         this._renderingChanged = true;
      }
      
      override public function get width() : Number
      {
         return this._width;
      }
      
      override public function set width(param1:Number) : void
      {
         if(this._width == param1)
         {
            return;
         }
         this._width = this._hitArea.width = param1;
         this._layoutChanged = true;
      }
      
      override public function get height() : Number
      {
         return this._height;
      }
      
      override public function set height(param1:Number) : void
      {
         if(this._height == param1)
         {
            return;
         }
         this._height = this._hitArea.height = param1;
         this._layoutChanged = true;
      }
      
      public function get textureScale() : Number
      {
         return this._textureScale;
      }
      
      public function set textureScale(param1:Number) : void
      {
         if(this._textureScale == param1)
         {
            return;
         }
         this._textureScale = param1;
         this._layoutChanged = true;
      }
      
      public function get smoothing() : String
      {
         return this._smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         if(this._smoothing == param1)
         {
            return;
         }
         this._smoothing = param1;
         this._propertiesChanged = true;
      }
      
      public function get color() : uint
      {
         return this._color;
      }
      
      public function set color(param1:uint) : void
      {
         if(this._color == param1)
         {
            return;
         }
         this._color = param1;
         this._propertiesChanged = true;
      }
      
      public function get useSeparateBatch() : Boolean
      {
         return this._useSeparateBatch;
      }
      
      public function set useSeparateBatch(param1:Boolean) : void
      {
         if(this._useSeparateBatch == param1)
         {
            return;
         }
         this._useSeparateBatch = param1;
         this._renderingChanged = true;
      }
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         if(!param2)
         {
            param2 = new Rectangle();
         }
         var _loc5_:Number = 1.7976931348623157e+308;
         var _loc4_:Number = -1.7976931348623157e+308;
         var _loc6_:Number = 1.7976931348623157e+308;
         var _loc3_:Number = -1.7976931348623157e+308;
         if(param1 == this)
         {
            _loc5_ = this._hitArea.x;
            _loc6_ = this._hitArea.y;
            _loc4_ = this._hitArea.x + this._hitArea.width;
            _loc3_ = this._hitArea.y + this._hitArea.height;
         }
         else
         {
            this.getTransformationMatrix(param1,HELPER_MATRIX);
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x,this._hitArea.y,HELPER_POINT);
            _loc5_ = _loc5_ < HELPER_POINT.x ? _loc5_ : HELPER_POINT.x;
            _loc4_ = _loc4_ > HELPER_POINT.x ? _loc4_ : HELPER_POINT.x;
            _loc6_ = _loc6_ < HELPER_POINT.y ? _loc6_ : HELPER_POINT.y;
            _loc3_ = _loc3_ > HELPER_POINT.y ? _loc3_ : HELPER_POINT.y;
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x,this._hitArea.y + this._hitArea.height,HELPER_POINT);
            _loc5_ = _loc5_ < HELPER_POINT.x ? _loc5_ : HELPER_POINT.x;
            _loc4_ = _loc4_ > HELPER_POINT.x ? _loc4_ : HELPER_POINT.x;
            _loc6_ = _loc6_ < HELPER_POINT.y ? _loc6_ : HELPER_POINT.y;
            _loc3_ = _loc3_ > HELPER_POINT.y ? _loc3_ : HELPER_POINT.y;
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x + this._hitArea.width,this._hitArea.y,HELPER_POINT);
            _loc5_ = _loc5_ < HELPER_POINT.x ? _loc5_ : HELPER_POINT.x;
            _loc4_ = _loc4_ > HELPER_POINT.x ? _loc4_ : HELPER_POINT.x;
            _loc6_ = _loc6_ < HELPER_POINT.y ? _loc6_ : HELPER_POINT.y;
            _loc3_ = _loc3_ > HELPER_POINT.y ? _loc3_ : HELPER_POINT.y;
            MatrixUtil.transformCoords(HELPER_MATRIX,this._hitArea.x + this._hitArea.width,this._hitArea.y + this._hitArea.height,HELPER_POINT);
            _loc5_ = _loc5_ < HELPER_POINT.x ? _loc5_ : HELPER_POINT.x;
            _loc4_ = _loc4_ > HELPER_POINT.x ? _loc4_ : HELPER_POINT.x;
            _loc6_ = _loc6_ < HELPER_POINT.y ? _loc6_ : HELPER_POINT.y;
            _loc3_ = _loc3_ > HELPER_POINT.y ? _loc3_ : HELPER_POINT.y;
         }
         param2.x = _loc5_;
         param2.y = _loc6_;
         param2.width = _loc4_ - _loc5_;
         param2.height = _loc3_ - _loc6_;
         return param2;
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!this.visible || !this.touchable))
         {
            return null;
         }
         return this._hitArea.containsPoint(param1) ? this : null;
      }
      
      override public function flatten() : void
      {
         this.validate();
         super.flatten();
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         this.validate();
         super.render(param1,param2);
      }
      
      public function readjustSize() : void
      {
         this.width = this._frame.width * this._textureScale;
         this.height = this._frame.height * this._textureScale;
      }
      
      private function validate() : void
      {
         var _loc4_:Image = null;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         this.refreshImages();
         if(this._propertiesChanged || this._layoutChanged || this._renderingChanged)
         {
            this.refreshBatch();
            if(this._textures.direction == "vertical")
            {
               _loc6_ = this._width;
               _loc7_ = _loc6_ / this._frame.width;
               _loc5_ = this._textures.firstRegionSize * _loc7_;
               _loc3_ = (this._frame.height - this._textures.firstRegionSize - this._textures.secondRegionSize) * _loc7_;
               _loc2_ = this._height - _loc5_ - _loc3_;
               if(_loc2_ < 0)
               {
                  _loc1_ = _loc2_ / 2;
                  _loc5_ += _loc1_;
                  _loc3_ += _loc1_;
               }
               if(_loc6_ > 0)
               {
                  if(this._useSeparateBatch)
                  {
                     _loc4_ = helperImage;
                     helperImage.texture = this._textures.first;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc4_ = this._firstRegionImage;
                     _loc4_.smoothing = this._smoothing;
                     _loc4_.color = this._color;
                  }
                  _loc4_.x = 0;
                  _loc4_.y = 0;
                  _loc4_.width = _loc6_;
                  _loc4_.height = _loc5_;
                  if(this._useSeparateBatch && _loc5_ > 0)
                  {
                     this._batch.addImage(helperImage);
                  }
                  if(_loc2_ > 0)
                  {
                     if(this._useSeparateBatch)
                     {
                        _loc4_ = helperImage;
                        helperImage.texture = this._textures.second;
                        helperImage.readjustSize();
                     }
                     else
                     {
                        _loc4_ = this._secondRegionImage;
                        _loc4_.smoothing = this._smoothing;
                        _loc4_.color = this._color;
                        _loc4_.visible = true;
                     }
                     _loc4_.x = 0;
                     _loc4_.y = _loc5_;
                     _loc4_.width = _loc6_;
                     _loc4_.height = _loc2_;
                     if(this._useSeparateBatch)
                     {
                        this._batch.addImage(helperImage);
                     }
                  }
                  else if(!this._useSeparateBatch)
                  {
                     this._secondRegionImage.visible = false;
                  }
                  if(this._useSeparateBatch)
                  {
                     _loc4_ = helperImage;
                     helperImage.texture = this._textures.third;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc4_ = this._thirdRegionImage;
                     _loc4_.smoothing = this._smoothing;
                     _loc4_.color = this._color;
                  }
                  _loc4_.x = 0;
                  _loc4_.y = this._height - _loc3_;
                  _loc4_.width = _loc6_;
                  _loc4_.height = _loc3_;
                  if(this._useSeparateBatch && _loc3_ > 0)
                  {
                     this._batch.addImage(helperImage);
                  }
               }
            }
            else
            {
               _loc6_ = this._height;
               _loc7_ = _loc6_ / this._frame.height;
               _loc5_ = this._textures.firstRegionSize * _loc7_;
               _loc3_ = (this._frame.width - this._textures.firstRegionSize - this._textures.secondRegionSize) * _loc7_;
               _loc2_ = this._width - _loc5_ - _loc3_;
               if(_loc2_ < 0)
               {
                  _loc1_ = _loc2_ / 2;
                  _loc5_ += _loc1_;
                  _loc3_ += _loc1_;
               }
               if(_loc6_ > 0)
               {
                  if(this._useSeparateBatch)
                  {
                     _loc4_ = helperImage;
                     helperImage.texture = this._textures.first;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc4_ = this._firstRegionImage;
                     _loc4_.smoothing = this._smoothing;
                     _loc4_.color = this._color;
                  }
                  _loc4_.x = 0;
                  _loc4_.y = 0;
                  _loc4_.width = _loc5_;
                  _loc4_.height = _loc6_;
                  if(this._useSeparateBatch && _loc5_ > 0)
                  {
                     this._batch.addImage(helperImage);
                  }
                  if(_loc2_ > 0)
                  {
                     if(this._useSeparateBatch)
                     {
                        _loc4_ = helperImage;
                        helperImage.texture = this._textures.second;
                        helperImage.readjustSize();
                     }
                     else
                     {
                        _loc4_ = this._secondRegionImage;
                        _loc4_.smoothing = this._smoothing;
                        _loc4_.color = this._color;
                        _loc4_.visible = true;
                     }
                     _loc4_.x = _loc5_;
                     _loc4_.y = 0;
                     _loc4_.width = _loc2_;
                     _loc4_.height = _loc6_;
                     if(this._useSeparateBatch)
                     {
                        this._batch.addImage(helperImage);
                     }
                  }
                  else if(!this._useSeparateBatch)
                  {
                     this._secondRegionImage.visible = false;
                  }
                  if(this._useSeparateBatch)
                  {
                     _loc4_ = helperImage;
                     helperImage.texture = this._textures.third;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc4_ = this._thirdRegionImage;
                     _loc4_.smoothing = this._smoothing;
                     _loc4_.color = this._color;
                  }
                  _loc4_.x = this._width - _loc3_;
                  _loc4_.y = 0;
                  _loc4_.width = _loc3_;
                  _loc4_.height = _loc6_;
                  if(this._useSeparateBatch && _loc3_ > 0)
                  {
                     this._batch.addImage(helperImage);
                  }
               }
            }
         }
         this._propertiesChanged = false;
         this._layoutChanged = false;
         this._renderingChanged = false;
      }
      
      private function refreshImages() : void
      {
         if(!this._renderingChanged || this._useSeparateBatch)
         {
            return;
         }
         if(this._firstRegionImage)
         {
            this._firstRegionImage.texture = this._textures.first;
            this._firstRegionImage.readjustSize();
         }
         else
         {
            this._firstRegionImage = new Image(this._textures.first);
            this.addChild(this._firstRegionImage);
         }
         if(this._secondRegionImage)
         {
            this._secondRegionImage.texture = this._textures.second;
            this._secondRegionImage.readjustSize();
         }
         else
         {
            this._secondRegionImage = new Image(this._textures.second);
            this.addChild(this._secondRegionImage);
         }
         if(this._thirdRegionImage)
         {
            this._thirdRegionImage.texture = this._textures.third;
            this._thirdRegionImage.readjustSize();
         }
         else
         {
            this._thirdRegionImage = new Image(this._textures.third);
            this.addChild(this._thirdRegionImage);
         }
      }
      
      private function refreshBatch() : void
      {
         if(this._useSeparateBatch)
         {
            if(!this._batch)
            {
               this._batch = new QuadBatch();
               this._batch.touchable = false;
               this.addChild(this._batch);
            }
            if(this._firstRegionImage)
            {
               this._firstRegionImage.removeFromParent(true);
               this._firstRegionImage = null;
            }
            if(this._secondRegionImage)
            {
               this._secondRegionImage.removeFromParent(true);
               this._secondRegionImage = null;
            }
            if(this._thirdRegionImage)
            {
               this._thirdRegionImage.removeFromParent(true);
               this._thirdRegionImage = null;
            }
            this._batch.reset();
            if(!helperImage)
            {
               helperImage = new Image(this._textures.first);
            }
            helperImage.smoothing = this._smoothing;
            helperImage.color = this._color;
         }
         else if(this._batch)
         {
            this._batch.removeFromParent(true);
            this._batch = null;
         }
      }
      
      private function flattenHandler(param1:Event) : void
      {
         this.validate();
      }
   }
}

