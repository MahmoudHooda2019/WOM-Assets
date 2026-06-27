package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class ResourcesChangedEventNotification extends AbstractIncomingMessage
   {
      
      private var _resources:Array;
      
      public function ResourcesChangedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _resources = [];
         if(param1.resources)
         {
            _loc3_ = 1;
            while(_loc3_ < 5)
            {
               _loc2_ = 0;
               if(param1.resources[_loc3_])
               {
                  _loc2_ = int(param1.resources[_loc3_]);
               }
               _resources[_loc3_] = _loc2_;
               _loc3_++;
            }
         }
      }
      
      public function get resources() : Array
      {
         return _resources;
      }
   }
}

