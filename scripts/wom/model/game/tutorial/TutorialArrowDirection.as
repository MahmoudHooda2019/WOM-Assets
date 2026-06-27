package wom.model.game.tutorial
{
   public class TutorialArrowDirection
   {
      
      public static const NONE:TutorialArrowDirection = new TutorialArrowDirection(0);
      
      public static const RIGHT:TutorialArrowDirection = new TutorialArrowDirection(1);
      
      public static const BOTTOM:TutorialArrowDirection = new TutorialArrowDirection(2);
      
      public static const LEFT:TutorialArrowDirection = new TutorialArrowDirection(3);
      
      public static const TOP:TutorialArrowDirection = new TutorialArrowDirection(4);
      
      private var _id:int;
      
      public function TutorialArrowDirection(param1:int)
      {
         super();
         _id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

