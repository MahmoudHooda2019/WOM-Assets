package peak.component
{
   import fl.controls.Button;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import peak.display.ButtonCursorManager;
   import peak.i18n.lang.Languages;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PButton extends Button
   {
      
      public function PButton(param1:Boolean = false)
      {
         super();
         this.label = "";
         this.buttonMode = true;
         this.useHandCursor = true;
         this.focusEnabled = false;
         this.tabEnabled = false;
         this.textField.width = 0;
         this.textField.embedFonts = Languages.isActiveLanguageEmdedded();
         this.textField.antiAliasType = "advanced";
         if(param1 || getStyleValue("useCustomCursor"))
         {
            instanceStyles["cursorManager"] = new ButtonCursorManager(this);
         }
      }
      
      public static function getStyleDefinition() : Object
      {
         return mergeStyles(Button.getStyleDefinition(),{"useCustomCursor":false});
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
   }
}

