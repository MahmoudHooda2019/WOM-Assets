package wom.view.component
{
   import fl.controls.RadioButtonGroup;
   import flash.display.DisplayObjectContainer;
   
   public class WomGiftGoldRadioButton extends WomRadioButton
   {
      
      public function WomGiftGoldRadioButton()
      {
         super();
      }
      
      public static function createAndAdd(param1:DisplayObjectContainer, param2:Object, param3:RadioButtonGroup) : WomGiftGoldRadioButton
      {
         var _loc4_:WomGiftGoldRadioButton = new WomGiftGoldRadioButton();
         _loc4_.width = _loc4_.height = 19;
         _loc4_.textField.width = _loc4_.textField.height = 0;
         _loc4_.value = param2;
         _loc4_.group = param3;
         param1.addChild(_loc4_);
         return _loc4_;
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
      }
   }
}

