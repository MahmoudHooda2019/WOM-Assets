package wom.model.game.tutorial
{
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class TutorialFocusedObject
   {
      
      private var _displayObject:DisplayObject;
      
      private var _displayObjectContainer:DisplayObjectContainer;
      
      private var _position:Point;
      
      private var _index:int;
      
      public function TutorialFocusedObject(param1:DisplayObject)
      {
         super();
         _displayObject = param1;
         _displayObjectContainer = _displayObject.parent;
         _position = new Point(_displayObject.x,_displayObject.y);
         _index = _displayObjectContainer.getChildIndex(_displayObject);
      }
      
      public function get displayObject() : DisplayObject
      {
         return _displayObject;
      }
      
      public function get displayObjectContainer() : DisplayObjectContainer
      {
         return _displayObjectContainer;
      }
      
      public function get position() : Point
      {
         return _position;
      }
      
      public function get index() : int
      {
         return _index;
      }
   }
}

