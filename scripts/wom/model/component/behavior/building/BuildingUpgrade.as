package wom.model.component.behavior.building
{
   import peak.cuckoo.core.Behavior;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.job.BuildingUpgradeJob;
   
   public class BuildingUpgrade extends Behavior
   {
      
      public static const TYPE_ID:String = "BuildingUpgrade";
      
      public var buildingUpgradeJob:BuildingUpgradeJob;
      
      private var under5min:Boolean = false;
      
      private var buildingViewManager:BuildingViewManager;
      
      private var womRoot:WomGameRoot;
      
      public function BuildingUpgrade(param1:BuildingUpgradeJob)
      {
         super();
         this.buildingUpgradeJob = param1;
      }
      
      override public function get typeId() : String
      {
         return "BuildingUpgrade";
      }
      
      override public function init() : void
      {
         var _loc2_:TowerAnimationManager = null;
         super.init();
         womRoot = owner.root as WomGameRoot;
         buildingViewManager = (owner as Building).viewManager;
         var _loc1_:BuildingTypeDIO = (owner as Building).data.buildingTypeDIO;
         if(_loc1_.kind.id == 28)
         {
            _loc2_ = owner.componentManager["TowerAnimationManager"] as TowerAnimationManager;
            if(_loc2_)
            {
               if(_loc2_.initialized)
               {
                  _loc2_.pauseTurning();
               }
               else
               {
                  _loc2_.requested = false;
               }
            }
         }
         if(_loc1_.id == 10)
         {
            (owner as Building).data.buildingInfo.incomplete = true;
            buildingViewManager.manageScaffolds();
         }
      }
      
      override public function update() : void
      {
         super.update();
         if(buildingUpgradeJob)
         {
            buildingViewManager.manageUpgradeProgressBar();
            if(!("BuildingRepair" in owner.componentManager))
            {
               if(womRoot.userInfo.gameMode == GameModeType.NORMAL && !under5min && buildingUpgradeJob.durationRemaining + buildingUpgradeJob.jobCreationTime - new Date().getTime() < 300000)
               {
                  under5min = true;
                  buildingViewManager.drawIndicator("SpeedupIcon");
               }
            }
            else
            {
               under5min = false;
            }
         }
         else
         {
            this.destroy();
         }
      }
      
      override public function destroy() : void
      {
         var _loc2_:TowerAnimationManager = null;
         buildingUpgradeJob = null;
         buildingViewManager.manageUpgradeProgressBar();
         if(womRoot.userInfo.gameMode == GameModeType.NORMAL)
         {
            buildingViewManager.clearIndicator();
         }
         var _loc1_:BuildingTypeDIO = (owner as Building).data.buildingTypeDIO;
         if(_loc1_.kind.id == 28)
         {
            _loc2_ = owner.componentManager["TowerAnimationManager"] as TowerAnimationManager;
            if(_loc2_)
            {
               if(_loc2_.initialized)
               {
                  _loc2_.enable();
               }
               else
               {
                  _loc2_.requested = true;
               }
            }
         }
         if(_loc1_.id == 10)
         {
            (owner as Building).data.buildingInfo.incomplete = false;
            buildingViewManager.manageScaffolds();
         }
         owner.componentManager.remove(this);
         super.destroy();
      }
   }
}

