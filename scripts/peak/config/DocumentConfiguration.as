package peak.config
{
   public interface DocumentConfiguration
   {
      
      function getParameter(param1:String) : *;
      
      function setParameter(param1:String, param2:*) : void;
      
      function hasParameter(param1:String) : Boolean;
      
      function deleteParameter(param1:String) : void;
   }
}

