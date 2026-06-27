package wom.view.mediator.ui.mainframe.city.friends.mobile
{
   import flash.utils.Dictionary;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.game.Profile;
   import wom.model.game.Thorzain;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   import wom.model.game.friend.DefaultFriendInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.GetWatchPostUnitsOfFriendRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.watchpost.MobileFriendWatchPostTransferWindow;
   import wom.view.ui.mainframe.city.friends.mobile.FriendsPanelFriendViewRenderer;
   import wom.view.ui.mainframe.city.friends.mobile.MobileFriendsPanel;
   
   public class MobileFriendsPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileFriendsPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileFriendsPanelMediator()
      {
         super();
      }
      
      public static function getFriendProfile(param1:Event) : Profile
      {
         param1.stopImmediatePropagation();
         return param1.data as Profile;
      }
      
      public static function sortWomFriends(param1:FriendInfo, param2:FriendInfo) : int
      {
         if(param1.experiencePoints > param2.experiencePoints)
         {
            return -1;
         }
         if(param1.experiencePoints < param2.experiencePoints)
         {
            return 1;
         }
         return 0;
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.friendsList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.friendsList,"visitButtonClicked",onVisitButtonClicked,Event);
         updateFriends();
      }
      
      private function onRendererAdded(param1:Event, param2:FriendsPanelFriendViewRenderer) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param2.friendInfo)
         {
            _loc3_ = param2.friendInfo.name;
            _loc4_ = facebookAPIManager.getUserNameByProfile(param2.friendInfo.profile);
            if(_loc4_ != _loc3_)
            {
               param2.friendInfo.name = _loc4_;
            }
            param2.updateUserNameTextField(_loc4_);
            eventMap.mapStarlingListener(param2.supportButton,"triggered",onReinforceClicked,Event);
         }
      }
      
      private function onReinforceClicked(param1:Event) : void
      {
         var _loc2_:FriendsPanelFriendViewRenderer = checkRendererValidityForClickedButton(param1);
         if(!_loc2_)
         {
            return;
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFriendWatchPostTransferWindow(_loc2_.friendInfo.profile.gameId,new <WindowEnumeration>[new WindowEnumeration(206,{"highligtThorzain":false})])));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new GetWatchPostUnitsOfFriendRequest(_loc2_.friendInfo.profile.gameId)));
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
      }
      
      private function onVisitButtonClicked(param1:Event) : void
      {
         var _loc2_:Profile = getFriendProfile(param1);
         dispatch(new StartVisitEvent("startVisit",_loc2_,_loc2_.isNpc,false));
      }
      
      private function updateFriends() : void
      {
         var _loc3_:Vector.<FriendInfo> = new Vector.<FriendInfo>();
         for each(var _loc5_ in documentConfiguration.friends)
         {
            if(_loc5_.profile.gameId in documentConfiguration.womFriends)
            {
               _loc3_.push(_loc5_);
            }
         }
         _loc3_.sort(sortWomFriends);
         var _loc4_:Dictionary = new Dictionary();
         var _loc1_:Vector.<BlockedFriendInfo> = userInfo.blockedFriendsMap[3];
         if(_loc1_ != null)
         {
            for each(var _loc2_ in _loc1_)
            {
               if(_loc2_.profile.gameId)
               {
                  _loc4_[_loc2_.profile.gameId] = true;
               }
            }
         }
         var _loc6_:Vector.<FriendInfo> = new Vector.<FriendInfo>(0);
         _loc6_.push(new DefaultFriendInfo("Thorzain",Thorzain.PROFILE));
         _loc3_ = _loc6_.concat(_loc3_);
         view.updateFriends(_loc3_,_loc4_,userInfo.friendWatchPostInfos,domainInfo.getBuilding(38).buildingSpecificInfo[BuildingSpecificInfoType.MERCENARY_CAPACITIES_PER_LEVEL.id]);
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : FriendsPanelFriendViewRenderer
      {
         var _loc3_:FriendsPanelFriendViewRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is FriendsPanelFriendViewRenderer)
         {
            _loc3_ = _loc2_.parent as FriendsPanelFriendViewRenderer;
            if(_loc3_.friendInfo)
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

