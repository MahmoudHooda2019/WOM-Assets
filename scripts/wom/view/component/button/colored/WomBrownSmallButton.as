package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomBrownSmallButton extends WomSmallButton
   {
      
      public function WomBrownSmallButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.BROWN_BUTTON_FILTER;
      }
   }
}

