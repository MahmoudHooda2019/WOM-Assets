package feathers.controls.text
{
   import feathers.core.FeathersControl;
   import feathers.core.ITextRenderer;
   import feathers.text.BitmapFontTextFormat;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.core.RenderSupport;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.text.BitmapChar;
   import starling.text.BitmapFont;
   import starling.textures.Texture;
   
   public class BitmapFontTextRenderer extends FeathersControl implements ITextRenderer
   {
      
      private static var HELPER_IMAGE:Image;
      
      private static const CHARACTER_ID_SPACE:int = 32;
      
      private static const CHARACTER_ID_TAB:int = 9;
      
      private static const CHARACTER_ID_LINE_FEED:int = 10;
      
      private static const CHARACTER_ID_CARRIAGE_RETURN:int = 13;
      
      private static var CHARACTER_BUFFER:Vector.<CharLocation>;
      
      private static var CHAR_LOCATION_POOL:Vector.<CharLocation>;
      
      private static const HELPER_MATRIX:Matrix = new Matrix();
      
      private static const HELPER_POINT:Point = new Point();
      
      protected var _characterBatch:QuadBatch;
      
      protected var _locations:Vector.<CharLocation>;
      
      protected var _images:Vector.<Image>;
      
      protected var _imagesCache:Vector.<Image>;
      
      protected var currentTextFormat:BitmapFontTextFormat;
      
      protected var _textFormat:BitmapFontTextFormat;
      
      protected var _disabledTextFormat:BitmapFontTextFormat;
      
      protected var _text:String = null;
      
      protected var _smoothing:String = "bilinear";
      
      protected var _wordWrap:Boolean = false;
      
      protected var _snapToPixels:Boolean = true;
      
      protected var _truncationText:String = "...";
      
      protected var _useSeparateBatch:Boolean = true;
      
      public function BitmapFontTextRenderer()
      {
         super();
         if(!CHAR_LOCATION_POOL)
         {
            CHAR_LOCATION_POOL = new Vector.<CharLocation>(0);
         }
         if(!CHARACTER_BUFFER)
         {
            CHARACTER_BUFFER = new Vector.<CharLocation>(0);
         }
         this.isQuickHitAreaEnabled = true;
      }
      
      public function get textFormat() : BitmapFontTextFormat
      {
         return this._textFormat;
      }
      
      public function set textFormat(param1:BitmapFontTextFormat) : void
      {
         if(this._textFormat == param1)
         {
            return;
         }
         this._textFormat = param1;
         this.invalidate("styles");
      }
      
      public function get disabledTextFormat() : BitmapFontTextFormat
      {
         return this._disabledTextFormat;
      }
      
      public function set disabledTextFormat(param1:BitmapFontTextFormat) : void
      {
         if(this._disabledTextFormat == param1)
         {
            return;
         }
         this._disabledTextFormat = param1;
         this.invalidate("styles");
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.invalidate("data");
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
         this.invalidate("styles");
      }
      
      public function get wordWrap() : Boolean
      {
         return _wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         if(this._wordWrap == param1)
         {
            return;
         }
         this._wordWrap = param1;
         this.invalidate("styles");
      }
      
      public function get snapToPixels() : Boolean
      {
         return _snapToPixels;
      }
      
      public function set snapToPixels(param1:Boolean) : void
      {
         if(this._snapToPixels == param1)
         {
            return;
         }
         this._snapToPixels = param1;
         this.invalidate("styles");
      }
      
      public function get truncationText() : String
      {
         return _truncationText;
      }
      
      public function set truncationText(param1:String) : void
      {
         if(this._truncationText == param1)
         {
            return;
         }
         this._truncationText = param1;
         this.invalidate("data");
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
         this.invalidate("styles");
      }
      
      public function get baseline() : Number
      {
         if(!this._textFormat)
         {
            return 0;
         }
         var _loc2_:BitmapFont = this._textFormat.font;
         var _loc3_:Number = this._textFormat.size;
         var _loc1_:Number = isNaN(_loc3_) ? 1 : _loc3_ / _loc2_.size;
         if(isNaN(_loc2_.baseline))
         {
            return _loc2_.lineHeight * _loc1_;
         }
         return _loc2_.baseline * _loc1_;
      }
      
      override public function dispose() : void
      {
         this.moveLocationsToPool();
         super.dispose();
      }
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:CharLocation = null;
         var _loc6_:Image = null;
         var _loc5_:Number = 0;
         var _loc4_:Number = 0;
         if(this._snapToPixels)
         {
            this.getTransformationMatrix(this.stage,HELPER_MATRIX);
            _loc5_ = Math.round(HELPER_MATRIX.tx) - HELPER_MATRIX.tx;
            _loc4_ = Math.round(HELPER_MATRIX.ty) - HELPER_MATRIX.ty;
         }
         if(this._locations)
         {
            _loc7_ = int(this._locations.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc3_ = this._locations[_loc8_];
               _loc6_ = this._images[_loc8_];
               _loc6_.x = _loc5_ + _loc3_.x;
               _loc6_.y = _loc4_ + _loc3_.y;
               _loc8_++;
            }
         }
         else if(this._characterBatch)
         {
            this._characterBatch.x = _loc5_;
            this._characterBatch.y = _loc4_;
         }
         super.render(param1,param2);
      }
      
      public function measureText(param1:Point = null) : Point
      {
         var _loc14_:int = 0;
         var _loc8_:int = 0;
         var _loc15_:BitmapChar = null;
         var _loc5_:Number = NaN;
         var _loc17_:Boolean = false;
         if(this.isInvalid("styles") || this.isInvalid("state"))
         {
            this.refreshTextFormat();
         }
         if(!param1)
         {
            param1 = new Point();
         }
         else
         {
            param1.x = param1.y = 0;
         }
         if(!this.currentTextFormat || !this._text)
         {
            return param1;
         }
         var _loc7_:BitmapFont = this.currentTextFormat.font;
         var _loc16_:Number = this.currentTextFormat.size;
         var _loc20_:Number = this.currentTextFormat.letterSpacing;
         var _loc13_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc2_:Number = isNaN(_loc16_) ? 1 : _loc16_ / _loc7_.size;
         var _loc3_:Number = _loc7_.lineHeight * _loc2_;
         var _loc4_:Number = !isNaN(this.explicitWidth) ? this.explicitWidth : this._maxWidth;
         var _loc23_:Boolean = this.currentTextFormat.align != "left";
         var _loc11_:Number = 0;
         var _loc22_:Number = 0;
         var _loc21_:Number = 0;
         var _loc6_:Number = NaN;
         var _loc12_:int = this._text.length;
         var _loc24_:Number = 0;
         var _loc10_:Number = 0;
         var _loc19_:int = 0;
         var _loc9_:String = "";
         var _loc18_:String = "";
         _loc14_ = 0;
         while(_loc14_ < _loc12_)
         {
            _loc8_ = this._text.charCodeAt(_loc14_);
            if(_loc8_ == 10 || _loc8_ == 13)
            {
               _loc22_ = Math.max(0,_loc22_ - _loc20_);
               _loc11_ = Math.max(_loc11_,_loc22_);
               _loc6_ = NaN;
               _loc22_ = 0;
               _loc21_ += _loc3_;
               _loc24_ = 0;
               _loc19_ = 0;
               _loc10_ = 0;
            }
            else
            {
               _loc15_ = _loc7_.getChar(_loc8_);
               if(!_loc15_)
               {
                  trace("Missing character " + String.fromCharCode(_loc8_) + " in font " + _loc7_.name + ".");
               }
               else
               {
                  if(_loc13_ && !isNaN(_loc6_))
                  {
                     _loc22_ += _loc15_.getKerning(_loc6_);
                  }
                  _loc5_ = _loc15_.xAdvance * _loc2_;
                  if(this._wordWrap)
                  {
                     _loc17_ = _loc6_ == 32 || _loc6_ == 9;
                     if(_loc8_ == 32 || _loc8_ == 9)
                     {
                        if(!_loc17_)
                        {
                           _loc10_ = 0;
                        }
                        _loc10_ += _loc5_;
                     }
                     else if(_loc17_)
                     {
                        _loc24_ = _loc22_;
                        _loc19_++;
                        _loc9_ += _loc18_;
                        _loc18_ = "";
                     }
                     if(_loc19_ > 0 && _loc22_ + _loc5_ > _loc4_)
                     {
                        _loc11_ = Math.max(_loc11_,_loc24_ - _loc10_);
                        _loc6_ = NaN;
                        _loc22_ -= _loc24_;
                        _loc21_ += _loc3_;
                        _loc24_ = 0;
                        _loc10_ = 0;
                        _loc19_ = 0;
                        _loc9_ = "";
                     }
                  }
                  _loc22_ += _loc5_ + _loc20_;
                  _loc6_ = _loc8_;
                  _loc18_ += String.fromCharCode(_loc8_);
               }
            }
            _loc14_++;
         }
         _loc22_ = Math.max(0,_loc22_ - _loc20_);
         _loc11_ = Math.max(_loc11_,_loc22_);
         param1.x = _loc11_;
         param1.y = _loc21_ + _loc7_.lineHeight * _loc2_;
         return param1;
      }
      
      override protected function draw() : void
      {
         var _loc2_:Boolean = this.isInvalid("data");
         var _loc4_:Boolean = this.isInvalid("styles");
         var _loc1_:Boolean = this.isInvalid("size");
         var _loc3_:Boolean = this.isInvalid("state");
         if(_loc4_ || _loc3_)
         {
            this.refreshTextFormat();
         }
         if(_loc2_ || _loc4_ || _loc1_)
         {
            this.refreshBatching();
            if(!this.currentTextFormat || !this._text)
            {
               this.setSizeInternal(0,0,false);
               return;
            }
            this.layoutCharacters(HELPER_POINT);
            this.setSizeInternal(HELPER_POINT.x,HELPER_POINT.y,false);
         }
      }
      
      protected function refreshBatching() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:Image = null;
         this.moveLocationsToPool();
         if(this._useSeparateBatch)
         {
            if(!this._characterBatch)
            {
               this._characterBatch = new QuadBatch();
               this._characterBatch.touchable = false;
               this.addChild(this._characterBatch);
            }
            this._characterBatch.reset();
            this._locations = null;
            if(this._images)
            {
               _loc1_ = int(this._images.length);
               _loc3_ = 0;
               while(_loc3_ < _loc1_)
               {
                  _loc2_ = this._images[_loc3_];
                  _loc2_.removeFromParent(true);
                  _loc3_++;
               }
            }
            this._images = null;
            this._imagesCache = null;
         }
         else
         {
            if(this._characterBatch)
            {
               this._characterBatch.removeFromParent(true);
               this._characterBatch = null;
            }
            if(!this._locations)
            {
               this._locations = new Vector.<CharLocation>(0);
            }
            if(!this._images)
            {
               this._images = new Vector.<Image>(0);
            }
            if(!this._imagesCache)
            {
               this._imagesCache = new Vector.<Image>(0);
            }
         }
      }
      
      protected function layoutCharacters(param1:Point = null) : Point
      {
         var _loc25_:* = undefined;
         var _loc19_:int = 0;
         var _loc7_:int = 0;
         var _loc20_:BitmapChar = null;
         var _loc4_:Number = NaN;
         var _loc24_:Boolean = false;
         var _loc22_:CharLocation = null;
         var _loc6_:int = 0;
         var _loc15_:Image = null;
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc14_:BitmapFont = this.currentTextFormat.font;
         var _loc23_:Number = this.currentTextFormat.size;
         var _loc10_:Number = this.currentTextFormat.letterSpacing;
         var _loc17_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc2_:Number = isNaN(_loc23_) ? 1 : _loc23_ / _loc14_.size;
         var _loc3_:Number = _loc14_.lineHeight * _loc2_;
         var _loc13_:Number = !isNaN(this.explicitWidth) ? this.explicitWidth : this._maxWidth;
         var _loc12_:String = this.getTruncatedText();
         var _loc11_:Boolean = this.currentTextFormat.align != "left";
         CHARACTER_BUFFER.length = 0;
         if(!this._useSeparateBatch)
         {
            _loc25_ = this._imagesCache;
            this._imagesCache = this._images;
            this._images = _loc25_;
         }
         var _loc8_:Number = 0;
         var _loc28_:Number = 0;
         var _loc27_:Number = 0;
         var _loc5_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc29_:Number = 0;
         var _loc16_:Number = 0;
         var _loc9_:int = 0;
         var _loc26_:int = 0;
         var _loc18_:int = int(_loc12_ ? _loc12_.length : 0);
         _loc19_ = 0;
         while(_loc19_ < _loc18_)
         {
            _loc21_ = false;
            _loc7_ = _loc12_.charCodeAt(_loc19_);
            if(_loc7_ == 10 || _loc7_ == 13)
            {
               _loc28_ = Math.max(0,_loc28_ - _loc10_);
               if(this._wordWrap || _loc11_)
               {
                  this.alignBuffer(_loc13_,_loc28_,0);
                  this.addBufferToBatch(0);
               }
               _loc8_ = Math.max(_loc8_,_loc28_);
               _loc5_ = NaN;
               _loc28_ = 0;
               _loc27_ += _loc3_;
               _loc29_ = 0;
               _loc16_ = 0;
               _loc9_ = 0;
               _loc26_ = 0;
            }
            else
            {
               _loc20_ = _loc14_.getChar(_loc7_);
               if(!_loc20_)
               {
                  trace("Missing character " + String.fromCharCode(_loc7_) + " in font " + _loc14_.name + ".");
               }
               else
               {
                  if(_loc17_ && !isNaN(_loc5_))
                  {
                     _loc28_ += _loc20_.getKerning(_loc5_);
                  }
                  _loc4_ = _loc20_.xAdvance * _loc2_;
                  if(this._wordWrap)
                  {
                     _loc24_ = _loc5_ == 32 || _loc5_ == 9;
                     if(_loc7_ == 32 || _loc7_ == 9)
                     {
                        if(!_loc24_)
                        {
                           _loc16_ = 0;
                        }
                        _loc16_ += _loc4_;
                     }
                     else if(_loc24_)
                     {
                        _loc29_ = _loc28_;
                        _loc9_ = 0;
                        _loc26_++;
                        _loc21_ = true;
                     }
                     if(_loc21_ && !_loc11_)
                     {
                        this.addBufferToBatch(0);
                     }
                     if(_loc26_ > 0 && _loc28_ + _loc4_ > _loc13_)
                     {
                        if(_loc11_)
                        {
                           this.trimBuffer(_loc9_);
                           this.alignBuffer(_loc13_,_loc29_ - _loc16_,_loc9_);
                           this.addBufferToBatch(_loc9_);
                        }
                        this.moveBufferedCharacters(-_loc29_,_loc3_,0);
                        _loc8_ = Math.max(_loc8_,_loc29_ - _loc16_);
                        _loc5_ = NaN;
                        _loc28_ -= _loc29_;
                        _loc27_ += _loc3_;
                        _loc29_ = 0;
                        _loc16_ = 0;
                        _loc9_ = 0;
                        _loc21_ = false;
                        _loc26_ = 0;
                     }
                  }
                  if(this._wordWrap || _loc11_ || !this._useSeparateBatch)
                  {
                     _loc22_ = CHAR_LOCATION_POOL.length > 0 ? CHAR_LOCATION_POOL.shift() : new CharLocation();
                     _loc22_.char = _loc20_;
                     _loc22_.x = _loc28_ + _loc20_.xOffset * _loc2_;
                     _loc22_.y = _loc27_ + _loc20_.yOffset * _loc2_;
                     _loc22_.scale = _loc2_;
                     if(this._wordWrap || _loc11_)
                     {
                        CHARACTER_BUFFER.push(_loc22_);
                        _loc9_++;
                     }
                     else
                     {
                        this.addLocation(_loc22_);
                     }
                  }
                  else
                  {
                     this.addCharacterToBatch(_loc20_,_loc28_ + _loc20_.xOffset * _loc2_,_loc27_ + _loc20_.yOffset * _loc2_,_loc2_);
                  }
                  _loc28_ += _loc4_ + _loc10_;
                  _loc5_ = _loc7_;
               }
            }
            _loc19_++;
         }
         _loc28_ = Math.max(0,_loc28_ - _loc10_);
         if(this._wordWrap || _loc11_)
         {
            this.alignBuffer(_loc13_,_loc28_,0);
            this.addBufferToBatch(0);
         }
         _loc8_ = Math.max(_loc8_,_loc28_);
         if(!this._useSeparateBatch)
         {
            _loc6_ = int(this._imagesCache.length);
            _loc19_ = 0;
            while(_loc19_ < _loc6_)
            {
               _loc15_ = this._imagesCache.shift();
               _loc15_.removeFromParent(true);
               _loc19_++;
            }
         }
         param1.x = _loc8_;
         param1.y = _loc27_ + _loc14_.lineHeight * _loc2_;
         return param1;
      }
      
      protected function trimBuffer(param1:int) : void
      {
         var _loc7_:int = 0;
         var _loc4_:CharLocation = null;
         var _loc2_:BitmapChar = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:int = CHARACTER_BUFFER.length - param1;
         _loc7_ = _loc6_ - 1;
         while(_loc7_ >= 0)
         {
            _loc4_ = CHARACTER_BUFFER[_loc7_];
            _loc2_ = _loc4_.char;
            _loc5_ = _loc2_.charID;
            if(!(_loc5_ == 32 || _loc5_ == 9))
            {
               break;
            }
            _loc3_++;
            _loc7_--;
         }
         if(_loc3_ > 0)
         {
            CHARACTER_BUFFER.splice(_loc7_ + 1,_loc3_);
         }
      }
      
      protected function alignBuffer(param1:Number, param2:Number, param3:int) : void
      {
         var _loc4_:String = this.currentTextFormat.align;
         if(_loc4_ == "center")
         {
            this.moveBufferedCharacters((param1 - param2) / 2,0,param3);
         }
         else if(_loc4_ == "right")
         {
            this.moveBufferedCharacters(param1 - param2,0,param3);
         }
      }
      
      protected function addBufferToBatch(param1:int) : void
      {
         var _loc4_:int = 0;
         var _loc2_:CharLocation = null;
         var _loc3_:int = CHARACTER_BUFFER.length - param1;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = CHARACTER_BUFFER.shift();
            if(this._useSeparateBatch)
            {
               this.addCharacterToBatch(_loc2_.char,_loc2_.x,_loc2_.y,_loc2_.scale);
               _loc2_.char = null;
               CHAR_LOCATION_POOL.push(_loc2_);
            }
            else
            {
               this.addLocation(_loc2_);
            }
            _loc4_++;
         }
      }
      
      protected function addLocation(param1:CharLocation) : void
      {
         var _loc4_:Image = null;
         var _loc2_:BitmapChar = param1.char;
         var _loc3_:Texture = _loc2_.texture;
         if(this._imagesCache.length > 0)
         {
            _loc4_ = this._imagesCache.shift();
            _loc4_.texture = _loc3_;
            _loc4_.readjustSize();
         }
         else
         {
            _loc4_ = new Image(_loc3_);
            this.addChild(_loc4_);
         }
         _loc4_.scaleX = _loc4_.scaleY = param1.scale;
         _loc4_.smoothing = this._smoothing;
         _loc4_.color = this.currentTextFormat.color;
         this._images.push(_loc4_);
         this._locations.push(param1);
      }
      
      protected function moveBufferedCharacters(param1:Number, param2:Number, param3:int) : void
      {
         var _loc6_:int = 0;
         var _loc4_:CharLocation = null;
         var _loc5_:int = CHARACTER_BUFFER.length - param3;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = CHARACTER_BUFFER[_loc6_];
            _loc4_.x = _loc4_.x + param1;
            _loc4_.y += param2;
            _loc6_++;
         }
      }
      
      protected function addCharacterToBatch(param1:BitmapChar, param2:Number, param3:Number, param4:Number, param5:RenderSupport = null, param6:Number = 1) : void
      {
         if(!HELPER_IMAGE)
         {
            HELPER_IMAGE = new Image(param1.texture);
         }
         else
         {
            HELPER_IMAGE.texture = param1.texture;
            HELPER_IMAGE.readjustSize();
         }
         HELPER_IMAGE.scaleX = HELPER_IMAGE.scaleY = param4;
         HELPER_IMAGE.x = param2;
         HELPER_IMAGE.y = param3;
         HELPER_IMAGE.color = this.currentTextFormat.color;
         HELPER_IMAGE.smoothing = this._smoothing;
         if(param5)
         {
            param5.pushMatrix();
            param5.transformMatrix(HELPER_IMAGE);
            param5.batchQuad(HELPER_IMAGE,param6,HELPER_IMAGE.texture,this._smoothing);
            param5.popMatrix();
         }
         else
         {
            this._characterBatch.addImage(HELPER_IMAGE);
         }
      }
      
      protected function refreshTextFormat() : void
      {
         if(!this._isEnabled && this._disabledTextFormat)
         {
            this.currentTextFormat = this._disabledTextFormat;
         }
         else
         {
            this.currentTextFormat = this._textFormat;
         }
      }
      
      protected function getTruncatedText() : String
      {
         var _loc8_:* = 0;
         var _loc5_:int = 0;
         var _loc9_:BitmapChar = null;
         var _loc2_:Number = NaN;
         if(!this._text)
         {
            return "";
         }
         if(this._maxWidth == Infinity || this._wordWrap || this._text.indexOf(String.fromCharCode(10)) >= 0 || this._text.indexOf(String.fromCharCode(13)) >= 0)
         {
            return this._text;
         }
         var _loc3_:BitmapFont = this.currentTextFormat.font;
         var _loc11_:Number = this.currentTextFormat.size;
         var _loc12_:Number = this.currentTextFormat.letterSpacing;
         var _loc6_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc1_:Number = isNaN(_loc11_) ? 1 : _loc11_ / _loc3_.size;
         var _loc13_:Number = 0;
         var _loc4_:Number = NaN;
         var _loc7_:int = this._text.length;
         var _loc10_:* = -1;
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc5_ = this._text.charCodeAt(_loc8_);
            _loc9_ = _loc3_.getChar(_loc5_);
            if(_loc9_)
            {
               _loc2_ = 0;
               if(_loc6_ && !isNaN(_loc4_))
               {
                  _loc2_ = _loc9_.getKerning(_loc4_);
               }
               _loc13_ += _loc2_ + _loc9_.xAdvance * _loc1_;
               if(_loc13_ > this._maxWidth)
               {
                  _loc10_ = _loc8_;
                  break;
               }
               _loc13_ += _loc12_;
               _loc4_ = _loc5_;
            }
            _loc8_++;
         }
         if(_loc10_ >= 0)
         {
            _loc7_ = this._truncationText.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc5_ = this._truncationText.charCodeAt(_loc8_);
               _loc9_ = _loc3_.getChar(_loc5_);
               if(_loc9_)
               {
                  _loc2_ = 0;
                  if(_loc6_ && !isNaN(_loc4_))
                  {
                     _loc2_ = _loc9_.getKerning(_loc4_);
                  }
                  _loc13_ += _loc2_ + _loc9_.xAdvance * _loc1_ + _loc12_;
                  _loc4_ = _loc5_;
               }
               _loc8_++;
            }
            _loc13_ -= _loc12_;
            _loc8_ = _loc10_;
            while(_loc8_ >= 0)
            {
               _loc5_ = this._text.charCodeAt(_loc8_);
               _loc4_ = _loc8_ > 0 ? this._text.charCodeAt(_loc8_ - 1) : NaN;
               _loc9_ = _loc3_.getChar(_loc5_);
               if(_loc9_)
               {
                  _loc2_ = 0;
                  if(_loc6_ && !isNaN(_loc4_))
                  {
                     _loc2_ = _loc9_.getKerning(_loc4_);
                  }
                  _loc13_ -= _loc2_ + _loc9_.xAdvance * _loc1_ + _loc12_;
                  if(_loc13_ <= this._maxWidth)
                  {
                     return this._text.substr(0,_loc8_) + this._truncationText;
                  }
               }
               _loc8_--;
            }
            return this._truncationText;
         }
         return this._text;
      }
      
      protected function moveLocationsToPool() : void
      {
         var _loc3_:int = 0;
         var _loc1_:CharLocation = null;
         if(!this._locations)
         {
            return;
         }
         var _loc2_:int = int(this._locations.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = this._locations.shift();
            _loc1_.char = null;
            CHAR_LOCATION_POOL.push(_loc1_);
            _loc3_++;
         }
      }
   }
}

import starling.text.BitmapChar;

class CharLocation
{
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   public function CharLocation()
   {
      super();
   }
}
