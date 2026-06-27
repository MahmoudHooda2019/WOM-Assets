package starling.display.graphics
{
   import starling.textures.Texture;
   
   public class Stroke extends Graphic
   {
      
      protected static const c_degenerateUseNext:uint = 1;
      
      protected static const c_degenerateUseLast:uint = 2;
      
      protected var _line:Vector.<StrokeVertex>;
      
      protected var _numVertices:int;
      
      public function Stroke()
      {
         super();
         clear();
      }
      
      protected static function createPolyLinePreAlloc(param1:Vector.<StrokeVertex>, param2:Vector.<Number>, param3:Vector.<uint>, param4:int) : void
      {
         var _loc39_:Number = NaN;
         _loc39_ = 3.141592653589793;
         var _loc34_:int = 0;
         var _loc17_:* = 0;
         var _loc29_:* = 0;
         var _loc26_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc27_:* = 0;
         var _loc31_:* = 0;
         var _loc6_:StrokeVertex = null;
         var _loc5_:StrokeVertex = null;
         var _loc9_:StrokeVertex = null;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc45_:int = 0;
         var _loc32_:Function = Math.sqrt;
         var _loc41_:Function = Math.sin;
         var _loc33_:int = int(param1.length);
         var _loc8_:int = 0;
         var _loc40_:int = 0;
         _loc34_ = 0;
         while(_loc34_ < _loc33_)
         {
            _loc17_ = param1[_loc34_].degenerate;
            _loc29_ = uint(_loc34_);
            if(_loc17_ != 0)
            {
               _loc29_ = uint(_loc17_ == 2 ? _loc34_ - 1 : _loc34_ + 1);
            }
            _loc26_ = _loc29_ == 0 || param1[_loc29_ - 1].degenerate > 0;
            _loc24_ = _loc29_ == _loc33_ - 1 || param1[_loc29_ + 1].degenerate > 0;
            _loc27_ = uint(_loc26_ ? _loc29_ : _loc29_ - 1);
            _loc31_ = uint(_loc24_ ? _loc29_ : _loc29_ + 1);
            _loc6_ = param1[_loc27_];
            _loc5_ = param1[_loc29_];
            _loc9_ = param1[_loc31_];
            _loc35_ = _loc6_.x;
            _loc36_ = _loc6_.y;
            _loc18_ = _loc5_.x;
            _loc16_ = _loc5_.y;
            _loc37_ = _loc9_.x;
            _loc38_ = _loc9_.y;
            _loc23_ = _loc18_ - _loc35_;
            _loc22_ = _loc16_ - _loc36_;
            _loc42_ = _loc37_ - _loc18_;
            _loc44_ = _loc38_ - _loc16_;
            if(_loc24_)
            {
               _loc37_ += _loc23_;
               _loc38_ += _loc22_;
               _loc42_ = _loc37_ - _loc18_;
               _loc44_ = _loc38_ - _loc16_;
            }
            if(_loc26_)
            {
               _loc35_ -= _loc42_;
               _loc36_ -= _loc44_;
               _loc23_ = _loc18_ - _loc35_;
               _loc22_ = _loc16_ - _loc36_;
            }
            _loc14_ = _loc32_(_loc23_ * _loc23_ + _loc22_ * _loc22_);
            _loc15_ = _loc32_(_loc42_ * _loc42_ + _loc44_ * _loc44_);
            _loc20_ = _loc5_.thickness * 0.5;
            if(!(_loc26_ || _loc24_))
            {
               _loc12_ = (_loc23_ * _loc42_ + _loc22_ * _loc44_) / (_loc14_ * _loc15_);
               _loc20_ /= _loc41_((3.141592653589793 - Math.acos(_loc12_)) * 0.5);
               if(_loc20_ > _loc5_.thickness * 4)
               {
                  _loc20_ = _loc5_.thickness * 4;
               }
               if(isNaN(_loc20_))
               {
                  _loc20_ = _loc5_.thickness * 0.5;
               }
            }
            _loc19_ = -_loc22_ / _loc14_;
            _loc21_ = _loc23_ / _loc14_;
            _loc43_ = -_loc44_ / _loc15_;
            _loc46_ = _loc42_ / _loc15_;
            _loc25_ = _loc19_ + _loc43_;
            _loc28_ = _loc21_ + _loc46_;
            _loc30_ = 1 / _loc32_(_loc25_ * _loc25_ + _loc28_ * _loc28_) * _loc20_;
            _loc25_ *= _loc30_;
            _loc28_ *= _loc30_;
            _loc11_ = _loc18_ + _loc25_;
            _loc10_ = _loc16_ + _loc28_;
            _loc13_ = _loc17_ ? _loc11_ : _loc18_ - _loc25_;
            _loc7_ = _loc17_ ? _loc10_ : _loc16_ - _loc28_;
            param2[_loc8_++] = _loc11_;
            param2[_loc8_++] = _loc10_;
            param2[_loc8_++] = 0;
            param2[_loc8_++] = _loc5_.r2;
            param2[_loc8_++] = _loc5_.g2;
            param2[_loc8_++] = _loc5_.b2;
            param2[_loc8_++] = _loc5_.a2;
            param2[_loc8_++] = _loc5_.u;
            param2[_loc8_++] = 1;
            param2[_loc8_++] = _loc13_;
            param2[_loc8_++] = _loc7_;
            param2[_loc8_++] = 0;
            param2[_loc8_++] = _loc5_.r1;
            param2[_loc8_++] = _loc5_.g1;
            param2[_loc8_++] = _loc5_.b1;
            param2[_loc8_++] = _loc5_.a1;
            param2[_loc8_++] = _loc5_.u;
            param2[_loc8_++] = 0;
            if(_loc34_ < _loc33_ - 1)
            {
               _loc45_ = param4 + (_loc34_ << 1);
               param3[_loc40_++] = _loc45_;
               param3[_loc40_++] = _loc45_ + 2;
               param3[_loc40_++] = _loc45_ + 1;
               param3[_loc40_++] = _loc45_ + 1;
               param3[_loc40_++] = _loc45_ + 2;
               param3[_loc40_++] = _loc45_ + 3;
            }
            _loc34_++;
         }
      }
      
      protected static function createPolyLine(param1:Vector.<StrokeVertex>, param2:Vector.<Number>, param3:Vector.<uint>, param4:int) : void
      {
         var _loc37_:Number = NaN;
         _loc37_ = 3.141592653589793;
         var _loc33_:int = 0;
         var _loc16_:* = 0;
         var _loc28_:* = 0;
         var _loc25_:Boolean = false;
         var _loc23_:Boolean = false;
         var _loc26_:* = 0;
         var _loc30_:* = 0;
         var _loc6_:StrokeVertex = null;
         var _loc5_:StrokeVertex = null;
         var _loc8_:StrokeVertex = null;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc43_:int = 0;
         var _loc31_:Function = Math.sqrt;
         var _loc39_:Function = Math.sin;
         var _loc32_:int = int(param1.length);
         _loc33_ = 0;
         while(_loc33_ < _loc32_)
         {
            _loc16_ = param1[_loc33_].degenerate;
            _loc28_ = uint(_loc33_);
            if(_loc16_ != 0)
            {
               _loc28_ = uint(_loc16_ == 2 ? _loc33_ - 1 : _loc33_ + 1);
            }
            _loc25_ = _loc28_ == 0 || param1[_loc28_ - 1].degenerate > 0;
            _loc23_ = _loc28_ == _loc32_ - 1 || param1[_loc28_ + 1].degenerate > 0;
            _loc26_ = uint(_loc25_ ? _loc28_ : _loc28_ - 1);
            _loc30_ = uint(_loc23_ ? _loc28_ : _loc28_ + 1);
            _loc6_ = param1[_loc26_];
            _loc5_ = param1[_loc28_];
            _loc8_ = param1[_loc30_];
            _loc34_ = _loc6_.x;
            _loc35_ = _loc6_.y;
            _loc17_ = _loc5_.x;
            _loc15_ = _loc5_.y;
            _loc36_ = _loc8_.x;
            _loc38_ = _loc8_.y;
            _loc22_ = _loc17_ - _loc34_;
            _loc21_ = _loc15_ - _loc35_;
            _loc40_ = _loc36_ - _loc17_;
            _loc42_ = _loc38_ - _loc15_;
            if(_loc23_)
            {
               _loc36_ += _loc22_;
               _loc38_ += _loc21_;
               _loc40_ = _loc36_ - _loc17_;
               _loc42_ = _loc38_ - _loc15_;
            }
            if(_loc25_)
            {
               _loc34_ -= _loc40_;
               _loc35_ -= _loc42_;
               _loc22_ = _loc17_ - _loc34_;
               _loc21_ = _loc15_ - _loc35_;
            }
            _loc13_ = _loc31_(_loc22_ * _loc22_ + _loc21_ * _loc21_);
            _loc14_ = _loc31_(_loc40_ * _loc40_ + _loc42_ * _loc42_);
            _loc19_ = _loc5_.thickness * 0.5;
            if(!(_loc25_ || _loc23_))
            {
               _loc11_ = (_loc22_ * _loc40_ + _loc21_ * _loc42_) / (_loc13_ * _loc14_);
               _loc19_ /= _loc39_((3.141592653589793 - Math.acos(_loc11_)) * 0.5);
               if(_loc19_ > _loc5_.thickness * 4)
               {
                  _loc19_ = _loc5_.thickness * 4;
               }
               if(isNaN(_loc19_))
               {
                  _loc19_ = _loc5_.thickness * 0.5;
               }
            }
            _loc18_ = -_loc21_ / _loc13_;
            _loc20_ = _loc22_ / _loc13_;
            _loc41_ = -_loc42_ / _loc14_;
            _loc44_ = _loc40_ / _loc14_;
            _loc24_ = _loc18_ + _loc41_;
            _loc27_ = _loc20_ + _loc44_;
            _loc29_ = 1 / _loc31_(_loc24_ * _loc24_ + _loc27_ * _loc27_) * _loc19_;
            _loc24_ *= _loc29_;
            _loc27_ *= _loc29_;
            _loc10_ = _loc17_ + _loc24_;
            _loc9_ = _loc15_ + _loc27_;
            _loc12_ = _loc16_ ? _loc10_ : _loc17_ - _loc24_;
            _loc7_ = _loc16_ ? _loc9_ : _loc15_ - _loc27_;
            param2.push(_loc10_,_loc9_,0,_loc5_.r2,_loc5_.g2,_loc5_.b2,_loc5_.a2,_loc5_.u,1,_loc12_,_loc7_,0,_loc5_.r1,_loc5_.g1,_loc5_.b1,_loc5_.a1,_loc5_.u,0);
            if(_loc33_ < _loc32_ - 1)
            {
               _loc43_ = param4 + (_loc33_ << 1);
               param3.push(_loc43_,_loc43_ + 2,_loc43_ + 1,_loc43_ + 1,_loc43_ + 2,_loc43_ + 3);
            }
            _loc33_++;
         }
      }
      
      protected static function fixUpPolyLine(param1:Vector.<StrokeVertex>) : void
      {
         if(param1.length > 0 && param1[0].degenerate > 0)
         {
            throw new Error("Degenerate on first line vertex");
         }
         var _loc2_:int = param1.length - 1;
         while(_loc2_ > 0 && param1[_loc2_].degenerate > 0)
         {
            param1.pop();
            _loc2_--;
         }
      }
      
      public function get numVertices() : int
      {
         return _numVertices;
      }
      
      override public function dispose() : void
      {
         clear();
         super.dispose();
      }
      
      public function clear() : void
      {
         if(minBounds)
         {
            minBounds.x = minBounds.y = Infinity;
            maxBounds.x = maxBounds.y = -Infinity;
         }
         if(_line)
         {
            StrokeVertex.returnInstances(_line);
         }
         _line = new Vector.<StrokeVertex>();
         _numVertices = 0;
         isInvalid = true;
      }
      
      public function addDegenerates(param1:Number, param2:Number) : void
      {
         if(_numVertices < 1)
         {
            return;
         }
         var _loc3_:StrokeVertex = _line[_numVertices - 1];
         addVertex(_loc3_.x,_loc3_.y,0);
         setLastVertexAsDegenerate(2);
         addVertex(param1,param2,0);
         setLastVertexAsDegenerate(1);
      }
      
      protected function setLastVertexAsDegenerate(param1:uint) : void
      {
         _line[_numVertices - 1].degenerate = param1;
         _line[_numVertices - 1].u = 0;
      }
      
      public function addVertex(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1, param6:uint = 16777215, param7:Number = 1) : void
      {
         var _loc20_:StrokeVertex = null;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc13_:Number = 0;
         var _loc11_:Vector.<Texture> = _material.textures;
         if(_line.length > 0 && _loc11_.length > 0)
         {
            _loc20_ = _line[_line.length - 1];
            _loc9_ = param1 - _loc20_.x;
            _loc10_ = param2 - _loc20_.y;
            _loc8_ = Math.sqrt(_loc9_ * _loc9_ + _loc10_ * _loc10_);
            _loc13_ = _loc20_.u + _loc8_ / _loc11_[0].width;
         }
         var _loc18_:Number = (param4 >> 16) / 255;
         var _loc17_:Number = ((param4 & 0xFF00) >> 8) / 255;
         var _loc14_:Number = (param4 & 0xFF) / 255;
         var _loc19_:Number = (param6 >> 16) / 255;
         var _loc16_:Number = ((param6 & 0xFF00) >> 8) / 255;
         var _loc15_:Number = (param6 & 0xFF) / 255;
         var _loc12_:StrokeVertex = _line[_numVertices] = StrokeVertex.getInstance();
         _loc12_.x = param1;
         _loc12_.y = param2;
         _loc12_.r1 = _loc18_;
         _loc12_.g1 = _loc17_;
         _loc12_.b1 = _loc14_;
         _loc12_.a1 = param5;
         _loc12_.r2 = _loc19_;
         _loc12_.g2 = _loc16_;
         _loc12_.b2 = _loc15_;
         _loc12_.a2 = param7;
         _loc12_.u = _loc13_;
         _loc12_.v = 0;
         _loc12_.thickness = param3;
         _loc12_.degenerate = 0;
         _numVertices = _numVertices + 1;
         if(param1 < minBounds.x)
         {
            minBounds.x = param1;
         }
         else if(param1 > maxBounds.x)
         {
            maxBounds.x = param1;
         }
         if(param2 < minBounds.y)
         {
            minBounds.y = param2;
         }
         else if(param2 > maxBounds.y)
         {
            maxBounds.y = param2;
         }
         if(maxBounds.x == -Infinity)
         {
            maxBounds.x = param1;
         }
         if(maxBounds.y == -Infinity)
         {
            maxBounds.y = param2;
         }
         isInvalid = true;
      }
      
      override protected function buildGeometry() : void
      {
         buildGeometryPreAllocatedVectors();
      }
      
      protected function buildGeometryOriginal() : void
      {
         var _loc3_:Number = NaN;
         _loc3_ = 0.1111111111111111;
         if(_line == null || _line.length == 0)
         {
            return;
         }
         vertices = new Vector.<Number>();
         indices = new Vector.<uint>();
         var _loc1_:int = 0;
         var _loc2_:int = int(vertices.length);
         fixUpPolyLine(_line);
         createPolyLine(_line,vertices,indices,_loc1_);
         _loc1_ += (vertices.length - _loc2_) * 0.1111111111111111;
      }
      
      protected function buildGeometryPreAllocatedVectors() : void
      {
         var _loc5_:Number = NaN;
         _loc5_ = 0.1111111111111111;
         if(_line == null || _line.length == 0)
         {
            return;
         }
         var _loc3_:int = 0;
         fixUpPolyLine(_line);
         var _loc2_:int = _line.length * 18;
         var _loc1_:int = (_line.length - 1) * 6;
         vertices = new Vector.<Number>(_loc2_,true);
         indices = new Vector.<uint>(_loc1_,true);
         createPolyLinePreAlloc(_line,vertices,indices,_loc3_);
         var _loc4_:int = 0;
         _loc3_ += (vertices.length - _loc4_) * 0.1111111111111111;
      }
   }
}

