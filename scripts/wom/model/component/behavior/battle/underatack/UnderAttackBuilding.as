package wom.model.component.behavior.battle.underatack
{
   import flash.media.Sound;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.grid.CityGrid;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.*;
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class UnderAttackBuilding extends UnderAttack
   {
      
      private var buildingData:BuildingData;
      
      private var cityGrid:CityGrid;
      
      private var ownerBuilding:Building;
      
      private var viewManager:BuildingViewManager;
      
      private var maxHealth:Number;
      
      public var attackerUnits:Vector.<Unit>;
      
      private var healthStateBarrier:Number;
      
      public var lootable:Boolean;
      
      protected var sfx:SfxManager;
      
      protected var damageSound:Sound;
      
      protected var destroySound:Sound;
      
      private var _barrier1:Number;
      
      private var _barrier2:Number;
      
      private var _barrier3:Number;
      
      public function UnderAttackBuilding(param1:BattleManager)
      {
         super(param1);
      }
      
      override public function init() : void
      {
         super.init();
         attackerUnits = new Vector.<Unit>();
         ownerBuilding = owner as Building;
         viewManager = ownerBuilding.viewManager;
         buildingData = ownerBuilding.data;
         maxHealth = buildingData.buildingTypeDIO.healthPointsPerLevel[buildingData.buildingInfo.level == 0 ? 0 : buildingData.buildingInfo.level - 1];
         _barrier1 = maxHealth * 0.7;
         _barrier2 = maxHealth * 0.5;
         _barrier3 = maxHealth * 0.3;
         if(buildingData.buildingInfo.healthPoint > _barrier1)
         {
            healthStateBarrier = _barrier1;
         }
         else if(buildingData.buildingInfo.healthPoint > _barrier2)
         {
            healthStateBarrier = _barrier2;
         }
         else if(buildingData.buildingInfo.healthPoint > _barrier3)
         {
            healthStateBarrier = _barrier3;
         }
         else
         {
            healthStateBarrier = 0;
         }
         cityGrid = owner.root.componentManager["CityGrid"] as CityGrid;
         lootable = buildingData.buildingTypeDIO.kind.id == 10 || buildingData.buildingTypeDIO.kind.id == 11 || buildingData.buildingTypeDIO.kind.id == 12;
         sfx = (owner.root as WomGameRoot).sfxManager;
         damageSound = sfx.getDamageSound(buildingData);
         destroySound = sfx.getDestroySound(buildingData);
      }
      
      public function startUnderAttack(param1:Unit) : void
      {
      }
      
      public function hit(param1:Number, param2:Number, param3:Boolean = true, param4:Boolean = false) : Boolean
      {
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         param1 *= buildingData.protectionModifier;
         param2 *= buildingData.protectionModifier;
         buildingData.damaged = true;
         var _loc7_:Number = buildingData.buildingInfo.healthPoint;
         buildingData.buildingInfo.healthPoint -= param1;
         battleManager.notifier.notifyBuildingHit(buildingData);
         if(param4 && _loc7_ > 0 && buildingData.buildingTypeDIO.id != 41)
         {
            battleManager.notifier.notifyCatapultDamage(buildingData.buildingInfo.healthPoint < 0 ? param1 + buildingData.buildingInfo.healthPoint : param1);
         }
         while(buildingData.buildingInfo.healthPoint < healthStateBarrier)
         {
            if(healthStateBarrier == 0)
            {
               break;
            }
            if(healthStateBarrier == _barrier3)
            {
               healthStateBarrier = 0;
               if(buildingData.buildingTypeDIO.baseSize > 15)
               {
                  viewManager.addDamageSmoke(true);
               }
            }
            else if(healthStateBarrier == _barrier2)
            {
               if(owner.componentManager["TowerDefense"])
               {
                  (owner.componentManager["TowerDefense"] as TowerDefense).applyDamageReduction();
               }
               healthStateBarrier = _barrier3;
               _loc6_ = "TowerAnimationManager" in owner.componentManager;
               if(_loc6_)
               {
                  _loc5_ = (owner.componentManager["TowerAnimationManager"] as TowerAnimationManager).getLastSide();
               }
               sfx.buildingDamage(damageSound,ownerBuilding);
               viewManager.manageMainVisuals();
               if(_loc6_ && ownerBuilding.viewManager.animation)
               {
                  (owner.componentManager["TowerAnimationManager"] as TowerAnimationManager).immediateTurnToFrame(_loc5_);
               }
            }
            else if(healthStateBarrier == _barrier1)
            {
               healthStateBarrier = _barrier2;
               viewManager.addDamageSmoke(true);
            }
         }
         viewManager.manageHealthProgressBar();
         if(buildingData.buildingInfo.healthPoint <= 0)
         {
            param2 *= (param1 + buildingData.buildingInfo.healthPoint) / param1;
            battleManager.battleFieldControl.buildingDestroyed(owner as Building,param2);
            battleManager.notifier.notifyRandomLoot(owner.root,buildingData.buildingInfo.instanceId,param2,param1,param3);
            return true;
         }
         battleManager.notifier.notifyRandomLoot(owner.root,buildingData.buildingInfo.instanceId,param2,param1,param3);
         return false;
      }
      
      public function destroyBuilding() : void
      {
         sfx.buildingDestroy(destroySound,ownerBuilding);
         buildingData.buildingInfo.healthPoint = 0;
         if(buildingData.buildingInfo.buildingTypeId == 19)
         {
            (owner.componentManager["CombineBuildingChildManager"] as CombineBuildingChildManager).killAllUnits();
         }
         viewManager.manageMainVisuals();
         viewManager.manageHealthProgressBar();
         viewManager.manageFortifications();
         viewManager.manageScaffolds();
         viewManager.swicthFireWithSmokes();
         var _loc2_:int = ownerBuilding.position.point.x;
         var _loc1_:int = ownerBuilding.position.point.y;
         cityGrid.unmarkBuilding(_loc2_,_loc1_,buildingData);
         if(owner.componentManager["TowerDefense"])
         {
            (owner.componentManager["TowerDefense"] as TowerDefense).towerDestroyed();
         }
      }
   }
}

