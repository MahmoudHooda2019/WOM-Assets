package wom.model.game.tutorial
{
   public class TutorialPointedAreaShape
   {
      
      public static const TYPE_ROUND_RECT:int = 1;
      
      public static const TYPE_ELLIPSE:int = 2;
      
      public static const TYPE_CUSTOM:int = 3;
      
      public static const TYPE_NONE:int = 4;
      
      public static const ROUND_RECT:TutorialPointedAreaShape = new TutorialPointedAreaShape(1);
      
      public static const ELLIPSE:TutorialPointedAreaShape = new TutorialPointedAreaShape(2);
      
      public static const NONE:TutorialPointedAreaShape = new TutorialPointedAreaShape(4);
      
      private var _type:int;
      
      private var _customCoordinates:Vector.<Number>;
      
      private var _customCommands:Vector.<int>;
      
      public function TutorialPointedAreaShape(param1:int, param2:Vector.<Number> = null, param3:Vector.<int> = null)
      {
         super();
         _type = param1;
         _customCoordinates = param2;
         _customCommands = param3;
      }
      
      public static function createCustomShape(param1:Vector.<Number>, param2:Vector.<int> = null) : TutorialPointedAreaShape
      {
         return new TutorialPointedAreaShape(3,param1,param2);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get customCoordinates() : Vector.<Number>
      {
         return _customCoordinates;
      }
      
      public function get customCommands() : Vector.<int>
      {
         return _customCommands;
      }
   }
}

