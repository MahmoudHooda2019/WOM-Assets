package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   
   public class SubscribedActionsUpdatedEventNotification extends AbstractIncomingMessage
   {
      
      private var _subscribedActions:Vector.<int>;
      
      public function SubscribedActionsUpdatedEventNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _subscribedActions = new Vector.<int>();
         for each(var _loc2_ in param1.subscribedActions)
         {
            _subscribedActions.push(_loc2_);
         }
      }
      
      public function get subscribedActions() : Vector.<int>
      {
         return _subscribedActions;
      }
   }
}

