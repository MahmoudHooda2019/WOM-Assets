package peak.component.mobile
{
   import feathers.controls.text.BitmapFontTextRenderer;
   import flash.geom.Point;
   import starling.text.BitmapChar;
   import starling.text.BitmapFont;
   
   public class MPBitmapFontTextRenderer extends BitmapFontTextRenderer
   {
      
      private static const CHARACTER_ID_SPACE:int = 32;
      
      private static const CHARACTER_ID_TAB:int = 9;
      
      private static const CHARACTER_ID_LINE_FEED:int = 10;
      
      private static const CHARACTER_ID_CARRIAGE_RETURN:int = 13;
      
      private static var CHARACTER_BUFFER:Vector.<CharLocation>;
      
      private static var CHAR_LOCATION_POOL:Vector.<CharLocation>;
      
      public function MPBitmapFontTextRenderer()
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
      
      public function get characterBatchWidth() : Number
      {
         return _characterBatch ? _characterBatch.width + _characterBatch.x : width;
      }
      
      override protected function layoutCharacters(param1:Point = null) : Point
      {
         var _loc18_:int = 0;
         var _loc7_:int = 0;
         var _loc19_:BitmapChar = null;
         var _loc5_:Number = NaN;
         var _loc23_:Boolean = false;
         var _loc21_:CharLocation = null;
         if(!param1)
         {
            param1 = new Point();
         }
         var _loc14_:BitmapFont = this.currentTextFormat.font;
         var _loc22_:Number = this.currentTextFormat.size;
         var _loc10_:Number = this.currentTextFormat.letterSpacing;
         var _loc16_:Boolean = this.currentTextFormat.isKerningEnabled;
         var _loc2_:Number = isNaN(_loc22_) ? 1 : _loc22_ / _loc14_.size;
         var _loc4_:int = 0;
         if(this.currentTextFormat is MPBitmapFontTextFormat)
         {
            _loc4_ = (this.currentTextFormat as MPBitmapFontTextFormat).lineSpacing;
         }
         var _loc3_:Number = (_loc14_.lineHeight - _loc4_) * _loc2_;
         var _loc13_:Number = !isNaN(this.explicitWidth) ? this.explicitWidth : this._maxWidth;
         var _loc12_:String = this.getTruncatedText();
         var _loc11_:Boolean = this.currentTextFormat.align != "left";
         CHARACTER_BUFFER.length = 0;
         var _loc8_:Number = 0;
         var _loc26_:Number = 0;
         var _loc25_:Number = 0;
         var _loc6_:Number = NaN;
         var _loc20_:Boolean = false;
         var _loc27_:Number = 0;
         var _loc15_:Number = 0;
         var _loc9_:int = 0;
         var _loc24_:int = 0;
         var _loc17_:int = int(_loc12_ ? _loc12_.length : 0);
         _loc18_ = 0;
         while(_loc18_ < _loc17_)
         {
            _loc20_ = false;
            _loc7_ = _loc12_.charCodeAt(_loc18_);
            if(_loc7_ == 10 || _loc7_ == 13)
            {
               _loc26_ = Math.max(0,_loc26_ - _loc10_);
               if(this._wordWrap || _loc11_)
               {
                  this.alignBuffer(_loc13_,_loc26_,0);
                  this.addBufferToBatch(0);
               }
               _loc8_ = Math.max(_loc8_,_loc26_);
               _loc6_ = NaN;
               _loc26_ = 0;
               _loc25_ += _loc3_;
               _loc27_ = 0;
               _loc15_ = 0;
               _loc9_ = 0;
               _loc24_ = 0;
            }
            else
            {
               _loc19_ = _loc14_.getChar(_loc7_);
               if(!_loc19_)
               {
                  trace("Missing character " + String.fromCharCode(_loc7_) + " in font " + _loc14_.name + ".");
               }
               else
               {
                  if(_loc16_ && !isNaN(_loc6_))
                  {
                     _loc26_ += _loc19_.getKerning(_loc6_);
                  }
                  _loc5_ = _loc19_.xAdvance * _loc2_;
                  if(this._wordWrap)
                  {
                     _loc23_ = _loc6_ == 32 || _loc6_ == 9;
                     if(_loc7_ == 32 || _loc7_ == 9)
                     {
                        if(!_loc23_)
                        {
                           _loc15_ = 0;
                        }
                        _loc15_ += _loc5_;
                     }
                     else if(_loc23_)
                     {
                        _loc27_ = _loc26_;
                        _loc9_ = 0;
                        _loc24_++;
                        _loc20_ = true;
                     }
                     if(_loc20_ && !_loc11_)
                     {
                        this.addBufferToBatch(0);
                     }
                     if(_loc24_ > 0 && _loc26_ + _loc5_ > _loc13_)
                     {
                        if(_loc11_)
                        {
                           this.trimBuffer(_loc9_);
                           this.alignBuffer(_loc13_,_loc27_ - _loc15_,_loc9_);
                           this.addBufferToBatch(_loc9_);
                        }
                        this.moveBufferedCharacters(-_loc27_,_loc3_,0);
                        _loc8_ = Math.max(_loc8_,_loc27_ - _loc15_);
                        _loc6_ = NaN;
                        _loc26_ -= _loc27_;
                        _loc25_ += _loc3_;
                        _loc27_ = 0;
                        _loc15_ = 0;
                        _loc9_ = 0;
                        _loc20_ = false;
                        _loc24_ = 0;
                     }
                  }
                  if(this._wordWrap || _loc11_)
                  {
                     _loc21_ = CHAR_LOCATION_POOL.length > 0 ? CHAR_LOCATION_POOL.shift() : new CharLocation();
                     _loc21_.char = _loc19_;
                     _loc21_.x = _loc26_ + _loc19_.xOffset * _loc2_;
                     _loc21_.y = _loc25_ + _loc19_.yOffset * _loc2_;
                     _loc21_.scale = _loc2_;
                     CHARACTER_BUFFER[CHARACTER_BUFFER.length] = _loc21_;
                     _loc9_++;
                  }
                  else
                  {
                     this.addCharacterToBatch(_loc19_,_loc26_ + _loc19_.xOffset * _loc2_,_loc25_ + _loc19_.yOffset * _loc2_,_loc2_);
                  }
                  _loc26_ += _loc5_ + _loc10_;
                  _loc6_ = _loc7_;
               }
            }
            _loc18_++;
         }
         _loc26_ = Math.max(0,_loc26_ - _loc10_);
         if(this._wordWrap || _loc11_)
         {
            this.alignBuffer(_loc13_,_loc26_,0);
            this.addBufferToBatch(0);
         }
         _loc8_ = Math.max(_loc8_,_loc26_);
         param1.x = _loc8_;
         param1.y = _loc25_ + _loc14_.lineHeight * _loc2_;
         return param1;
      }
      
      override protected function trimBuffer(param1:int) : void
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
      
      override protected function alignBuffer(param1:Number, param2:Number, param3:int) : void
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
      
      override protected function addBufferToBatch(param1:int) : void
      {
         var _loc5_:int = 0;
         var _loc3_:CharLocation = null;
         var _loc4_:int = CHARACTER_BUFFER.length - param1;
         var _loc2_:int = int(CHAR_LOCATION_POOL.length);
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = CHARACTER_BUFFER.shift();
            this.addCharacterToBatch(_loc3_.char,_loc3_.x,_loc3_.y,_loc3_.scale);
            _loc3_.char = null;
            CHAR_LOCATION_POOL[_loc2_] = _loc3_;
            _loc2_++;
            _loc5_++;
         }
      }
      
      override protected function moveBufferedCharacters(param1:Number, param2:Number, param3:int) : void
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
