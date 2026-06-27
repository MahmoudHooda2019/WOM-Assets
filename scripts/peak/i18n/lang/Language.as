package peak.i18n.lang
{
   import flash.globalization.Collator;
   import flash.globalization.StringTools;
   
   public class Language
   {
      
      private var _webApiId:String;
      
      private var _id:String;
      
      private var _fullName:String;
      
      private var _active:Boolean;
      
      public var stringTools:StringTools;
      
      public var collator:Collator;
      
      public function Language(param1:String, param2:String = "", param3:String = "", param4:Boolean = true)
      {
         super();
         this._webApiId = param2;
         this._id = param1;
         this._fullName = param3;
         this._active = param4;
         this.stringTools = new StringTools(param1);
         this.collator = new Collator(param1);
      }
      
      public function get webApiId() : String
      {
         return _webApiId;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get fullName() : String
      {
         return _fullName;
      }
      
      public function get active() : Boolean
      {
         return _active;
      }
      
      public function toUpperCase(param1:String) : String
      {
         return stringTools.toUpperCase(param1);
      }
      
      public function toLowerCase(param1:String) : String
      {
         return stringTools.toLowerCase(param1);
      }
   }
}

