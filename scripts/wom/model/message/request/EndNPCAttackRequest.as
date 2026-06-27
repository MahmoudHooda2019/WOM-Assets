package wom.model.message.request
{
   import flash.utils.Dictionary;
   import peak.messaging.AbstractOutgoingMessage;
   import peak.messaging.OutgoingMessage;
   import wom.model.dto.combat.DefenderBuildingInfo;
   import wom.model.dto.combat.PostNPCBattleInfo;
   import wom.model.game.resource.ResourceType;
   
   public class EndNPCAttackRequest extends AbstractOutgoingMessage implements OutgoingMessage
   {
      
      private var postBattleInfo:PostNPCBattleInfo;
      
      public function EndNPCAttackRequest(param1:PostNPCBattleInfo)
      {
         super();
         this.postBattleInfo = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc11_:int = 0;
         var _loc14_:int = 0;
         var _loc9_:Array = null;
         var _loc16_:Dictionary = null;
         var _loc6_:Array = [];
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         var _loc10_:Array = new Array(postBattleInfo.defenderInfo.healthPoints.length);
         var _loc18_:Array = [];
         var _loc7_:Array = [];
         var _loc19_:Array = [];
         var _loc8_:Array = [];
         _loc11_ = 0;
         while(_loc11_ < postBattleInfo.defenderInfo.healthPoints.length)
         {
            _loc10_[_loc11_] = {
               "id":postBattleInfo.defenderInfo.healthPoints[_loc11_].instanceId,
               "healthPoints":(postBattleInfo.defenderInfo.healthPoints[_loc11_].healthPoint < 0 ? 0 : postBattleInfo.defenderInfo.healthPoints[_loc11_].healthPoint)
            };
            _loc11_++;
         }
         for each(var _loc12_ in ResourceType.resourceTypes)
         {
            _loc14_ = _loc12_.id;
            if(postBattleInfo.lootedHarvestedResources[_loc14_])
            {
               _loc18_.push({
                  "id":_loc14_,
                  "amount":postBattleInfo.lootedHarvestedResources[_loc14_]
               });
            }
         }
         for(var _loc15_ in postBattleInfo.defenderInfo.unitsToRemoveFromBarracks)
         {
            _loc1_.push({
               "id":_loc15_,
               "amount":postBattleInfo.defenderInfo.unitsToRemoveFromBarracks[_loc15_]
            });
         }
         for(var _loc4_ in postBattleInfo.lootedUnharvestedResources)
         {
            _loc7_.push({
               "instanceId":_loc4_,
               "amount":postBattleInfo.lootedUnharvestedResources[_loc4_]
            });
         }
         for(var _loc13_ in postBattleInfo.defenderInfo.unitsToRemoveFromWatchPost)
         {
            _loc9_ = [];
            _loc16_ = postBattleInfo.defenderInfo.unitsToRemoveFromWatchPost[_loc13_];
            for(_loc15_ in _loc16_)
            {
               _loc9_.push({
                  "id":_loc15_,
                  "amount":_loc16_[_loc15_]
               });
            }
            _loc6_.push({
               "watchPostInstanceId":_loc13_,
               "unitsToRemoveFromWatchPost":_loc9_
            });
         }
         for(_loc15_ in postBattleInfo.defenderInfo.unitsToRemoveFromFriendWatchPost)
         {
            _loc2_.push({
               "id":_loc15_,
               "amount":postBattleInfo.defenderInfo.unitsToRemoveFromFriendWatchPost[_loc15_]
            });
         }
         for each(var _loc5_ in postBattleInfo.defenderInfo.defenderBuildingInfo)
         {
            _loc19_.push(_loc5_.serialize());
         }
         for each(var _loc3_ in postBattleInfo.defenderInfo.usedTrapInstanceIds)
         {
            _loc8_.push(_loc3_);
         }
         var _loc17_:Object = {
            "healthPoints":_loc10_,
            "usedTrapInstanceIds":_loc8_,
            "beastHealth":(postBattleInfo.defenderInfo.beastHealth == -1 ? null : postBattleInfo.defenderInfo.beastHealth),
            "unitsToRemoveFromBarracks":_loc1_,
            "unitsToRemoveFromWatchPosts":_loc6_,
            "unitsToRemoveFromFriendWatchPost":_loc2_,
            "defenderBuildingInfo":_loc19_
         };
         if(postBattleInfo.defenderInfo.profile.isNpc)
         {
            _loc17_.npcName = postBattleInfo.defenderInfo.profile.npcId;
         }
         else
         {
            _loc17_.gameUid = postBattleInfo.defenderInfo.profile.gameId;
         }
         return {"info":{
            "defenderInfo":_loc17_,
            "lootedHarvestedResources":_loc18_,
            "lootedUnharvestedResources":_loc7_
         }};
      }
   }
}

