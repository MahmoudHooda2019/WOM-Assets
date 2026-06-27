package wom.view.component.progressbar
{
   import peak.component.mobile.MPBitmapFontTextFormat;
   
   public class MobileNoBgProgressBar extends MobileWomProgressBar
   {
      
      public function MobileNoBgProgressBar(param1:String, param2:String, param3:int, param4:MPBitmapFontTextFormat, param5:int = -1)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override protected function refreshBackground() : void
      {
         super.refreshBackground();
         if(this.currentBackground)
         {
            this.currentBackground.visible = false;
         }
      }
   }
}

