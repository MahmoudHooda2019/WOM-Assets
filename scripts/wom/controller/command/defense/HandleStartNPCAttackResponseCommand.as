package wom.controller.command.defense
{
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import peak.logging.log;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.defense.NPCAttackStatus;
   import wom.model.game.defense.UnitBatchInfoDTO;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.response.StartNPCAttackResponse;
   import wom.service.logging.WomLoggerContexts;
   
   public class HandleStartNPCAttackResponseCommand extends PCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function HandleStartNPCAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc7_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:* = undefined;
         var _loc3_:UnitTypeDIO = null;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:UnitStatusType = null;
         var _loc1_:StartNPCAttackResponse = messageReceivedEvent.message as StartNPCAttackResponse;
         if(_loc1_.resultCode == 0)
         {
            gameRootHolder.gameRoot.exitBuildMode();
            gameRootHolder.gameRoot.cancelMove();
            dispatch(new PopUpWindowEvent("delayPopUps",null));
            coreManager.closeBuildingTooltip();
            userInfo.npcAttackStatus = NPCAttackStatus.ATTACK;
            dispatch(new ModelUpdateEvent("npcAttackStatusUpdated"));
            userInfo.gameMode = GameModeType.DEFEND;
            dispatch(new GameModeChangedEvent("gameModeChange"));
            if(_loc1_.beastHealth != -1 && attackInfo.beast)
            {
               attackInfo.beast.healthPoints = _loc1_.beastHealth;
            }
            soundPlayer.stopAmbient();
            soundPlayer.playMusicById("DefenseTheme");
            attackInfo.reset();
            attackInfo.unitTypes = new Dictionary();
            attackInfo.units = new Vector.<UnitInfo>();
            attackInfo.attackStartTime = getTimer();
            attackInfo.attackEndTime = attackInfo.attackStartTime + 420000;
            attackInfo.attackEndTimeExtended = false;
            attackInfo.defender = userInfo.profile;
            attackInfo.attacker = new Profile(null,null,null,_loc1_.npcName);
            attackInfo.attackingUserResources = [];
            attackInfo.isAttackOngoing = true;
            attackInfo.beast = null;
            attackInfo.usedTrapInstanceIds = new Vector.<int>();
            attackInfo.combatItemEffects = new Vector.<ItemEffectInfo>();
            attackInfo.mostNeededPartId = -1;
            attackInfo.seedNumber = _loc1_.seedNumber;
            coreManager.prepareNPCAttack();
            coreManager.startBattle();
            _loc7_ = userInfo.mandatoryTutorialCompleted ? 60 : 10;
            _loc10_ = userInfo.mandatoryTutorialCompleted ? 150 : 50;
            _loc9_ = 300;
            _loc5_ = _loc10_;
            _loc4_ = (_loc9_ - _loc10_) / _loc1_.batches.length;
            for each(var _loc6_ in _loc1_.batches)
            {
               _loc8_ = _loc6_.batch;
               _loc3_ = domainInfo.getUnit(_loc8_.id);
               _loc11_ = 0;
               _loc12_ = 0;
               while(_loc12_ < _loc8_.amount)
               {
                  _loc2_ = UnitStatusType.DEPLOYING;
                  attackInfo.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),_loc2_,-1,_loc8_.id,_loc3_.healthPointsPerLevel[_loc11_],1,1,1));
                  _loc12_++;
               }
               if(!(_loc8_.id in attackInfo.unitTypes))
               {
                  attackInfo.unitTypes[_loc8_.id] = new UnitTypeInfo(_loc8_.id,1,true,false,false,false,false,0,0,0);
               }
               coreManager.deployNPCUnits(_loc7_,_loc5_ >> 0,_loc6_.direction);
               _loc5_ += _loc4_;
            }
            if(userInfo.mandatoryTutorialCompleted)
            {
               coreManager.panToCenter();
            }
            else
            {
               coreManager.panToBuildingByTypeId(31);
            }
         }
         else
         {
            log(WomLoggerContexts.GAME,"NPC Attack Failed : " + _loc1_.resultMessage);
         }
      }
   }
}

