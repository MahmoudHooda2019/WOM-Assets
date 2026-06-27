package peak.display
{
   public class TextInputDTO
   {
      
      private var _inputId:String;
      
      private var _text:String;
      
      public function TextInputDTO(param1:String, param2:String)
      {
         super();
         _inputId = param1;
         _text = param2;
      }
      
      public function get inputId() : String
      {
         return _inputId;
      }
      
      public function get text() : String
      {
         return _text;
      }
   }
}

