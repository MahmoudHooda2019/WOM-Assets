package wom.model.component.behavior.unit
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class SynchronizedWander extends Wander
   {
      
      private var root:WomGameRoot;
      
      public function SynchronizedWander(param1:int, param2:int, param3:int, param4:GameSprite)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function init() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         initialized = true;
         root = owner.root as WomGameRoot;
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
            _loc1_ = root.pseudoRandomGenerator.nextDouble() * areaScale;
            _loc2_ = root.pseudoRandomGenerator.nextDouble() * areaScale;
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
            animation.direction = root.pseudoRandomGenerator.nextDouble() * 8;
         }
      }
      
      override protected function addRandomWaypoint() : void
      {
         var _loc1_:Number = root.pseudoRandomGenerator.nextDouble() * areaScale;
         var _loc3_:Number = root.pseudoRandomGenerator.nextDouble() * areaScale;
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
      
      override protected function addRandomBehaviour(param1:Unit = null) : void
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
         var _loc2_:Number = root.pseudoRandomGenerator.nextDouble() * 4;
         if(_loc2_ > 3)
         {
            wander.enable();
            wander.wait = root.pseudoRandomGenerator.nextDouble() * 300;
            animation.state = 0;
            animation.direction = root.pseudoRandomGenerator.nextDouble() * 8;
         }
         else if(_loc2_ > 2)
         {
            wander.enable();
            wander.wait = root.pseudoRandomGenerator.nextDouble() * 600;
            animation.state = notAttack ? 0 : 2;
         }
         else
         {
            addRandomWaypoint();
         }
      }
   }
}

