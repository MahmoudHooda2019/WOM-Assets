package wom.view.component
{
   import feathers.controls.text.TextFieldTextEditor;
   
   public class MobileWomTextFieldTextEditor extends TextFieldTextEditor
   {
      
      public function MobileWomTextFieldTextEditor()
      {
         super();
      }
      
      override public function set visible(param1:Boolean) : void
      {
         if(textField)
         {
            textField.visible = param1;
         }
         super.visible = param1;
      }
   }
}

