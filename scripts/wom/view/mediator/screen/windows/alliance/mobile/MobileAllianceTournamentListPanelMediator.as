package wom.view.mediator.screen.windows.alliance.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.message.request.alliance.GetRequestedAlliancesRequest;
   import wom.model.message.request.alliance.GetTournamentsPageRequest;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentListPanel;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceTournamentTipsPopUp;
   
   public class MobileAllianceTournamentListPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAllianceTournamentListPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileAllianceTournamentListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         view.myAllianceSummary = allianceInfo.myAllianceSummary;
         eventMap.mapStarlingListener(view.helpButton,"triggered",onHintClicked,Event);
         eventMap.mapStarlingListener(view.tournamentAttackButton,"triggered",onTournamentAttackClicked,Event);
         eventMap.mapStarlingListener(view.attackWithGoldButton,"triggered",onAttackWithGoldClicked,Event);
         mapListeners();
         performServerRequests();
         view.updateDurationRelatedFields(userInfo.tournamentNextAttackRemainingDuration,userInfo.tournamentRemainingDuration,userInfo.tournamentStartRemainingDuration);
      }
      
      private function onAttackWithGoldClicked(param1:Event) : void
      {
         dispatch(new StartAttackEvent("startAttack",null,false,false,true,true,false,false,true,true));
      }
      
      private function onTournamentAttackClicked(param1:Event) : void
      {
         dispatch(new StartAttackEvent("startAttack",null,false,false,true,true,false,false,true));
      }
      
      protected function performServerRequests() : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetRequestedAlliancesRequest()));
         if(view.alliances == null || view.alliances.length <= 0)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetTournamentsPageRequest(1,false,50)));
         }
      }
      
      protected function mapListeners() : void
      {
         addContextListener("tournamentsInfoUpdated",onAllianceTournamentRankingInfoUpdated,ModelUpdateEvent);
         addContextListener("tick",onTick);
      }
      
      private function onHintClicked(param1:Event) : void
      {
         dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileAllianceTournamentTipsPopUp()));
      }
      
      private function onAllianceTournamentRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(allianceInfo.tournamentsRankingInfo != null)
         {
            view.update(allianceInfo.tournamentsRankingInfo);
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         view.updateDurationRelatedFields(userInfo.tournamentNextAttackRemainingDuration,userInfo.tournamentRemainingDuration,userInfo.tournamentStartRemainingDuration);
      }
   }
}

