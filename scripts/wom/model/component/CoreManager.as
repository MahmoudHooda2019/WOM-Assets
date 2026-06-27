package wom.model.component
{
   import flash.geom.Point;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.game.defense.NPCAttackDirection;
   import wom.model.game.helper.RowColumnPair;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitRecruitJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitInfo;
   
   public interface CoreManager
   {
      
      function addBuildings(param1:Vector.<BuildingInfo>, param2:Vector.<BuildingUpgradeJob>, param3:Vector.<BuildingRepairJob>) : void;
      
      function addBuilding(param1:BuildingInfo, param2:BuildingUpgradeJob = null, param3:BuildingRepairJob = null, param4:Boolean = false, param5:Boolean = false) : void;
      
      function addGrids(param1:RowColumnPair) : void;
      
      function updateGrids(param1:RowColumnPair) : void;
      
      function startBuild(param1:int, param2:Boolean, param3:Boolean = false, param4:Boolean = true) : void;
      
      function startBuildDecoration(param1:DecorationVariationInfo, param2:Boolean = false) : void;
      
      function addBackground() : void;
      
      function upgradeFinished(param1:int) : void;
      
      function startUpgrade(param1:int, param2:BuildingUpgradeJob) : void;
      
      function startRecruitment(param1:int, param2:UnitRecruitJob) : void;
      
      function moveBuilding(param1:int, param2:Point, param3:int, param4:int) : void;
      
      function startMove(param1:int) : void;
      
      function activateFinished(param1:int) : void;
      
      function upgradeCancelled(param1:int) : void;
      
      function cancelRecruitment(param1:int) : void;
      
      function releaseWorker(param1:int) : void;
      
      function fortificationUpgradeFinished(param1:int, param2:int) : void;
      
      function removeBuilding(param1:int) : void;
      
      function removeDecoration(param1:int) : void;
      
      function setWorkerCount(param1:int) : void;
      
      function notifyHealthPointChangeOfABuilding(param1:int) : void;
      
      function startRepair(param1:int, param2:BuildingRepairJob) : void;
      
      function endRepair(param1:int) : void;
      
      function manageBuildingBoundaryEnvironment(param1:int) : void;
      
      function assignUnitToBarracks(param1:UnitInfo) : void;
      
      function setUnits(param1:Vector.<UnitInfo>) : void;
      
      function setBeast(param1:BeastInfo) : void;
      
      function hireUnitFromHiringQuartersToBarracks(param1:UnitInfo, param2:int) : void;
      
      function executeUnitInBarracks(param1:int) : void;
      
      function executeUnitInWatchPost(param1:UnitInfo) : void;
      
      function deployUnitToWatchPostFromBarracks(param1:int, param2:int) : void;
      
      function deployUnitToWatchPostFromStore(param1:UnitInfo, param2:int) : void;
      
      function setFactories() : void;
      
      function startBattle() : void;
      
      function setDeployDiameter(param1:int, param2:int) : void;
      
      function killUnitForBeast(param1:int, param2:int) : void;
      
      function moveBuildingByPlanner(param1:int, param2:Point) : void;
      
      function moveDecorationByPlanner(param1:int, param2:Point) : void;
      
      function harvest(param1:int, param2:Number) : void;
      
      function lootResource(param1:int, param2:ResourceType, param3:int) : void;
      
      function lootPart(param1:int, param2:int) : void;
      
      function sendBeastToBeastKeeper(param1:BeastInfo) : void;
      
      function sendBeastToBeastCave(param1:BeastInfo) : void;
      
      function notifyBeastModelChange(param1:BeastInfo) : void;
      
      function handleCatapultAction(param1:int, param2:int) : void;
      
      function recalculateAllUnitStats() : void;
      
      function manageResourceProducerAnimations() : void;
      
      function manageStockpileAnimations() : void;
      
      function stopResourceAnimation(param1:int) : void;
      
      function drawIndicator(param1:int, param2:String) : void;
      
      function retreatBeast() : void;
      
      function displayBuildingDamage(param1:int, param2:int) : void;
      
      function manageCityCenterIndicatorStatus() : void;
      
      function manageMercenaryBarracksNotEnoughSpaceIndicator() : void;
      
      function manageIncompleteBuildingIndicators() : void;
      
      function determineHelpableStatusOfBuildings() : void;
      
      function removeHelpableStatusOfBuilding(param1:int) : void;
      
      function getCenterOfCityPosition() : Point;
      
      function getBuildingPositionByInstanceId(param1:int) : Point;
      
      function getBuildingPositionByTypeId(param1:int) : Point;
      
      function getBuildingByInstanceId(param1:String) : Building;
      
      function getBuildingByTypeId(param1:int) : Building;
      
      function getBuildingProgressBarPosition(param1:int) : Point;
      
      function deployNPCUnits(param1:Number, param2:Number, param3:NPCAttackDirection) : void;
      
      function prepareNPCAttack() : void;
      
      function notifyBeastHealthChange() : void;
      
      function changeBloodEffectSetting(param1:Boolean) : void;
      
      function closeBuildingTooltip() : void;
      
      function manageTrainingChamberIndicators() : void;
      
      function manageRecruitmentChamberIndicator() : void;
      
      function manageHiringQuartersAnimations() : void;
      
      function manageTrainingChamberAnimations() : void;
      
      function panToCenter() : void;
      
      function panToBuildingByTypeId(param1:int, param2:int = 0, param3:int = 0) : void;
      
      function centerToBuildingByTypeId(param1:int, param2:int = 0, param3:int = 0) : void;
      
      function zoomIn() : void;
      
      function zoomOut() : void;
      
      function startSpying() : void;
      
      function endSpying() : void;
      
      function addDecorations(param1:Vector.<DecorationInfo>) : void;
      
      function addDecoration(param1:DecorationInfo) : void;
      
      function addTerrain(param1:Array) : void;
      
      function destroyAllDoodads() : void;
      
      function updateAllianceFlags() : void;
      
      function raiseRP(param1:int) : void;
      
      function buildBeastCage() : void;
      
      function freeCagedBeast(param1:int) : void;
      
      function transferUnitInBarracks(param1:int) : void;
      
      function manageBlacksmithAnimation() : void;
      
      function buildCityExpansionSigns() : void;
      
      function mobileConfirmCanvasOperation() : void;
      
      function mobileCancelCanvasOperation() : void;
      
      function drawMobileTutorialArrowByTypeId(param1:int, param2:int = 0, param3:int = 0, param4:String = "TutorialArrowDownM") : void;
      
      function clearMobileTutorialArrowByTypeId(param1:int) : void;
      
      function drawMobileTutorialArrowByInstanceId(param1:String, param2:int = 0, param3:int = 0, param4:String = "TutorialArrowDownM") : void;
      
      function clearMobileTutorialArrowByInstanceId(param1:String) : void;
      
      function createFakeMobileDeployCircle(param1:Point) : void;
   }
}

