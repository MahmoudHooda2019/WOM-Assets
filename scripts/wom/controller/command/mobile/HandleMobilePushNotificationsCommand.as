package wom.controller.command.mobile
{
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobilePushNotificationsEvent;
   import wom.service.mobile.MobilePushNotificationsService;
   
   public class HandleMobilePushNotificationsCommand extends PCommand
   {
      
      [Inject]
      public var event:MobilePushNotificationsEvent;
      
      [Inject]
      public var mobilePushNotificationsService:MobilePushNotificationsService;
      
      public function HandleMobilePushNotificationsCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:String = event.type;
         if("setupMobilePushNotificationsService" === _loc1_)
         {
            mobilePushNotificationsService.init();
         }
      }
   }
}

