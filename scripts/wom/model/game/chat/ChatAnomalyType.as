package wom.model.game.chat
{
   public class ChatAnomalyType
   {
      
      public static const UNKNOWN:ChatAnomalyType = new ChatAnomalyType(0);
      
      public static const MESSAGE_REPEAT_FLOOD:ChatAnomalyType = new ChatAnomalyType(1);
      
      public static const FILTERED_WORD_EXISTS:ChatAnomalyType = new ChatAnomalyType(2);
      
      private var _id:int;
      
      public function ChatAnomalyType(param1:int)
      {
         super();
         this._id = param1;
      }
      
      public function get id() : int
      {
         return _id;
      }
   }
}

