package peak.cuckoo.game.behavior
{
   import flash.utils.getTimer;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.Root;
   
   public class FpsSync extends Behavior
   {
      
      public static const TYPE_ID:String = "FPSSync";
      
      public static var frameNum:int = 0;
      
      protected var factor:Number;
      
      public var fps:int;
      
      public var precise:Number;
      
      public var elapsed:Number;
      
      public var elapsedDiscrete:int;
      
      public var over:Number;
      
      public var deltaTime:int;
      
      private var last:int = 0;
      
      private var root:Root;
      
      public var lastRealTime:int;
      
      public var currentGameTime:int = 0;
      
      public function FpsSync(param1:int, param2:Root)
      {
         super();
         this.root = param2;
         this.fps = param1;
         factor = param1 / 1000;
         over = 0;
      }
      
      override public function get typeId() : String
      {
         return "FPSSync";
      }
      
      override public function init() : void
      {
      }
      
      override public function update() : void
      {
         var _loc1_:int = getTimer();
         deltaTime = _loc1_ - lastRealTime;
         currentGameTime += deltaTime * root.timeFactor;
         precise = elapsed = last == 0 ? 0 : (currentGameTime - last) * factor;
         elapsed += over;
         elapsedDiscrete = elapsed;
         over = elapsed - elapsedDiscrete;
         lastRealTime = _loc1_;
         last = currentGameTime;
         frameNum = frameNum + 1;
      }
      
      public function reset() : void
      {
         frameNum = 0;
         over = 0;
      }
   }
}

