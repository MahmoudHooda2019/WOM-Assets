package peak.component.mobile
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import feathers.controls.ToggleSwitch;
   import peak.i18n.lang.Languages;
   
   public class MPToggleSwitch extends ToggleSwitch
   {
      
      public var flarabyAS3:FlarabyAS3;
      
      public function MPToggleSwitch(param1:Boolean = false)
      {
         super();
         this.isFocusEnabled = false;
         this.useHandCursor = true;
         if(Languages.activeLanguageId == "ar")
         {
            flarabyAS3 = new FlarabyAS3();
         }
      }
      
      override public function set offText(param1:String) : void
      {
         super.offText = param1;
      }
      
      override public function set onText(param1:String) : void
      {
         super.onText = param1;
      }
   }
}

