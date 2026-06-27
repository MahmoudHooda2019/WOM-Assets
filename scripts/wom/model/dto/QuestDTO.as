package wom.model.dto
{
   public class QuestDTO
   {
      
      private var _questId:int;
      
      private var _order:int;
      
      private var _family:String;
      
      private var _rewards:Vector.<QuestRewardDTO>;
      
      private var _visualId:String;
      
      private var _completed:Boolean;
      
      private var _claiming:Boolean;
      
      private var _tasks:Vector.<TaskDTO>;
      
      public function QuestDTO(param1:int, param2:int, param3:String, param4:Vector.<QuestRewardDTO>, param5:String, param6:Boolean, param7:Vector.<TaskDTO>)
      {
         super();
         _questId = param1;
         _order = param2;
         _family = param3;
         _rewards = param4;
         _visualId = param5;
         _completed = param6;
         _tasks = param7;
         _claiming = false;
      }
      
      public function get questId() : int
      {
         return _questId;
      }
      
      public function get order() : int
      {
         return _order;
      }
      
      public function get family() : String
      {
         return _family;
      }
      
      public function get rewards() : Vector.<QuestRewardDTO>
      {
         return _rewards;
      }
      
      public function get visualId() : String
      {
         return _visualId;
      }
      
      public function get completed() : Boolean
      {
         return _completed;
      }
      
      public function get tasks() : Vector.<TaskDTO>
      {
         return _tasks;
      }
      
      public function get claiming() : Boolean
      {
         return _claiming;
      }
      
      public function set claiming(param1:Boolean) : void
      {
         _claiming = param1;
      }
   }
}

