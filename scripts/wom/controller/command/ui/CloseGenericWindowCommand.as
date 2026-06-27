package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.ui.CloseGenericWindowEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.GenericWindow;
   
   public class CloseGenericWindowCommand extends PCommand
   {
      
      [Inject]
      public var event:CloseGenericWindowEvent;
      
      public function CloseGenericWindowCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:GenericWindow = event.genericWindow;
         var _loc2_:WindowEnumeration = null;
         if(_loc1_ != null)
         {
            if(_loc1_.windowEnumerations != null && _loc1_.windowEnumerations.length > 0)
            {
               _loc2_ = _loc1_.windowEnumerations.pop();
               if(_loc1_.windowEnumerations.length > 0)
               {
                  _loc2_.attributes.windowEnumerations = _loc1_.windowEnumerations;
               }
            }
            dispatch(new PopUpWindowEvent("closePopUpWindow",_loc1_));
            if(_loc2_ != null)
            {
               dispatch(new WindowCreationEvent("createWindow",_loc2_));
            }
         }
      }
   }
}

