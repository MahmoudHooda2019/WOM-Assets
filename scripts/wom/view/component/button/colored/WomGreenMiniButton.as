package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomGreenMiniButton extends WomMiniButton
   {
      
      public function WomGreenMiniButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.GREEN_BUTTON_FILTER;
      }
   }
}

