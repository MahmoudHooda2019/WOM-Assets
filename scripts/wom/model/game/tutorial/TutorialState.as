package wom.model.game.tutorial
{
   import flash.utils.Dictionary;
   
   public class TutorialState
   {
      
      public static const HIDDEN_STATE_ID:String = "-1";
      
      private var _id:String;
      
      private var _window:TutorialWindow;
      
      private var _pointedArea:TutorialPointedArea;
      
      private var _mask:TutorialMask;
      
      private var _additionalInfo:Dictionary;
      
      private var _persistAfterCompletion:Boolean;
      
      public function TutorialState(param1:String, param2:TutorialWindow, param3:TutorialPointedArea, param4:TutorialMask, param5:Boolean)
      {
         super();
         _id = param1;
         _window = param2 != null ? param2 : new TutorialWindow();
         _pointedArea = param3 != null ? param3 : new TutorialPointedArea();
         _mask = param4 != null ? param4 : TutorialMask.VISIBLE;
         _additionalInfo = new Dictionary();
         _persistAfterCompletion = param5;
      }
      
      public function get id() : String
      {
         return _id;
      }
      
      public function get window() : TutorialWindow
      {
         return _window;
      }
      
      public function get pointedArea() : TutorialPointedArea
      {
         return _pointedArea;
      }
      
      public function get mask() : TutorialMask
      {
         return _mask;
      }
      
      public function get additionalInfo() : Dictionary
      {
         return _additionalInfo;
      }
      
      public function get persistAfterCompletion() : Boolean
      {
         return _persistAfterCompletion;
      }
   }
}

