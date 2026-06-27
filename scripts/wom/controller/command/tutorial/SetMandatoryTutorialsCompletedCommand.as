package wom.controller.command.tutorial
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.UserInfo;
   import wom.model.message.request.SetMandatoryTutorialCompletedRequest;
   import wom.util.HasoffersUtil;
   
   public class SetMandatoryTutorialsCompletedCommand extends PCommand
   {
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function SetMandatoryTutorialsCompletedCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         userInfo.mandatoryTutorialCompleted = true;
         dispatch(new OutgoingMessageEvent("outgoingMessage",new SetMandatoryTutorialCompletedRequest()));
         coreManager.buildBeastCage();
         if(ExternalInterface.available)
         {
            ExternalInterface.call("gameClient.tutorial.finish");
            ExternalInterface.call("gameClient.startnow.check");
            ExternalInterface.call("WOM.buybuddy.track",2);
         }
         HasoffersUtil.trackAction("849493960");
      }
   }
}

