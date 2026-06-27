package wom.view.mediator.screen.windows.general
{
   import starling.events.Event;
   import wom.model.game.window.WindowEnumeration;
   import wom.service.mobile.MobileExternalPages;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.general.MobileGeneralInformationWindow;
   
   public class MobileGeneralInformationWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileGeneralInformationWindow;
      
      [Inject]
      public var mobileExternalPagesService:MobileExternalPages;
      
      public function MobileGeneralInformationWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.faqButton,"triggered",onFaqButtonClicked,Event);
         eventMap.mapStarlingListener(view.guidesButton,"triggered",onPlayerGuidesButtonClicked,Event);
         eventMap.mapStarlingListener(view.contactButton,"triggered",onContactSupportButtonClicked,Event);
      }
      
      private function onFaqButtonClicked(param1:Event) : void
      {
         mobileExternalPagesService.openURL("faq");
      }
      
      private function onPlayerGuidesButtonClicked(param1:Event) : void
      {
         mobileExternalPagesService.openURL("playerguide");
      }
      
      private function onContactSupportButtonClicked(param1:Event) : void
      {
         view.addWindowEnumeration(new WindowEnumeration(-9,{"womview":view}));
         view.addWindowEnumeration(new WindowEnumeration(204,{}));
         closeWindow();
      }
   }
}

