package peak.util
{
   public class NumberUtil
   {
      
      public function NumberUtil()
      {
         super();
      }
      
      public static function prettyFormatExtended(param1:Number, param2:Object = null, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null, param7:Object = null, param8:Object = null, param9:Object = null, param10:Object = null) : String
      {
         var _loc20_:String = param2 == null ? "," : param2.toString();
         var _loc24_:String = param3 == null ? "k" : param3.toString();
         var _loc21_:String = param4 == null ? "m" : param4.toString();
         var _loc13_:String = param5 == null ? "b" : param5.toString();
         var _loc22_:String = param6 == null ? "t" : param6.toString();
         var _loc16_:int = int(param7 == null ? 3 : int(param7));
         var _loc14_:int = int(param8 == null ? 6 : int(param8));
         var _loc17_:int = int(param9 == null ? 9 : int(param9));
         var _loc15_:int = int(param10 == null ? 12 : int(param10));
         var _loc23_:Number = Math.pow(10,_loc15_);
         var _loc19_:Number = Math.pow(10,_loc17_);
         var _loc12_:Number = Math.pow(10,_loc14_);
         var _loc18_:Number = Math.pow(10,_loc16_);
         var _loc11_:String = "";
         if(param1 >= _loc23_)
         {
            _loc11_ = _loc22_;
            param1 /= 1000000000000;
         }
         else if(param1 >= _loc19_)
         {
            _loc11_ = _loc13_;
            param1 /= 1000000000;
         }
         else if(param1 >= _loc12_)
         {
            _loc11_ = _loc21_;
            param1 /= 1000000;
         }
         else if(param1 >= _loc18_)
         {
            _loc11_ = _loc24_;
            param1 /= 1000;
         }
         return format(param1 >> 0,_loc20_) + _loc11_;
      }
      
      public static function prettyFormat(param1:Number, param2:Object = null, param3:Object = null, param4:Object = null, param5:Object = null, param6:Object = null) : String
      {
         var _loc12_:String = param2 == null ? "," : param2.toString();
         var _loc14_:String = param3 == null ? "k" : param3.toString();
         var _loc13_:String = param4 == null ? "m" : param4.toString();
         var _loc10_:int = int(param5 == null ? 5 : int(param5));
         var _loc9_:int = int(param6 == null ? 8 : int(param6));
         var _loc8_:Number = Math.pow(10,_loc9_);
         var _loc11_:Number = Math.pow(10,_loc10_);
         var _loc7_:String = "";
         if(param1 >= _loc8_)
         {
            _loc7_ = _loc13_;
            param1 /= 1000000;
         }
         else if(param1 >= _loc11_)
         {
            _loc7_ = _loc14_;
            param1 /= 1000;
         }
         return format(param1 >> 0,_loc12_) + _loc7_;
      }
      
      public static function format(param1:Number, param2:String = ",") : String
      {
         var _loc3_:int = 0;
         var _loc6_:String = String(param1);
         var _loc5_:String = "";
         var _loc4_:int = 0;
         _loc3_ = _loc6_.length - 1;
         while(_loc3_ >= 0)
         {
            _loc4_++;
            _loc5_ = _loc6_.substr(_loc3_,1) + _loc5_;
            if(_loc4_ == 3 && _loc3_ != 0)
            {
               _loc5_ = param2 + _loc5_;
               _loc4_ = 0;
            }
            _loc3_--;
         }
         return _loc5_;
      }
      
      public static function numberFormat(param1:*, param2:int = 2, param3:Boolean = false, param4:Boolean = true) : String
      {
         var _loc8_:Boolean = false;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc7_:Number = Math.pow(10,param2);
         var _loc6_:String = String(Math.round(_loc7_ * Number(param1)) / _loc7_);
         _loc8_ = _loc6_.indexOf(".") == -1;
         var _loc9_:int = _loc8_ ? _loc6_.length : _loc6_.indexOf(".");
         var _loc5_:String = (_loc8_ && !param3 ? "" : (param4 ? "," : ".")) + _loc6_.substr(_loc9_ + 1);
         if(param3)
         {
            _loc10_ = 0;
            while(_loc10_ <= param2 - (_loc6_.length - (_loc8_ ? _loc9_ - 1 : _loc9_)))
            {
               _loc5_ += "0";
               _loc10_++;
            }
         }
         while(_loc11_ + 3 < (_loc6_.substr(0,1) == "-" ? _loc9_ - 1 : _loc9_))
         {
            _loc5_ = (param4 ? "." : ",") + _loc6_.substr(_loc9_ - (_loc11_ += 3),3) + _loc5_;
         }
         return _loc6_.substr(0,_loc9_ - _loc11_) + _loc5_;
      }
      
      public static function toRoman(param1:Number) : String
      {
         var _loc3_:Array = [1000,900,800,700,600,500,400,300,200,100,90,80,70,60,50,40,30,20,10,9,8,7,6,5,4,3,2,1];
         var _loc2_:Array = ["M","CM","DCCC","DCC","DC","D","CD","CCC","CC","C","XC","LXXX","LXX","LX","L","XL","XXX","XX","X","IX","VIII","VII","VI","V","IV","III","II","I"];
         var _loc4_:String = "";
         while(param1 > 0)
         {
            if(param1 - _loc3_[0] >= 0)
            {
               param1 -= _loc3_[0];
               _loc4_ += _loc2_[0];
            }
            else
            {
               _loc3_.shift();
               _loc2_.shift();
            }
         }
         return _loc4_;
      }
      
      public static function randomIntRange(param1:Number, param2:Number) : int
      {
         return int(randomNumberRange(param1,param2));
      }
      
      public static function randomNumberRange(param1:Number, param2:Number) : Number
      {
         param2++;
         return Math.floor(param1 + Math.random() * (param2 - param1));
      }
   }
}

