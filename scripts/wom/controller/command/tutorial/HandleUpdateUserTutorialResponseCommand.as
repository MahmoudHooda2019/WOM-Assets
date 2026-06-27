package wom.controller.command.tutorial
{
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.model.game.UserInfo;
   import wom.model.message.response.UpdateUserTutorialResponse;
   
   public class HandleUpdateUserTutorialResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleUpdateUserTutorialResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:UpdateUserTutorialResponse = event.message as UpdateUserTutorialResponse;
         if(_loc1_.success)
         {
         }
      }
   }
}

