package peak.util
{
   public class PseudoRandomNumberGenerator
   {
      
      private static const NUMBERS:Vector.<Number> = new <Number>[0.0625,0.078125,0.09375,0.109375,0.125,0.15625,0.1875,0.21875,0.25,0.28125,0.3125,0.34375,0.375,0.40625,0.4375,0.46875,0.5,0.53125,0.5625,0.59375,0.625,0.65625,0.6875,0.71875,0.75,0.78125,0.8125,0.84375,0.875,0.90625,0.9375,0.96875];
      
      public var seed:uint;
      
      public function PseudoRandomNumberGenerator()
      {
         super();
         seed = 1;
      }
      
      public function nextDouble() : Number
      {
         var _loc2_:uint = 16807 * (seed >> 16);
         var _loc1_:uint = 16807 * (seed & 0xFFFF) + ((_loc2_ & 0x7FFF) << 16) + (_loc2_ >> 15);
         seed = _loc1_ > 2147483647 ? _loc1_ - 2147483647 : _loc1_;
         return NUMBERS[seed & 0x1F];
      }
      
      private function nextInt() : uint
      {
         var _loc2_:uint = 16807 * (seed >> 16);
         var _loc1_:uint = 16807 * (seed & 0xFFFF) + ((_loc2_ & 0x7FFF) << 16) + (_loc2_ >> 15);
         return seed = _loc1_ > 2147483647 ? _loc1_ - 2147483647 : _loc1_;
      }
   }
}

