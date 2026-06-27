package wom.model.component
{
   import flash.events.TimerEvent;
   import flash.utils.ByteArray;
   import flash.utils.Timer;
   import flash.utils.getTimer;
   import org.robotlegs.mvcs.Actor;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import peak.thread.IdleWorkerThreadEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.AddWaypointsEvent;
   import wom.controller.event.combat.CombatHelpTextEvent;
   import wom.controller.event.combat.EndAttackEvent;
   import wom.controller.event.combat.RemoveDeployedUnitsEvent;
   import wom.controller.event.defense.EndNPCAttackEvent;
   import wom.controller.event.defense.EndTuskHornEvent;
   import wom.controller.event.ui.VictoryMeterEvent;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.behavior.battle.tower.BeastCave;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.DeployBeastCircleInfoDTO;
   import wom.model.dto.DeployUnitCircleInfoDTO;
   import wom.model.dto.DeployedCatapultCircleInfoDTO;
   import wom.model.dto.PathFindWaypointDTO;
   import wom.model.dto.combat.ReceivedTroopsReleasedFromWatchPostLog;
   import wom.model.dto.combat.TriggeredExplosiveInfo;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.request.BeastDeployedRequest;
   import wom.model.message.request.CatapultUsedRequest;
   import wom.model.message.request.SaveDeltaTimeRequest;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.ui.mainframe.combat.tooltip.MobileMercenaryDeployTabBeastView;
   
   public class CuckooNotifier extends Actor
   {
      
      private static var _instance:CuckooNotifier;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      private var _noTargetToAttack:Boolean;
      
      private var _endAttackTimer:Timer;
      
      public function CuckooNotifier()
      {
         super();
         _instance = this;
      }
      
      public static function getInstance() : CuckooNotifier
      {
         return _instance;
      }
      
      public function warnIdle(param1:Boolean = true, param2:String = "Root") : void
      {
         dispatch(new IdleWorkerThreadEvent("idleWorkerThread",param1,param2));
      }
      
      public function battleStarted() : void
      {
         _noTargetToAttack = false;
         _endAttackTimer = new Timer(2000,1);
         _endAttackTimer.addEventListener("timerComplete",onTimerCompleteAndEndAttack);
      }
      
      public function notifyRandomLoot(param1:Root, param2:int, param3:int, param4:int, param5:Boolean = true) : void
      {
         var _loc10_:WomGameRoot = null;
         var _loc9_:int = 0;
         var _loc12_:BuildingInfo = null;
         var _loc6_:BuildingTypeDIO = null;
         var _loc11_:ResourceType = null;
         var _loc7_:* = undefined;
         try
         {
            _loc10_ = param1 as WomGameRoot;
            _loc9_ = -1;
            _loc12_ = null;
            _loc6_ = null;
            for each(var _loc8_ in cityInfo.buildings)
            {
               if(_loc8_.instanceId == param2)
               {
                  _loc6_ = domainInfo.getBuilding(_loc8_.buildingTypeId);
                  _loc12_ = _loc8_;
                  break;
               }
            }
            if(!_loc6_ && !_loc12_)
            {
               log(WomLoggerContexts.GAME,"Error missing data on loot attacked command");
               return;
            }
            if(_loc6_.kind.id == 11)
            {
               if(!_loc6_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id])
               {
                  log(WomLoggerContexts.GAME,"Unexpected error on loot attacked command");
                  return;
               }
               _loc9_ = (_loc6_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType).id;
               if(_loc12_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] <= 0)
               {
                  if(param5 && _loc12_.healthPoint > 0)
                  {
                     coreManager.displayBuildingDamage(param2,param4);
                  }
                  return;
               }
               _loc11_ = ResourceType.determineResourceType(_loc9_);
               param3 = int(param3 > _loc12_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] ? _loc12_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] : param3);
               _loc12_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] -= param3;
               if(!(_loc12_.instanceId in attackInfo.lootedUnharvestedResources))
               {
                  attackInfo.lootedUnharvestedResources[_loc12_.instanceId] = 0;
               }
               var _loc14_:* = _loc12_.instanceId;
               var _loc15_:* = attackInfo.lootedUnharvestedResources[_loc14_] + param3;
               attackInfo.lootedUnharvestedResources[_loc14_] = _loc15_;
            }
            else
            {
               if(param3 <= 0 && param5)
               {
                  coreManager.displayBuildingDamage(param2,param4);
                  return;
               }
               _loc7_ = new Vector.<int>();
               for each(_loc11_ in ResourceType.resourceTypes)
               {
                  if(cityInfo.resourceAmounts[_loc11_.id] > 0)
                  {
                     _loc7_.push(_loc11_.id);
                  }
               }
               if(_loc7_.length == 0)
               {
                  if(param5)
                  {
                     coreManager.displayBuildingDamage(param2,param4);
                  }
                  return;
               }
               _loc9_ = _loc7_[_loc10_.pseudoRandomGenerator.nextDouble() * _loc7_.length << 0];
               _loc11_ = ResourceType.determineResourceType(_loc9_);
               param3 = int(param3 > cityInfo.resourceAmounts[_loc11_.id] ? cityInfo.resourceAmounts[_loc11_.id] : param3);
               if(param3 > 0)
               {
                  _loc15_ = _loc11_.id;
                  _loc14_ = cityInfo.resourceAmounts[_loc15_] - param3;
                  cityInfo.resourceAmounts[_loc15_] = _loc14_;
                  attackInfo.lootedHarvestedResources[_loc11_.id] += param3;
               }
            }
            if(param3 > 0)
            {
               coreManager.lootResource(param2,_loc11_,param3);
               dispatch(new ModelUpdateEvent("lootedResourcesUpdated"));
            }
         }
         catch(e:Error)
         {
            log(WomLoggerContexts.GAME,"Error occured at loot attacked command " + e.getStackTrace());
         }
      }
      
      public function notifyDestroyedLoot(param1:Root, param2:int) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:BuildingTypeDIO = null;
         var _loc6_:int = 0;
         var _loc7_:WomGameRoot = param1 as WomGameRoot;
         for each(var _loc4_ in cityInfo.buildings)
         {
            if(_loc4_.instanceId == param2)
            {
               _loc5_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
               if(_loc5_.kind.id == 10)
               {
                  for each(var _loc8_ in ResourceType.resourceTypes)
                  {
                     _loc3_ = cityInfo.resourceAmounts[_loc8_.id] * attackInfo.ccco << 0;
                     cityInfo.resourceAmounts[_loc8_.id] -= _loc3_;
                     attackInfo.lootedHarvestedResources[_loc8_.id] += _loc3_;
                     if(_loc3_ > 0)
                     {
                        coreManager.lootResource(param2,_loc8_,_loc3_);
                     }
                  }
               }
               else if(_loc5_.kind.id == 12)
               {
                  for each(_loc8_ in ResourceType.resourceTypes)
                  {
                     _loc3_ = cityInfo.resourceAmounts[_loc8_.id] * attackInfo.spco << 0;
                     cityInfo.resourceAmounts[_loc8_.id] -= _loc3_;
                     attackInfo.lootedHarvestedResources[_loc8_.id] += _loc3_;
                     if(_loc3_ > 0)
                     {
                        coreManager.lootResource(param2,_loc8_,_loc3_);
                     }
                  }
               }
               else if(_loc5_.kind.id == 11)
               {
                  _loc8_ = _loc5_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType;
                  _loc3_ = _loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] << 0;
                  if(!(_loc4_.instanceId in attackInfo.lootedUnharvestedResources))
                  {
                     attackInfo.lootedUnharvestedResources[_loc4_.instanceId] = 0;
                  }
                  var _loc10_:int = _loc4_.instanceId;
                  var _loc9_:Number = attackInfo.lootedUnharvestedResources[_loc10_] + _loc3_;
                  attackInfo.lootedUnharvestedResources[_loc10_] = _loc9_;
                  _loc4_.buildingSpecificInfo[BuildingSpecificInfoType.UNHARVESTED_RESOURCE.id] = 0;
                  if(_loc3_ > 0)
                  {
                     coreManager.lootResource(param2,_loc8_,_loc3_);
                  }
               }
               if(userInfo.gameMode == GameModeType.ATTACK && (_loc5_.kind.id == 10 && !attackInfo.defender.isNpc || !attackInfo.defender.isNpc && (_loc5_.kind.id == 12 || _loc5_.kind.id == 11) && _loc7_.pseudoRandomGenerator.nextDouble() * 100 <= (attackInfo.defender.isNpc ? attackInfo.pfpfn : attackInfo.pfpfp) * 4))
               {
                  _loc6_ = findNeededPartId(_loc5_.id,_loc5_.kind.id,_loc7_);
                  if(_loc6_ != -1)
                  {
                     if(!(_loc6_ in attackInfo.lootedParts))
                     {
                        attackInfo.lootedParts[_loc6_] = 0;
                     }
                     attackInfo.lootedParts[_loc6_]++;
                     coreManager.lootPart(_loc4_.instanceId,_loc6_);
                  }
               }
               dispatch(new ModelUpdateEvent("lootedResourcesUpdated"));
               break;
            }
         }
      }
      
      public function notifyTrapActivated(param1:GameSprite) : void
      {
         var _loc2_:BuildingData = param1.componentManager["BuildingData"] as BuildingData;
         attackInfo.explosivesTriggeredLogs.push(new TriggeredExplosiveInfo(_loc2_.buildingTypeDIO.id,getTimer() - attackInfo.attackStartTime));
         attackInfo.usedTrapInstanceIds.push(_loc2_.buildingInfo.instanceId);
      }
      
      public function unitDeployed(param1:Boolean) : void
      {
         if(param1 && !attackInfo.ottomanSoundPlayed)
         {
            soundPlayer.playSfxById("Ottoman");
            attackInfo.ottomanSoundPlayed = true;
         }
         dispatch(new ModelUpdateEvent("attackInfoUpdated"));
      }
      
      public function defenderUnitDied(param1:Unit) : void
      {
         if(param1.isBeast)
         {
            if(cityInfo.beast && cityInfo.beast.instanceId == param1.data.info.instanceId)
            {
               attackInfo.defenderBeastFledTime = getTimer() - attackInfo.attackStartTime;
            }
         }
      }
      
      public function attackerUnitDied(param1:Unit) : void
      {
         if(param1.isBeast)
         {
            if(attackInfo.beast && attackInfo.beast.instanceId == param1.data.info.instanceId)
            {
               attackInfo.attackerBeastFledTime = getTimer() - attackInfo.attackStartTime;
            }
            dispatch(new ModelUpdateEvent("beastHealthUpdated"));
         }
      }
      
      public function allDeployedUnitsDied() : void
      {
         if(attackInfo.deployPassed)
         {
            _endAttackTimer.start();
         }
         else
         {
            if(attackInfo.beast && attackInfo.beast.status == UnitStatusType.WAITING_TO_DEPLOY)
            {
               return;
            }
            for each(var _loc1_ in attackInfo.units)
            {
               if(_loc1_.status == UnitStatusType.WAITING_TO_DEPLOY || _loc1_.status == UnitStatusType.DEPLOYING)
               {
                  return;
               }
            }
            _endAttackTimer.start();
         }
      }
      
      public function noTargetToAttack() : void
      {
         if(!_noTargetToAttack)
         {
            _noTargetToAttack = true;
            _endAttackTimer.start();
            soundPlayer.playSfxById("VictoryChant");
         }
      }
      
      public function onTimerCompleteAndEndAttack(param1:TimerEvent) : void
      {
         MobileMercenaryDeployTabBeastView.buttonState = 1;
         if(userInfo.gameMode == GameModeType.ATTACK)
         {
            dispatch(new EndAttackEvent("endAttack"));
         }
         else if(userInfo.gameMode == GameModeType.DEFEND)
         {
            dispatch(new EndNPCAttackEvent("endNPCAttack"));
         }
         else if(userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            dispatch(new EndTuskHornEvent("endAttack"));
         }
      }
      
      public function watchPostUnitDeployed(param1:Building) : void
      {
         var _loc3_:ReceivedTroopsReleasedFromWatchPostLog = null;
         var _loc4_:int = param1.data.buildingInfo.instanceId;
         if(!(_loc4_ in attackInfo.troopsReleasedFromWatchPostLogs))
         {
            _loc3_ = new ReceivedTroopsReleasedFromWatchPostLog();
            _loc3_.occurrenceTimeInMillis = getTimer() - attackInfo.attackStartTime;
            for each(var _loc2_ in cityInfo.units)
            {
               if(_loc2_.buildingId == _loc4_)
               {
                  if(!(_loc2_.typeId in _loc3_.troopCounts))
                  {
                     _loc3_.troopCounts[_loc2_.typeId] = 0;
                  }
                  _loc3_.troopCounts[_loc2_.typeId]++;
               }
            }
            attackInfo.troopsReleasedFromWatchPostLogs[_loc4_] = _loc3_;
         }
      }
      
      public function unitRetreated(param1:Unit) : void
      {
         var _loc3_:WomGameRoot = param1.root as WomGameRoot;
         if(_loc3_)
         {
            for each(var _loc2_ in _loc3_.buildings)
            {
               if(_loc2_.data && _loc2_.data.buildingInfo && _loc2_.data.buildingInfo.buildingTypeId == 29)
               {
                  if("TowerDefense" in _loc2_.componentManager)
                  {
                     (_loc2_.componentManager["TowerDefense"] as BeastCave).attackingUnitRetreated(param1);
                  }
               }
            }
         }
      }
      
      public function notifyBuildingHit(param1:BuildingData) : void
      {
         attackInfo.buildingDamagedLogs[param1.buildingInfo.instanceId] = getTimer() - attackInfo.attackStartTime;
      }
      
      public function firstDeploy() : void
      {
         var _loc1_:int = 0;
         userInfo.redirectToMap = false;
         userInfo.mapInCampaignMode = false;
         soundPlayer.stopAmbient();
         soundPlayer.playMusicById("AttackTheme");
         if(userInfo.fromMap)
         {
            _loc1_ = (getTimer() - attackInfo.attackStartTime) / 1000 << 0;
            kontagentApi.trackCustomEvent("MapAttack",{
               "subtype1":"attack_deploy",
               "subtype2":_loc1_
            });
         }
         dispatch(new CombatHelpTextEvent("firstUnitDeployText",false));
      }
      
      public function notifyCatapultDamage(param1:Number) : void
      {
         attackInfo.totalCatapultDamageDone += param1;
      }
      
      public function notifyBuildingDestroyed(param1:int, param2:int) : void
      {
         if(param2 == 10)
         {
            dispatch(new VictoryMeterEvent("cityCenterDestroyed"));
         }
         else if(param2 == 19)
         {
            for each(var _loc3_ in cityInfo.units)
            {
               if(_loc3_.buildingId == param1)
               {
                  _loc3_.status = UnitStatusType.DEAD;
               }
            }
         }
      }
      
      public function waypointCalculated(param1:PathFindWaypointDTO) : void
      {
         if(userInfo.gameMode == GameModeType.ATTACK)
         {
            dispatch(new AddWaypointsEvent("addWayPoint",param1));
         }
      }
      
      public function unitDeployedDTO(param1:DeployUnitCircleInfoDTO) : void
      {
         dispatch(new RemoveDeployedUnitsEvent("unitDeployed",param1));
      }
      
      public function beastDeployedDTO(param1:DeployBeastCircleInfoDTO) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new BeastDeployedRequest(getTimer() - attackInfo.attackStartTime,param1)));
      }
      
      public function catapultDeployedDTO(param1:DeployedCatapultCircleInfoDTO) : void
      {
         dispatch(new OutgoingMessageEvent("outgoingMessage",new CatapultUsedRequest(param1,getTimer() - attackInfo.attackStartTime)));
      }
      
      public function beastRetreated() : void
      {
         attackInfo.beastRetreatFrameNumber = FpsSync.frameNum;
      }
      
      public function flushCollectedData(param1:int, param2:ByteArray) : void
      {
         dispatch(new RemoveDeployedUnitsEvent("flushDeployedUnits"));
         dispatch(new AddWaypointsEvent("flushWaypoints"));
         dispatch(new OutgoingMessageEvent("outgoingMessage",new SaveDeltaTimeRequest(param1,param2)));
      }
      
      private function findNeededPartId(param1:int, param2:int, param3:WomGameRoot) : int
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Boolean = false;
         var _loc7_:int = 0;
         var _loc4_:InventoryItemDTO = null;
         if(param2 == 10)
         {
            return attackInfo.mostNeededPartId;
         }
         var _loc10_:int = (param1 - 11) * 4 + 10;
         var _loc5_:Vector.<int> = new Vector.<int>();
         _loc9_ = 0;
         while(_loc9_ < 4)
         {
            _loc6_ = _loc10_ + _loc9_;
            _loc8_ = false;
            _loc7_ = 0;
            while(_loc7_ < userInfo.items.length)
            {
               _loc4_ = userInfo.items[_loc7_];
               if(_loc4_.category == InventoryItemCategory.PARTS && _loc4_.id == _loc6_)
               {
                  _loc8_ = true;
                  if(_loc4_.amount < 20)
                  {
                     _loc5_.push(_loc6_);
                  }
                  break;
               }
               _loc7_++;
            }
            if(!_loc8_)
            {
               _loc5_.push(_loc6_);
            }
            _loc9_++;
         }
         if(_loc5_.length > 0)
         {
            return randomizeVector(_loc5_,param3)[0];
         }
         return -1;
      }
      
      private function randomizeVector(param1:Vector.<int>, param2:WomGameRoot) : Vector.<int>
      {
         var _loc3_:Vector.<int> = new Vector.<int>();
         while(param1.length > 0)
         {
            _loc3_.push(param1.splice(Math.floor(Math.random() * param1.length),1));
         }
         return _loc3_;
      }
   }
}

