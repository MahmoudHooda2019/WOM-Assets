package wom.model.message.notification
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   
   public class ResourcesHarvestedEventNotification extends AbstractIncomingMessage
   {
      
      private var _currentStocks:Dictionary;
      
      public function ResourcesHarvestedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _currentStocks = new Dictionary();
         for(var _loc2_ in param1.currentStocks)
         {
            _currentStocks[_loc2_] = param1.currentStocks[_loc2_];
         }
      }
      
      public function get currentStocks() : Dictionary
      {
         return _currentStocks;
      }
   }
}

