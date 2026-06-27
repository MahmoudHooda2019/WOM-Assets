package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomGreenLargeButton extends WomLargeButton
   {
      
      public function WomGreenLargeButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.GREEN_BUTTON_FILTER;
      }
   }
}

