package wom.model.component.factory
{
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitTypeInfo;
   
   public interface UnitFactory
   {
      
      function assignAlreadyWorkingWorker(param1:Building) : void;
      
      function setWorkerCount(param1:int) : void;
      
      function addUnitToBarracks(param1:UnitInfo, param2:UnitTypeInfo) : void;
      
      function addHiredUnitToBarracks(param1:UnitInfo, param2:UnitTypeInfo, param3:int) : void;
      
      function addBeastToCanvas(param1:BeastInfo, param2:int, param3:int, param4:int = 0) : Unit;
      
      function addUnitToCanvas(param1:UnitInfo, param2:UnitTypeInfo, param3:int, param4:int, param5:int = 0) : Unit;
      
      function setGameRootHolder(param1:WomGameRootHolder) : void;
      
      function addBeastToCave(param1:BeastInfo) : void;
      
      function createUnit(param1:UnitInfo, param2:UnitTypeInfo = null, param3:Number = 0, param4:Number = 0, param5:Number = 0, param6:Boolean = true) : Unit;
   }
}

