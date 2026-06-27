package wom.model.game.chat
{
   public class ChatMessageType
   {
      
      public static const UNKNOWN:ChatMessageType = new ChatMessageType(0,"Unknown");
      
      public static const WORLD:ChatMessageType = new ChatMessageType(1,"World");
      
      public static const ALLIANCE:ChatMessageType = new ChatMessageType(2,"Alliance");
      
      private var _id:int;
      
      private var _name:String;
      
      public function ChatMessageType(param1:int, param2:String)
      {
         super();
         this._id = param1;
         this._name = param2;
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get name() : String
      {
         return _name;
      }
   }
}

