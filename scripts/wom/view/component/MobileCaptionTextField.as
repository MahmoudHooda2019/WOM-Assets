package wom.view.component
{
   import peak.i18n.PText;
   
   public class MobileCaptionTextField extends MobileWomTextField
   {
      
      public function MobileCaptionTextField()
      {
         super();
      }
      
      override public function set text(param1:String) : void
      {
         var _loc2_:String = param1;
         super.text = peak.i18n.PText.INSTANCE.activeLanguage.stringTools.toUpperCase(_loc2_);
      }
   }
}

