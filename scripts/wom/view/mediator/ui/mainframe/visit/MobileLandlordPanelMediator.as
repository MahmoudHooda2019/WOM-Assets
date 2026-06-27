package wom.view.mediator.ui.mainframe.visit
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.logging.LoggerContext;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.LeagueLevelDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.windows.battlepoints.MobileBattlePointsInfoWindow;
   import wom.view.screen.windows.rank.mobile.MobileLeaderboardWindow;
   import wom.view.ui.mainframe.city.MobileLandlordPanel;
   import wom.view.ui.tooltip.MobileExperiencePointsTooltipView;
   
   public class MobileLandlordPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var view:MobileLandlordPanel;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileLandlordPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("allianceInfoUpdated",onAllianceUpdated,ModelUpdateEvent);
         addContextListener("allianceSummaryUpdated",onAllianceUpdated,ModelUpdateEvent);
         addContextListener("experiencePointsUpdated",onExperiencePointsUpdated,ModelUpdateEvent);
         addContextListener("battlePointsUpdated",onBattlePointsUpdated,ModelUpdateEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addContextListener("mobileIdUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addContextListener("leagueStatusUpdated",onLeagueStatusUpdated,ModelUpdateEvent);
         addContextListener("activate",onActivateScreenEvent,ActivateScreenEvent);
         eventMap.mapStarlingListener(view.playerContainer,"touch",onTab,TouchEvent);
         eventMap.mapStarlingListener(view.scoreIcon,"touch",onScoreMouseClick,TouchEvent);
         eventMap.mapStarlingListener(view.leagueIcon,"touch",onLeagueClick,TouchEvent);
         eventMap.mapStarlingListener(view.divisionTextField,"touch",onLeagueClick,TouchEvent);
         updateUser();
         onExperiencePointsUpdated(null);
         leagueStatusUpdated();
      }
      
      private function onGameModeUpdated(param1:GameModeChangedEvent) : void
      {
         updateUser();
      }
      
      private function onLeagueClick(param1:TouchEvent) : void
      {
         var _loc2_:Touch = null;
         if(userInfo.mandatoryTutorialCompleted)
         {
            _loc2_ = param1.getTouch(param1.target as DisplayObject,"ended");
            if(_loc2_ && userInfo.gameMode == GameModeType.NORMAL)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileLeaderboardWindow()));
            }
         }
      }
      
      private function leagueStatusUpdated() : void
      {
         eventMap.unmapStarlingListener(view.leagueIcon,"touch",onLeagueClick,TouchEvent);
         eventMap.unmapStarlingListener(view.divisionTextField,"touch",onLeagueClick,TouchEvent);
         view.updateWithLeague(leagueManager.myLeague != null ? leagueManager.myLeague.levelDIO : domainInfo.getLeagueLevel(0));
         eventMap.mapStarlingListener(view.leagueIcon,"touch",onLeagueClick,TouchEvent);
         eventMap.mapStarlingListener(view.divisionTextField,"touch",onLeagueClick,TouchEvent);
      }
      
      private function onLeagueStatusUpdated(param1:ModelUpdateEvent) : void
      {
         leagueStatusUpdated();
      }
      
      private function onBattlePointsUpdated(param1:ModelUpdateEvent) : void
      {
         if(view.self)
         {
            updateWithBattlePoints(userInfo.battlePoints);
         }
      }
      
      private function updateWithBattlePoints(param1:int) : void
      {
         view.updateWithBattlePoints(param1);
      }
      
      private function onScoreMouseClick(param1:TouchEvent) : void
      {
         var _loc2_:Touch = null;
         if(userInfo.mandatoryTutorialCompleted)
         {
            _loc2_ = param1.getTouch(param1.target as DisplayObject,"ended");
            if(_loc2_)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBattlePointsInfoWindow(),null,null,null,false,userInfo.delayPopups));
            }
         }
      }
      
      private function onExperiencePointsUpdated(param1:ModelUpdateEvent) : void
      {
         updateWithExperiencePoints();
      }
      
      private function updateWithExperiencePoints() : void
      {
         var _loc1_:int = 0;
         if(view.self && !isNaN(userInfo.experiencePoints))
         {
            view.levelIcon.visible = view.levelTextField.visible = true;
            view.updateWithExperience(userInfo.experiencePoints);
            if(view.self)
            {
               _loc1_ = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
            }
         }
         else if(!view.self && city)
         {
            view.updateWithLevel(city.ownerLevel);
         }
         else
         {
            view.levelIcon.visible = view.levelTextField.visible = false;
         }
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateUser();
      }
      
      private function onActivateScreenEvent(param1:ActivateScreenEvent) : void
      {
         updateUser(param1.screen);
      }
      
      private function onAllianceUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateWithAlliance(city.ownerAlliance);
      }
      
      private function updateUser(param1:WomScreenType = null) : void
      {
         var _loc2_:Profile = null;
         view.updateWithAlliance(city.ownerAlliance);
         if(param1 == null && userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            view.updateUser(userInfo.profile,facebookAPIManager.getUserNameByProfile(userInfo.profile,true,true),NaN,true);
            updateWithBattlePoints(userInfo.battlePoints);
         }
         else if(param1 == WomScreenType.MAP || userInfo.gameMode == GameModeType.NORMAL)
         {
            view.updateUser(userInfo.profile,facebookAPIManager.getUserNameByProfile(userInfo.profile,true,true),NaN,true);
            updateWithBattlePoints(userInfo.battlePoints);
         }
         else if(param1 == WomScreenType.CITY && userInfo.gameMode == GameModeType.VISIT)
         {
            view.updateUser(visitInfo.landlord,facebookAPIManager.getUserNameByProfile(visitInfo.landlord),visitInfo.guid);
            updateWithBattlePoints(city.ownerBattlePoints);
         }
         else if((param1 == WomScreenType.CITY || param1 == null) && userInfo.gameMode == GameModeType.ATTACK)
         {
            _loc2_ = TutorialListInfo.getProfileAccordingToTutorial(attackInfo.defender,userInfo.tutorialsInfo);
            view.updateUser(_loc2_,facebookAPIManager.getUserNameByProfile(_loc2_),attackInfo.guid);
            updateWithBattlePoints(city.ownerBattlePoints);
         }
         else
         {
            log(LoggerContext.combine(WomLoggerContexts.GAME,LoggerContexts.UNEXPECTED),"User updated with invalid screen/game mode combination! ScreenType: " + param1 + ", GameMode: " + userInfo.gameMode);
         }
         updateWithExperiencePoints();
      }
      
      private function onTab(param1:Event) : void
      {
         var _loc3_:MobileExperiencePointsTooltipView = null;
         var _loc2_:Touch = (param1 as TouchEvent).getTouch(view,"ended");
         if(_loc2_)
         {
            if(userInfo.gameMode == GameModeType.NORMAL)
            {
               _loc3_ = new MobileExperiencePointsTooltipView();
               dispatch(new MobileTooltipEvent("mobileTooltipEventShow",_loc3_,25,58));
            }
         }
      }
   }
}

