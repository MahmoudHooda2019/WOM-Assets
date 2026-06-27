package wom.view.mediator.screen.windows.league.mobile
{
   import feathers.data.ListCollection;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.league.LeagueMemberInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.league.mobile.MobileLeagueMembersListPanel;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileLeagueMembersListPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeagueMembersListPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobileLeagueMembersListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("leagueMembersRankingInfoUpdated",onLeagueMembersRankingInfoUpdated,ModelUpdateEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.headerRank,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerLevel,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerAlliance,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerName,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.headerBattlePoints,"touch",onHeaderClicked,TouchEvent);
         leagueMembersRankingInfoUpdated();
         onPlatformUsersUpdated(null);
      }
      
      private function leagueMembersRankingInfoUpdated() : void
      {
         view.updateWithMembers(leagueManager.myLeague != null ? leagueManager.myLeague.members : new Vector.<LeagueMemberInfo>(),userInfo.profile);
      }
      
      private function onLeagueMembersRankingInfoUpdated(param1:ModelUpdateEvent) : void
      {
         leagueMembersRankingInfoUpdated();
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateName();
      }
      
      private function updateName() : void
      {
         var _loc1_:ListCollection = null;
         var _loc4_:int = 0;
         var _loc2_:LeagueMemberInfo = null;
         var _loc3_:String = null;
         if(view.memberList && view.memberList.dataProvider)
         {
            _loc1_ = view.memberList.dataProvider;
            _loc4_ = 0;
            while(_loc4_ < _loc1_.data.length)
            {
               _loc2_ = _loc1_.data[_loc4_];
               _loc3_ = _loc2_.profile.mobileName ? _loc2_.profile.mobileName : facebookAPIManager.getUserNameByProfile(_loc2_.profile);
               if(_loc3_ != _loc2_.name)
               {
                  _loc2_.name = _loc3_;
                  _loc1_.updateItemAt(_loc4_);
               }
               _loc4_++;
            }
         }
      }
      
      public function onHeaderClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view,"ended");
         if(_loc2_ && param1.currentTarget && param1.currentTarget is MobileListHeaderView)
         {
            view.headerClicked(param1.currentTarget as MobileListHeaderView);
         }
      }
   }
}

