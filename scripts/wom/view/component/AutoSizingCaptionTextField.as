package wom.view.component
{
   import flash.filters.GlowFilter;
   import flash.text.TextFormat;
   
   public class AutoSizingCaptionTextField extends CaptionTextField
   {
      
      public function AutoSizingCaptionTextField(param1:GlowFilter = null, param2:Boolean = false)
      {
         super(param1,param2);
      }
      
      override public function set text(param1:String) : void
      {
         super.text = param1;
         if(textWidth > 0)
         {
            while(textWidth > width - 4 && defaultTextFormat.size > 12)
            {
               defaultTextFormat = new TextFormat(null,int(defaultTextFormat.size) - 1);
               setTextFormat(defaultTextFormat);
            }
         }
         height = this.textHeight + 4;
      }
   }
}

