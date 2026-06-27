package wom.controller.command.ui
{
   import wom.controller.PCommand;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.ui.MobileCloseGenericWindowEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileCloseGenericWindowCommand extends PCommand
   {
      
      [Inject]
      public var event:MobileCloseGenericWindowEvent;
      
      public function MobileCloseGenericWindowCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:MobileGenericWindow = event.mobileGenericWindow;
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
            dispatch(new MobilePopUpWindowEvent("closePopUpWindow",_loc1_));
            if(_loc2_ != null)
            {
               dispatch(new WindowCreationEvent("createWindow",_loc2_));
            }
         }
      }
   }
}

