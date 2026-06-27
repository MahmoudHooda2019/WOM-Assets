package wom.controller.command.visit
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.game.VisitInfo;
   import wom.model.game.viral.UserNotification;
   
   public class HandleDailyPerUserHelpCapacityReachedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function HandleDailyPerUserHelpCapacityReachedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:String = "";
         _loc1_ = "IconRPL";
         var _temp_6:* = §§findproperty(UserNotificationEvent);
         var _temp_5:* = "userNotificationEventShow";
         var _temp_4:* = §§findproperty(UserNotification);
         var _temp_3:* = 4;
         var _temp_2:* = 0;
         var _temp_1:* = _loc1_;
         var _loc2_:String = "ui.notification.visitcomplete";
         dispatch(new UserNotificationEvent(_temp_5,new UserNotification(_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_))));
      }
   }
}

