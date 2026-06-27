package wom.controller.command.guest
{
   import flash.events.Event;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.response.guest.SetAvatarResponse;
   
   public class HandleSetAvatarResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleSetAvatarResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:SetAvatarResponse = messageReceivedEvent.message as SetAvatarResponse;
         userInfo.profile.avatar = _loc1_.avatarId + ":" + _loc1_.name;
         dispatch(new ModelUpdateEvent("mobileIdUpdated"));
         dispatch(new ChatClientEvent("connectToChatServer"));
      }
      
      override protected function dispatch(param1:Event) : Boolean
      {
         return super.dispatch(param1);
      }
   }
}

