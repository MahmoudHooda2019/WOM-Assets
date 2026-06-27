package wom.model.game
{
   import starling.display.DisplayObject;
   
   public class MobilePopUpWindowInfo
   {
      
      private var _window:DisplayObject;
      
      private var _vectorPosition:int;
      
      private var _showModal:Boolean;
      
      private var _customPosition:Boolean;
      
      public function MobilePopUpWindowInfo(param1:DisplayObject, param2:int, param3:Boolean, param4:Boolean)
      {
         super();
         _window = param1;
         _vectorPosition = param2;
         _showModal = param3;
         _customPosition = param4;
      }
      
      public function get window() : DisplayObject
      {
         return _window;
      }
      
      public function get vectorPosition() : int
      {
         return _vectorPosition;
      }
      
      public function get showModal() : Boolean
      {
         return _showModal;
      }
      
      public function get customPosition() : Boolean
      {
         return _customPosition;
      }
   }
}

