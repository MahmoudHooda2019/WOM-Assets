package peak.component
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import fl.controls.RadioButton;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.i18n.lang.Languages;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PRadioButton extends RadioButton
   {
      
      public var flarabyAS3:FlarabyAS3;
      
      public function PRadioButton()
      {
         super();
         this.focusEnabled = false;
         this.tabEnabled = false;
         this.textField.width = 0;
         this.textField.embedFonts = Languages.isActiveLanguageEmdedded();
         this.textField.antiAliasType = "advanced";
         if(Languages.activeLanguageId == "ar")
         {
            flarabyAS3 = new FlarabyAS3();
         }
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
         }
         if(param1 is Bitmap)
         {
            return new Bitmap((param1 as Bitmap).bitmapData);
         }
         return super.getDisplayObjectInstance(param1);
      }
      
      override public function set label(param1:String) : void
      {
         if(flarabyAS3 != null)
         {
            super.label = flarabyAS3.convertArabicString(param1,this.textField.width,this.textField.getTextFormat());
         }
         else
         {
            super.label = param1;
         }
      }
   }
}

