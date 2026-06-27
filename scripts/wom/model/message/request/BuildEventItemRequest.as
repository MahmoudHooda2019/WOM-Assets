package wom.model.message.request
{
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   
   public class BuildEventItemRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var _itemId:int;
      
      private var _completeResources:Boolean;
      
      public function BuildEventItemRequest(param1:int, param2:Boolean = false)
      {
         super();
         _itemId = param1;
         _completeResources = param2;
      }
      
      override public function serialize() : Object
      {
         var _loc1_:Object = {"itemId":_itemId};
         if(_completeResources)
         {
            _loc1_.completeResources = _completeResources;
         }
         return _loc1_;
      }
   }
}

