package wom.view
{
   import wom.view.component.*;
   
   public class MobileWindowHeaderTextField extends MobileCaptionTextField
   {
      
      public function MobileWindowHeaderTextField()
      {
         super();
         this.textRendererProperties.textFormat = getCaptionTextFormat(46,"center");
      }
   }
}

