package wom.model.component.attribute.data
{
   import peak.cuckoo.core.Attribute;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.animation.StateDirectionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import wom.controller.event.WorkerUpdateEvent;
   import wom.model.component.WomGameRoot;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.entity.gamesprite.Worker;
   
   public class WorkerStatus extends Attribute
   {
      
      public static const TYPE_ID:String = "WorkerStatus";
      
      public var targetBuilding:GameSprite;
      
      private var _busy:Boolean;
      
      public var attendingX:Number = 2147483647;
      
      public var attendingY:Number = 2147483647;
      
      private var ownerUnit:Unit;
      
      public function WorkerStatus(param1:Boolean)
      {
         super();
         this._busy = param1;
      }
      
      override public function get typeId() : String
      {
         return "WorkerStatus";
      }
      
      override public function init() : void
      {
         super.init();
         ownerUnit = owner as Unit;
      }
      
      public function walkAndWork(param1:int, param2:int, param3:int) : void
      {
         var px:int = param1;
         var py:int = param2;
         var baseSize:int = param3;
         var ptarget:Point3 = new Point3(px + baseSize / 2,py + baseSize / 2);
         ownerUnit.movement.moveToSquare(px,py,baseSize,ptarget);
         ownerUnit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
         {
            ownerUnit.animation.state = 2;
            ownerUnit.movement.faceTo(ptarget);
         });
      }
      
      public function arrivedBuildingForWork(param1:Point3) : void
      {
         ownerUnit.animation.state = 2;
         ownerUnit.movement.faceTo(param1);
      }
      
      public function arrivedBuildingForStop(param1:StateDirectionAnimation) : void
      {
         param1.state = 0;
         param1.direction = 1;
      }
      
      public function attendingCoordinates(param1:int, param2:int) : void
      {
         attendingX = param1;
         attendingY = param2;
      }
      
      public function stopWorking() : void
      {
         var anim:StateDirectionAnimation;
         attendingX = 2147483647;
         attendingY = 2147483647;
         if(ownerUnit.animation.state != 2)
         {
            anim = ownerUnit.animation;
            ownerUnit.movement.movementFinished.addFunctionOnce(function(param1:Unit):void
            {
               anim.state = 0;
               anim.direction = 1;
            });
         }
         else
         {
            ownerUnit.animation.state = 0;
            ownerUnit.animation.direction = 1;
         }
         busy = false;
      }
      
      public function get busy() : Boolean
      {
         return _busy;
      }
      
      public function set busy(param1:Boolean) : void
      {
         _busy = param1;
         (owner.root as WomGameRoot).eventDispatcher.dispatchEvent(new WorkerUpdateEvent("updateCount"));
         (owner as Worker).lastWorkerSpeechTimer = 0;
      }
   }
}

