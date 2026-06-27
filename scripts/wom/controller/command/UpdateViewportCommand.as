package wom.controller.command
{
   import peak.display.ViewportResizeEvent;
   import wom.controller.PCommand;
   import wom.model.game.UserInfo;
   
   public class UpdateViewportCommand extends PCommand
   {
      
      [Inject]
      public var viewportResizeEvent:ViewportResizeEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function UpdateViewportCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         userInfo.viewport = viewportResizeEvent.viewport;
      }
   }
}

