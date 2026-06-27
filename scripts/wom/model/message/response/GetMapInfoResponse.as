package wom.model.message.response
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractIncomingMessage;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.Profile;
   import wom.model.message.util.AllianceDeserializeUtil;
   
   public class GetMapInfoResponse extends AbstractIncomingMessage
   {
      
      private var _resultCode:int;
      
      private var _resultMessage:String;
      
      private var _friendsOnMap:Dictionary;
      
      private var _nonFriendsOnMap:Dictionary;
      
      private var _allianceEnemies:Dictionary;
      
      private var _revanchists:Dictionary;
      
      private var _mapMemberInfos:Dictionary;
      
      public function GetMapInfoResponse()
      {
         super();
      }
      
      override public function deserialize(param1:Object) : void
      {
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc6_:Object = null;
         var _loc10_:Profile = null;
         var _loc3_:MapMemberInfo = null;
         var _loc2_:int = 0;
         var _loc9_:int = 0;
         _resultCode = param1.resultCode;
         _resultMessage = param1.resultMessage;
         _friendsOnMap = new Dictionary();
         _nonFriendsOnMap = new Dictionary();
         _allianceEnemies = new Dictionary();
         _revanchists = new Dictionary();
         _mapMemberInfos = new Dictionary();
         if(_resultCode == 0)
         {
            if(param1.mapInfo)
            {
               for each(var _loc12_ in param1.mapInfo.friendsOnMap)
               {
                  _friendsOnMap[_loc12_] = true;
               }
               for each(var _loc4_ in param1.mapInfo.nonFriendsOnMap)
               {
                  _nonFriendsOnMap[_loc4_] = true;
               }
               for each(var _loc5_ in param1.mapInfo.allianceEnemies)
               {
                  _allianceEnemies[_loc5_] = true;
               }
               for each(var _loc11_ in param1.mapInfo.revanchists)
               {
                  _revanchists[_loc11_] = true;
               }
               _loc7_ = int(param1.mapInfo.mapMemberInfos.length);
               _loc8_ = int(param1.mapInfo.raceMembers.length);
               _loc2_ = 1;
               _loc9_ = 0;
               while(_loc9_ < _loc8_)
               {
                  _loc6_ = param1.mapInfo.raceMembers[_loc9_];
                  _loc10_ = new Profile(null,null,null,_loc6_.npcName,_loc6_.npcClanId);
                  _loc3_ = new MapMemberInfo(_loc10_,_loc6_.position,_loc6_.level,_loc6_.bp,_loc6_.online,_loc6_.numberOfWins,_loc6_.numberOfBattles,_loc6_.playerRelation,_loc6_.underProtection,_loc6_.mandatoryTutorialCompleted,_loc6_.completelyDestroyed,AllianceDeserializeUtil.deserializeAllianceSummary(_loc6_.alliance),false,false,false,_loc6_.canRetaliate,true);
                  _mapMemberInfos[_loc2_++] = _loc3_;
                  _loc9_++;
               }
               _loc9_ = 0;
               while(_loc9_ < _loc7_)
               {
                  _loc6_ = param1.mapInfo.mapMemberInfos[_loc9_];
                  if(_loc6_.mmi && _loc6_.mmi != null)
                  {
                     _loc10_ = new Profile(_loc6_.mmi[0],_loc6_.mmi[1],_loc6_.mmi[2]);
                  }
                  else
                  {
                     _loc10_ = new Profile(null,null,null,_loc6_.npcName);
                  }
                  _loc3_ = new MapMemberInfo(_loc10_,_loc6_.position,_loc6_.level,_loc6_.bp,_loc6_.online,_loc6_.numberOfWins,_loc6_.numberOfBattles,_loc6_.playerRelation,_loc6_.underProtection,_loc6_.mandatoryTutorialCompleted,_loc6_.completelyDestroyed,AllianceDeserializeUtil.deserializeAllianceSummary(_loc6_.alliance),_friendsOnMap[_loc10_.gameId],_allianceEnemies[_loc10_.gameId],_revanchists[_loc10_.gameId],_loc6_.canRetaliate,false);
                  _mapMemberInfos[_loc2_++] = _loc3_;
                  _loc9_++;
               }
            }
         }
      }
      
      public function get friendsOnMap() : Dictionary
      {
         return _friendsOnMap;
      }
      
      public function get nonFriendsOnMap() : Dictionary
      {
         return _nonFriendsOnMap;
      }
      
      public function get allianceEnemies() : Dictionary
      {
         return _allianceEnemies;
      }
      
      public function get revanchists() : Dictionary
      {
         return _revanchists;
      }
      
      public function get resultCode() : int
      {
         return _resultCode;
      }
      
      public function get resultMessage() : String
      {
         return _resultMessage;
      }
      
      public function get mapMemberInfos() : Dictionary
      {
         return _mapMemberInfos;
      }
   }
}

