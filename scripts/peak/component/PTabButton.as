package peak.component
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import com.yahoo.astra.fl.controls.tabBarClasses.TabButton;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import peak.display.ButtonCursorManager;
   import peak.i18n.lang.Languages;
   import peak.resource.asset.display.AssetDisplayObject;
   
   public class PTabButton extends TabButton
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _flarabyAS3Data:String;
      
      public function PTabButton(param1:Boolean = false)
      {
         super();
         this.label = "";
         if(param1 || getStyleValue("useCustomCursor"))
         {
            instanceStyles["cursorManager"] = new ButtonCursorManager(this);
         }
         if(Languages.activeLanguageId == "ar")
         {
            _flarabyAS3 = new FlarabyAS3();
            _flarabyAS3Data = "";
         }
      }
      
      override protected function getDisplayObjectInstance(param1:Object) : DisplayObject
      {
         if(param1 is AssetDisplayObject)
         {
            return (param1 as AssetDisplayObject).clone();
         }
         if(param1 is BitmapData)
         {
            return new Bitmap(param1 as BitmapData);
         }
         return super.getDisplayObjectInstance(param1);
      }
      
      override public function set label(param1:String) : void
      {
         if(_flarabyAS3 != null)
         {
            _flarabyAS3Data = param1 != null ? param1 : "";
            super.label = _flarabyAS3.convertArabicString(_flarabyAS3Data,this.textField.width,this.textField.getTextFormat());
         }
         else
         {
            super.label = param1;
         }
      }
      
      override public function get label() : String
      {
         if(_flarabyAS3 != null)
         {
            return _flarabyAS3Data;
         }
         return super.label;
      }
   }
}

