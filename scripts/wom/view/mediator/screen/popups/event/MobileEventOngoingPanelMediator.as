package wom.view.mediator.screen.popups.event
{
   import starling.events.Event;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.popups.event.MobileEventOngoingPanel;
   
   public class MobileEventOngoingPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileEventOngoingPanel;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileEventOngoingPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         view.setBackgroundImageName(documentConfiguration.eventOngoingBackgroundImageName);
         super.onRegister();
         eventMap.mapStarlingListener(view.howToPlayButton,"triggered",onHowToPlayButtonClicked,Event);
      }
      
      private function onHowToPlayButtonClicked(param1:Event) : void
      {
         view.toggleHelpContent();
      }
   }
}

