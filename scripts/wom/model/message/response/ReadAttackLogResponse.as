package wom.model.message.response
{
   public class ReadAttackLogResponse extends DefaultResponse
   {
      
      private var _attackLogId:Number;
      
      private var _markAllAsRead:Boolean;
      
      public function ReadAttackLogResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         super.deserialize(param1);
         _attackLogId = param1.attackLogId;
         _markAllAsRead = param1.markAllAsRead;
      }
      
      public function get attackLogId() : Number
      {
         return _attackLogId;
      }
      
      public function get markAllAsRead() : Boolean
      {
         return _markAllAsRead;
      }
   }
}

