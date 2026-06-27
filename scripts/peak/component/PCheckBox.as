package peak.component
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import fl.controls.CheckBox;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.display.ButtonCursorManager;
   import peak.i18n.lang.Languages;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PCheckBox extends CheckBox
   {
      
      public var flarabyAS3:FlarabyAS3;
      
      public function PCheckBox(param1:Boolean = false)
      {
         super();
         this.focusEnabled = false;
         this.tabEnabled = false;
         this.useHandCursor = true;
         if(param1 || getStyleValue("useCustomCursor"))
         {
            instanceStyles["cursorManager"] = new ButtonCursorManager(this);
         }
         if(Languages.activeLanguageId == "ar")
         {
            flarabyAS3 = new FlarabyAS3();
         }
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(CheckBox.getStyleDefinition(),{"useCustomCursor":false});
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is Bitmap)
         {
            return new Bitmap((param1 as Bitmap).bitmapData);
         }
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
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

