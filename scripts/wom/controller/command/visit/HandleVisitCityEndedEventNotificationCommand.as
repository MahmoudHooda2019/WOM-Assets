package wom.controller.command.visit
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.help.HelpInfo;
   import wom.view.screen.popups.help.MobileHelpedFriendPopUp;
   
   public class HandleVisitCityEndedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function HandleVisitCityEndedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:Dictionary = new Dictionary();
         var _loc1_:int = 0;
         for(var _loc4_ in userInfo.helps)
         {
            _loc3_[_loc4_] = new Vector.<HelpInfo>();
            for each(var _loc2_ in userInfo.helps[_loc4_])
            {
               _loc3_[_loc4_].push(_loc2_.clone());
            }
            userInfo.helps[_loc4_].length = 0;
            delete userInfo.helps[_loc4_];
            _loc1_++;
         }
         if(_loc1_ > 0 && userInfo.mandatoryTutorialCompleted)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHelpedFriendPopUp(_loc3_)));
         }
      }
   }
}

