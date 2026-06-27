package wom.model.component.behavior.building
{
   import peak.cuckoo.core.Behavior;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.job.BuildingRepairJob;
   
   public class BuildingRepair extends Behavior
   {
      
      public static const TYPE_ID:String = "BuildingRepair";
      
      private var womRoot:WomGameRoot;
      
      private var buildingData:BuildingData;
      
      private var lastHealth:int = -1;
      
      private var buildingViewManager:BuildingViewManager;
      
      public var buildingRepairJob:BuildingRepairJob;
      
      private var under5min:Boolean = false;
      
      private var maxHealth:Number;
      
      private var _barrier1:Number;
      
      private var _barrier3:Number;
      
      private var healthStateBarrier:Number;
      
      public function BuildingRepair(param1:BuildingRepairJob)
      {
         super();
         this.buildingRepairJob = param1;
      }
      
      override public function get typeId() : String
      {
         return "BuildingRepair";
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         buildingViewManager = (owner as Building).viewManager;
         buildingData = (owner as Building).data;
         maxHealth = buildingData.buildingTypeDIO.healthPointsPerLevel[buildingData.buildingInfo.level == 0 ? 0 : buildingData.buildingInfo.level - 1];
         _barrier1 = maxHealth * 0.7;
         _barrier3 = maxHealth * 0.3;
         if(buildingData.buildingInfo.healthPoint < _barrier3)
         {
            healthStateBarrier = _barrier3;
         }
         else if(buildingData.buildingInfo.healthPoint < _barrier1)
         {
            healthStateBarrier = _barrier1;
         }
         else
         {
            healthStateBarrier = maxHealth;
         }
         buildingViewManager.prepareAssetsForRepair();
         if(buildingViewManager.specializedAnimation)
         {
            buildingViewManager.stopAnimation();
         }
      }
      
      override public function update() : void
      {
         if(buildingData.buildingInfo.healthPoint == maxHealth || buildingRepairJob == null)
         {
            destroy();
         }
         else if(lastHealth != buildingData.buildingInfo.healthPoint)
         {
            lastHealth = buildingData.buildingInfo.healthPoint;
            buildingViewManager.manageMainVisuals();
            buildingViewManager.manageHealthProgressBar();
            if(buildingData.buildingTypeDIO.id != 41 && womRoot.userInfo.gameMode == GameModeType.NORMAL && !under5min && buildingRepairJob.durationRemaining + buildingRepairJob.jobCreationTime - new Date().getTime() < 300000)
            {
               under5min = true;
               buildingViewManager.drawIndicator("SpeedupIcon");
            }
            if(buildingData.buildingInfo.healthPoint > healthStateBarrier)
            {
               if(healthStateBarrier == _barrier3)
               {
                  healthStateBarrier = _barrier1;
                  if(buildingData.buildingTypeDIO.baseSize > 15)
                  {
                     buildingViewManager.removeSmoke();
                  }
               }
               else if(healthStateBarrier == _barrier1)
               {
                  healthStateBarrier = maxHealth;
                  buildingViewManager.removeSmoke();
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         buildingRepairJob = null;
         buildingViewManager.manageHealthProgressBar();
         buildingViewManager.manageMainVisuals();
         buildingViewManager.manageFortifications();
         buildingViewManager.manageScaffolds();
         buildingViewManager.manageSmokes();
         if(womRoot.userInfo.gameMode == GameModeType.NORMAL)
         {
            buildingViewManager.clearIndicator();
         }
         owner.componentManager.remove(this);
         super.destroy();
      }
   }
}

