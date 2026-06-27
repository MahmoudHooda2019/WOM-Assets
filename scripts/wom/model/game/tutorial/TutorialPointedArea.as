package wom.model.game.tutorial
{
   import flash.geom.Rectangle;
   
   public class TutorialPointedArea
   {
      
      private var _enabled:Boolean;
      
      private var _alignmentReference:TutorialAlignmentReferenceType;
      
      private var _rect:Rectangle;
      
      private var _arrowDirection:TutorialArrowDirection;
      
      private var _shape:TutorialPointedAreaShape;
      
      private var _arrowMarginX:int;
      
      private var _arrowMarginY:int;
      
      public function TutorialPointedArea(param1:Boolean = false, param2:TutorialAlignmentReferenceType = null, param3:Rectangle = null, param4:TutorialArrowDirection = null, param5:TutorialPointedAreaShape = null, param6:int = 0, param7:int = 0)
      {
         super();
         _enabled = param1;
         if(_enabled)
         {
            _alignmentReference = param2 != null ? param2 : TutorialAlignmentReferenceType.TOP_LEFT;
            _rect = param3 != null ? param3 : new Rectangle(0,0,1,1);
            _arrowDirection = param4 != null ? param4 : TutorialArrowDirection.NONE;
            _shape = param5 != null ? param5 : TutorialPointedAreaShape.ELLIPSE;
            _arrowMarginX = param6;
            _arrowMarginY = param7;
         }
      }
      
      public function get enabled() : Boolean
      {
         return _enabled;
      }
      
      public function get alignmentReference() : TutorialAlignmentReferenceType
      {
         return _alignmentReference;
      }
      
      public function get rect() : Rectangle
      {
         return _rect;
      }
      
      public function get arrowDirection() : TutorialArrowDirection
      {
         return _arrowDirection;
      }
      
      public function get shape() : TutorialPointedAreaShape
      {
         return _shape;
      }
      
      public function get arrowMarginX() : int
      {
         return _arrowMarginX;
      }
      
      public function get arrowMarginY() : int
      {
         return _arrowMarginY;
      }
   }
}

