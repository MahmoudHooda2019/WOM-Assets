package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomGreenSmallButton extends WomSmallButton
   {
      
      public function WomGreenSmallButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.GREEN_BUTTON_FILTER;
      }
   }
}

