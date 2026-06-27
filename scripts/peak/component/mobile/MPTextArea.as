package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.TextArea;
   import peak.i18n.lang.Languages;
   
   public class MPTextArea extends TextArea
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _inputId:String;
      
      public function MPTextArea()
      {
         super();
         _inputId = "";
         if(Languages.activeLanguageId == "ar")
         {
            _flarabyAS3 = new FlarabyAS3();
         }
      }
      
      public function get inputId() : String
      {
         return _inputId;
      }
      
      public function set inputId(param1:String) : void
      {
         _inputId = param1 != null ? param1 : "";
      }
      
      override public function get text() : String
      {
         if(_flarabyAS3 != null)
         {
            return _flarabyAS3.convertArabicString(this.text,this.textEditorProperties.textWidth,this.textEditorProperties.getTextFormat());
         }
         return super.text;
      }
   }
}

