package wom.model.component.attribute
{
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.resource.SoundPlayer;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.SoundChannelContainer;
   import wom.model.game.attack.GameModeType;
   import wom.model.resource.WomAssetRepository;
   
   public class SfxManager extends Behavior
   {
      
      public static const TYPE_ID:String = "SFXManager";
      
      private static const ATTACK_PLAY_LIMIT:int = 100;
      
      private static const MOVE_PLAY_LIMIT:int = 200;
      
      private static const DEATH_PLAY_LIMIT:int = 100;
      
      private static const DESTROY_PLAY_LIMIT:int = 100;
      
      private static const DAMAGE_PLAY_LIMIT:int = 100;
      
      private static const CONTAINER_SIZE:int = 200;
      
      public var soundPlayer:SoundPlayer;
      
      private var unitDeathDefaultSounds:Vector.<Sound> = new Vector.<Sound>();
      
      private var burnLoop:SoundChannel;
      
      private var fireLoopSound:Sound;
      
      public var assetRepository:WomAssetRepository;
      
      private var viewport:Viewport;
      
      private var sync:FpsSync;
      
      private var womRoot:WomGameRoot;
      
      private var lastAttackPlayed:int;
      
      private var lastMovePlayed:int;
      
      private var lastDeathPlayed:int;
      
      private var lastDamagePlayed:int;
      
      private var lastDestroyPlayed:int;
      
      private var current:int = 0;
      
      private var soundContainer:Vector.<EffectSound> = new Vector.<EffectSound>(200,true);
      
      private var loopingSounds:Vector.<SoundChannelContainer>;
      
      public function SfxManager(param1:SoundPlayer, param2:WomAssetRepository)
      {
         super();
         priority = 0;
         this.soundPlayer = param1;
         this.assetRepository = param2;
         unitDeathDefaultSounds[0] = param2.getSoundAssetReference("MercDeath1").soundAsset.sound;
         unitDeathDefaultSounds[1] = param2.getSoundAssetReference("MercDeath2").soundAsset.sound;
         unitDeathDefaultSounds[2] = param2.getSoundAssetReference("MercDeath3").soundAsset.sound;
         fireLoopSound = param2.getSoundAssetReference("DamagedFire").soundAsset.sound;
         loopingSounds = new Vector.<SoundChannelContainer>();
         param1.onDisableSfx(sfxDisabled);
         param1.onEnableSfx(sfxEnabled);
      }
      
      override public function get typeId() : String
      {
         return "SFXManager";
      }
      
      override public function init() : void
      {
         super.init();
         viewport = owner.root.viewport;
         sync = owner.root.sync;
         womRoot = owner.root as WomGameRoot;
         loopingSounds.length = 0;
      }
      
      override public function update() : void
      {
         current = (current + 1) % 200;
         var _loc1_:EffectSound = soundContainer[current];
         while(_loc1_)
         {
            soundPlayer.playSfx(_loc1_.sound,_loc1_.pan,_loc1_.volume);
            _loc1_ = _loc1_.next;
         }
         soundContainer[current] = null;
      }
      
      private function add(param1:EffectSound) : void
      {
         var _loc2_:EffectSound = null;
         var _loc3_:int = (current + Math.random() * 20) % 200;
         if(!soundContainer[_loc3_])
         {
            soundContainer[_loc3_] = param1;
         }
         else
         {
            _loc2_ = soundContainer[_loc3_];
            while(_loc2_.next)
            {
               _loc2_ = _loc2_.next;
            }
            _loc2_.next = param1;
         }
      }
      
      public function unitMove(param1:Sound, param2:Unit) : void
      {
         if(sync.currentGameTime - lastMovePlayed < 200)
         {
            return;
         }
         lastMovePlayed = sync.currentGameTime;
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         if(womRoot.userInfo.gameMode == GameModeType.NORMAL)
         {
            if(param2.data.typeInfo)
            {
               _loc3_ *= 0.5;
            }
            soundPlayer.playSfx(param1,_loc4_,_loc3_);
         }
         else
         {
            add(new EffectSound(param1,_loc4_,_loc3_));
         }
      }
      
      public function unitAttack(param1:Sound, param2:GameSprite) : void
      {
         if(sync.currentGameTime - lastAttackPlayed < 100)
         {
            return;
         }
         lastAttackPlayed = sync.currentGameTime;
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         _loc3_ *= Math.random() * 0.3 + 0.5;
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         add(new EffectSound(param1,_loc4_,_loc3_));
      }
      
      public function unitDeath(param1:Sound, param2:GameSprite) : void
      {
         if(sync.currentGameTime - lastDeathPlayed < 100)
         {
            return;
         }
         lastDeathPlayed = sync.currentGameTime;
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         if(!param1)
         {
            soundPlayer.playSfx(unitDeathDefaultSounds[Math.random() * 3 >> 0],_loc4_,_loc3_);
         }
         else
         {
            soundPlayer.playSfx(param1,_loc4_,_loc3_);
         }
      }
      
      public function buildingDamage(param1:Sound, param2:GameSprite) : void
      {
         if(sync.currentGameTime - lastDamagePlayed < 100)
         {
            return;
         }
         lastDamagePlayed = sync.currentGameTime;
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         soundPlayer.playSfx(param1,_loc4_,_loc3_);
      }
      
      public function buildingDestroy(param1:Sound, param2:GameSprite) : void
      {
         if(sync.currentGameTime - lastDestroyPlayed < 100)
         {
            return;
         }
         lastDestroyPlayed = sync.currentGameTime;
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         soundPlayer.playSfx(param1,_loc4_,_loc3_);
      }
      
      public function towerEffect(param1:Sound, param2:GameSprite) : SoundChannel
      {
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         return soundPlayer.playSfx(param1,_loc4_,_loc3_);
      }
      
      public function trapActivate(param1:Sound, param2:GameSprite) : void
      {
         var _loc3_:Number = 1;
         if(param2.culled)
         {
            _loc3_ *= 0.3;
         }
         _loc3_ *= Math.random() * 0.3 + 0.5;
         var _loc4_:Number = param2.bounds.point.x / viewport.rect.width * 2 - 1;
         soundPlayer.playSfx(param1,_loc4_,_loc3_);
      }
      
      public function catapultActivate(param1:Sound) : SoundChannelContainer
      {
         var _loc2_:SoundChannelContainer = new SoundChannelContainer();
         _loc2_.channel = soundPlayer.playSfx(_loc2_.sfx = param1,0,1,2147483647);
         loopingSounds.push(_loc2_);
         return _loc2_;
      }
      
      public function catapultFinished(param1:SoundChannelContainer) : void
      {
         param1.channel && param1.channel.stop();
         var _loc2_:int = loopingSounds.indexOf(param1);
         if(_loc2_ != -1)
         {
            loopingSounds.splice(_loc2_,1);
         }
      }
      
      public function startBurn() : void
      {
         if(!burnLoop)
         {
            burnLoop = soundPlayer.playSfx(fireLoopSound,0,1,2147483647);
         }
      }
      
      public function getMoveSound(param1:UnitData) : Vector.<Sound>
      {
         var _loc2_:Vector.<Sound> = new Vector.<Sound>();
         if(!param1.info)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("WorkerMovement1").soundAsset.sound);
            _loc2_.push(assetRepository.getSoundAssetReference("WorkerMovement2").soundAsset.sound);
         }
         else if(param1.info.typeId == 23 || param1.info.typeId == 25)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("HezarfenMovement").soundAsset.sound);
         }
         else if(param1.isBeast && param1.levelIndex + 1 <= 3)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("BeastMove13").soundAsset.sound);
         }
         else if(param1.isBeast)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("BeastMove46").soundAsset.sound);
         }
         else if(param1.info.typeId == 12)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("NightRiderMovement").soundAsset.sound);
         }
         else if(param1.info.typeId == 24)
         {
            _loc2_.push(assetRepository.getSoundAssetReference("GentleHealerMovement").soundAsset.sound);
         }
         else
         {
            _loc2_.push(assetRepository.getSoundAssetReference("MercMovement1").soundAsset.sound);
            _loc2_.push(assetRepository.getSoundAssetReference("MercMovement2").soundAsset.sound);
         }
         return _loc2_;
      }
      
      public function getAttackSound(param1:UnitData) : Sound
      {
         var _loc2_:Sound = null;
         if(param1.isBeast)
         {
            if(param1.levelIndex + 1 <= 3)
            {
               _loc2_ = assetRepository.getSoundAssetReference("BeastAttack13").soundAsset.sound;
            }
            else
            {
               _loc2_ = assetRepository.getSoundAssetReference("BeastAttack46").soundAsset.sound;
            }
         }
         else
         {
            switch(param1.info.typeId)
            {
               case 10:
                  _loc2_ = assetRepository.getSoundAssetReference("BedouinBruteAttack").soundAsset.sound;
                  break;
               case 11:
                  _loc2_ = assetRepository.getSoundAssetReference("JanissaryAttack").soundAsset.sound;
                  break;
               case 12:
                  _loc2_ = assetRepository.getSoundAssetReference("NightRiderAttack").soundAsset.sound;
                  break;
               case 13:
                  _loc2_ = assetRepository.getSoundAssetReference("PersianHashishinAttack").soundAsset.sound;
                  break;
               case 14:
                  _loc2_ = assetRepository.getSoundAssetReference("KhamikazeeAttack").soundAsset.sound;
                  break;
               case 15:
                  _loc2_ = assetRepository.getSoundAssetReference("NubianGuardAttack").soundAsset.sound;
                  break;
               case 16:
                  _loc2_ = assetRepository.getSoundAssetReference("RavagerAttack").soundAsset.sound;
                  break;
               case 17:
                  _loc2_ = assetRepository.getSoundAssetReference("PainblowerAttack").soundAsset.sound;
                  break;
               case 18:
                  _loc2_ = assetRepository.getSoundAssetReference("SneakPeakAttack").soundAsset.sound;
                  break;
               case 19:
                  _loc2_ = assetRepository.getSoundAssetReference("MongolianGargantuanAttack").soundAsset.sound;
                  break;
               case 20:
                  _loc2_ = assetRepository.getSoundAssetReference("PharaohWarriorAttack").soundAsset.sound;
                  break;
               case 21:
               case 30:
                  _loc2_ = assetRepository.getSoundAssetReference("RocknGaulAttack").soundAsset.sound;
                  break;
               case 22:
                  _loc2_ = assetRepository.getSoundAssetReference("PersianSapperAttack").soundAsset.sound;
                  break;
               case 23:
                  _loc2_ = assetRepository.getSoundAssetReference("HezarfenAttack").soundAsset.sound;
                  break;
               case 24:
                  _loc2_ = assetRepository.getSoundAssetReference("GentleHealerAttack").soundAsset.sound;
                  break;
               default:
                  _loc2_ = assetRepository.getSoundAssetReference("BedouinBruteAttack").soundAsset.sound;
            }
         }
         return _loc2_;
      }
      
      public function getDeathSound(param1:UnitData) : Sound
      {
         var _loc2_:Sound = null;
         if(param1.isBeast)
         {
            _loc2_ = assetRepository.getSoundAssetReference("BeastDeath").soundAsset.sound;
         }
         else
         {
            switch(param1.info.typeId - 18)
            {
               case 0:
                  _loc2_ = assetRepository.getSoundAssetReference("SneakPeakDeath").soundAsset.sound;
                  break;
               case 3:
                  _loc2_ = assetRepository.getSoundAssetReference("RocknGaulDeath").soundAsset.sound;
                  break;
               case 6:
                  _loc2_ = assetRepository.getSoundAssetReference("GentleHealerDeath").soundAsset.sound;
            }
         }
         return _loc2_;
      }
      
      public function getDamageSound(param1:BuildingData) : Sound
      {
         var _loc3_:Sound = null;
         var _loc2_:int = param1.buildingInfo.level;
         if(_loc2_ >= 5)
         {
            _loc3_ = assetRepository.getSoundAssetReference("BuildingLevel5Damage").soundAsset.sound;
         }
         else if(_loc2_ >= 3)
         {
            _loc3_ = assetRepository.getSoundAssetReference("BuildingLevel3To4Damage").soundAsset.sound;
         }
         else
         {
            _loc3_ = assetRepository.getSoundAssetReference("BuildingLevel1To2Damage").soundAsset.sound;
         }
         return _loc3_;
      }
      
      public function getDestroySound(param1:BuildingData) : Sound
      {
         var _loc2_:Sound = null;
         var _loc3_:int = param1.buildingInfo.level;
         if(param1.buildingInfo.buildingTypeId == 10)
         {
            _loc2_ = assetRepository.getSoundAssetReference("CityCenterDestroy").soundAsset.sound;
         }
         else if(_loc3_ >= 10)
         {
            _loc2_ = assetRepository.getSoundAssetReference("BuildingLevel10Destroy").soundAsset.sound;
         }
         else if(_loc3_ >= 5)
         {
            _loc2_ = assetRepository.getSoundAssetReference("BuildingLevel5To9Destroy").soundAsset.sound;
         }
         else if(_loc3_ >= 3)
         {
            _loc2_ = assetRepository.getSoundAssetReference("BuildingLevel3To4Destroy").soundAsset.sound;
         }
         else
         {
            _loc2_ = assetRepository.getSoundAssetReference("BuildingLevel1To2Destroy").soundAsset.sound;
         }
         return _loc2_;
      }
      
      override public function destroy() : void
      {
         disable();
         burnLoop && burnLoop.stop();
         burnLoop = null;
         for each(var _loc1_ in loopingSounds)
         {
            _loc1_.channel && _loc1_.channel.stop();
         }
         loopingSounds.length = 0;
      }
      
      private function sfxDisabled() : void
      {
         burnLoop && burnLoop.stop();
         for each(var _loc1_ in loopingSounds)
         {
            _loc1_.channel && _loc1_.channel.stop();
         }
      }
      
      private function sfxEnabled() : void
      {
         if(burnLoop)
         {
            burnLoop = null;
            startBurn();
         }
         for each(var _loc1_ in loopingSounds)
         {
            _loc1_.channel = soundPlayer.playSfx(_loc1_.sfx,0,1,2147483647);
         }
      }
   }
}

import flash.media.Sound;

class EffectSound
{
   
   public var sound:Sound;
   
   public var pan:Number;
   
   public var volume:Number;
   
   public var next:EffectSound;
   
   public function EffectSound(param1:Sound, param2:Number = 0, param3:Number = 1)
   {
      super();
      this.sound = param1;
      this.pan = param2;
      this.volume = param3;
   }
}
