package wom.view.component.button.colored
{
   import flash.filters.GlowFilter;
   import wom.view.component.WomTextFormats;
   
   public class WomBlueSmallButton extends WomSmallButton
   {
      
      public function WomBlueSmallButton()
      {
         super();
      }
      
      override protected function get captionFilter() : GlowFilter
      {
         return WomTextFormats.BLUE_BUTTON_FILTER;
      }
   }
}

