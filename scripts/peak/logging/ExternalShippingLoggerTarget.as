package peak.logging
{
   import flash.external.ExternalInterface;
   import flash.net.URLVariables;
   import peak.config.DocumentConfiguration;
   
   public class ExternalShippingLoggerTarget extends ShippingLoggerTarget
   {
      
      public function ExternalShippingLoggerTarget(param1:Number = 40, param2:Number = 32000)
      {
         super(param1,param2);
      }
      
      override protected function initShippingLoader() : void
      {
      }
      
      override protected function initShippingRequest(param1:DocumentConfiguration) : void
      {
      }
      
      override protected function shipNext() : void
      {
         var _loc1_:URLVariables = getShippingVariables();
         if(ExternalInterface.available && ExternalInterface.call("WOM.log.ship",_loc1_["login_time"],_loc1_["message"],_loc1_["uid"],_loc1_["env"]) == "ok")
         {
            shippingComplete();
         }
         else
         {
            shippingError();
         }
      }
   }
}

