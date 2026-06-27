package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.TextInput;
   
   public class MPTextInput extends TextInput
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _inputId:String;
      
      private var currentFrame:int = -1;
      
      public function MPTextInput()
      {
         super();
      }
      
      public function get inputId() : String
      {
         return _inputId;
      }
      
      public function set inputId(param1:String) : void
      {
         _inputId = param1 != null ? param1 : "";
      }
   }
}

