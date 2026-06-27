package wom.view.component
{
   import peak.component.mobile.MPTextInput;
   
   public class MobileWomTextInput extends MPTextInput
   {
      
      public function MobileWomTextInput()
      {
         super();
         this.maxChars = 512;
         this.height = 59;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(textEditor)
         {
            textEditor.visible = param1;
         }
         super.visible = param1;
      }
      
      override public function set isEnabled(param1:Boolean) : void
      {
         if(textEditor)
         {
            textEditor.isEnabled = param1;
            textEditor.isEditable = param1;
            textEditor.visible = !param1 ? false : visible;
            textEditor.touchable = param1;
         }
         super.isEnabled = param1;
      }
   }
}

