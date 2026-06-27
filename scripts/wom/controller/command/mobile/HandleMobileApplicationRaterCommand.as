package wom.controller.command.mobile
{
   import com.distriqt.extension.applicationrater.ApplicationRater;
   import com.freshplanet.ane.AirDeviceId;
   import wom.controller.PCommand;
   import wom.controller.event.mobile.MobileApplicationRaterEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.service.mobile.MobileApplicationRaterService;
   
   public class HandleMobileApplicationRaterCommand extends PCommand
   {
      
      [Inject]
      public var event:MobileApplicationRaterEvent;
      
      [Inject]
      public var mobileApplicationRaterService:MobileApplicationRaterService;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      public function HandleMobileApplicationRaterCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         if(!ApplicationRater.isSupported)
         {
            return;
         }
         if(AirDeviceId.getInstance().isOnAndroid && !documentConfiguration.enableAndroidRater)
         {
            return;
         }
         switch(event.type)
         {
            case "setupMobileApplicationRater":
               mobileApplicationRaterService.init();
               break;
            case "significantEvent":
               mobileApplicationRaterService.significantEventOccured();
         }
      }
   }
}

