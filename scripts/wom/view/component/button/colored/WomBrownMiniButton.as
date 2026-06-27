package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomBrownMiniButton extends WomMiniButton
   {
      
      public function WomBrownMiniButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.BROWN_BUTTON_FILTER;
      }
   }
}

