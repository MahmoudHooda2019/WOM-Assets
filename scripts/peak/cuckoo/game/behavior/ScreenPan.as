package peak.cuckoo.game.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Viewport;
   import peak.signal.Signal0;
   
   public class ScreenPan extends Behavior
   {
      
      public static const TYPE_ID:String = "ScreenPan";
      
      private var viewport:Viewport;
      
      private var totalDuration:Number = 0;
      
      private var userInteract:BaseInteract;
      
      public var panningFinished:Signal0;
      
      private var sync:FpsSync;
      
      private var initialVelocityX:Number;
      
      private var initialVelocityY:Number;
      
      public function ScreenPan()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "ScreenPan";
      }
      
      override public function init() : void
      {
         super.init();
         totalDuration = 0;
         viewport = owner.root.viewport;
         panningFinished = new Signal0();
         userInteract = owner.root.userInteract;
         sync = owner.root.sync;
         startEnabled = false;
      }
      
      override public function update() : void
      {
         var _loc2_:Number = sync.precise / 60;
         totalDuration += _loc2_;
         var _loc1_:Number = initialVelocityX * Math.pow(2,-10 * totalDuration);
         var _loc3_:Number = initialVelocityY * Math.pow(2,-10 * totalDuration);
         if(_loc1_ <= 1 && _loc1_ >= -1 && _loc3_ <= 1 && _loc3_ >= -1)
         {
            disable();
         }
         viewport.moveTo(viewport.rect.x + _loc1_ * _loc2_,viewport.rect.y + _loc3_ * _loc2_);
      }
      
      override public function disable() : void
      {
         super.disable();
         totalDuration = 0;
         panningFinished.dispatch();
      }
      
      public function reset() : void
      {
         panningFinished.removeAll();
         disable();
      }
      
      public function addPanCommand(param1:Number, param2:Number) : void
      {
         initialVelocityX = -param1 / owner.root.scale;
         initialVelocityY = param2 / owner.root.scale;
         totalDuration = 0;
         enable();
      }
   }
}

