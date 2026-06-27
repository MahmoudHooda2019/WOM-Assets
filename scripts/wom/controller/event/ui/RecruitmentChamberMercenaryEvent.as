package wom.controller.event.ui
{
   import flash.events.Event;
   
   public class RecruitmentChamberMercenaryEvent extends Event
   {
      
      public static const SELECTED:String = "recruitmentChamberMercenarySelected";
      
      private var _mercenaryId:int;
      
      public function RecruitmentChamberMercenaryEvent(param1:String, param2:int)
      {
         super(param1);
         this._mercenaryId = param2;
      }
      
      override public function clone() : Event
      {
         return new RecruitmentChamberMercenaryEvent(type,_mercenaryId);
      }
      
      public function get mercenaryId() : int
      {
         return _mercenaryId;
      }
   }
}

