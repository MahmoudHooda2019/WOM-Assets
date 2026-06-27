package peak.messaging
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractMessageContainer implements MessageContainer
   {
      
      private var _messageId:int;
      
      private var _messageType:*;
      
      public function AbstractMessageContainer(param1:*, param2:int)
      {
         super();
         if(getQualifiedClassName(AbstractMessageContainer) == getQualifiedClassName(this))
         {
            throw new IllegalOperationError("Illegal operation on abstract class: " + getQualifiedClassName(this));
         }
         _messageType = param1;
         _messageId = param2;
      }
      
      public function get messageType() : *
      {
         return _messageType;
      }
      
      public function get messageId() : int
      {
         return _messageId;
      }
   }
}

