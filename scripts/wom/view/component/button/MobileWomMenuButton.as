package wom.view.component.button
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   
   public class MobileWomMenuButton extends MobileWomButton
   {
      
      private var _iconMargin:int;
      
      public function MobileWomMenuButton(param1:String, param2:String, param3:MPBitmapFontTextFormat, param4:int = 0, param5:int = 0, param6:String = null)
      {
         _iconMargin = param5;
         super("Transparent",param1,param2,param3,param4,param6);
      }
      
      override protected function positionLabelAndIcon() : void
      {
         super.positionLabelAndIcon();
         if(currentIcon)
         {
            currentIcon.y = (height - currentIcon.height) / 2 + _iconMargin + (_currentState == "down" ? 3 : 0);
         }
         labelTextRenderer.y += _yMargin + (_currentState == "down" ? 3 : 0);
      }
      
      override protected function layoutContent() : void
      {
         autoSizeTextRenderers();
         if(currentIcon)
         {
            currentIcon.x = width - currentIcon.width >> 1;
            currentIcon.y = (height - currentIcon.height) / 2 + _iconMargin + (_currentState == "down" ? 3 : 0);
         }
         labelTextRenderer.validate();
         labelTextRenderer.x = (width - labelTextRenderer.width >> 1) - 1;
         labelTextRenderer.y = (height >> 1) + _yMargin + (_currentState == "down" ? 3 : 0);
      }
      
      override protected function determinePaddedIconWidth() : Number
      {
         return 0;
      }
   }
}

