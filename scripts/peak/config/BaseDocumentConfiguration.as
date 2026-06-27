package peak.config
{
   public class BaseDocumentConfiguration implements DocumentConfiguration
   {
      
      public var parameters:Object;
      
      public function BaseDocumentConfiguration()
      {
         super();
      }
      
      public function getParameter(param1:String) : *
      {
         return parameters[param1];
      }
      
      public function setParameter(param1:String, param2:*) : void
      {
         parameters[param1] = param2;
      }
      
      public function hasParameter(param1:String) : Boolean
      {
         return param1 in parameters;
      }
      
      public function deleteParameter(param1:String) : void
      {
         delete parameters[param1];
      }
   }
}

