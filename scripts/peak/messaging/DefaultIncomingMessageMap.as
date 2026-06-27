package peak.messaging
{
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DefaultIncomingMessageMap implements IncomingMessageMap
   {
      
      private static const EVENT_TYPE_PREFIX:String = "event";
      
      private var typeToClassMap:Dictionary;
      
      public function DefaultIncomingMessageMap()
      {
         super();
         typeToClassMap = new Dictionary();
      }
      
      public function mapMessage(param1:*, param2:Class) : void
      {
         typeToClassMap[param1] = param2;
      }
      
      public function unmapAll() : void
      {
         typeToClassMap = new Dictionary();
      }
      
      public function getClassByType(param1:*) : Class
      {
         return typeToClassMap[param1];
      }
      
      public function hasClassForType(param1:*) : Boolean
      {
         return param1 in typeToClassMap;
      }
      
      public function getEventTypeFor(param1:Class) : String
      {
         return "event" + getQualifiedClassName(param1);
      }
      
      public function unmapMessage(param1:*) : void
      {
         delete typeToClassMap[param1];
      }
   }
}

