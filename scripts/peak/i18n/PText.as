package peak.i18n
{
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import peak.i18n.lang.Language;
   import peak.serialization.json.PJSON;
   
   public class PText
   {
      
      public static const ERROR_TEXT:String = "[notext]";
      
      public static const INSTANCE:PText = new PText();
      
      private static const LOOKUP0:RegExp = /\{0(\/.*?)?\}/g;
      
      private static const LOOKUP1:RegExp = /\{1(\/.*?)?\}/g;
      
      private static const LOOKUP2:RegExp = /\{2(\/.*?)?\}/g;
      
      public var definitions:Dictionary = new Dictionary();
      
      private var languages:Dictionary = new Dictionary();
      
      public var activeLanguage:Language;
      
      public function PText()
      {
         super();
         definitions = new Dictionary();
      }
      
      public function addLanguage(param1:Language) : void
      {
         languages[param1.id] = param1;
      }
      
      public function hasLanguageId(param1:String) : Boolean
      {
         return param1 in languages;
      }
      
      public function getLanguageById(param1:String) : Language
      {
         return languages[param1];
      }
      
      public function setActiveLanguageById(param1:String) : void
      {
         if(param1 in languages)
         {
            activeLanguage = languages[param1];
            return;
         }
         throw new Error("language not found, use ");
      }
      
      public function install(param1:Language, param2:Object) : void
      {
         var _loc3_:Object = null;
         if(!(param1.id in definitions))
         {
            definitions[param1.id] = {};
         }
         _loc3_ = definitions[param1.id];
         for(var _loc5_ in param2)
         {
            if(_loc5_ in _loc3_)
            {
               for(var _loc4_ in param2[_loc5_])
               {
                  _loc3_[_loc5_][_loc4_] = param2[_loc5_][_loc4_];
               }
            }
            else
            {
               _loc3_[_loc5_] = param2[_loc5_];
            }
         }
      }
      
      public function installFromEmbeddedFile(param1:Language, param2:Class) : void
      {
         var _loc3_:ByteArray = new param2();
         var _loc4_:String = _loc3_.readUTFBytes(_loc3_.length);
         install(param1,PJSON.decode(_loc4_));
         _loc3_.clear();
      }
      
      final protected function getText(param1:String) : String
      {
         var _loc3_:Object = definitions[activeLanguage.id];
         for each(var _loc2_ in param1.split("."))
         {
            if(!(_loc2_ in _loc3_))
            {
               return "[notext]";
            }
            _loc3_ = _loc3_[_loc2_];
         }
         return String(_loc3_);
      }
      
      public function getText0(param1:String) : String
      {
         var _loc6_:String = param1;
         var _loc5_:Object = this.definitions[this.activeLanguage.id];
         var _loc3_:int = 0;
         var _loc2_:Array = _loc6_.split(".");
         while(true)
         {
            for each(var _loc4_ in _loc2_)
            {
               if(!(_loc4_ in _loc5_))
               {
                  §§push("[notext]");
                  break;
               }
               _loc5_ = _loc5_[_loc4_];
            }
            return String(_loc5_);
         }
         return §§pop();
      }
      
      public function getText1(param1:String, param2:*) : String
      {
         var _loc7_:String = param1;
         var _loc6_:Object = this.definitions[this.activeLanguage.id];
         var _loc4_:int = 0;
         var _loc3_:Array = _loc7_.split(".");
         while(true)
         {
            for each(var _loc5_ in _loc3_)
            {
               if(!(_loc5_ in _loc6_))
               {
                  §§push("[notext]");
                  break;
               }
               _loc6_ = _loc6_[_loc5_];
            }
            §§push(String(_loc6_));
            break;
         }
         return §§pop().replace(LOOKUP0,param2);
      }
      
      public function getText2(param1:String, param2:*, param3:*) : String
      {
         var _loc8_:String = param1;
         var _loc7_:Object = this.definitions[this.activeLanguage.id];
         var _loc5_:int = 0;
         var _loc4_:Array = _loc8_.split(".");
         while(true)
         {
            for each(var _loc6_ in _loc4_)
            {
               if(!(_loc6_ in _loc7_))
               {
                  §§push("[notext]");
                  break;
               }
               _loc7_ = _loc7_[_loc6_];
            }
            §§push(String(_loc7_));
            break;
         }
         return §§pop().replace(LOOKUP0,param2).replace(LOOKUP1,param3);
      }
      
      public function getText3(param1:String, param2:*, param3:*, param4:*) : String
      {
         var _loc9_:String = param1;
         var _loc8_:Object = this.definitions[this.activeLanguage.id];
         var _loc6_:int = 0;
         var _loc5_:Array = _loc9_.split(".");
         while(true)
         {
            for each(var _loc7_ in _loc5_)
            {
               if(!(_loc7_ in _loc8_))
               {
                  §§push("[notext]");
                  break;
               }
               _loc8_ = _loc8_[_loc7_];
            }
            §§push(String(_loc8_));
            break;
         }
         return §§pop().replace(LOOKUP0,param2).replace(LOOKUP1,param3).replace(LOOKUP2,param4);
      }
      
      public function getTextN(param1:String, param2:Array) : String
      {
         var _loc4_:int = 0;
         var _loc9_:String = param1;
         var _loc8_:Object = this.definitions[this.activeLanguage.id];
         var _loc6_:int = 0;
         var _loc5_:Array = _loc9_.split(".");
         while(true)
         {
            for each(var _loc7_ in _loc5_)
            {
               if(!(_loc7_ in _loc8_))
               {
                  §§push("[notext]");
                  break;
               }
               _loc8_ = _loc8_[_loc7_];
            }
            §§push(String(_loc8_));
            break;
         }
         var _loc3_:String = §§pop();
         _loc4_ = param2.length - 1;
         while(_loc4_ >= 0)
         {
            _loc3_ = _loc3_.replace(new RegExp("\\{" + _loc4_ + "(\\/.*?)?\\}","g"),param2[_loc4_]);
            _loc4_--;
         }
         return _loc3_;
      }
      
      public function hasKey(param1:String) : Boolean
      {
         if(!activeLanguage || !(activeLanguage.id in definitions))
         {
            return false;
         }
         var _loc3_:Object = definitions[activeLanguage.id];
         for each(var _loc2_ in param1.split("."))
         {
            if(!(_loc2_ in _loc3_))
            {
               return false;
            }
            _loc3_ = _loc3_[_loc2_];
         }
         return true;
      }
   }
}

