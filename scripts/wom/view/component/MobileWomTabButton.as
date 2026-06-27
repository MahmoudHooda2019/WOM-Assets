package wom.view.component
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   
   public class MobileWomTabButton extends MPButton
   {
      
      public function MobileWomTabButton()
      {
         super();
         setPaddings(0,0,15,15);
      }
      
      override public function set label(param1:String) : void
      {
         var _loc2_:String = param1;
         super.label = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
      }
   }
}

