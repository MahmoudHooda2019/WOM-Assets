package peak.messaging
{
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public dynamic class DefaultOutgoingMessageMap implements OutgoingMessageMap
   {
      
      private var classToTypeMap:Dictionary;
      
      public function DefaultOutgoingMessageMap()
      {
         super();
         classToTypeMap = new Dictionary();
      }
      
      public function mapMessage(param1:*, param2:Class) : void
      {
         classToTypeMap[param2] = param1;
      }
      
      public function unmapAll() : void
      {
         classToTypeMap = new Dictionary();
      }
      
      public function getTypeByClass(param1:Class) : *
      {
         return classToTypeMap[param1];
      }
      
      public function getTypeByInstance(param1:Message) : *
      {
         return getTypeByClass(getDefinitionByName(getQualifiedClassName(param1)) as Class);
      }
      
      public function unmapMessage(param1:Class) : void
      {
         delete classToTypeMap[param1];
      }
   }
}

