package wom.controller.command.map
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.model.component.WomCampaignRoot;
   import wom.model.domain.DomainInfo;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.CampaignMapInfo;
   import wom.model.game.MobileMapInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.GetMapInfoResponse;
   
   public class HandleGetMapInfoResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var campaignRoot:WomCampaignRoot;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var campaignMapInfo:CampaignMapInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var mobileMapInfo:MobileMapInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function HandleGetMapInfoResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Number = NaN;
         var _loc7_:* = undefined;
         var _loc3_:int = 0;
         var _loc5_:Dictionary = null;
         var _loc6_:Dictionary = null;
         var _loc2_:GetMapInfoResponse = messageReceivedEvent.message as GetMapInfoResponse;
         if(_loc2_.resultCode == 0)
         {
            _loc1_ = allianceInfo.myAllianceSummary ? allianceInfo.myAllianceSummary.id : -1;
            _loc7_ = new Vector.<ProfileIdPair>();
            _loc3_ = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
            _loc5_ = _loc2_.mapMemberInfos;
            for each(var _loc4_ in _loc5_)
            {
               if(_loc4_.alliance && _loc4_.alliance.id == _loc1_)
               {
                  _loc4_.playerRelation = 9;
               }
               else if(_loc4_.completelyDestroyed)
               {
                  _loc4_.playerRelation = 8;
               }
               else if(_loc4_.underProtection || !_loc4_.mandatoryTutorialCompleted)
               {
                  _loc4_.playerRelation = 7;
               }
               else if(!_loc4_.isEventNpc && !_loc4_.canBeRetaliated && _loc4_.level < _loc3_ - 4)
               {
                  _loc4_.playerRelation = 6;
               }
               else if(!_loc4_.isEventNpc && !_loc4_.canBeRetaliated && _loc4_.level > _loc3_ + 4)
               {
                  _loc4_.playerRelation = 10;
               }
               if(!_loc4_.profile.isNpc)
               {
                  _loc7_.push(new ProfileIdPair(_loc4_.profile.platformId,_loc4_.profile.avatar));
               }
               else if(!_loc4_.isEventNpc)
               {
                  campaignMapInfo.npcInfos[_loc4_.npcClan] = _loc4_;
               }
            }
            _loc7_.push(new ProfileIdPair(userInfo.profile.platformId,userInfo.profile.avatar));
            if(_loc7_.length > 0)
            {
               dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc7_));
            }
            if(campaignMapInfo.byPassMap)
            {
               campaignMapInfo.byPassMap = false;
               _loc6_ = new Dictionary();
               _loc6_["mapScreenCampaignMode"] = true;
               dispatch(new ActivateScreenEvent("activate",WomScreenType.MAP,_loc6_));
            }
            mobileMapInfo.friendsOnMap = _loc2_.friendsOnMap;
            mobileMapInfo.nonFriendsOnMap = _loc2_.nonFriendsOnMap;
            mobileMapInfo.allianceEnemies = _loc2_.allianceEnemies;
            mobileMapInfo.revanchists = _loc2_.revanchists;
            mobileMapInfo.mapMemberInfos = _loc2_.mapMemberInfos;
            dispatch(new ModelUpdateEvent("mobileMapMemberListUpdated"));
         }
      }
   }
}

