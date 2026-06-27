package peak.messaging
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractOutgoingMessage implements OutgoingMessage
   {
      
      public function AbstractOutgoingMessage()
      {
         super();
         if(getQualifiedClassName(AbstractOutgoingMessage) == getQualifiedClassName(this))
         {
            throw new IllegalOperationError("Illegal operation on abstract class: " + getQualifiedClassName(this));
         }
      }
      
      public function serialize() : Object
      {
         throw new IllegalOperationError("Illegal operation on abstract class: " + getQualifiedClassName(this));
      }
   }
}

