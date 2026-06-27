package wom.model.component.behavior.unit
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.behavior.building.CombineBuildingChildManager;
   import wom.model.component.behavior.movement.Movement;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class Wander extends Behavior
   {
      
      public static const TYPE_ID:String = "Wander";
      
      public var knockKnock:Boolean;
      
      protected var emptyEdgeScale:int;
      
      protected var areaScale:int;
      
      protected var buildingScale:int;
      
      public var wait:int;
      
      protected var movement:Movement;
      
      protected var animation:StateDirectionAnimation;
      
      protected var wander:Wander;
      
      protected var position:Position;
      
      public var keepingBuilding:GameSprite;
      
      protected var check:Boolean;
      
      protected var notAttack:Boolean;
      
      protected var isBeast:Boolean = false;
      
      protected var rangeSquare:int = 0;
      
      public function Wander(param1:int, param2:int, param3:int, param4:GameSprite)
      {
         super();
         this.emptyEdgeScale = param1;
         this.areaScale = param2;
         this.buildingScale = param3;
         this.keepingBuilding = param4;
      }
      
      override public function get typeId() : String
      {
         return "Wander";
      }
      
      override public function init() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         super.init();
         movement = (owner as Unit).movement;
         animation = (owner as Unit).animation;
         wander = owner.componentManager["Wander"] as Wander;
         position = (owner as GameSprite).position;
         isBeast = (owner as Unit).data.isBeast;
         if(isBeast)
         {
            rangeSquare = (owner as Unit).data.levelIndex * (owner as Unit).data.levelIndex;
         }
         if(!knockKnock)
         {
            _loc1_ = Math.random() * areaScale;
            _loc2_ = Math.random() * areaScale;
            if(isBeast)
            {
               _loc1_ = 14;
               _loc2_ = 14;
            }
            else
            {
               if(_loc1_ < buildingScale && _loc2_ < buildingScale)
               {
                  _loc1_ += buildingScale;
                  _loc2_ += buildingScale;
               }
               _loc1_ += emptyEdgeScale;
               _loc2_ += emptyEdgeScale;
            }
            position.move(_loc1_,_loc2_,0);
         }
         notAttack = (owner as Unit).data.info.typeId == 14;
         movement.clearWaypoint();
         addRandomWaypoint();
         startEnabled = false;
         (owner as Unit).data.calculateStats();
      }
      
      override public function update() : void
      {
         wait = wait - 1;
         if(wait <= 0)
         {
            this.disable();
            animation.state = 0;
            addRandomBehaviour();
         }
         if(wait % 50 == 0)
         {
            animation.direction = Math.random() * 8;
         }
      }
      
      protected function addRandomWaypoint() : void
      {
         var _loc1_:Number = Math.random() * areaScale;
         var _loc3_:Number = Math.random() * areaScale;
         if(_loc1_ < buildingScale && _loc3_ < buildingScale)
         {
            _loc1_ += buildingScale;
            _loc3_ += buildingScale;
         }
         _loc1_ += emptyEdgeScale;
         _loc3_ += emptyEdgeScale;
         var _loc2_:Point3 = new Point3(_loc1_,_loc3_,0);
         movement.addWaypoint(_loc2_);
         if(isBeast)
         {
            movement.generalTarget = _loc2_;
            movement.rangeSquare = rangeSquare;
         }
         movement.movementFinished.addFunctionOnce(addRandomBehaviour);
      }
      
      protected function addRandomBehaviour(param1:Unit = null) : void
      {
         check = false;
         if(position.point.x > emptyEdgeScale + areaScale)
         {
            position.point.x = emptyEdgeScale + areaScale;
            check = true;
         }
         if(position.point.y > emptyEdgeScale + areaScale)
         {
            position.point.y = emptyEdgeScale + areaScale;
            check = true;
         }
         if(check)
         {
            position.refreshPosition();
         }
         var _loc2_:Number = Math.random() * 4;
         if(_loc2_ > 3)
         {
            wander.enable();
            wander.wait = Math.random() * 300;
            animation.state = 0;
            animation.direction = Math.random() * 8;
         }
         else if(_loc2_ > 2)
         {
            wander.enable();
            wander.wait = Math.random() * 600;
            animation.state = notAttack ? 0 : 2;
         }
         else
         {
            addRandomWaypoint();
         }
      }
      
      public function byeBye(param1:CombineBuildingChildManager, param2:int) : void
      {
         var ownerUnit:Unit;
         var cbcm:CombineBuildingChildManager = param1;
         var buildingInstanceId:int = param2;
         this.disable();
         movement.clearWaypoint();
         movement.addWaypoint(new Point3(cbcm.gateCoord.x,cbcm.gateCoord.y));
         if(owner is Unit)
         {
            ownerUnit = owner as Unit;
            ownerUnit.aboutToBeKicked = true;
            movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               cbcm.kickMe(ownerUnit,buildingInstanceId);
            });
         }
      }
      
      override protected function stop() : void
      {
         movement.clearWaypoint();
         super.stop();
      }
   }
}

