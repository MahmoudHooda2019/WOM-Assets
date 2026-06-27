package wom.model.configuration
{
   import flash.display.LoaderInfo;
   import peak.config.DocumentConfiguration;
   
   [Inject]
   public class WebDocumentConfiguration extends WomDocumentConfiguration implements DocumentConfiguration
   {
      
      public function WebDocumentConfiguration(param1:LoaderInfo)
      {
         super();
         parameters = param1.parameters;
         init();
      }
   }
}

