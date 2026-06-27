package wom.view.component
{
   import flash.text.TextFormat;
   import peak.component.PCheckBox;
   import wom.model.game.viral.Subscription;
   
   public class WomPigeonPostCheckBox extends PCheckBox
   {
      
      private var _subscription:Subscription;
      
      public function WomPigeonPostCheckBox(param1:Subscription)
      {
         super();
         _subscription = param1;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         this.textField.y -= 1;
      }
      
      override protected function drawTextFormat() : void
      {
         super.drawTextFormat();
         this.textField.setTextFormat(enabled ? WomTextFormats.BOLD_19 : WomTextFormats.BOLD_19_DISABLED);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         this.textField.setTextFormat(param1 ? WomTextFormats.BOLD_19 : WomTextFormats.BOLD_19_DISABLED);
         this.alpha = param1 ? 1 : 0.5;
      }
      
      public function get subscription() : Subscription
      {
         return _subscription;
      }
   }
}

