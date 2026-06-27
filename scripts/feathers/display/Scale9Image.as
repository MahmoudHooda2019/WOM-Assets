package feathers.display
{
   import feathers.textures.Scale9Textures;
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
   
   public class Scale9Image extends Sprite
   {
      
      private static var helperImage:Image;
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      private var _propertiesChanged:Boolean = true;
      
      private var _layoutChanged:Boolean = true;
      
      private var _renderingChanged:Boolean = true;
      
      private var _frame:Rectangle;
      
      private var _textures:Scale9Textures;
      
      private var _width:Number = NaN;
      
      private var _height:Number = NaN;
      
      private var _textureScale:Number = 1;
      
      private var _smoothing:String = "bilinear";
      
      private var _color:uint = 16777215;
      
      private var _useSeparateBatch:Boolean = true;
      
      private var _hitArea:Rectangle;
      
      private var _batch:QuadBatch;
      
      private var _topLeftImage:Image;
      
      private var _topCenterImage:Image;
      
      private var _topRightImage:Image;
      
      private var _middleLeftImage:Image;
      
      private var _middleCenterImage:Image;
      
      private var _middleRightImage:Image;
      
      private var _bottomLeftImage:Image;
      
      private var _bottomCenterImage:Image;
      
      private var _bottomRightImage:Image;
      
      public function Scale9Image(param1:Scale9Textures, param2:Number = 1)
      {
         super();
         this.textures = param1;
         this._textureScale = param2;
         this._hitArea = new Rectangle();
         this.readjustSize();
         this.addEventListener("flatten",flattenHandler);
      }
      
      public function get textures() : Scale9Textures
      {
         return this._textures;
      }
      
      public function set textures(param1:Scale9Textures) : void
      {
         if(!param1)
         {
            throw new IllegalOperationError("Scale9Image textures cannot be null.");
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
         var _loc6_:Rectangle = null;
         var _loc3_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc5_:Image = null;
         this.refreshImages();
         if(this._propertiesChanged || this._layoutChanged || this._renderingChanged)
         {
            this.refreshBatch();
            _loc6_ = this._textures.scale9Grid;
            _loc3_ = _loc6_.x * this._textureScale;
            _loc9_ = _loc6_.y * this._textureScale;
            _loc4_ = (this._frame.width - _loc6_.x - _loc6_.width) * this._textureScale;
            _loc7_ = (this._frame.height - _loc6_.y - _loc6_.height) * this._textureScale;
            _loc1_ = this._width - _loc3_ - _loc4_;
            _loc2_ = this._height - _loc9_ - _loc7_;
            if(_loc1_ < 0)
            {
               _loc8_ = _loc1_ / 2;
               _loc3_ += _loc8_;
               _loc4_ += _loc8_;
            }
            if(_loc2_ < 0)
            {
               _loc8_ = _loc2_ / 2;
               _loc9_ += _loc8_;
               _loc7_ += _loc8_;
            }
            if(_loc9_ > 0)
            {
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.topLeft;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._topLeftImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc3_;
               _loc5_.height = _loc9_;
               _loc5_.x = _loc3_ - _loc5_.width;
               _loc5_.y = _loc9_ - _loc5_.height;
               if(this._useSeparateBatch && _loc3_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
               if(_loc1_ > 0)
               {
                  if(this._useSeparateBatch)
                  {
                     _loc5_ = helperImage;
                     helperImage.texture = this._textures.topCenter;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc5_ = this._topCenterImage;
                     _loc5_.smoothing = this._smoothing;
                     _loc5_.color = this._color;
                     _loc5_.visible = true;
                  }
                  _loc5_.width = _loc1_;
                  _loc5_.height = _loc9_;
                  _loc5_.x = _loc3_;
                  _loc5_.y = _loc9_ - _loc5_.height;
                  if(this._useSeparateBatch)
                  {
                     this._batch.addImage(helperImage);
                  }
               }
               else if(!this._useSeparateBatch)
               {
                  this._topCenterImage.visible = false;
               }
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.topRight;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._topRightImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc4_;
               _loc5_.height = _loc9_;
               _loc5_.x = this._width - _loc4_;
               _loc5_.y = _loc9_ - _loc5_.height;
               if(this._useSeparateBatch && _loc4_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
            }
            else if(!this._useSeparateBatch)
            {
               this._topLeftImage.visible = false;
               this._topCenterImage.visible = false;
               this._topRightImage.visible = false;
            }
            if(_loc2_ > 0)
            {
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.middleLeft;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._middleLeftImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc3_;
               _loc5_.height = _loc2_;
               _loc5_.x = _loc3_ - _loc5_.width;
               _loc5_.y = _loc9_;
               if(this._useSeparateBatch && _loc3_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
               if(_loc1_ > 0)
               {
                  if(this._useSeparateBatch)
                  {
                     _loc5_ = helperImage;
                     helperImage.texture = this._textures.middleCenter;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc5_ = this._middleCenterImage;
                     _loc5_.smoothing = this._smoothing;
                     _loc5_.color = this._color;
                     _loc5_.visible = true;
                  }
                  _loc5_.width = _loc1_;
                  _loc5_.height = _loc2_;
                  _loc5_.x = _loc3_;
                  _loc5_.y = _loc9_;
                  if(this._useSeparateBatch)
                  {
                     this._batch.addImage(helperImage);
                  }
               }
               else if(!this._useSeparateBatch)
               {
                  this._middleCenterImage.visible = false;
               }
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.middleRight;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._middleRightImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc4_;
               _loc5_.height = _loc2_;
               _loc5_.x = this._width - _loc4_;
               _loc5_.y = _loc9_;
               if(this._useSeparateBatch && _loc4_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
            }
            else if(!this._useSeparateBatch)
            {
               this._middleLeftImage.visible = false;
               this._middleCenterImage.visible = false;
               this._middleRightImage.visible = false;
            }
            if(_loc7_ > 0)
            {
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.bottomLeft;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._bottomLeftImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc3_;
               _loc5_.height = _loc7_;
               _loc5_.x = _loc3_ - _loc5_.width;
               _loc5_.y = this._height - _loc7_;
               if(this._useSeparateBatch && _loc3_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
               if(_loc1_ > 0)
               {
                  if(this._useSeparateBatch)
                  {
                     _loc5_ = helperImage;
                     helperImage.texture = this._textures.bottomCenter;
                     helperImage.readjustSize();
                  }
                  else
                  {
                     _loc5_ = this._bottomCenterImage;
                     _loc5_.smoothing = this._smoothing;
                     _loc5_.color = this._color;
                     _loc5_.visible = true;
                  }
                  _loc5_.width = _loc1_;
                  _loc5_.height = _loc7_;
                  _loc5_.x = _loc3_;
                  _loc5_.y = this._height - _loc7_;
                  if(this._useSeparateBatch)
                  {
                     this._batch.addImage(helperImage);
                  }
               }
               else if(!this._useSeparateBatch)
               {
                  this._bottomCenterImage.visible = true;
               }
               if(this._useSeparateBatch)
               {
                  _loc5_ = helperImage;
                  helperImage.texture = this._textures.bottomRight;
                  helperImage.readjustSize();
               }
               else
               {
                  _loc5_ = this._bottomRightImage;
                  _loc5_.smoothing = this._smoothing;
                  _loc5_.color = this._color;
                  _loc5_.visible = true;
               }
               _loc5_.width = _loc4_;
               _loc5_.height = _loc7_;
               _loc5_.x = this._width - _loc4_;
               _loc5_.y = this._height - _loc7_;
               if(this._useSeparateBatch && _loc4_ > 0)
               {
                  this._batch.addImage(helperImage);
               }
            }
            else if(!this._useSeparateBatch)
            {
               this._bottomLeftImage.visible = false;
               this._bottomCenterImage.visible = false;
               this._bottomRightImage.visible = false;
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
         if(this._topLeftImage)
         {
            this._topLeftImage.texture = this._textures.topLeft;
            this._topLeftImage.readjustSize();
         }
         else
         {
            this._topLeftImage = new Image(this._textures.topLeft);
            this.addChild(this._topLeftImage);
         }
         if(this._topCenterImage)
         {
            this._topCenterImage.texture = this._textures.topCenter;
            this._topCenterImage.readjustSize();
         }
         else
         {
            this._topCenterImage = new Image(this._textures.topCenter);
            this.addChild(this._topCenterImage);
         }
         if(this._topRightImage)
         {
            this._topRightImage.texture = this._textures.topRight;
            this._topRightImage.readjustSize();
         }
         else
         {
            this._topRightImage = new Image(this._textures.topRight);
            this.addChild(this._topRightImage);
         }
         if(this._middleLeftImage)
         {
            this._middleLeftImage.texture = this._textures.middleLeft;
            this._middleLeftImage.readjustSize();
         }
         else
         {
            this._middleLeftImage = new Image(this._textures.middleLeft);
            this.addChild(this._middleLeftImage);
         }
         if(this._middleCenterImage)
         {
            this._middleCenterImage.texture = this._textures.middleCenter;
            this._middleCenterImage.readjustSize();
         }
         else
         {
            this._middleCenterImage = new Image(this._textures.middleCenter);
            this.addChild(this._middleCenterImage);
         }
         if(this._middleRightImage)
         {
            this._middleRightImage.texture = this._textures.middleRight;
            this._middleRightImage.readjustSize();
         }
         else
         {
            this._middleRightImage = new Image(this._textures.middleRight);
            this.addChild(this._middleRightImage);
         }
         if(this._bottomLeftImage)
         {
            this._bottomLeftImage.texture = this._textures.bottomLeft;
            this._bottomLeftImage.readjustSize();
         }
         else
         {
            this._bottomLeftImage = new Image(this._textures.bottomLeft);
            this.addChild(this._bottomLeftImage);
         }
         if(this._bottomCenterImage)
         {
            this._bottomCenterImage.texture = this._textures.bottomCenter;
            this._bottomCenterImage.readjustSize();
         }
         else
         {
            this._bottomCenterImage = new Image(this._textures.bottomCenter);
            this.addChild(this._bottomCenterImage);
         }
         if(this._bottomRightImage)
         {
            this._bottomRightImage.texture = this._textures.bottomRight;
            this._bottomRightImage.readjustSize();
         }
         else
         {
            this._bottomRightImage = new Image(this._textures.bottomRight);
            this.addChild(this._bottomRightImage);
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
            if(this._topLeftImage)
            {
               this._topLeftImage.removeFromParent(true);
               this._topLeftImage = null;
            }
            if(this._topCenterImage)
            {
               this._topCenterImage.removeFromParent(true);
               this._topCenterImage = null;
            }
            if(this._topRightImage)
            {
               this._topRightImage.removeFromParent(true);
               this._topRightImage = null;
            }
            if(this._middleLeftImage)
            {
               this._middleLeftImage.removeFromParent(true);
               this._middleLeftImage = null;
            }
            if(this._middleCenterImage)
            {
               this._middleCenterImage.removeFromParent(true);
               this._middleCenterImage = null;
            }
            if(this._middleRightImage)
            {
               this._middleRightImage.removeFromParent(true);
               this._middleRightImage = null;
            }
            if(this._bottomLeftImage)
            {
               this._bottomLeftImage.removeFromParent(true);
               this._bottomLeftImage = null;
            }
            if(this._bottomCenterImage)
            {
               this._bottomCenterImage.removeFromParent(true);
               this._bottomCenterImage = null;
            }
            if(this._bottomRightImage)
            {
               this._bottomRightImage.removeFromParent(true);
               this._bottomRightImage = null;
            }
            this._batch.reset();
            if(!helperImage)
            {
               helperImage = new Image(this._textures.topLeft);
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

