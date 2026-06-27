package wom.controller.event.ui
{
   import flash.events.Event;
   import wom.model.dto.TaskDTO;
   
   public class QuestDetailTaskReadyEvent extends Event
   {
      
      public static const READY:String = "questDetailTaskReadyEvent";
      
      private var _taskDTO:TaskDTO;
      
      public function QuestDetailTaskReadyEvent(param1:String, param2:TaskDTO)
      {
         super(param1);
         _taskDTO = param2;
      }
      
      override public function clone() : Event
      {
         return new QuestDetailTaskReadyEvent(type,_taskDTO);
      }
      
      public function get taskDTO() : TaskDTO
      {
         return _taskDTO;
      }
   }
}

