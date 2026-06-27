package wom.model.component.behavior.movement
{
   import flash.media.Sound;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.BaseProjection;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.Signal1;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.UnitData;
   import wom.model.component.behavior.unit.SynchronizedWander;
   import wom.model.component.entity.gamesprite.Unit;
   
   public class Movement extends Behavior
   {
      
      public static const barrier1:Number = -5;
      
      public static const barrier2:Number = -0.2;
      
      public static const barrier3:Number = 0.6666666666666666;
      
      public static const barrier4:Number = 1.5;
      
      public static const TYPE_ID:String = "UnitMovement";
      
      public var movementFinished:Signal1;
      
      protected var sync:FpsSync;
      
      public var _waypoints:Vector.<Point3>;
      
      public var ranged:int;
      
      public var rangeSquare:Number = 0;
      
      public var generalTarget:Point3;
      
      public var speedFactor:Number = 1;
      
      protected var setDirection:Boolean;
      
      public var unitData:UnitData;
      
      protected var ownerPosition:Position;
      
      protected var ownerAnimation:StateDirectionAnimation;
      
      protected var rootProjection:BaseProjection;
      
      protected var sfx:SfxManager;
      
      protected var sound:Sound;
      
      protected var sounds:Vector.<Sound> = new Vector.<Sound>();
      
      protected var soundVariarity:int;
      
      protected var ownerUnit:Unit;
      
      protected var womRoot:WomGameRoot;
      
      protected var hasRandomWander:Boolean;
      
      public function Movement()
      {
         super();
         _waypoints = new Vector.<Point3>();
         movementFinished = new Signal1();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "UnitMovement";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         womRoot = owner.root as WomGameRoot;
         sfx = womRoot.sfxManager;
         ownerUnit = owner as Unit;
         unitData = ownerUnit.data;
         ownerPosition = owner.componentManager["Position"] as Position;
         ownerAnimation = owner.componentManager["Animation"] as StateDirectionAnimation;
         rootProjection = owner.root.componentManager["BaseProjection"] as BaseProjection;
         sounds = sfx.getMoveSound(unitData);
         soundVariarity = sounds.length;
         sound = sounds[0];
         startEnabled = false;
      }
      
      public function addWaypoint(param1:Point3) : void
      {
         _waypoints.push(param1);
         this.enable();
      }
      
      public function set waypoints(param1:Vector.<Point3>) : void
      {
         setDirection = true;
         if(!param1)
         {
            param1 = new Vector.<Point3>();
         }
         _waypoints = param1;
         if(_waypoints.length > 0)
         {
            enable();
         }
         if(soundVariarity > 1)
         {
            sound = sounds[Math.random() * soundVariarity >> 0];
         }
         sfx.unitMove(sound,ownerUnit);
      }
      
      public function clearWaypoint(param1:Boolean = false) : void
      {
         rangeSquare = 0;
         _waypoints.length = 0;
         movementFinished.removeAll();
         setDirection = true;
         this.disable();
      }
      
      override public function update() : void
      {
         disable();
      }
      
      public function turn(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = param2 / param1;
         if(param1 > 0)
         {
            if(_loc3_ < -5)
            {
               ownerAnimation.direction = 6;
            }
            else if(_loc3_ < -0.2)
            {
               ownerAnimation.direction = 7;
            }
            else if(_loc3_ < 0.6666666666666666)
            {
               ownerAnimation.direction = 0;
            }
            else if(_loc3_ < 1.5)
            {
               ownerAnimation.direction = 1;
            }
            else
            {
               ownerAnimation.direction = 2;
            }
         }
         else if(param1 < 0)
         {
            if(_loc3_ < -5)
            {
               ownerAnimation.direction = 2;
            }
            else if(_loc3_ < -0.2)
            {
               ownerAnimation.direction = 3;
            }
            else if(_loc3_ < 0.6666666666666666)
            {
               ownerAnimation.direction = 4;
            }
            else if(_loc3_ < 1.5)
            {
               ownerAnimation.direction = 5;
            }
            else
            {
               ownerAnimation.direction = 6;
            }
         }
         else if(_loc3_ == -Infinity)
         {
            ownerAnimation.direction = 6;
         }
         else
         {
            ownerAnimation.direction = 2;
         }
      }
      
      public function faceTo(param1:Point3) : void
      {
         turn(param1.x - ownerPosition.point.x,param1.y - ownerPosition.point.y);
      }
      
      public function faceToCoor(param1:Number, param2:Number) : void
      {
         turn(param1 - ownerPosition.point.x,param2 - ownerPosition.point.y);
      }
      
      public function moveToSquare(param1:int, param2:int, param3:int, param4:Point3, param5:int = 0) : void
      {
      }
      
      public function moveToPoint(param1:Point3, param2:int = 0) : void
      {
      }
      
      override public function enable() : void
      {
         super.enable();
      }
      
      override protected function start() : void
      {
         super.start();
         ownerAnimation.state = 1;
         hasRandomWander = ownerUnit.componentManager["Wander"] && !(ownerUnit.componentManager["Wander"] is SynchronizedWander);
      }
      
      override protected function stop() : void
      {
         ownerAnimation.state = 0;
         super.stop();
      }
      
      override public function destroy() : void
      {
         clearWaypoint(true);
         super.destroy();
      }
   }
}

