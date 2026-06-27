package wom.model.game.window
{
   import wom.view.component.button.MobileWomButton;
   
   public class MobileWindowEnumerationButton
   {
      
      private var _enumeration:WindowEnumeration;
      
      private var _button:MobileWomButton;
      
      private var _buttonIconAssetId:String;
      
      public function MobileWindowEnumerationButton(param1:WindowEnumeration, param2:MobileWomButton, param3:String = null)
      {
         super();
         _enumeration = param1;
         _button = param2;
         _buttonIconAssetId = param3;
      }
      
      public function get enumeration() : WindowEnumeration
      {
         return _enumeration;
      }
      
      public function get button() : MobileWomButton
      {
         return _button;
      }
      
      public function get buttonIconAssetId() : String
      {
         return _buttonIconAssetId;
      }
   }
}

