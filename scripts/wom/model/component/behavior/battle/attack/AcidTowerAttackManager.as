package wom.model.component.behavior.battle.attack
{
   import flash.display.BitmapData;
   import flash.media.Sound;
   import peak.cuckoo.game.dto.Point3;
   import peak.thread.WorkerThread;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.ParticleManager;
   import wom.model.component.behavior.battle.BattleFieldControl;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Particle;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.game.unit.UnitStatusType;
   
   public class AcidTowerAttackManager extends UnitAttackManager
   {
      
      public static const DROP_GROW_TIME:int = 30;
      
      public static const DROP_DISPOSAL_TIME:int = 180;
      
      private const BOMB_VELOCITY:int = 30;
      
      private const EXPLOSION_RANGE:Number = 12;
      
      private var baseSize:int;
      
      private var particleBitmapData:BitmapData;
      
      private var iS:int;
      
      private var iF:int;
      
      private var jS:int;
      
      private var jF:int;
      
      private var bfc:BattleFieldControl;
      
      private var rangeSquare:Number;
      
      private var x:int;
      
      private var y:int;
      
      private var particleManager:ParticleManager;
      
      private var towerSound:Vector.<Sound> = new Vector.<Sound>();
      
      private var range:int;
      
      private var particleAssetId:String;
      
      public function AcidTowerAttackManager(param1:int)
      {
         super();
         this.baseSize = param1;
         wait = new WorkerThread();
      }
      
      override public function init() : void
      {
         initialized = true;
         womRoot = owner.root as WomGameRoot;
         ownerUnit = owner as Unit;
         sync = womRoot.sync;
         bfc = womRoot.battleManager.battleFieldControl;
         hit = ownerUnit.hit;
         othersHitting = new Vector.<Unit>();
         range = ownerUnit.data.range;
         rangeSquare = range * range;
         x = ownerUnit.position.point.x;
         y = ownerUnit.position.point.y;
         iS = (x - range) / 10;
         iF = (x + range) / 10;
         jS = (y - range) / 10;
         jF = (y + range) / 10;
         if(iS < 0)
         {
            iS = iS - 1;
         }
         if(iF > 0)
         {
            iF = iF + 1;
         }
         if(jS < 0)
         {
            jS = jS - 1;
         }
         if(jF > 0)
         {
            jF = jF + 1;
         }
         particleManager = womRoot.particleManager;
         sfx = womRoot.sfxManager;
         towerSound[0] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack1").soundAsset.sound;
         towerSound[1] = sfx.assetRepository.getSoundAssetReference("BombardTowerAttack2").soundAsset.sound;
         particleAssetId = "U34Ball";
      }
      
      override public function update() : void
      {
         var _loc1_:Particle = null;
         var _loc2_:Point3 = null;
         wait.value -= sync.precise;
         var _loc3_:WorkerThread = wait;
         var _loc4_:WorkerThread;
         if(_loc3_._value > (_loc4_ = womRoot.zcmp)._value)
         {
            return;
         }
         var _temp_4:* = wait;
         var _loc5_:WorkerThread;
         var _loc7_:Number = (_loc5_ = womRoot.uhwd)._value;
         var _loc6_:WorkerThread = _temp_4;
         _loc6_._value = _loc7_;
         targetUnit = selectNearestUnit();
         if(targetUnit)
         {
            _loc1_ = new Particle(new Point3(ownerUnit.position.projected.x + 30,ownerUnit.position.projected.y + 30),targetUnit.position.projected,new Point3(targetUnit.viewManager.middlePoint.x,targetUnit.viewManager.middlePoint.y),30,particleAssetId,false,false);
            _loc2_ = new Point3(targetUnit.position.point.x,targetUnit.position.point.y,targetUnit.position.point.z);
            _loc1_.hit.add(new HitHandler(this,_loc2_));
            particleManager.throwParticle(_loc1_);
            sfx.towerEffect(towerSound[Math.random() * 4 > 1 ? 0 : 1],ownerUnit);
         }
      }
      
      private function selectNearestUnit() : Unit
      {
         var _loc9_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:BattleField = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:Unit = null;
         var _loc7_:Number = rangeSquare + 1000;
         var _loc3_:Unit = null;
         _loc9_ = iS;
         while(_loc9_ <= iF)
         {
            _loc8_ = jS;
            while(_loc8_ <= jF)
            {
               _loc1_ = bfc.battleFields[(_loc9_ << 10) + (_loc8_ << 0)] as BattleField;
               if(_loc1_ && _loc1_.defenceUnits && _loc1_.defenceUnits.length > 0)
               {
                  _loc6_ = _loc9_ * 10 - x;
                  _loc5_ = _loc8_ * 10 - y;
                  _loc4_ = _loc6_ * _loc6_ + _loc5_ * _loc5_;
                  if(_loc4_ < rangeSquare)
                  {
                     _loc2_ = _loc1_.defenceUnits[0];
                     if(_loc2_.data && _loc2_.data.info && _loc2_.data.info.status != UnitStatusType.IN_WATCH_POST && _loc2_.data.info.healthPoints > 0 && _loc7_ > _loc4_)
                     {
                        _loc7_ = _loc4_;
                        _loc3_ = _loc2_;
                     }
                  }
               }
               _loc8_++;
            }
            _loc9_++;
         }
         return _loc3_;
      }
      
      public function createExplosionAnimation(param1:int, param2:int) : void
      {
         var _loc4_:Point3 = new Point3(param1,param2);
         var _loc3_:Point3 = new Point3();
         womRoot.projection.transform(_loc4_,_loc3_);
         womRoot.battleManager.effects.addFoamAnimation(_loc3_.x,_loc3_.y);
      }
      
      override public function stopAttackBuilding(param1:Boolean = false) : void
      {
      }
      
      override public function defendYourself(param1:Unit = null) : void
      {
      }
      
      override public function startAttackBuilding(param1:Building) : void
      {
      }
      
      override public function retreatAttack() : void
      {
      }
      
      override public function enemyUnitDied(param1:Unit) : void
      {
      }
   }
}

import peak.cuckoo.game.dto.Point3;
import peak.signal.Slot0;

class HitHandler implements Slot0
{
   
   public var owner:AcidTowerAttackManager;
   
   public var x:Number;
   
   public var y:Number;
   
   public var air:Boolean;
   
   public function HitHandler(param1:AcidTowerAttackManager, param2:Point3)
   {
      super();
      this.owner = param1;
      this.x = param2.x;
      this.y = param2.y;
      this.air = param2.z > 5;
   }
   
   public function onSignal0() : void
   {
      owner.createExplosionAnimation(x,y);
      owner.hit.hit(x,y,air);
   }
}
