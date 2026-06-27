package peak.i18n.lang
{
   public class Languages
   {
      
      public static const englishLanguageId:String = "en";
      
      public static const arabicLanguageId:String = "ar";
      
      public static const dutchLanguageId:String = "nl";
      
      public static const russianLanguageId:String = "ru";
      
      public static var activeLanguageId:String = "en";
      
      public static const TURKISH:Language = new Language("tr","1","Türkçe");
      
      public static const ENGLISH:Language = new Language("en","2","English");
      
      public static const FRENCH:Language = new Language("fr","3","Français");
      
      public static const GERMAN:Language = new Language("de","4","Deutsch");
      
      public static const PORTUGUESE:Language = new Language("pt","5","Portugues");
      
      public static const ITALIAN:Language = new Language("it","6","Italiano");
      
      public static const SPANISH:Language = new Language("es","7","Espanol");
      
      public static const ARABIC:Language = new Language("ar","8","Arabic",false);
      
      public static const RUSSIAN:Language = new Language("ru","9","Russian",false);
      
      public static const JAPANESE:Language = new Language("ja","10","Japanese",false);
      
      public static const CHINESE_SIMPLIFIED:Language = new Language("zh-cn","11","Simplified Chinese",false);
      
      public static const CHINESE_TRADITIONAL:Language = new Language("zh-tw","12","Traditional Chinese",false);
      
      public static const DUTCH:Language = new Language("nl","13","Dutch",false);
      
      public static const CUSTOM:Language = new Language("custom","0","Custom",false);
      
      public static const supportedLanguages:Vector.<Language> = new Vector.<Language>(0);
      
      public static const NON_EMBEDDED_LANGUAGES:Array = [RUSSIAN.id,JAPANESE.id,CHINESE_SIMPLIFIED.id,CHINESE_TRADITIONAL.id];
      
      supportedLanguages.push(ENGLISH);
      supportedLanguages.push(TURKISH);
      supportedLanguages.push(FRENCH);
      supportedLanguages.push(GERMAN);
      supportedLanguages.push(ITALIAN);
      supportedLanguages.push(PORTUGUESE);
      supportedLanguages.push(SPANISH);
      
      public function Languages()
      {
         super();
      }
      
      public static function determineLanguage(param1:String) : Language
      {
         var _loc2_:Language = null;
         switch(param1)
         {
            case ENGLISH.id:
               _loc2_ = ENGLISH;
               break;
            case TURKISH.id:
               _loc2_ = TURKISH;
               break;
            case FRENCH.id:
               _loc2_ = FRENCH;
               break;
            case GERMAN.id:
               _loc2_ = GERMAN;
               break;
            case ARABIC.id:
               _loc2_ = ARABIC;
               break;
            case ITALIAN.id:
               _loc2_ = ITALIAN;
               break;
            case PORTUGUESE.id:
               _loc2_ = PORTUGUESE;
               break;
            case SPANISH.id:
               _loc2_ = SPANISH;
               break;
            case RUSSIAN.id:
               _loc2_ = RUSSIAN;
               break;
            case JAPANESE.id:
               _loc2_ = JAPANESE;
               break;
            case CHINESE_SIMPLIFIED.id:
               _loc2_ = CHINESE_SIMPLIFIED;
               break;
            case CHINESE_TRADITIONAL.id:
               _loc2_ = CHINESE_TRADITIONAL;
               break;
            case DUTCH.id:
               _loc2_ = DUTCH;
               break;
            case CUSTOM.id:
               _loc2_ = CUSTOM;
               break;
            default:
               _loc2_ = ENGLISH;
         }
         return _loc2_;
      }
      
      public static function isActiveLanguageEmdedded() : Boolean
      {
         return NON_EMBEDDED_LANGUAGES.indexOf(activeLanguageId) < 0;
      }
   }
}

