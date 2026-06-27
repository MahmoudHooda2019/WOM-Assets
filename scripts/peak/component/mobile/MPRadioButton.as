package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.Radio;
   import peak.i18n.lang.Languages;
   
   public class MPRadioButton extends Radio
   {
      
      public var flarabyAS3:FlarabyAS3;
      
      public function MPRadioButton()
      {
         super();
         this.isFocusEnabled = false;
         if(Languages.activeLanguageId == "ar")
         {
            flarabyAS3 = new FlarabyAS3();
         }
      }
      
      override public function set label(param1:String) : void
      {
         if(flarabyAS3 != null)
         {
            super.label = flarabyAS3.convertArabicString(param1,this.labelTextRenderer.width,this.defaultLabelProperties.textFormat);
         }
         else
         {
            super.label = param1;
         }
      }
   }
}

