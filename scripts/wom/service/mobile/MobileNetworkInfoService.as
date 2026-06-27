package wom.service.mobile
{
   import com.distriqt.extension.networkinfo.NetworkInfo;
   import org.robotlegs.mvcs.Actor;
   
   public class MobileNetworkInfoService extends Actor
   {
      
      private static const DEV_KEY:String = "284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==";
      
      private static var INITIALIZED:Boolean = false;
      
      public function MobileNetworkInfoService()
      {
         super();
      }
      
      [PostConstruct]
      private function init() : void
      {
         if(!INITIALIZED)
         {
            NetworkInfo.init("284b1f2c9cd3a119b43c7da3b6f30e76ca840e92FUtVhD2TalB5zYStgu5sDitsv/fpZG8BU91/U8kcE5qWeMkNoJ4a+hoSH5Gf36kkY0obOvPc5NXnU0tbE15bWg==");
            INITIALIZED = true;
         }
      }
      
      public function isNetworkConnected() : Boolean
      {
         return NetworkInfo.networkInfo.isReachable();
      }
   }
}

