package wom.model.dto
{
   public class SwearFilterLanguageDTO
   {
      
      private var _languageId:String;
      
      private var _wholeWords:Vector.<String>;
      
      private var _insideWords:Vector.<String>;
      
      public function SwearFilterLanguageDTO(param1:String, param2:Vector.<String>, param3:Vector.<String>)
      {
         super();
         _languageId = param1;
         _wholeWords = param2;
         _insideWords = param3;
      }
      
      public function get languageId() : String
      {
         return _languageId;
      }
      
      public function get wholeWords() : Vector.<String>
      {
         return _wholeWords;
      }
      
      public function get insideWords() : Vector.<String>
      {
         return _insideWords;
      }
   }
}

