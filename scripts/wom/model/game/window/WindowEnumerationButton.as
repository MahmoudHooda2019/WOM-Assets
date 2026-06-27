package wom.model.game.window
{
   import fl.controls.Button;
   
   public class WindowEnumerationButton
   {
      
      private var _enumeration:WindowEnumeration;
      
      private var _button:Button;
      
      private var _buttonIconAssetId:String;
      
      public function WindowEnumerationButton(param1:WindowEnumeration, param2:Button, param3:String = null)
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
      
      public function get button() : Button
      {
         return _button;
      }
      
      public function get buttonIconAssetId() : String
      {
         return _buttonIconAssetId;
      }
   }
}

