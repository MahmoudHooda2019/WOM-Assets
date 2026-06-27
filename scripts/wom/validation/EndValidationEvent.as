package wom.validation
{
   import flash.events.Event;
   import wom.model.dto.combat.PostBattleAttackerInfo;
   import wom.model.dto.combat.PostBattleDefenderInfo;
   
   public class EndValidationEvent extends Event
   {
      
      public static const END_BATTLE_VALIDATION:String = "endBattleValidation";
      
      private var _postBattleDefenderInfo:PostBattleDefenderInfo;
      
      private var _postBattleAttackerInfo:PostBattleAttackerInfo;
      
      public function EndValidationEvent(param1:String, param2:PostBattleDefenderInfo, param3:PostBattleAttackerInfo)
      {
         super(param1);
         _postBattleDefenderInfo = param2;
         _postBattleAttackerInfo = param3;
      }
      
      override public function clone() : Event
      {
         return new EndValidationEvent(type,_postBattleDefenderInfo,_postBattleAttackerInfo);
      }
      
      public function get postBattleDefenderInfo() : PostBattleDefenderInfo
      {
         return _postBattleDefenderInfo;
      }
      
      public function get postBattleAttackerInfo() : PostBattleAttackerInfo
      {
         return _postBattleAttackerInfo;
      }
   }
}

