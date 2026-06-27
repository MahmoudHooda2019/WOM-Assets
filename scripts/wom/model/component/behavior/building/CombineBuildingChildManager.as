package wom.model.component.behavior.building
{
   import flash.geom.Point;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.bounds.notCompositeBased.ParentRenderBounds;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.projection.IsoUnitProjection;
   import wom.model.component.attribute.projection.UnitOffsetProjection;
   import wom.model.component.behavior.Particle3DAnimationManager;
   import wom.model.component.behavior.unit.SynchronizedWander;
   import wom.model.component.behavior.unit.Wander;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.operations.Units;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.unit.UnitStatusType;
   
   public class CombineBuildingChildManager extends Behavior
   {
      
      public static const TYPE_ID:String = "CombineBuildingChildManager";
      
      public var gateCoord:Point3;
      
      public var buildingSpace:int;
      
      public var gardenSpace:int;
      
      public var edgeSpace:int;
      
      public var units:Vector.<Unit>;
      
      private var compositeView:CompositeView;
      
      private var ownerGS:GameSprite;
      
      private var womRoot:WomGameRoot;
      
      public function CombineBuildingChildManager(param1:int, param2:int, param3:int, param4:Point)
      {
         super();
         units = new Vector.<Unit>();
         this.edgeSpace = param1;
         this.gardenSpace = param2;
         this.buildingSpace = param3;
         this.gateCoord = new Point3(param4.x,param4.y);
      }
      
      override public function get typeId() : String
      {
         return "CombineBuildingChildManager";
      }
      
      override public function init() : void
      {
         units = new Vector.<Unit>();
         super.init();
         ownerGS = owner as GameSprite;
         womRoot = owner.root as WomGameRoot;
         compositeView = ownerGS.view as CompositeView;
      }
      
      override public function update() : void
      {
         super.update();
         ZSort.sort(compositeView.children);
      }
      
      public function addUnit(param1:Unit, param2:Boolean = false) : void
      {
         var _loc3_:Wander = null;
         if(param2)
         {
            owner.root.layers[3].remove(param1);
            param1.position.move(gateCoord.x,gateCoord.y,0);
         }
         if("Wander" in param1.componentManager)
         {
            param1.componentManager.remove(param1.componentManager["Wander"]);
         }
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.componentManager.add(param1.bounds = new CompositeChildRenderBounds());
         param1.componentManager.add(new UnitOffsetProjection((param1.componentManager["BaseProjection"] as BaseProjection).sortPoint,(owner as Building).data.buildingTypeDIO.baseSize,compositeView));
         compositeView.addChild(param1);
         param1.composite = ownerGS;
         owner.addChild(param1);
         param1.init();
         if(womRoot.userInfo.gameMode == GameModeType.ATTACK && param1.data.isBeast)
         {
            _loc3_ = new SynchronizedWander(edgeSpace,gardenSpace,buildingSpace,ownerGS);
         }
         else
         {
            _loc3_ = new Wander(edgeSpace,gardenSpace,buildingSpace,ownerGS);
         }
         param1.componentManager.add(_loc3_);
         _loc3_.knockKnock = param2;
         _loc3_.init();
         units.push(param1);
         ownerGS.bounds.update();
         param1.position.refreshPosition();
      }
      
      public function removeUnit(param1:Unit) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.composite = null;
         var _loc2_:Point = gateCoord;
         if((owner as Building).data.buildingInfo.buildingTypeId == 19)
         {
            _loc2_ = new Point(2,2);
         }
         (ownerGS.view as CompositeView).clearChild(param1);
         param1.position.point.x = ownerGS.position.point.x + _loc2_.x;
         param1.position.point.y = ownerGS.position.point.y + _loc2_.y;
         param1.position.refreshPosition();
         param1.componentManager.add(param1.bounds = new ParentRenderBounds());
         param1.componentManager.add(new IsoUnitProjection((param1.componentManager["BaseProjection"] as BaseProjection).sortPoint));
         if("Wander" in param1.componentManager)
         {
            param1.componentManager.remove(param1.componentManager["Wander"]);
         }
         param1.data.calculateStats();
         owner.root.addChild(param1);
         param1.bounds.init();
         param1.init();
         units.splice(units.indexOf(param1),1);
         owner.root.layers[3].add(param1);
      }
      
      private function killUnit(param1:Unit) : void
      {
         if(param1.parent)
         {
            param1.parent.removeChild(param1);
         }
         param1.data.info.status = UnitStatusType.DEAD;
         removeUnit(param1);
         param1.destroyAll();
      }
      
      public function kickMe(param1:Unit, param2:int) : void
      {
         var building:Building;
         var buildingType:int;
         var x:int;
         var y:int;
         var unit:Unit = param1;
         var buildingInstanceId:int = param2;
         removeUnit(unit);
         building = womRoot.buildings[buildingInstanceId];
         buildingType = building.data.buildingInfo.buildingTypeId;
         x = building.position.point.x;
         y = building.position.point.y;
         if(buildingType == 27)
         {
            x += building.data.buildingTypeDIO.baseSize / 2;
            unit.movement.moveToPoint(new Point3(x,y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.arrivedToExecution(param1,building,womRoot);
            });
            delete womRoot.units[unit.data.info.instanceId];
         }
         else if(buildingType == 37)
         {
            x += 6;
            y += building.data.buildingTypeDIO.baseSize;
            unit.movement.moveToPoint(new Point3(x,y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.moveWatchPostFromWalk(param1.movement,building,x,y,param1,womRoot);
            });
         }
         else if(buildingType == 29)
         {
            x += building.data.buildingTypeDIO.gateCoord.x;
            y += building.data.buildingTypeDIO.gateCoord.y;
            unit.movement.moveToPoint(new Point3(x,y,0));
            if(unit.isBeast)
            {
               unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
               {
                  Units.cagedBeastArrived(womRoot);
               });
            }
            else
            {
               unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
               {
                  Units.arrivedToBeast(param1,building,womRoot);
               });
               delete womRoot.units[unit.data.info.instanceId];
            }
         }
         else if(buildingType == 30)
         {
            x += 10;
            y += 15;
            unit.movement.moveToPoint(new Point3(x,y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               Units.arrivedToBeastKeeper(param1,womRoot);
            });
         }
         else if(buildingType == 42 || buildingType == 10)
         {
            x += 6;
            y += building.data.buildingTypeDIO.baseSize - 1;
            unit.movement.moveToPoint(new Point3(x,y,0));
            unit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               unit.parent.removeChild(unit);
               womRoot.layers[3].remove(unit);
            });
         }
      }
      
      public function killAllUnits() : void
      {
         var _loc1_:Unit = null;
         var _loc3_:Point3 = null;
         var _loc2_:Particle3DAnimationManager = womRoot.particle3DAnimationManager;
         while(units.length > 0)
         {
            _loc1_ = units[0];
            _loc3_ = new Point3();
            _loc3_.x = ownerGS.position.projected.x + _loc1_.position.projected.x + _loc1_.bounds.width / 2;
            _loc3_.y = ownerGS.position.projected.y + _loc1_.position.projected.y + _loc1_.bounds.height / 2;
            _loc2_.spillBlood(_loc3_);
            killUnit(_loc1_);
         }
      }
      
      public function pruneUnitsForBattle() : void
      {
         var _loc1_:Unit = null;
         while(units.length > 5)
         {
            _loc1_ = units[int(Math.random() * units.length)];
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            removeUnit(_loc1_);
            _loc1_.destroyAll();
         }
      }
   }
}

