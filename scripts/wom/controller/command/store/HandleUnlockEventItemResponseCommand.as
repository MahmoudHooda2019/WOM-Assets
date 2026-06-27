package wom.controller.command.store
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageDisplayEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.response.UnlockEventItemResponse;
   
   public class HandleUnlockEventItemResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUnlockEventItemResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:Boolean = false;
         var _loc1_:UnlockEventItemResponse = messageReceivedEvent.message as UnlockEventItemResponse;
         if(_loc1_.resultCode != 0)
         {
            eventDispatcher.dispatchEvent(new MessageDisplayEvent("messageDisplay",_loc1_.resultMessage));
         }
         else
         {
            _loc2_ = checkUnlocked(_loc1_.itemId);
            if(!_loc2_)
            {
               userInfo.unlockedEventItems.push(_loc1_.itemId);
               dispatch(new ModelUpdateEvent("eventItemsUpdated"));
            }
         }
      }
      
      private function checkUnlocked(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = userInfo.unlockedEventItems.length - 1;
         while(_loc2_ >= 0)
         {
            if(userInfo.unlockedEventItems[_loc2_] == param1)
            {
               return true;
            }
            _loc2_--;
         }
         return false;
      }
   }
}

