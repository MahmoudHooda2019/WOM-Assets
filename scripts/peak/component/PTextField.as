package peak.component
{
   import com.arabicode.text.Flaraby.FlarabyAS3;
   import flash.text.TextField;
   import peak.i18n.lang.Languages;
   
   public class PTextField extends TextField
   {
      
      private var _flarabyAS3:FlarabyAS3;
      
      private var _flarabyAS3Data:String;
      
      public function PTextField(param1:Boolean = false)
      {
         super();
         this.embedFonts = Languages.isActiveLanguageEmdedded();
         this.antiAliasType = "advanced";
         this.selectable = param1;
         if(Languages.activeLanguageId == "ar")
         {
            _flarabyAS3 = new FlarabyAS3();
            _flarabyAS3.extraCharWidth = 2;
            _flarabyAS3Data = "";
         }
      }
      
      override public function set text(param1:String) : void
      {
         if(_flarabyAS3 != null)
         {
            _flarabyAS3Data = param1 != null ? param1 : "";
            super.text = _flarabyAS3.convertArabicString(_flarabyAS3Data,this.width,this.getTextFormat());
         }
         else
         {
            super.text = param1;
         }
      }
      
      override public function set htmlText(param1:String) : void
      {
         if(_flarabyAS3 != null)
         {
            _flarabyAS3.html = true;
            _flarabyAS3Data = param1 != null ? param1 : "";
            super.htmlText = _flarabyAS3.convertArabicString(_flarabyAS3Data,this.width,this.getTextFormat());
         }
         else
         {
            super.htmlText = param1;
         }
      }
      
      override public function appendText(param1:String) : void
      {
         if(_flarabyAS3 != null)
         {
            var _temp_1:* = §§findproperty(_flarabyAS3Data);
            _flarabyAS3Data += param1 != null ? param1 : "";
            super.appendText(_flarabyAS3.convertArabicString(param1,this.width,this.getTextFormat()));
         }
         else
         {
            super.appendText(param1);
         }
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         if(_flarabyAS3 != null)
         {
            _flarabyAS3.width = param1;
            if(_flarabyAS3.html)
            {
               super.htmlText = _flarabyAS3.convertArabicString(_flarabyAS3Data,param1,this.getTextFormat());
            }
            else
            {
               super.text = _flarabyAS3.convertArabicString(_flarabyAS3Data,param1,this.getTextFormat());
            }
         }
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         if(_flarabyAS3 != null)
         {
            _flarabyAS3.height = param1;
         }
      }
      
      override public function set multiline(param1:Boolean) : void
      {
         super.multiline = param1;
         if(_flarabyAS3 != null)
         {
            _flarabyAS3.multiline = param1;
         }
      }
      
      public function set extraCharWidth(param1:Number) : void
      {
         if(_flarabyAS3 != null && !isNaN(param1))
         {
            _flarabyAS3.extraCharWidth = param1;
         }
      }
   }
}

