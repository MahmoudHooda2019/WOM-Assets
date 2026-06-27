package wom.view.component
{
   public class WindowHeaderTextField extends AutoSizingCaptionTextField
   {
      
      public function WindowHeaderTextField()
      {
         super(WomTextFormats.HEADER_FILTER);
         this.defaultTextFormat = WomTextFormats.CAPTION_40;
         this.defaultTextFormat = WomTextFormats.CENTER_40;
      }
   }
}

