package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomRedLargeButton extends WomLargeButton
   {
      
      public function WomRedLargeButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.RED_BUTTON_FILTER;
      }
   }
}

