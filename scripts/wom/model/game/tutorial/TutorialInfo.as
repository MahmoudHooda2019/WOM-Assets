package wom.model.game.tutorial
{
   public class TutorialInfo
   {
      
      private var _tutorialId:String;
      
      private var _nextTutorialId:String;
      
      private var _states:Vector.<TutorialState>;
      
      private var _currentStateIndex:int;
      
      private var _isCompleted:Boolean;
      
      public function TutorialInfo(param1:String, param2:String)
      {
         super();
         _tutorialId = param1;
         _nextTutorialId = param2;
         _states = new Vector.<TutorialState>();
         _currentStateIndex = 0;
         _isCompleted = false;
      }
      
      public function get tutorialId() : String
      {
         return _tutorialId;
      }
      
      public function get nextTutorialId() : String
      {
         return _nextTutorialId;
      }
      
      public function get states() : Vector.<TutorialState>
      {
         return _states;
      }
      
      public function get currentStateIndex() : int
      {
         return _currentStateIndex;
      }
      
      public function set currentStateIndex(param1:int) : void
      {
         _currentStateIndex = param1;
      }
      
      public function get isCompleted() : Boolean
      {
         return _isCompleted;
      }
      
      public function set isCompleted(param1:Boolean) : void
      {
         _isCompleted = param1;
      }
   }
}

