package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomRedSmallButton extends WomSmallButton
   {
      
      public function WomRedSmallButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.RED_BUTTON_FILTER;
      }
   }
}

