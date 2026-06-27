package wom.controller.command.combat
{
   import flash.utils.Dictionary;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.controller.PCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.EndAttackEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.behavior.FpsSyncCollector;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.dto.combat.BuildingHealth;
   import wom.model.dto.combat.DefenderBuildingInfo;
   import wom.model.dto.combat.PostBattleAttackerInfo;
   import wom.model.dto.combat.PostBattleDefenderInfo;
   import wom.model.dto.combat.PostBattleInfo;
   import wom.model.dto.combat.ReceivedBeastFledBattleFieldLog;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.request.EndAttackRequest;
   import wom.service.kontagent.WomKontagentApi;
   import wom.validation.EndValidationEvent;
   
   public class EndAttackCommand extends PCommand
   {
      
      [Inject]
      public var event:EndAttackEvent;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function EndAttackCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:Building = null;
         var _loc15_:int = 0;
         var _loc11_:String = null;
         var _loc6_:PostBattleInfo = null;
         var _loc10_:EndAttackRequest = null;
         attackInfo.attackEnded = true;
         attackInfo.isAttackOngoing = false;
         userInfo.fromMap = false;
         var _loc13_:Vector.<DefenderBuildingInfo> = new Vector.<DefenderBuildingInfo>();
         var _loc9_:Vector.<BuildingHealth> = new Vector.<BuildingHealth>();
         for each(var _loc12_ in city.buildings)
         {
            _loc9_.push(new BuildingHealth(_loc12_.instanceId,_loc12_.healthPoint));
            _loc3_ = gameRootHolder.gameRoot.buildings[_loc12_.instanceId];
            if(_loc3_)
            {
               _loc13_.push(_loc3_.data.createLog());
            }
         }
         var _loc14_:Dictionary = new Dictionary();
         for each(var _loc2_ in attackInfo.units)
         {
            if(_loc2_.status == UnitStatusType.ATTACKING || _loc2_.status == UnitStatusType.DEAD)
            {
               if(!(_loc2_.typeId in _loc14_))
               {
                  _loc14_[_loc2_.typeId] = 0;
               }
               _loc14_[_loc2_.typeId]++;
            }
         }
         var _loc8_:Dictionary = new Dictionary();
         var _loc1_:Dictionary = new Dictionary();
         var _loc4_:Dictionary = new Dictionary();
         for each(_loc2_ in city.units)
         {
            if(_loc2_.status == UnitStatusType.DEAD)
            {
               _loc15_ = 0;
               for each(_loc12_ in city.buildings)
               {
                  if(_loc12_.instanceId == _loc2_.buildingId)
                  {
                     _loc15_ = _loc12_.buildingTypeId;
                     break;
                  }
               }
               if(_loc15_ == 19)
               {
                  if(!(_loc2_.typeId in _loc1_))
                  {
                     _loc1_[_loc2_.typeId] = 0;
                  }
                  _loc1_[_loc2_.typeId]++;
               }
               else if(_loc15_ == 37)
               {
                  if(!(_loc2_.buildingId in _loc8_))
                  {
                     _loc8_[_loc2_.buildingId] = new Dictionary();
                  }
                  if(!(_loc2_.typeId in _loc8_[_loc2_.buildingId]))
                  {
                     _loc8_[_loc2_.buildingId][_loc2_.typeId] = 0;
                  }
                  _loc8_[_loc2_.buildingId][_loc2_.typeId]++;
               }
               else if(_loc15_ == 38)
               {
                  if(!(_loc2_.typeId in _loc4_))
                  {
                     _loc4_[_loc2_.typeId] = 0;
                  }
                  _loc4_[_loc2_.typeId]++;
               }
            }
         }
         var _loc5_:PostBattleAttackerInfo = new PostBattleAttackerInfo(attackInfo.attacker,attackInfo.beast ? attackInfo.beast.healthPoints : -1,attackInfo.lootedParts);
         var _loc7_:PostBattleDefenderInfo = new PostBattleDefenderInfo(attackInfo.defender,_loc9_,attackInfo.usedTrapInstanceIds,city.beast ? city.beast.healthPoints : -1,_loc8_,_loc1_,_loc4_,_loc13_,attackInfo.totalCatapultDamageDone,city.beastCannonInfo.ammoAmount);
         kontagentApi.trackCustomEvent("AverageCombatFPS",{"value":int(Math.floor(60 / (gameRootHolder.gameRoot.battleManager.totalPrecise / gameRootHolder.gameRoot.battleManager.frameCount)))});
         _loc11_ = "";
         _loc6_ = new PostBattleInfo(attackInfo.attackerBeastFledTime == -1 ? null : new ReceivedBeastFledBattleFieldLog(attackInfo.beast.typeId,attackInfo.attackerBeastFledTime),attackInfo.defenderBeastFledTime == -1 ? null : new ReceivedBeastFledBattleFieldLog(city.beast.typeId,attackInfo.defenderBeastFledTime),attackInfo.buildingDamagedLogs,attackInfo.troopsReleasedFromWatchPostLogs,_loc5_,_loc7_,attackInfo.lootedHarvestedResources,attackInfo.lootedUnharvestedResources,attackInfo.explosivesTriggeredLogs,FpsSync.frameNum,attackInfo.beastRetreatFrameNumber,_loc11_);
         (gameRootHolder.gameRoot.componentManager["FpsSyncCollector"] as FpsSyncCollector).deflateAndFlushCollectedData();
         _loc10_ = new EndAttackRequest(_loc6_,TutorialListInfo.checkInNpcRevengeTutorial(userInfo.tutorialsInfo));
         dispatch(new OutgoingMessageEvent("outgoingMessage",_loc10_));
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
      }
   }
}

