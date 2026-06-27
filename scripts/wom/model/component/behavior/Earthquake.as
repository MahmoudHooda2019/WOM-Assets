package wom.model.component.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.attribute.Viewport;
   
   public class Earthquake extends Behavior
   {
      
      public static const TYPE_ID:String = "Earthquake";
      
      private var viewport:Viewport;
      
      private var x:Number;
      
      private var y:Number;
      
      public function Earthquake()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "Earthquake";
      }
      
      override public function init() : void
      {
         super.init();
         viewport = owner.root.viewport;
         startEnabled = false;
      }
      
      override public function update() : void
      {
         var _loc1_:Number = 4 * Math.random() - 2;
         var _loc2_:Number = 2 * Math.random() - 1;
         viewport.moveTo(x + _loc1_,y + _loc2_);
      }
      
      public function startEarthquake() : void
      {
         x = viewport.rect.x;
         y = viewport.rect.y;
         enable();
      }
      
      public function endEarthquake() : void
      {
         disable();
      }
      
      public function onMouseMove() : void
      {
         x = viewport.rect.x;
         y = viewport.rect.y;
      }
      
      override protected function start() : void
      {
         super.start();
         owner.root.userInteract.moveDrag.addFunction(onMouseMove);
      }
      
      override protected function stop() : void
      {
         owner.root.userInteract.moveDrag.removeFunction(onMouseMove);
         super.stop();
      }
   }
}

