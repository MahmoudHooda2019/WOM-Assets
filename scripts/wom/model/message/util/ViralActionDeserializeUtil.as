package wom.model.message.util
{
   import flash.utils.Dictionary;
   import wom.model.game.viral.ViralAction;
   
   public class ViralActionDeserializeUtil
   {
      
      public function ViralActionDeserializeUtil()
      {
         super();
      }
      
      public static function createViralAction(param1:Object) : ViralAction
      {
         var _loc3_:* = null;
         var _loc2_:Dictionary = new Dictionary();
         if(param1.type == "questCompleted")
         {
            _loc2_["questDTO"] = QuestDeserializeUtil.createQuestDTO(param1,"questDefinition");
         }
         else
         {
            for(var _loc4_ in param1)
            {
               if(_loc4_ != "type")
               {
                  _loc2_[_loc4_] = param1[_loc4_];
               }
            }
         }
         return new ViralAction(param1.type,_loc2_);
      }
   }
}

