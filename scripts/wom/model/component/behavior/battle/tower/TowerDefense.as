package wom.model.component.behavior.battle.tower
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   import peak.thread.WorkerThread;
   import wom.model.component.WomGameRoot;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.*;
   import wom.model.component.behavior.battle.visuals.TowerAnimationFrame;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class TowerDefense extends TowerAnimationFrame
   {
      
      public static const TYPE_ID:String = "TowerDefense";
      
      public static const DAMAGE_REDUCTION:Number = 0.25;
      
      protected var womRoot:WomGameRoot;
      
      protected var sync:FpsSync;
      
      public var tm:WorkerThread;
      
      public var rm:WorkerThread;
      
      protected var reloadWait:Number = 0;
      
      public var position:Point3;
      
      public var iS:int;
      
      public var iF:int;
      
      public var jS:int;
      
      public var jF:int;
      
      public var tu:Unit;
      
      protected var td:Number;
      
      protected var attacksAir:Boolean = false;
      
      protected var attacksGround:Boolean = false;
      
      protected var ownerBuilding:Building;
      
      public function TowerDefense(param1:BattleManager, param2:Number)
      {
         super(param1,param2);
         tm = new WorkerThread();
         rm = new WorkerThread();
      }
      
      override public function get typeId() : String
      {
         return "TowerDefense";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         womRoot = owner.root as WomGameRoot;
         ownerBuilding = owner as Building;
         attacksAir = ownerBuilding.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.ATTACKS_AIR.id];
         attacksGround = ownerBuilding.data.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.ATTACKS_GROUND.id];
         var _loc1_:int = (owner as Building).data.buildingTypeDIO.baseSize / 2;
         position = new Point3((owner as GameSprite).position.point.x + _loc1_,(owner as GameSprite).position.point.y + _loc1_);
         iS = (position.x - r) / 10;
         iF = (position.x + r) / 10;
         jS = (position.y - r) / 10;
         jF = (position.y + r) / 10;
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
         var _loc2_:Number = ownerBuilding.data.buildingTypeDIO.healthPointsPerLevel[ownerBuilding.data.buildingInfo.level == 0 ? 0 : ownerBuilding.data.buildingInfo.level - 1];
         if(ownerBuilding.data.buildingInfo.healthPoint < _loc2_ * 0.5)
         {
            applyDamageReduction();
         }
         var _temp_15:* = tm;
         var _loc7_:Number = womRoot.tds._value;
         var _loc4_:WorkerThread = _temp_15;
         _loc4_._value = _loc7_;
         var _temp_18:* = rm;
         var _loc5_:WorkerThread;
         var _loc8_:Number = (_loc5_ = womRoot.tdrd)._value;
         var _loc6_:WorkerThread = _temp_18;
         _loc6_._value = _loc8_;
         reloadWait = 0;
         startEnabled = false;
         if("TowerAnimationManager" in owner.componentManager)
         {
            (owner.componentManager["TowerAnimationManager"] as TowerAnimationManager).resetAnimationForBattle();
         }
      }
      
      public function checkTarget() : void
      {
         var _loc1_:Number = (tu.position.point.x - position.x) * (tu.position.point.x - position.x) + (tu.position.point.y - position.y) * (tu.position.point.y - position.y);
         if(_loc1_ > r * r || tu.data.info.typeId == 22 && tu.movement.enabled)
         {
            stopAttack(false);
         }
      }
      
      public function checkUnitToAttack(param1:Unit) : int
      {
         if(param1.data.info.typeId == 22 && param1.movement.enabled)
         {
            var _loc3_:WorkerThread = womRoot.tdrd;
            return _loc3_._value;
         }
         if(!attacksGround && !param1.data.typeDIO.flying || !attacksAir && param1.data.typeDIO.flying)
         {
            var _loc4_:WorkerThread = womRoot.tdrd;
            return _loc4_._value;
         }
         var _loc2_:Number = (param1.position.point.x - position.x) * (param1.position.point.x - position.x) + (param1.position.point.y - position.y) * (param1.position.point.y - position.y);
         if(r * r < _loc2_)
         {
            var _loc5_:WorkerThread = womRoot.tdrd;
            return _loc5_._value;
         }
         if(!tu || _loc2_ < td)
         {
            td = _loc2_;
            if(param1 is Unit)
            {
               tu = param1;
               if(!(tu is Unit))
               {
                  throw new VerifyError("Could not verify");
               }
            }
            if(_loc2_ != td)
            {
               throw new VerifyError("Could not verify");
            }
         }
         if(!tu || _loc2_ < td)
         {
            throw new VerifyError("Could not verify");
         }
         var _loc6_:WorkerThread = womRoot.tdrg;
         return _loc6_._value;
      }
      
      override public function update() : void
      {
         var _loc1_:WorkerThread = rm;
         var _loc4_:WorkerThread;
         if(_loc1_._value != womRoot.tdrd._value && _loc3_._value != (_loc4_ = womRoot.tdrg)._value)
         {
            throw new VerifyError("Could not verify rm");
         }
         var _loc5_:WorkerThread = rm;
         var _loc6_:WorkerThread;
         if(_loc5_._value == (_loc6_ = womRoot.tdrg)._value)
         {
            reloadWait -= sync.precise;
            var _loc7_:WorkerThread = womRoot.zcmp;
            if(_loc7_._value >= reloadWait)
            {
               var _temp_8:* = rm;
               var _loc8_:WorkerThread;
               var _loc12_:Number = (_loc8_ = womRoot.tdrd)._value;
               var _loc9_:WorkerThread = _temp_8;
               _loc9_._value = _loc12_;
               var _loc10_:WorkerThread = tm;
               var _loc11_:WorkerThread;
               if(_loc10_._value == (_loc11_ = womRoot.tds)._value)
               {
                  disable();
               }
            }
         }
         if(tu && tu.data && tu.data.info.healthPoints <= 0)
         {
            stopAttack();
         }
      }
      
      public function startAttack() : void
      {
         tu.underAttack.startTowerUnderAttack(ownerBuilding);
      }
      
      public function stopAttack(param1:Boolean = true) : void
      {
         if(tu && param1)
         {
            tu.underAttack.stopTowerUnderAttack(ownerBuilding);
         }
         tu = null;
         var _temp_3:* = tm;
         var _loc4_:Number = womRoot.tds._value;
         var _loc3_:WorkerThread = _temp_3;
         _loc3_._value = _loc4_;
      }
      
      public function calculateDamage() : void
      {
      }
      
      public function set damageModifier(param1:Number) : void
      {
         d = param1;
         calculateDamage();
      }
      
      public function applyDamageReduction(param1:Number = 0.25) : void
      {
         damageModifier = d * (1 - param1);
      }
      
      public function towerDestroyed() : void
      {
      }
   }
}

