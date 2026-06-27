package wom.controller.command.inbox
{
   import flash.external.ExternalInterface;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.view.screen.popups.InboxEmptyPopUp;
   
   public class OpenInboxWindowCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function OpenInboxWindowCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(ExternalInterface.available && documentConfiguration.axess == null)
         {
            ExternalInterface.call("retrieveRequests");
         }
         else
         {
            dispatch(new PopUpWindowEvent("showPopUpWindow",new InboxEmptyPopUp(),0,null,null,false));
         }
      }
   }
}

