package wom.model.message.notification
{
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.QuestDTO;
   import wom.model.message.util.QuestDeserializeUtil;
   
   public class VisibleQuestsChangedNotification extends AbstractIncomingMessage
   {
      
      private var _visibleQuests:Vector.<QuestDTO>;
      
      public function VisibleQuestsChangedNotification()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         _visibleQuests = new Vector.<QuestDTO>();
         for each(var _loc2_ in param1.visibleQuests)
         {
            _visibleQuests.push(QuestDeserializeUtil.createQuestDTO(_loc2_));
         }
      }
      
      public function get visibleQuests() : Vector.<QuestDTO>
      {
         return _visibleQuests;
      }
   }
}

