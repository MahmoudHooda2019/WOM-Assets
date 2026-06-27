package wom.util
{
   import com.adobe.crypto.MD5;
   import com.freshplanet.ane.AirDeviceId;
   import com.hasoffers.nativeExtensions.MobileAppTracker;
   
   public class HasoffersUtil
   {
      
      public function HasoffersUtil()
      {
         super();
      }
      
      public static function trackAction(param1:String) : void
      {
         MobileAppTracker.instance.trackAction(param1,0,null,null,true);
      }
      
      public static function getUserId() : String
      {
         var _loc6_:String = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         if(AirDeviceId.getInstance().isOnAndroid)
         {
            _loc6_ = AirDeviceId.getInstance().getID("");
         }
         else
         {
            _loc6_ = AirDeviceId.getInstance().getID("");
            if(_loc6_ == null)
            {
               _loc6_ = AirDeviceId.getInstance().getIDFV();
            }
         }
         var _loc2_:String = MD5.hash(_loc6_);
         var _loc3_:String = "0" + _loc2_.substr(0,15);
         var _loc1_:BigDecimal = new BigDecimal();
         var _loc5_:int = _loc3_.length;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            _loc4_ = int("0x" + _loc3_.charAt(_loc5_ - _loc7_ - 1));
            _loc1_ = _loc1_.add(new BigDecimal(16).pow(new BigDecimal(_loc7_)).multiply(new BigDecimal(_loc4_)));
            _loc7_++;
         }
         return _loc1_.toString();
      }
   }
}

