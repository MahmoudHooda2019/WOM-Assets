package wom.model.component.operations
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Root;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.GuillotineData;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class Units
   {
      
      public function Units()
      {
         super();
      }
      
      public static function arrivedToExecution(param1:Unit, param2:GameSprite, param3:Root, param4:Boolean = true) : void
      {
         if(param4)
         {
            (param3 as WomGameRoot).particle3DAnimationManager.spillBlood(new Point3(param1.position.projected.x + param1.bounds.width / 2,param1.position.projected.y + param1.bounds.height / 2));
         }
         var _loc5_:SfxManager = (param3 as WomGameRoot).sfxManager;
         _loc5_.unitDeath(_loc5_.getDeathSound(param1.data),param1);
         param1.parent.removeChild(param1);
         (param2.componentManager["GuillotineData"] as GuillotineData).removeUnit();
         param3.layers[3].remove(param1);
         param1.destroy();
      }
      
      public static function arrivedToWatchPost(param1:Unit, param2:GameSprite, param3:Root) : void
      {
         param1.parent.removeChild(param1);
         param3.layers[3].remove(param1);
         param1.componentManager.destroyAll();
      }
      
      public static function removeUponArrival(param1:Unit, param2:Root) : void
      {
         param1.parent.removeChild(param1);
         param2.layers[3].remove(param1);
         param1.componentManager.destroyAll();
      }
      
      public static function arrivedToBeast(param1:Unit, param2:GameSprite, param3:Root) : void
      {
         param1.parent.removeChild(param1);
         param3.layers[3].remove(param1);
      }
      
      public static function arrivedWatchPostDoor(param1:Unit, param2:Building, param3:Root) : void
      {
         var unit:Unit = param1;
         var build:Building = param2;
         var root:Root = param3;
         var tx:int = build.position.point.x + build.data.buildingTypeDIO.baseSize / 2;
         var ty:int = build.position.point.y;
         unit.movement.moveToPoint(new Point3(tx,ty));
         unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            arrivedToExecution(param1,build,root,false);
         });
         (build.componentManager["GuillotineData"] as GuillotineData).addUnit();
      }
      
      public static function moveWatchPostFromWalk(param1:Movement, param2:Building, param3:int, param4:int, param5:GameSprite, param6:WomGameRoot) : void
      {
         var movement:Movement = param1;
         var build:Building = param2;
         var x:int = param3;
         var y:int = param4;
         var unit:GameSprite = param5;
         var root:WomGameRoot = param6;
         movement.clearWaypoint();
         movement.addWaypoint(new Point3(x,y - build.data.buildingTypeDIO.baseSize / 2));
         movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            arrivedToWatchPost(param1,build,root);
         });
      }
      
      public static function arrivedToBeastKeeper(param1:Unit, param2:Root) : void
      {
         param1.parent.removeChild(param1);
         param2.layers[3].remove(param1);
         param1.componentManager.destroyAll();
         delete (param2 as WomGameRoot).units[param1.data.info.instanceId];
      }
      
      public static function cagedBeastArrived(param1:WomGameRoot) : void
      {
         param1.removeCagedBeast();
      }
   }
}

