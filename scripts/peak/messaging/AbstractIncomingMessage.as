package peak.messaging
{
   import flash.errors.IllegalOperationError;
   import flash.utils.getQualifiedClassName;
   
   public class AbstractIncomingMessage implements IncomingMessage
   {
      
      public function AbstractIncomingMessage()
      {
         super();
         if(getQualifiedClassName(AbstractIncomingMessage) == getQualifiedClassName(this))
         {
            throw new IllegalOperationError("Illegal operation on abstract class: " + getQualifiedClassName(this));
         }
      }
      
      public function deserialize(param1:Object) : void
      {
         throw new IllegalOperationError("Illegal operation on abstract class: " + getQualifiedClassName(this));
      }
   }
}

