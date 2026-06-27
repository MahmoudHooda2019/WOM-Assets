package wom.view.component
{
   import flash.filters.GlowFilter;
   import peak.i18n.PText;
   
   public class CaptionTextField extends WomTextField
   {
      
      public function CaptionTextField(param1:GlowFilter = null, param2:Boolean = false)
      {
         super(param2);
         this.defaultTextFormat = WomTextFormats.CAPTION_DEFAULT;
         if(param1)
         {
            if(param1 == WomTextFormats.NO_FILTER)
            {
               this.filters = null;
            }
            else
            {
               this.filters = [param1];
            }
         }
         else
         {
            this.filters = [WomTextFormats.DEFAULT_FILTER];
         }
      }
      
      override public function set text(param1:String) : void
      {
         var _loc2_:String = param1;
         super.text = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
      }
      
      override public function appendText(param1:String) : void
      {
         var _temp_1:* = this;
         var _loc2_:String = param1;
         _temp_1.super.appendText(peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_));
      }
   }
}

