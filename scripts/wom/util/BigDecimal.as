package wom.util
{
   public class BigDecimal
   {
      
      private static const ispos:int = 1;
      
      private static const iszero:int = 0;
      
      private static const isneg:int = -1;
      
      private static const MinExp:int = -999999999;
      
      private static const MaxExp:int = 999999999;
      
      private static const MinArg:int = -999999999;
      
      private static const MaxArg:int = 999999999;
      
      public static const ZERO:BigDecimal = BigDecimal.createStatic(0);
      
      public static const ONE:BigDecimal = BigDecimal.createStatic(1);
      
      public static const TEN:BigDecimal = BigDecimal.createStatic(10);
      
      private static const VALUE_ZERO:int = new String("0").charCodeAt(0);
      
      private static const VALUE_NINE:int = new String("9").charCodeAt(0);
      
      private static const VALUE_EUPPER:int = new String("e").charCodeAt(0);
      
      private static const VALUE_ELOWER:int = new String("E").charCodeAt(0);
      
      private static const VALUE_DOT:int = new String(".").charCodeAt(0);
      
      private static const bytecar:Array = new Array(190);
      
      private static const bytedig:Array = diginit();
      
      private var ind:int;
      
      private var form:int = 0;
      
      private var mant:Array;
      
      private var exp:int;
      
      public function BigDecimal(param1:Object = 0, param2:int = 0, param3:int = -1)
      {
         var _loc7_:Boolean = false;
         var _loc24_:Boolean = false;
         var _loc15_:int = 0;
         var _loc14_:int = 0;
         var _loc4_:* = 0;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc16_:int = 0;
         super();
         var _loc22_:int = 0;
         var _loc21_:int = 0;
         var _loc5_:Boolean = false;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc17_:int = 0;
         var _loc20_:int = 0;
         var _loc23_:int = 0;
         var _loc12_:int = 0;
         var _loc25_:String = null;
         var _loc13_:Boolean = false;
         if(param1 == null)
         {
            return;
         }
         if(param1 is int)
         {
            createFromInt(param1 as int);
            return;
         }
         if(param1 is Number)
         {
            _loc25_ = (param1 as Number).toString();
            _loc13_ = true;
         }
         else if(!(param1 is String))
         {
            badarg("bad parameter",0,_loc25_);
         }
         else
         {
            _loc25_ = param1 as String;
         }
         if(param3 == -1)
         {
            param3 = _loc25_.length;
         }
         if(param3 <= 0)
         {
            bad(_loc25_);
         }
         ind = 1;
         if(_loc25_.charAt(param2) == "-")
         {
            if(--param3 == 0)
            {
               bad(_loc25_);
            }
            ind = -1;
            param2++;
         }
         else if(_loc25_.charAt(param2) == "+")
         {
            if(--param3 == 0)
            {
               bad(_loc25_);
            }
            param2++;
         }
         _loc7_ = false;
         _loc24_ = false;
         _loc15_ = 0;
         _loc14_ = -1;
         _loc4_ = -1;
         var _loc6_:int = param3;
         _loc22_ = param2;
         while(true)
         {
            if(_loc6_ <= 0)
            {
               if(_loc15_ == 0)
               {
                  bad(_loc25_);
               }
               if(_loc14_ >= 0)
               {
                  exp = exp + _loc14_ - _loc15_;
               }
               var _loc8_:int = _loc4_ - 1;
               _loc22_ = param2;
               while(_loc22_ <= _loc8_)
               {
                  _loc21_ = _loc25_.charCodeAt(_loc22_);
                  if(_loc21_ == BigDecimal.VALUE_ZERO)
                  {
                     param2++;
                     _loc14_--;
                     _loc15_--;
                  }
                  else
                  {
                     if(_loc21_ != BigDecimal.VALUE_DOT)
                     {
                        if(_loc21_ > BigDecimal.VALUE_NINE)
                        {
                        }
                        break;
                     }
                     param2++;
                     _loc14_--;
                  }
                  _loc22_++;
               }
               mant = new Array(_loc15_);
            }
            addr02e7:
            _loc21_ = _loc25_.charCodeAt(_loc22_);
            if(_loc21_ >= BigDecimal.VALUE_ZERO)
            {
               if(_loc21_ <= BigDecimal.VALUE_NINE)
               {
                  _loc4_ = _loc22_;
                  _loc15_++;
                  continue;
               }
            }
            if(_loc21_ == BigDecimal.VALUE_DOT)
            {
               if(_loc14_ >= 0)
               {
                  bad(_loc25_);
               }
               _loc14_ = _loc22_ - param2;
            }
            else
            {
               if(_loc21_ == BigDecimal.VALUE_ELOWER)
               {
                  break;
               }
               if(_loc21_ == BigDecimal.VALUE_EUPPER)
               {
                  break;
               }
               if(!isDigitInt(_loc21_))
               {
                  bad(_loc25_);
               }
               _loc7_ = true;
               _loc4_ = _loc22_;
               _loc15_++;
            }
            continue;
            _loc17_ = param2;
            if(_loc7_)
            {
               _loc10_ = _loc15_;
               _loc22_ = 0;
               while(_loc10_ > 0)
               {
                  if(_loc22_ == _loc14_)
                  {
                     _loc17_++;
                  }
                  _loc20_ = int(_loc25_[_loc17_]);
                  if(_loc20_ <= BigDecimal.VALUE_NINE)
                  {
                     mant[_loc22_] = _loc20_ - VALUE_ZERO;
                  }
                  else
                  {
                     bad(_loc25_);
                  }
                  _loc17_++;
                  _loc10_--;
                  _loc22_++;
               }
            }
            else
            {
               _loc11_ = _loc15_;
               _loc22_ = 0;
               while(_loc11_ > 0)
               {
                  if(_loc22_ == _loc14_)
                  {
                     _loc17_++;
                  }
                  mant[_loc22_] = _loc25_.charCodeAt(_loc17_) - BigDecimal.VALUE_ZERO;
                  _loc17_++;
                  _loc11_--;
                  _loc22_++;
               }
            }
            if(mant[0] == 0)
            {
               ind = 0;
               if(exp > 0)
               {
                  exp = 0;
               }
               if(_loc24_)
               {
                  mant = ZERO.mant;
                  exp = 0;
               }
            }
            else if(_loc24_)
            {
               form = 1;
               _loc12_ = exp + mant.length - 1;
               if(_loc12_ < -999999999 || _loc12_ > 999999999)
               {
                  bad(_loc25_);
               }
            }
            if(_loc13_)
            {
               _loc16_ = -exp < 10 ? 10 : -exp;
               assignMyself(setScale(_loc16_));
            }
            return;
            _loc6_--;
            _loc22_++;
         }
         if(_loc22_ - param2 > param3 - 2)
         {
            bad(_loc25_);
         }
         _loc5_ = false;
         if(_loc25_.charAt(_loc22_ + 1) == "-")
         {
            _loc5_ = true;
            _loc18_ = _loc22_ + 2;
         }
         else if(_loc25_.charAt(_loc22_ + 1) == "+")
         {
            _loc18_ = _loc22_ + 2;
         }
         else
         {
            _loc18_ = _loc22_ + 1;
         }
         _loc19_ = param3 - (_loc18_ - param2);
         if(_loc19_ == 0 || _loc19_ > 9)
         {
            bad(_loc25_);
         }
         _loc9_ = _loc19_;
         _loc17_ = _loc18_;
         while(_loc9_ > 0)
         {
            _loc20_ = _loc25_.charCodeAt(_loc17_);
            if(_loc20_ < BigDecimal.VALUE_ZERO)
            {
               bad(_loc25_);
            }
            if(_loc20_ > BigDecimal.VALUE_NINE)
            {
               bad(_loc25_);
            }
            else
            {
               _loc23_ = _loc20_ - BigDecimal.VALUE_ZERO;
            }
            exp = exp * 10 + _loc23_;
            _loc9_--;
            _loc17_++;
         }
         if(_loc5_)
         {
            exp = -exp;
         }
         _loc24_ = true;
         §§goto(addr02e7);
      }
      
      private static function div(param1:int, param2:int) : int
      {
         return (param1 - param1 % param2) / param2 as int;
      }
      
      private static function arraycopy(param1:Array, param2:int, param3:Array, param4:int, param5:int) : void
      {
         var _loc6_:int = 0;
         if(param4 > param2)
         {
            _loc6_ = param5 - 1;
            while(_loc6_ >= 0)
            {
               param3[_loc6_ + param4] = param1[_loc6_ + param2];
               _loc6_--;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < param5)
            {
               param3[_loc6_ + param4] = param1[_loc6_ + param2];
               _loc6_++;
            }
         }
      }
      
      private static function createArrayWithZeros(param1:int) : Array
      {
         var _loc3_:int = 0;
         var _loc2_:Array = new Array(param1);
         _loc3_ = 0;
         while(_loc3_ < param1)
         {
            _loc2_[_loc3_] = 0;
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function isDigit(param1:String) : Boolean
      {
         return param1.charCodeAt(0) >= BigDecimal.VALUE_ZERO && param1.charCodeAt(0) <= BigDecimal.VALUE_NINE;
      }
      
      private static function isDigitInt(param1:int) : Boolean
      {
         return param1 >= BigDecimal.VALUE_ZERO && param1 <= BigDecimal.VALUE_NINE;
      }
      
      public static function getChars(param1:String, param2:int, param3:int, param4:Array, param5:int) : void
      {
         if(param2 == param3)
         {
            return;
         }
         param2;
         while(param2 < param3)
         {
            param4[param5++] = param1.charAt(param2);
            param2++;
         }
      }
      
      private static function createStatic(param1:int) : BigDecimal
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:BigDecimal = new BigDecimal(null);
         if(param1 > 0)
         {
            _loc2_.ind = 1;
            param1 = -param1;
         }
         else if(param1 == 0)
         {
            _loc2_.ind = 0;
         }
         else
         {
            _loc2_.ind = -1;
         }
         _loc3_ = param1;
         _loc4_ = 18;
         while(true)
         {
            _loc3_ = div(_loc3_,10);
            if(_loc3_ == 0)
            {
               break;
            }
            _loc4_--;
         }
         _loc2_.mant = new Array(19 - _loc4_);
         _loc4_ = 19 - _loc4_ - 1;
         while(true)
         {
            _loc2_.mant[_loc4_] = -(param1 % 10);
            param1 = div(param1,10);
            if(param1 == 0)
            {
               break;
            }
            _loc4_--;
         }
         return _loc2_;
      }
      
      private static function extend(param1:Array, param2:int) : Array
      {
         var _loc3_:Array = null;
         if(param1.length == param2)
         {
            return param1;
         }
         _loc3_ = createArrayWithZeros(param2);
         arraycopy(param1,0,_loc3_,0,param1.length);
         return _loc3_;
      }
      
      private static function byteaddsub(param1:Array, param2:int, param3:Array, param4:int, param5:int, param6:Boolean) : Array
      {
         var _loc19_:int = 0;
         var _loc18_:int = 0;
         var _loc16_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:Array = null;
         var _loc17_:Boolean = false;
         var _loc12_:int = 0;
         var _loc11_:Array = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         _loc19_ = int(param1.length);
         _loc18_ = int(param3.length);
         _loc16_ = param2 - 1;
         _loc15_ = _loc14_ = param4 - 1;
         if(_loc15_ < _loc16_)
         {
            _loc15_ = _loc16_;
         }
         _loc9_ = null;
         if(param6)
         {
            if(_loc15_ + 1 == _loc19_)
            {
               _loc9_ = param1;
            }
         }
         if(_loc9_ == null)
         {
            _loc9_ = createArrayWithZeros(_loc15_ + 1);
         }
         _loc17_ = false;
         if(param5 == 1)
         {
            _loc17_ = true;
         }
         else if(param5 == -1)
         {
            _loc17_ = true;
         }
         _loc12_ = 0;
         _loc8_ = _loc15_;
         for(; _loc8_ >= 0; _loc8_--)
         {
            if(_loc16_ >= 0)
            {
               if(_loc16_ < _loc19_)
               {
                  _loc12_ += param1[_loc16_];
               }
               _loc16_--;
            }
            if(_loc14_ >= 0)
            {
               if(_loc14_ < _loc18_)
               {
                  if(_loc17_)
                  {
                     if(param5 > 0)
                     {
                        _loc12_ += param3[_loc14_];
                     }
                     else
                     {
                        _loc12_ -= param3[_loc14_];
                     }
                  }
                  else
                  {
                     _loc12_ += param3[_loc14_] * param5;
                  }
               }
               _loc14_--;
            }
            if(_loc12_ < 10)
            {
               if(_loc12_ >= 0)
               {
                  _loc9_[_loc8_] = _loc12_;
                  _loc12_ = 0;
                  continue;
               }
            }
            _loc13_ = _loc12_ + 90;
            _loc9_[_loc8_] = bytedig[_loc13_];
            _loc12_ = int(bytecar[_loc13_]);
         }
         if(_loc12_ == 0)
         {
            return _loc9_;
         }
         _loc11_ = null;
         if(param6)
         {
            if(_loc15_ + 2 == param1.length)
            {
               _loc11_ = param1;
            }
         }
         if(_loc11_ == null)
         {
            _loc11_ = new Array(_loc15_ + 2);
         }
         _loc11_[0] = _loc12_;
         if(_loc15_ < 10)
         {
            _loc7_ = _loc15_ + 1;
            _loc10_ = 0;
            while(_loc7_ > 0)
            {
               _loc11_[_loc10_ + 1] = _loc9_[_loc10_];
               _loc7_--;
               _loc10_++;
            }
         }
         else
         {
            arraycopy(_loc9_,0,_loc11_,1,_loc15_ + 1);
         }
         return _loc11_;
      }
      
      private static function diginit() : Array
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = new Array(190);
         _loc3_ = 0;
         while(_loc3_ <= 189)
         {
            _loc1_ = _loc3_ - 90;
            if(_loc1_ >= 0)
            {
               _loc2_[_loc3_] = _loc1_ % 10;
               bytecar[_loc3_] = div(_loc1_,10);
            }
            else
            {
               _loc1_ += 100;
               _loc2_[_loc3_] = _loc1_ % 10;
               bytecar[_loc3_] = div(_loc1_,10) - 10;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private static function clone(param1:BigDecimal) : BigDecimal
      {
         var _loc2_:BigDecimal = null;
         _loc2_ = new BigDecimal(null);
         _loc2_.ind = param1.ind;
         _loc2_.exp = param1.exp;
         _loc2_.form = param1.form;
         _loc2_.mant = param1.mant;
         return _loc2_;
      }
      
      private static function allzero(param1:Array, param2:int) : Boolean
      {
         var _loc4_:int = 0;
         if(param2 < 0)
         {
            param2 = 0;
         }
         var _loc3_:int = param1.length - 1;
         _loc4_ = param2;
         while(_loc4_ <= _loc3_)
         {
            if(param1[_loc4_] != 0)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      private function assignMyself(param1:BigDecimal) : void
      {
         this.ind = param1.ind;
         this.form = param1.form;
         this.exp = param1.exp;
         this.mant = param1.mant;
      }
      
      private function createFromInt(param1:int = 0) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1 <= 9)
         {
            if(param1 >= -9)
            {
               if(param1 == 0)
               {
                  mant = ZERO.mant;
                  ind = 0;
               }
               else if(param1 == 1)
               {
                  mant = ONE.mant;
                  ind = 1;
               }
               else if(param1 == -1)
               {
                  mant = ONE.mant;
                  ind = -1;
               }
               else
               {
                  mant = new Array(1);
                  if(param1 > 0)
                  {
                     mant[0] = param1 as int;
                     ind = 1;
                  }
                  else
                  {
                     mant[0] = -param1 as int;
                     ind = -1;
                  }
               }
               return;
            }
         }
         if(param1 > 0)
         {
            ind = 1;
            param1 = -param1 as int;
         }
         else
         {
            ind = -1;
         }
         _loc2_ = param1;
         _loc3_ = 9;
         while(true)
         {
            _loc2_ = div(_loc2_,10);
            if(_loc2_ == 0)
            {
               break;
            }
            _loc3_--;
         }
         mant = new Array(10 - _loc3_);
         _loc3_ = 10 - _loc3_ - 1;
         while(true)
         {
            mant[_loc3_] = -(param1 % 10 as int);
            param1 = div(param1,10);
            if(param1 == 0)
            {
               break;
            }
            _loc3_--;
         }
      }
      
      public function abs(param1:MathContext = null) : BigDecimal
      {
         if(param1 == null)
         {
            param1 = MathContext.PLAIN;
         }
         if(this.ind == -1)
         {
            return this.negate(param1);
         }
         return this.plus(param1);
      }
      
      public function add(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         var _loc11_:BigDecimal = null;
         var _loc12_:int = 0;
         var _loc3_:BigDecimal = null;
         var _loc16_:Array = null;
         var _loc17_:int = 0;
         var _loc18_:Array = null;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc19_:int = 0;
         var _loc5_:int = 0;
         var _loc15_:Array = null;
         var _loc14_:int = 0;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(param2.lostDigits)
         {
            checkdigits(param1,param2.digits);
         }
         _loc11_ = this;
         if(_loc11_.ind == 0)
         {
            if(param2.form != 0)
            {
               return param1.plus(param2);
            }
            if(param1.ind == 0)
            {
               if(param2.form != 0)
               {
                  return _loc11_.plus(param2);
               }
            }
         }
         _loc12_ = param2.digits;
         if(_loc12_ > 0)
         {
            if(_loc11_.mant.length > _loc12_)
            {
               _loc11_ = clone(_loc11_).roundContext(param2);
            }
            if(param1.mant.length > _loc12_)
            {
               param1 = clone(param1).roundContext(param2);
            }
         }
         _loc3_ = new BigDecimal();
         _loc16_ = _loc11_.mant;
         _loc17_ = int(_loc11_.mant.length);
         _loc18_ = param1.mant;
         _loc8_ = int(param1.mant.length);
         if(_loc11_.exp == param1.exp)
         {
            _loc3_.exp = _loc11_.exp;
         }
         else if(_loc11_.exp > param1.exp)
         {
            _loc7_ = _loc17_ + _loc11_.exp - param1.exp;
            if(_loc7_ >= _loc8_ + _loc12_ + 1)
            {
               if(_loc12_ > 0)
               {
                  _loc3_.mant = _loc16_;
                  _loc3_.exp = _loc11_.exp;
                  _loc3_.ind = _loc11_.ind;
                  if(_loc17_ < _loc12_)
                  {
                     _loc3_.mant = extend(_loc11_.mant,_loc12_);
                     _loc3_.exp -= _loc12_ - _loc17_;
                  }
                  return _loc3_.finish(param2,false);
               }
            }
            _loc3_.exp = param1.exp;
            if(_loc7_ > _loc12_ + 1)
            {
               if(_loc12_ > 0)
               {
                  _loc19_ = _loc7_ - _loc12_ - 1;
                  _loc8_ -= _loc19_;
                  _loc3_.exp += _loc19_;
                  _loc7_ = _loc12_ + 1;
               }
            }
            if(_loc7_ > _loc17_)
            {
               _loc17_ = _loc7_;
            }
         }
         else
         {
            _loc7_ = _loc8_ + param1.exp - _loc11_.exp;
            if(_loc7_ >= _loc17_ + _loc12_ + 1)
            {
               if(_loc12_ > 0)
               {
                  _loc3_.mant = _loc18_;
                  _loc3_.exp = param1.exp;
                  _loc3_.ind = param1.ind;
                  if(_loc8_ < _loc12_)
                  {
                     _loc3_.mant = extend(param1.mant,_loc12_);
                     _loc3_.exp -= _loc12_ - _loc8_;
                  }
                  return _loc3_.finish(param2,false);
               }
            }
            _loc3_.exp = _loc11_.exp;
            if(_loc7_ > _loc12_ + 1)
            {
               if(_loc12_ > 0)
               {
                  _loc19_ = _loc7_ - _loc12_ - 1;
                  _loc17_ -= _loc19_;
                  _loc3_.exp += _loc19_;
                  _loc7_ = _loc12_ + 1;
               }
            }
            if(_loc7_ > _loc8_)
            {
               _loc8_ = _loc7_;
            }
         }
         if(_loc11_.ind == 0)
         {
            _loc3_.ind = 1;
         }
         else
         {
            _loc3_.ind = _loc11_.ind;
         }
         if((_loc11_.ind == -1 ? 1 : 0) == (param1.ind == -1 ? 1 : 0))
         {
            _loc5_ = 1;
         }
         else
         {
            _loc5_ = -1;
            if(param1.ind != 0)
            {
               if(_loc17_ < _loc8_ || _loc11_.ind == 0)
               {
                  _loc15_ = _loc16_;
                  _loc16_ = _loc18_;
                  _loc18_ = _loc15_;
                  _loc19_ = _loc17_;
                  _loc17_ = _loc8_;
                  _loc8_ = _loc19_;
                  _loc3_.ind = -_loc3_.ind;
               }
               else if(_loc17_ <= _loc8_)
               {
                  _loc14_ = 0;
                  _loc13_ = 0;
                  _loc9_ = _loc16_.length - 1;
                  _loc10_ = _loc18_.length - 1;
                  while(true)
                  {
                     if(_loc14_ <= _loc9_)
                     {
                        _loc6_ = int(_loc16_[_loc14_]);
                     }
                     else
                     {
                        if(_loc13_ > _loc10_)
                        {
                           if(param2.form != 0)
                           {
                              return ZERO;
                           }
                           break;
                        }
                        _loc6_ = 0;
                     }
                     if(_loc13_ <= _loc10_)
                     {
                        _loc4_ = int(_loc18_[_loc13_]);
                     }
                     else
                     {
                        _loc4_ = 0;
                     }
                     if(_loc6_ != _loc4_)
                     {
                        if(_loc6_ < _loc4_)
                        {
                           _loc15_ = _loc16_;
                           _loc16_ = _loc18_;
                           _loc18_ = _loc15_;
                           _loc19_ = _loc17_;
                           _loc17_ = _loc8_;
                           _loc8_ = _loc19_;
                           _loc3_.ind = -_loc3_.ind;
                        }
                        break;
                     }
                     _loc14_++;
                     _loc13_++;
                  }
               }
            }
         }
         _loc3_.mant = byteaddsub(_loc16_,_loc17_,_loc18_,_loc8_,_loc5_,false);
         return _loc3_.finish(param2,false);
      }
      
      public function compareTo(param1:BigDecimal, param2:MathContext = null) : int
      {
         var _loc3_:BigDecimal = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(param2.lostDigits)
         {
            checkdigits(param1,param2.digits);
         }
         if(this.ind == param1.ind && this.exp == param1.exp)
         {
            _loc5_ = int(this.mant.length);
            if(_loc5_ < param1.mant.length)
            {
               return -this.ind;
            }
            if(_loc5_ > param1.mant.length)
            {
               return this.ind;
            }
            if(_loc5_ <= param2.digits || param2.digits == 0)
            {
               _loc4_ = _loc5_;
               _loc6_ = 0;
               while(_loc4_ > 0)
               {
                  if(this.mant[_loc6_] < param1.mant[_loc6_])
                  {
                     return -this.ind;
                  }
                  if(this.mant[_loc6_] > param1.mant[_loc6_])
                  {
                     return this.ind;
                  }
                  _loc4_--;
                  _loc6_++;
               }
               return 0;
            }
         }
         else
         {
            if(this.ind < param1.ind)
            {
               return -1;
            }
            if(this.ind > param1.ind)
            {
               return 1;
            }
         }
         _loc3_ = clone(param1);
         _loc3_.ind = -_loc3_.ind;
         return this.add(_loc3_,param2).ind;
      }
      
      public function divideRound(param1:BigDecimal, param2:int) : BigDecimal
      {
         var _loc3_:MathContext = null;
         _loc3_ = new MathContext(0,0,false,param2);
         return this.dodivide("D",param1,_loc3_,-1);
      }
      
      public function divideScaleRound(param1:BigDecimal, param2:int, param3:int) : BigDecimal
      {
         var _loc4_:MathContext = null;
         if(param2 < 0)
         {
            throw new Error("Negative scale: " + param2);
         }
         _loc4_ = new MathContext(0,0,false,param3);
         return this.dodivide("D",param1,_loc4_,param2);
      }
      
      public function divide(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         return this.dodivide("D",param1,param2,-1);
      }
      
      public function divideInteger(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         return this.dodivide("I",param1,param2,0);
      }
      
      public function max(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(this.compareTo(param1,param2) >= 0)
         {
            return this.plus(param2);
         }
         return param1.plus(param2);
      }
      
      public function min(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(this.compareTo(param1,param2) <= 0)
         {
            return this.plus(param2);
         }
         return param1.plus(param2);
      }
      
      public function multiply(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         var _loc9_:BigDecimal = null;
         var _loc7_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc3_:BigDecimal = null;
         var _loc8_:Array = null;
         var _loc14_:Array = null;
         var _loc13_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(param2.lostDigits)
         {
            checkdigits(param1,param2.digits);
         }
         _loc9_ = this;
         _loc7_ = 0;
         _loc10_ = param2.digits;
         if(_loc10_ > 0)
         {
            if(_loc9_.mant.length > _loc10_)
            {
               _loc9_ = clone(_loc9_).roundContext(param2);
            }
            if(param1.mant.length > _loc10_)
            {
               param1 = clone(param1).roundContext(param2);
            }
         }
         else
         {
            if(_loc9_.exp > 0)
            {
               _loc7_ += _loc9_.exp;
            }
            if(param1.exp > 0)
            {
               _loc7_ += param1.exp;
            }
         }
         if(_loc9_.mant.length < param1.mant.length)
         {
            _loc14_ = _loc9_.mant;
            _loc13_ = param1.mant;
         }
         else
         {
            _loc14_ = param1.mant;
            _loc13_ = _loc9_.mant;
         }
         _loc11_ = _loc14_.length + _loc13_.length - 1;
         if(_loc14_[0] * _loc13_[0] > 9)
         {
            _loc5_ = _loc11_ + 1;
         }
         else
         {
            _loc5_ = _loc11_;
         }
         _loc3_ = new BigDecimal();
         _loc8_ = createArrayWithZeros(_loc5_);
         var _loc12_:int = int(_loc14_.length);
         _loc6_ = 0;
         while(_loc12_ > 0)
         {
            _loc4_ = int(_loc14_[_loc6_]);
            if(_loc4_ != 0)
            {
               _loc8_ = byteaddsub(_loc8_,_loc8_.length,_loc13_,_loc11_,_loc4_,true);
            }
            _loc11_--;
            _loc12_--;
            _loc6_++;
         }
         _loc3_.ind = _loc9_.ind * param1.ind;
         _loc3_.exp = _loc9_.exp + param1.exp - _loc7_;
         if(_loc7_ == 0)
         {
            _loc3_.mant = _loc8_;
         }
         else
         {
            _loc3_.mant = extend(_loc8_,_loc8_.length + _loc7_);
         }
         return _loc3_.finish(param2,false);
      }
      
      public function negate(param1:MathContext = null) : BigDecimal
      {
         var _loc2_:BigDecimal = null;
         if(param1 == null)
         {
            param1 = MathContext.PLAIN;
         }
         if(param1.lostDigits)
         {
            checkdigits(null as BigDecimal,param1.digits);
         }
         _loc2_ = clone(this);
         _loc2_.ind = -_loc2_.ind;
         return _loc2_.finish(param1,false);
      }
      
      public function plus(param1:MathContext = null) : BigDecimal
      {
         if(param1 == null)
         {
            param1 = MathContext.PLAIN;
         }
         if(param1.lostDigits)
         {
            checkdigits(null as BigDecimal,param1.digits);
         }
         if(param1.form == 0)
         {
            if(this.form == 0)
            {
               if(this.mant.length <= param1.digits)
               {
                  return this;
               }
               if(param1.digits == 0)
               {
                  return this;
               }
            }
         }
         return clone(this).finish(param1,false);
      }
      
      public function pow(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         var _loc7_:int = 0;
         var _loc11_:BigDecimal = null;
         var _loc4_:int = 0;
         var _loc8_:MathContext = null;
         var _loc3_:BigDecimal = null;
         var _loc10_:Boolean = false;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(param2.lostDigits)
         {
            checkdigits(param1,param2.digits);
         }
         _loc7_ = param1.intcheck(-999999999,999999999);
         _loc11_ = this;
         _loc4_ = param2.digits;
         if(_loc4_ == 0)
         {
            if(param1.ind == -1)
            {
               throw new Error("Negative power: " + param1.toString());
            }
            _loc5_ = 0;
         }
         else
         {
            if(param1.mant.length + param1.exp > _loc4_)
            {
               throw Error("Too many digits: " + param1.toString());
            }
            if(_loc11_.mant.length > _loc4_)
            {
               _loc11_ = clone(_loc11_).roundContext(param2);
            }
            _loc6_ = param1.mant.length + param1.exp;
            _loc5_ = _loc4_ + _loc6_ + 1;
         }
         _loc8_ = new MathContext(_loc5_,param2.form,false,param2.roundingMode);
         _loc3_ = ONE;
         if(_loc7_ == 0)
         {
            return _loc3_;
         }
         if(_loc7_ < 0)
         {
            _loc7_ = -_loc7_;
         }
         _loc10_ = false;
         _loc9_ = 1;
         while(true)
         {
            _loc7_ += _loc7_;
            if(_loc7_ < 0)
            {
               _loc10_ = true;
               _loc3_ = _loc3_.multiply(_loc11_,_loc8_);
            }
            if(_loc9_ == 31)
            {
               break;
            }
            if(_loc10_)
            {
               _loc3_ = _loc3_.multiply(_loc3_,_loc8_);
            }
            _loc9_++;
         }
         if(param1.ind < 0)
         {
            _loc3_ = ONE.divide(_loc3_,_loc8_);
         }
         return _loc3_.finish(param2,true);
      }
      
      public function remainder(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         return this.dodivide("R",param1,param2,-1);
      }
      
      public function subtract(param1:BigDecimal, param2:MathContext = null) : BigDecimal
      {
         var _loc3_:BigDecimal = null;
         if(param2 == null)
         {
            param2 = MathContext.PLAIN;
         }
         if(param2.lostDigits)
         {
            checkdigits(param1,param2.digits);
         }
         _loc3_ = clone(param1);
         _loc3_.ind = -_loc3_.ind;
         return this.add(_loc3_,param2);
      }
      
      public function numberValue() : Number
      {
         return new Number(this.toString());
      }
      
      public function equals(param1:Object) : Boolean
      {
         var _loc4_:BigDecimal = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc7_:int = 0;
         var _loc5_:Array = null;
         var _loc6_:Array = null;
         if(param1 == null)
         {
            return false;
         }
         if(!(param1 is BigDecimal))
         {
            return false;
         }
         _loc4_ = param1 as BigDecimal;
         if(this.ind != _loc4_.ind)
         {
            return false;
         }
         if(this.mant.length == _loc4_.mant.length && this.exp == _loc4_.exp && this.form == _loc4_.form)
         {
            _loc2_ = int(this.mant.length);
            _loc7_ = 0;
            while(_loc2_ > 0)
            {
               if(this.mant[_loc7_] != _loc4_.mant[_loc7_])
               {
                  return false;
               }
               _loc2_--;
               _loc7_++;
            }
         }
         else
         {
            _loc5_ = this.layout();
            _loc6_ = _loc4_.layout();
            if(_loc5_.length != _loc6_.length)
            {
               return false;
            }
            _loc3_ = int(_loc5_.length);
            _loc7_ = 0;
            while(_loc3_ > 0)
            {
               if(_loc5_[_loc7_] != _loc6_[_loc7_])
               {
                  return false;
               }
               _loc3_--;
               _loc7_++;
            }
         }
         return true;
      }
      
      public function format(param1:int, param2:int, param3:int = -1, param4:int = -1, param5:int = 1, param6:int = 4) : String
      {
         var _loc18_:BigDecimal = null;
         var _loc12_:Array = null;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc16_:int = 0;
         var _loc23_:int = 0;
         var _loc20_:int = 0;
         var _loc14_:int = 0;
         var _loc19_:Array = null;
         var _loc24_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc22_:int = 0;
         var _loc21_:Array = null;
         var _loc17_:int = 0;
         var _loc15_:int = 0;
         if(param1 < -1 || param1 == 0)
         {
            badarg("format",1,new String(param1));
         }
         if(param2 < -1)
         {
            badarg("format",2,new String(param2));
         }
         if(param3 < -1 || param3 == 0)
         {
            badarg("format",3,new String(param3));
         }
         if(param4 < -1)
         {
            badarg("format",4,new String(param3));
         }
         if(param5 != 1)
         {
            if(param5 != 2)
            {
               if(param5 == -1)
               {
                  param5 = 1;
               }
               else
               {
                  badarg("format",5,new String(param5));
               }
            }
         }
         if(param6 != 4)
         {
            try
            {
               if(param6 == -1)
               {
                  param6 = 4;
               }
               else
               {
                  new MathContext(9,1,false,param6);
               }
            }
            catch($10:Error)
            {
               badarg("format",6,new String(param6));
            }
         }
         _loc18_ = clone(this);
         if(param4 == -1)
         {
            _loc18_.form = 0;
         }
         else if(_loc18_.ind == 0)
         {
            _loc18_.form = 0;
         }
         else
         {
            _loc23_ = _loc18_.exp + _loc18_.mant.length;
            if(_loc23_ > param4)
            {
               _loc18_.form = param5;
            }
            else if(_loc23_ < -5)
            {
               _loc18_.form = param5;
            }
            else
            {
               _loc18_.form = 0;
            }
         }
         if(param2 >= 0)
         {
            while(true)
            {
               if(_loc18_.form == 0)
               {
                  _loc20_ = -_loc18_.exp;
               }
               else if(_loc18_.form == 1)
               {
                  _loc20_ = _loc18_.mant.length - 1;
               }
               else
               {
                  _loc14_ = (_loc18_.exp + _loc18_.mant.length - 1) % 3;
                  if(_loc14_ < 0)
                  {
                     _loc14_ = 3 + _loc14_;
                  }
                  if(++_loc14_ >= _loc18_.mant.length)
                  {
                     _loc20_ = 0;
                  }
                  else
                  {
                     _loc20_ = _loc18_.mant.length - _loc14_;
                  }
               }
               if(_loc20_ == param2)
               {
                  break;
               }
               if(_loc20_ < param2)
               {
                  _loc19_ = extend(_loc18_.mant,_loc18_.mant.length + param2 - _loc20_);
                  _loc18_.mant = _loc19_;
                  _loc18_.exp -= param2 - _loc20_;
                  if(_loc18_.exp < -999999999)
                  {
                     throw new Error("Exponent Overflow: " + _loc18_.exp);
                  }
                  break;
               }
               _loc24_ = _loc20_ - param2;
               if(_loc24_ > _loc18_.mant.length)
               {
                  _loc18_.mant = ZERO.mant;
                  _loc18_.ind = 0;
                  _loc18_.exp = 0;
               }
               else
               {
                  _loc8_ = _loc18_.mant.length - _loc24_;
                  _loc13_ = _loc18_.exp;
                  _loc18_.round(_loc8_,param6);
                  if(_loc18_.exp - _loc13_ == _loc24_)
                  {
                     break;
                  }
               }
            }
         }
         _loc12_ = _loc18_.layout();
         if(param1 > 0)
         {
            _loc10_ = int(_loc12_.length);
            _loc22_ = 0;
            while(_loc10_ > 0)
            {
               if(_loc12_[_loc22_] == VALUE_DOT)
               {
                  break;
               }
               if(_loc12_[_loc22_] == VALUE_EUPPER)
               {
                  break;
               }
               _loc10_--;
               _loc22_++;
            }
            if(_loc22_ > param1)
            {
               badarg("format",1,new String(param1));
            }
            if(_loc22_ < param1)
            {
               _loc21_ = new Array(_loc12_.length + param1 - _loc22_);
               _loc11_ = param1 - _loc22_;
               _loc17_ = 0;
               while(_loc11_ > 0)
               {
                  _loc21_[_loc17_] = " ";
                  _loc11_--;
                  _loc17_++;
               }
               arraycopy(_loc12_,0,_loc21_,_loc17_,_loc12_.length);
               _loc12_ = _loc21_;
            }
         }
         if(param3 > 0)
         {
            _loc7_ = _loc12_.length - 1;
            _loc22_ = _loc12_.length - 1;
            while(_loc7_ > 0)
            {
               if(_loc12_[_loc22_] == VALUE_EUPPER)
               {
                  break;
               }
               _loc7_--;
               _loc22_--;
            }
            if(_loc22_ == 0)
            {
               _loc21_ = new Array(_loc12_.length + param3 + 2);
               arraycopy(_loc12_,0,_loc21_,0,_loc12_.length);
               _loc9_ = param3 + 2;
               _loc17_ = int(_loc12_.length);
               while(_loc9_ > 0)
               {
                  _loc21_[_loc17_] = " ";
                  _loc9_--;
                  _loc17_++;
               }
               _loc12_ = _loc21_;
            }
            else
            {
               _loc15_ = _loc12_.length - _loc22_ - 2;
               if(_loc15_ > param3)
               {
                  badarg("format",3,new String(param3));
               }
               if(_loc15_ < param3)
               {
                  _loc21_ = new Array(_loc12_.length + param3 - _loc15_);
                  arraycopy(_loc12_,0,_loc21_,0,_loc22_ + 2);
                  _loc16_ = param3 - _loc15_;
                  _loc17_ = _loc22_ + 2;
                  while(_loc16_ > 0)
                  {
                     _loc21_[_loc17_] = "0";
                     _loc16_--;
                     _loc17_++;
                  }
                  arraycopy(_loc12_,_loc22_ + 2,_loc21_,_loc17_,_loc15_);
                  _loc12_ = _loc21_;
               }
            }
         }
         return new String(_loc12_);
      }
      
      public function intValueExact() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         if(ind == 0)
         {
            return 0;
         }
         _loc1_ = mant.length - 1;
         if(exp < 0)
         {
            _loc1_ += exp;
            if(!allzero(mant,_loc1_ + 1))
            {
               throw new Error("Decimal part non-zero: " + this.toString());
            }
            if(_loc1_ < 0)
            {
               return 0;
            }
            _loc4_ = 0;
         }
         else
         {
            if(exp + _loc1_ > 9)
            {
               throw new Error("Conversion overflow: " + this.toString());
            }
            _loc4_ = exp;
         }
         _loc2_ = 0;
         var _loc5_:int = _loc1_ + _loc4_;
         _loc6_ = 0;
         while(_loc6_ <= _loc5_)
         {
            _loc2_ *= 10;
            if(_loc6_ <= _loc1_)
            {
               _loc2_ += mant[_loc6_];
            }
            _loc6_++;
         }
         if(_loc1_ + _loc4_ == 9)
         {
            _loc3_ = div(_loc2_,1000000000);
            if(_loc3_ != mant[0])
            {
               if(_loc2_ == -2147483648)
               {
                  if(ind == -1)
                  {
                     if(mant[0] == 2)
                     {
                        return _loc2_;
                     }
                  }
               }
               throw new Error("Conversion overflow: " + this.toString());
            }
         }
         if(ind == 1)
         {
            return _loc2_;
         }
         return -_loc2_;
      }
      
      public function movePointLeft(param1:int) : BigDecimal
      {
         var _loc2_:BigDecimal = null;
         _loc2_ = clone(this);
         _loc2_.exp -= param1;
         return _loc2_.finish(MathContext.PLAIN,false);
      }
      
      public function movePointRight(param1:int) : BigDecimal
      {
         var _loc2_:BigDecimal = null;
         _loc2_ = clone(this);
         _loc2_.exp += param1;
         return _loc2_.finish(MathContext.PLAIN,false);
      }
      
      public function scale() : int
      {
         if(exp >= 0)
         {
            return 0;
         }
         return -exp;
      }
      
      public function setScale(param1:int, param2:int = -1) : BigDecimal
      {
         var _loc6_:int = 0;
         var _loc3_:BigDecimal = null;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param2 == -1)
         {
            param2 = 7;
         }
         _loc6_ = this.scale();
         if(_loc6_ == param1)
         {
            if(this.form == 0)
            {
               return this;
            }
         }
         _loc3_ = clone(this);
         if(_loc6_ <= param1)
         {
            if(_loc6_ == 0)
            {
               _loc5_ = _loc3_.exp + param1;
            }
            else
            {
               _loc5_ = param1 - _loc6_;
            }
            _loc3_.mant = extend(_loc3_.mant,_loc3_.mant.length + _loc5_);
            _loc3_.exp = -param1;
         }
         else
         {
            if(param1 < 0)
            {
               throw new Error("Negative scale: " + param1);
            }
            _loc4_ = _loc3_.mant.length - (_loc6_ - param1);
            _loc3_ = _loc3_.round(_loc4_,param2);
            if(_loc3_.exp != -param1)
            {
               _loc3_.mant = extend(_loc3_.mant,_loc3_.mant.length + 1);
               _loc3_.exp -= 1;
            }
         }
         _loc3_.form = 0;
         return _loc3_;
      }
      
      public function signum() : int
      {
         return this.ind;
      }
      
      public function toCharArray() : Array
      {
         return layout();
      }
      
      public function toString() : String
      {
         var _loc3_:int = 0;
         var _loc2_:Array = layout();
         var _loc1_:String = "";
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ += _loc2_[_loc3_];
            _loc3_++;
         }
         return _loc1_;
      }
      
      private function layout() : Array
      {
         var _loc11_:Array = null;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:String = null;
         var _loc12_:int = 0;
         var _loc14_:int = 0;
         var _loc6_:String = "";
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         _loc11_ = new Array(mant.length);
         var _loc5_:int = int(mant.length);
         _loc7_ = 0;
         while(_loc5_ > 0)
         {
            _loc11_[_loc7_] = new String(mant[_loc7_]);
            _loc5_--;
            _loc7_++;
         }
         if(form != 0)
         {
            _loc9_ = "";
            if(ind == -1)
            {
               _loc9_ += "-";
            }
            _loc12_ = exp + _loc11_.length - 1;
            if(form == 1)
            {
               _loc9_ += _loc11_[0];
               if(_loc11_.length > 1)
               {
                  _loc9_ += ".";
                  _loc9_ = _loc9_ + _loc11_.slice(1).join("");
               }
            }
            else
            {
               _loc14_ = _loc12_ % 3;
               if(_loc14_ < 0)
               {
                  _loc14_ = 3 + _loc14_;
               }
               _loc12_ -= _loc14_;
               if(++_loc14_ >= _loc11_.length)
               {
                  _loc9_ += _loc11_.join("");
                  _loc3_ = _loc14_ - _loc11_.length;
                  while(_loc3_ > 0)
                  {
                     _loc9_ += "0";
                     _loc3_--;
                  }
               }
               else
               {
                  _loc9_ += _loc11_.slice(0,_loc14_).join("");
                  _loc9_ = _loc9_ + ".";
                  _loc9_ = _loc9_ + _loc11_.slice(_loc14_).join("");
               }
            }
            if(_loc12_ != 0)
            {
               if(_loc12_ < 0)
               {
                  _loc6_ = "-";
                  _loc12_ = -_loc12_;
               }
               else
               {
                  _loc6_ = "+";
               }
               _loc9_ += "E";
               _loc9_ = _loc9_ + _loc6_;
               _loc9_ = _loc9_ + _loc12_;
            }
            return _loc9_.split("");
         }
         if(exp == 0)
         {
            if(ind >= 0)
            {
               return _loc11_;
            }
            _loc8_ = new Array(_loc11_.length + 1);
            _loc8_[0] = "-";
            arraycopy(_loc11_,0,_loc8_,1,_loc11_.length);
            return _loc8_;
         }
         _loc13_ = ind == -1 ? 1 : 0;
         _loc10_ = exp + _loc11_.length;
         if(_loc10_ < 1)
         {
            _loc4_ = _loc13_ + 2 - exp;
            _loc8_ = new Array(_loc4_);
            if(_loc13_ != 0)
            {
               _loc8_[0] = "-";
            }
            _loc8_[_loc13_] = "0";
            _loc8_[_loc13_ + 1] = ".";
            _loc1_ = -_loc10_;
            _loc7_ = _loc13_ + 2;
            while(_loc1_ > 0)
            {
               _loc8_[_loc7_] = "0";
               _loc1_--;
               _loc7_++;
            }
            arraycopy(_loc11_,0,_loc8_,_loc13_ + 2 - _loc10_,_loc11_.length);
            return _loc8_;
         }
         if(_loc10_ > _loc11_.length)
         {
            _loc4_ = _loc13_ + _loc10_;
            _loc8_ = new Array(_loc4_);
            if(_loc13_ != 0)
            {
               _loc8_[0] = "-";
            }
            arraycopy(_loc11_,0,_loc8_,_loc13_,_loc11_.length);
            _loc2_ = _loc10_ - _loc11_.length;
            _loc7_ = _loc13_ + _loc11_.length;
            while(_loc2_ > 0)
            {
               _loc8_[_loc7_] = "0";
               _loc2_--;
               _loc7_++;
            }
            return _loc8_;
         }
         _loc4_ = _loc13_ + 1 + _loc11_.length;
         _loc8_ = new Array(_loc4_);
         if(_loc13_ != 0)
         {
            _loc8_[0] = "-";
         }
         arraycopy(_loc11_,0,_loc8_,_loc13_,_loc10_);
         _loc8_[_loc13_ + _loc10_] = ".";
         arraycopy(_loc11_,_loc10_,_loc8_,_loc13_ + _loc10_ + 1,_loc11_.length - _loc10_);
         return _loc8_;
      }
      
      private function intcheck(param1:int, param2:int) : int
      {
         var _loc3_:int = 0;
         _loc3_ = this.intValueExact();
         if(_loc3_ < param1 || _loc3_ > param2)
         {
            throw new Error("Conversion overflow: " + _loc3_);
         }
         return _loc3_;
      }
      
      private function dodivide(param1:String, param2:BigDecimal, param3:MathContext, param4:int) : BigDecimal
      {
         var _loc16_:BigDecimal = null;
         var _loc26_:int = 0;
         var _loc24_:int = 0;
         var _loc6_:BigDecimal = null;
         var _loc10_:int = 0;
         var _loc12_:Array = null;
         var _loc7_:int = 0;
         var _loc14_:Array = null;
         var _loc18_:int = 0;
         var _loc15_:int = 0;
         var _loc9_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc25_:int = 0;
         var _loc11_:int = 0;
         var _loc23_:int = 0;
         var _loc8_:int = 0;
         var _loc27_:int = 0;
         var _loc13_:int = 0;
         var _loc22_:* = 0;
         var _loc28_:Array = null;
         var _loc5_:int = 0;
         var _loc29_:int = 0;
         var _loc17_:Array = null;
         if(param3.lostDigits)
         {
            checkdigits(param2,param3.digits);
         }
         _loc16_ = this;
         if(param2.ind == 0)
         {
            throw new Error("Divide by 0");
         }
         if(_loc16_.ind == 0)
         {
            if(param3.form != 0)
            {
               return ZERO;
            }
            if(param4 == -1)
            {
               return _loc16_;
            }
            return _loc16_.setScale(param4);
         }
         _loc26_ = param3.digits;
         if(_loc26_ > 0)
         {
            if(_loc16_.mant.length > _loc26_)
            {
               _loc16_ = clone(_loc16_).roundContext(param3);
            }
            if(param2.mant.length > _loc26_)
            {
               param2 = clone(param2).roundContext(param3);
            }
         }
         else
         {
            if(param4 == -1)
            {
               param4 = _loc16_.scale();
            }
            _loc26_ = int(_loc16_.mant.length);
            if(param4 != -_loc16_.exp)
            {
               _loc26_ = _loc26_ + param4 + _loc16_.exp;
            }
            _loc26_ = _loc26_ - (param2.mant.length - 1) - param2.exp;
            if(_loc26_ < _loc16_.mant.length)
            {
               _loc26_ = int(_loc16_.mant.length);
            }
            if(_loc26_ < param2.mant.length)
            {
               _loc26_ = int(param2.mant.length);
            }
         }
         _loc24_ = _loc16_.exp - param2.exp + _loc16_.mant.length - param2.mant.length;
         if(_loc24_ < 0)
         {
            if(param1 != "D")
            {
               if(param1 == "I")
               {
                  return ZERO;
               }
               return clone(_loc16_).finish(param3,false);
            }
         }
         _loc6_ = new BigDecimal();
         _loc6_.ind = _loc16_.ind * param2.ind;
         _loc6_.exp = _loc24_;
         _loc6_.mant = createArrayWithZeros(_loc26_ + 1);
         _loc10_ = _loc26_ + _loc26_ + 1;
         _loc12_ = extend(_loc16_.mant,_loc10_);
         _loc7_ = _loc10_;
         _loc14_ = param2.mant;
         _loc18_ = _loc10_;
         _loc15_ = _loc14_[0] * 10 + 1;
         if(_loc14_.length > 1)
         {
            _loc15_ += _loc14_[1];
         }
         _loc9_ = 0;
         loop0:
         while(true)
         {
            _loc21_ = 0;
            loop1:
            while(_loc7_ >= _loc18_)
            {
               if(_loc7_ == _loc18_)
               {
                  _loc19_ = _loc7_;
                  _loc25_ = 0;
                  for(; _loc19_ > 0; _loc19_--,_loc25_++)
                  {
                     if(_loc25_ < _loc14_.length)
                     {
                        _loc11_ = int(_loc14_[_loc25_]);
                     }
                     else
                     {
                        _loc11_ = 0;
                     }
                     if(_loc12_[_loc25_] < _loc11_)
                     {
                        break loop1;
                     }
                     if(_loc12_[_loc25_] <= _loc11_)
                     {
                        continue;
                     }
                     _loc23_ = int(_loc12_[0]);
                  }
                  _loc21_++;
                  _loc6_.mant[_loc9_] = _loc21_;
                  _loc9_++;
                  _loc12_[0] = 0;
                  break loop0;
               }
               _loc23_ = _loc12_[0] * 10;
               if(_loc7_ > 1)
               {
                  _loc23_ += _loc12_[1];
               }
               _loc8_ = div(_loc23_ * 10,_loc15_);
               if(_loc8_ == 0)
               {
                  _loc8_ = 1;
               }
               _loc21_ += _loc8_;
               _loc12_ = byteaddsub(_loc12_,_loc7_,_loc14_,_loc18_,-_loc8_,true);
               if(_loc12_[0] == 0)
               {
                  _loc20_ = _loc7_ - 2;
                  _loc27_ = 0;
                  while(_loc27_ <= _loc20_)
                  {
                     if(_loc12_[_loc27_] != 0)
                     {
                        break;
                     }
                     _loc7_--;
                     _loc27_++;
                  }
                  if(_loc27_ != 0)
                  {
                     arraycopy(_loc12_,_loc27_,_loc12_,0,_loc7_);
                  }
               }
            }
            if(_loc9_ != 0 || _loc21_ != 0)
            {
               _loc6_.mant[_loc9_] = _loc21_;
               if(++_loc9_ == _loc26_ + 1)
               {
                  break;
               }
               if(_loc12_[0] == 0)
               {
                  break;
               }
            }
            if(param4 >= 0)
            {
               if(-_loc6_.exp > param4)
               {
                  break;
               }
            }
            if(param1 != "D")
            {
               if(_loc6_.exp <= 0)
               {
                  break;
               }
            }
            _loc6_.exp -= 1;
            _loc18_--;
         }
         if(_loc9_ == 0)
         {
            _loc9_ = 1;
         }
         if(param1 == "I" || param1 == "R")
         {
            if(_loc9_ + _loc6_.exp > _loc26_)
            {
               throw new Error("Integer overflow");
            }
            if(param1 == "R")
            {
               if(_loc6_.mant[0] == 0)
               {
                  return clone(_loc16_).finish(param3,false);
               }
               if(_loc12_[0] == 0)
               {
                  return ZERO;
               }
               _loc6_.ind = _loc16_.ind;
               _loc13_ = _loc26_ + _loc26_ + 1 - _loc16_.mant.length;
               _loc6_.exp = _loc6_.exp - _loc13_ + _loc16_.exp;
               _loc22_ = _loc7_;
               _loc25_ = _loc22_ - 1;
               while(_loc25_ >= 1)
               {
                  if(!(_loc6_.exp < _loc16_.exp && _loc6_.exp < param2.exp))
                  {
                     break;
                  }
                  if(_loc12_[_loc25_] != 0)
                  {
                     break;
                  }
                  _loc22_--;
                  _loc6_.exp += 1;
                  _loc25_--;
               }
               if(_loc22_ < _loc12_.length)
               {
                  _loc28_ = new Array(_loc22_);
                  arraycopy(_loc12_,0,_loc28_,0,_loc22_);
                  _loc12_ = _loc28_;
               }
               _loc6_.mant = _loc12_;
               return _loc6_.finish(param3,false);
            }
         }
         else if(_loc12_[0] != 0)
         {
            _loc5_ = int(_loc6_.mant[_loc9_ - 1]);
            if(_loc5_ % 5 == 0)
            {
               _loc6_.mant[_loc9_ - 1] = _loc5_ + 1;
            }
         }
         if(param4 >= 0)
         {
            if(_loc9_ != _loc6_.mant.length)
            {
               _loc6_.exp -= _loc6_.mant.length - _loc9_;
            }
            _loc29_ = _loc6_.mant.length - (-_loc6_.exp - param4);
            _loc6_.round(_loc29_,param3.roundingMode);
            if(_loc6_.exp != -param4)
            {
               _loc6_.mant = extend(_loc6_.mant,_loc6_.mant.length + 1);
               _loc6_.exp -= 1;
            }
            return _loc6_.finish(param3,true);
         }
         if(_loc9_ == _loc6_.mant.length)
         {
            _loc6_.roundContext(param3);
            _loc9_ = _loc26_;
         }
         else
         {
            if(_loc6_.mant[0] == 0)
            {
               return ZERO;
            }
            _loc17_ = new Array(_loc9_);
            arraycopy(_loc6_.mant,0,_loc17_,0,_loc9_);
            _loc6_.mant = _loc17_;
         }
         return _loc6_.finish(param3,true);
      }
      
      private function bad(param1:String) : void
      {
         throw new Error("Not a number: " + param1);
      }
      
      private function badarg(param1:String, param2:int, param3:String) : void
      {
         throw new Error("Bad argument " + param2 + " " + "to" + " " + param1 + ":" + " " + param3);
      }
      
      private function checkdigits(param1:BigDecimal, param2:int) : void
      {
         if(param2 == 0)
         {
            return;
         }
         if(this.mant.length > param2)
         {
            if(!allzero(this.mant,param2))
            {
               throw new Error("Too many digits: " + this.toString());
            }
         }
         if(param1 == null)
         {
            return;
         }
         if(param1.mant.length > param2)
         {
            if(!allzero(param1.mant,param2))
            {
               throw new Error("Too many digits: " + param1.toString());
            }
         }
      }
      
      private function roundContext(param1:MathContext) : BigDecimal
      {
         return round(param1.digits,param1.roundingMode);
      }
      
      private function round(param1:int, param2:int) : BigDecimal
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:Boolean = false;
         var _loc9_:int = 0;
         var _loc5_:Array = null;
         _loc7_ = mant.length - param1;
         if(_loc7_ <= 0)
         {
            return this;
         }
         exp += _loc7_;
         _loc3_ = ind;
         _loc8_ = mant;
         if(param1 > 0)
         {
            mant = new Array(param1);
            arraycopy(_loc8_,0,mant,0,param1);
            _loc6_ = true;
            _loc9_ = int(_loc8_[param1]);
         }
         else
         {
            mant = ZERO.mant;
            ind = 0;
            _loc6_ = false;
            if(param1 == 0)
            {
               _loc9_ = int(_loc8_[0]);
            }
            else
            {
               _loc9_ = 0;
            }
         }
         _loc4_ = 0;
         if(param2 == 4)
         {
            if(_loc9_ >= 5)
            {
               _loc4_ = _loc3_;
            }
         }
         else if(param2 == 7)
         {
            if(!allzero(_loc8_,param1))
            {
               throw new Error("Rounding necessary");
            }
         }
         else if(param2 == 5)
         {
            if(_loc9_ > 5)
            {
               _loc4_ = _loc3_;
            }
            else if(_loc9_ == 5)
            {
               if(!allzero(_loc8_,param1 + 1))
               {
                  _loc4_ = _loc3_;
               }
            }
         }
         else if(param2 == 6)
         {
            if(_loc9_ > 5)
            {
               _loc4_ = _loc3_;
            }
            else if(_loc9_ == 5)
            {
               if(!allzero(_loc8_,param1 + 1))
               {
                  _loc4_ = _loc3_;
               }
               else if(mant[mant.length - 1] % 2 == 1)
               {
                  _loc4_ = _loc3_;
               }
            }
         }
         else if(param2 != 1)
         {
            if(param2 == 0)
            {
               if(!allzero(_loc8_,param1))
               {
                  _loc4_ = _loc3_;
               }
            }
            else if(param2 == 2)
            {
               if(_loc3_ > 0)
               {
                  if(!allzero(_loc8_,param1))
                  {
                     _loc4_ = _loc3_;
                  }
               }
            }
            else
            {
               if(param2 != 3)
               {
                  throw new Error("Bad round value: " + param2);
               }
               if(_loc3_ < 0)
               {
                  if(!allzero(_loc8_,param1))
                  {
                     _loc4_ = _loc3_;
                  }
               }
            }
         }
         if(_loc4_ != 0)
         {
            if(ind == 0)
            {
               mant = ONE.mant;
               ind = _loc4_;
            }
            else
            {
               if(ind == -1)
               {
                  _loc4_ = -_loc4_;
               }
               _loc5_ = byteaddsub(mant,mant.length,ONE.mant,1,_loc4_,_loc6_);
               if(_loc5_.length > mant.length)
               {
                  exp = exp + 1;
                  arraycopy(_loc5_,0,mant,0,mant.length);
               }
               else
               {
                  mant = _loc5_;
               }
            }
         }
         if(exp > 999999999)
         {
            throw new Error("Exponent Overflow: " + exp);
         }
         return this;
      }
      
      private function finish(param1:MathContext, param2:Boolean) : BigDecimal
      {
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc3_:Array = null;
         var _loc5_:int = 0;
         var _loc7_:int = 0;
         if(param1.digits != 0)
         {
            if(this.mant.length > param1.digits)
            {
               this.roundContext(param1);
            }
         }
         if(param2)
         {
            if(param1.form != 0)
            {
               _loc4_ = int(this.mant.length);
               _loc8_ = _loc4_ - 1;
               while(_loc8_ >= 1)
               {
                  if(this.mant[_loc8_] != 0)
                  {
                     break;
                  }
                  _loc4_--;
                  exp = exp + 1;
                  _loc8_--;
               }
               if(_loc4_ < this.mant.length)
               {
                  _loc3_ = new Array(_loc4_);
                  arraycopy(this.mant,0,_loc3_,0,_loc4_);
                  this.mant = _loc3_;
               }
            }
         }
         form = 0;
         var _loc6_:int = int(this.mant.length);
         _loc8_ = 0;
         for(; _loc6_ > 0; _loc6_--,_loc8_++)
         {
            if(this.mant[_loc8_] != 0)
            {
               if(_loc8_ > 0)
               {
                  _loc3_ = new Array(this.mant.length - _loc8_);
                  arraycopy(this.mant,_loc8_,_loc3_,0,this.mant.length - _loc8_);
                  this.mant = _loc3_;
               }
               _loc5_ = exp + mant.length;
               if(_loc5_ > 0)
               {
                  if(_loc5_ > param1.digits)
                  {
                     if(param1.digits != 0)
                     {
                        form = param1.form;
                     }
                  }
                  if(_loc5_ - 1 <= 999999999)
                  {
                     return this;
                  }
               }
               else if(_loc5_ < -5)
               {
                  form = param1.form;
               }
               if(--_loc5_ < -999999999 || _loc5_ > 999999999)
               {
                  if(form == 2)
                  {
                     _loc7_ = _loc5_ % 3;
                     if(_loc7_ < 0)
                     {
                        _loc7_ = 3 + _loc7_;
                     }
                     _loc5_ -= _loc7_;
                     if(_loc5_ >= -999999999)
                     {
                        if(_loc5_ <= 999999999)
                        {
                           §§goto(addr01c9);
                        }
                     }
                  }
                  throw new Error("Exponent Overflow: " + _loc5_);
               }
            }
            continue;
            addr01c9:
            return this;
         }
         ind = 0;
         if(param1.form != 0)
         {
            exp = 0;
         }
         else if(exp > 0)
         {
            exp = 0;
         }
         else if(exp < -999999999)
         {
            throw new ("Exponent Overflow: " + exp)();
         }
         mant = ZERO.mant;
         return this;
      }
   }
}

