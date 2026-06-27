package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomOrangeSmallButton extends WomSmallButton
   {
      
      public function WomOrangeSmallButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.ORANGE_BUTTON_FILTER;
      }
   }
}

