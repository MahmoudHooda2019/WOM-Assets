package wom.model.dto.combat
{
   import flash.utils.Dictionary;
   import wom.model.game.Profile;
   
   public class PostBattleDefenderInfo
   {
      
      private var _profile:Profile;
      
      private var _healthPoints:Vector.<BuildingHealth>;
      
      private var _usedTrapInstanceIds:Vector.<int>;
      
      private var _beastHealth:Number;
      
      private var _unitsToRemoveFromWatchPost:Dictionary;
      
      private var _unitsToRemoveFromBarracks:Dictionary;
      
      private var _defenderBuildingInfo:Vector.<DefenderBuildingInfo>;
      
      private var _totalCatapultDamageDone:int;
      
      private var _unitsToRemoveFromFriendWatchPost:Dictionary;
      
      private var _remainingBeastCannonAmmo:int;
      
      public function PostBattleDefenderInfo(param1:Profile, param2:Vector.<BuildingHealth>, param3:Vector.<int>, param4:Number, param5:Dictionary, param6:Dictionary, param7:Dictionary, param8:Vector.<DefenderBuildingInfo>, param9:int, param10:int)
      {
         super();
         _profile = param1;
         _healthPoints = param2;
         _usedTrapInstanceIds = param3;
         _beastHealth = param4;
         _unitsToRemoveFromWatchPost = param5;
         _unitsToRemoveFromBarracks = param6;
         _unitsToRemoveFromFriendWatchPost = param7;
         _defenderBuildingInfo = param8;
         _totalCatapultDamageDone = param9;
         _remainingBeastCannonAmmo = param10;
      }
      
      public static function deserialize(param1:Object) : PostBattleDefenderInfo
      {
         var _loc10_:int = 0;
         var _loc7_:Vector.<BuildingHealth> = new Vector.<BuildingHealth>();
         for each(var _loc8_ in param1.healthPoints)
         {
            _loc7_.push(BuildingHealth.deserialize(_loc8_));
         }
         var _loc4_:Vector.<int> = new Vector.<int>();
         for each(var _loc9_ in param1.usedTrapInstanceIds)
         {
            _loc4_.push(_loc9_);
         }
         var _loc12_:Dictionary = new Dictionary();
         for each(var _loc6_ in param1.unitsToRemoveFromWatchPosts)
         {
            _loc10_ = int(_loc6_.watchPostInstanceId);
            _loc12_[_loc10_] = new Dictionary();
            for each(var _loc14_ in _loc6_.unitsToRemoveFromWatchPost)
            {
               _loc12_[_loc10_][_loc14_.id] = _loc14_.amount;
            }
         }
         var _loc11_:Dictionary = new Dictionary();
         for each(var _loc3_ in param1.unitsToRemoveFromBarracks)
         {
            _loc11_[_loc3_.id] = _loc3_.amount;
         }
         var _loc2_:Dictionary = new Dictionary();
         for each(_loc14_ in param1.unitsToRemoveFromFriendWatchPost)
         {
            _loc2_[_loc14_.id] = _loc14_.amount;
         }
         var _loc13_:Vector.<DefenderBuildingInfo> = new Vector.<DefenderBuildingInfo>();
         for each(var _loc5_ in param1.defenderBuildingInfo)
         {
            _loc13_.push(DefenderBuildingInfo.deserialize(_loc5_));
         }
         return new PostBattleDefenderInfo(null,_loc7_,_loc4_,param1.beastHealth,_loc12_,_loc11_,_loc2_,_loc13_,param1.totalCatapultDamage,param1.remainingBeastCannonAmmo);
      }
      
      public function get profile() : Profile
      {
         return _profile;
      }
      
      public function get healthPoints() : Vector.<BuildingHealth>
      {
         return _healthPoints;
      }
      
      public function get usedTrapInstanceIds() : Vector.<int>
      {
         return _usedTrapInstanceIds;
      }
      
      public function get beastHealth() : Number
      {
         return _beastHealth;
      }
      
      public function get unitsToRemoveFromWatchPost() : Dictionary
      {
         return _unitsToRemoveFromWatchPost;
      }
      
      public function get unitsToRemoveFromBarracks() : Dictionary
      {
         return _unitsToRemoveFromBarracks;
      }
      
      public function get defenderBuildingInfo() : Vector.<DefenderBuildingInfo>
      {
         return _defenderBuildingInfo;
      }
      
      public function get totalCatapultDamageDone() : int
      {
         return _totalCatapultDamageDone;
      }
      
      public function get unitsToRemoveFromFriendWatchPost() : Dictionary
      {
         return _unitsToRemoveFromFriendWatchPost;
      }
      
      public function get remainingBeastCannonAmmo() : int
      {
         return _remainingBeastCannonAmmo;
      }
      
      public function serialize() : Object
      {
         var _loc9_:int = 0;
         var _loc7_:Array = null;
         var _loc12_:Dictionary = null;
         var _loc5_:Array = [];
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         var _loc8_:Array = new Array(_healthPoints.length);
         var _loc14_:Array = [];
         var _loc6_:Array = [];
         _loc9_ = 0;
         while(_loc9_ < _healthPoints.length)
         {
            _loc8_[_loc9_] = {
               "id":_healthPoints[_loc9_].instanceId,
               "healthPoints":(_healthPoints[_loc9_].healthPoint < 0 ? 0 : _healthPoints[_loc9_].healthPoint)
            };
            _loc9_++;
         }
         for(var _loc11_ in _unitsToRemoveFromBarracks)
         {
            _loc1_.push({
               "id":_loc11_,
               "amount":_unitsToRemoveFromBarracks[_loc11_]
            });
         }
         for(var _loc10_ in _unitsToRemoveFromWatchPost)
         {
            _loc7_ = [];
            _loc12_ = _unitsToRemoveFromWatchPost[_loc10_];
            for(_loc11_ in _loc12_)
            {
               _loc7_.push({
                  "id":_loc11_,
                  "amount":_loc12_[_loc11_]
               });
            }
            _loc5_.push({
               "watchPostInstanceId":_loc10_,
               "unitsToRemoveFromWatchPost":_loc7_
            });
         }
         for(_loc11_ in _unitsToRemoveFromFriendWatchPost)
         {
            _loc2_.push({
               "id":_loc11_,
               "amount":_unitsToRemoveFromFriendWatchPost[_loc11_]
            });
         }
         for each(var _loc4_ in _defenderBuildingInfo)
         {
            _loc14_.push(_loc4_.serialize());
         }
         for each(var _loc3_ in _usedTrapInstanceIds)
         {
            _loc6_.push(_loc3_);
         }
         var _loc13_:Object = {
            "healthPoints":_loc8_,
            "tcd":_totalCatapultDamageDone,
            "usedTrapInstanceIds":_loc6_,
            "beastHealth":(_beastHealth == -1 ? null : _beastHealth),
            "unitsToRemoveFromBarracks":_loc1_,
            "unitsToRemoveFromWatchPosts":_loc5_,
            "unitsToRemoveFromFriendWatchPost":_loc2_,
            "defenderBuildingInfo":_loc14_,
            "remainingBeastCannonAmmo":_remainingBeastCannonAmmo
         };
         if(profile.isNpc)
         {
            _loc13_.npcName = _profile.npcId;
         }
         else
         {
            _loc13_.gameUid = _profile.gameId;
         }
         return _loc13_;
      }
   }
}

