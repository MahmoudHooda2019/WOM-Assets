package wom.model.component.enum
{
   public class CanvasMode
   {
      
      public static const NORMAL:CanvasMode = new CanvasMode(0,"Normal");
      
      public static const BUILD:CanvasMode = new CanvasMode(1,"Build");
      
      public static const MOVE:CanvasMode = new CanvasMode(2,"Move");
      
      public static const MOBILE_SELECT:CanvasMode = new CanvasMode(3,"MobileSelect");
      
      public static const MOBILE_CATAPULT:CanvasMode = new CanvasMode(4,"MobileCatapult");
      
      public static const MOBILE_SIEGE_TOWER:CanvasMode = new CanvasMode(5,"MobileSiegeTower");
      
      public static const canvasModes:Array = [NORMAL,BUILD,MOVE,MOBILE_SELECT,MOBILE_CATAPULT,MOBILE_SIEGE_TOWER];
      
      private var _id:int;
      
      private var _name:String;
      
      public function CanvasMode(param1:int, param2:String)
      {
         super();
         _id = param1;
         _name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

