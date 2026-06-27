package wom.model.dto
{
   import wom.model.game.window.WindowEnumeration;
   
   public class TaskDTO
   {
      
      private var _taskId:int;
      
      private var _questId:int;
      
      private var _completed:Boolean;
      
      private var _skipped:Boolean;
      
      private var _progressValue:int;
      
      private var _retro:Boolean;
      
      private var _maxProgressValue:int;
      
      private var _skippable:Boolean;
      
      private var _skipCost:int;
      
      private var _highlight:WindowEnumeration;
      
      public function TaskDTO(param1:int, param2:int, param3:Boolean, param4:Boolean, param5:int, param6:Boolean, param7:int, param8:Boolean, param9:int, param10:WindowEnumeration)
      {
         super();
         _taskId = param1;
         _questId = param2;
         _completed = param3;
         _skipped = param4;
         _progressValue = param5;
         _retro = param6;
         _maxProgressValue = param7;
         _skippable = param8;
         _skipCost = param9;
         _highlight = param10;
      }
      
      public function get taskId() : int
      {
         return _taskId;
      }
      
      public function get questId() : int
      {
         return _questId;
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function get skipped() : Boolean
      {
         return _skipped;
      }
      
      public function get progressValue() : int
      {
         return _progressValue;
      }
      
      public function get retro() : Boolean
      {
         return _retro;
      }
      
      public function get maxProgressValue() : int
      {
         return _maxProgressValue;
      }
      
      public function get skippable() : Boolean
      {
         return _skippable;
      }
      
      public function get skipCost() : int
      {
         return _skipCost;
      }
      
      public function get highlight() : WindowEnumeration
      {
         return _highlight;
      }
   }
}

