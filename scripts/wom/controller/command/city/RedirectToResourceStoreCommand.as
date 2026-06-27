package wom.controller.command.city
{
   import wom.controller.PCommand;
   import wom.controller.event.model.NotEnoughResourceEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.view.screen.windows.store.StoreWindow;
   
   public class RedirectToResourceStoreCommand extends PCommand
   {
      
      [Inject]
      public var event:NotEnoughResourceEvent;
      
      public function RedirectToResourceStoreCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         dispatch(new PopUpWindowEvent("showPopUpWindow",new StoreWindow(-1,1)));
      }
   }
}

