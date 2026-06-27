package wom.controller.command.bootstrap
{
   import peak.i18n.PText;
   import peak.i18n.lang.Language;
   import peak.i18n.lang.Languages;
   import peak.serialization.json.PJSON;
   import wom.controller.PCommand;
   import wom.model.configuration.WomDocumentConfiguration;
   
   public class BootstrapInternationalizationCommand extends PCommand
   {
      
      private var DomainEn:Class = domain_en_json$6a60dc139d214c8bb563df28c419d5001337811683;
      
      private var DomainAr:Class = §domain_ar_json$a1830cadba5e51a626caec93e7e4f543-1063585837§;
      
      [Inject]
      public var pText:PText;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function BootstrapInternationalizationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:String = documentConfiguration.hasParameter("lang") ? documentConfiguration.getParameter("lang") : Languages.ENGLISH.id;
         Languages.activeLanguageId = _loc2_;
         var _loc1_:Language = new Language(_loc2_);
         pText.addLanguage(_loc1_);
         if(documentConfiguration.hasParameter("lang_definitions"))
         {
            pText.install(_loc1_,PJSON.decode(documentConfiguration.getParameter("lang_definitions")));
         }
         else
         {
            pText.installFromEmbeddedFile(_loc1_,_loc2_ == "ar" ? DomainAr : DomainEn);
         }
         pText.setActiveLanguageById(_loc2_);
      }
   }
}

