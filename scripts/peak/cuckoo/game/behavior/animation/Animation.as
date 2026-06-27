package peak.cuckoo.game.behavior.animation
{
   import flash.display.BitmapData;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.FpsSync;
   
   public class Animation extends Behavior
   {
      
      public static const TYPE_ID:String = "Animation";
      
      protected var sync:FpsSync;
      
      protected var view:AnimationAssetView;
      
      public var fpsChangeRate:int;
      
      public var frameWidth:int;
      
      public var frameHeight:int;
      
      public var frameTotal:int;
      
      public var frameNum:int;
      
      protected var frameCounter:Number = 0;
      
      public var prepared:Boolean = false;
      
      public var requested:Boolean = true;
      
      public var ownerSprite:GameSprite;
      
      public function Animation()
      {
         super();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "Animation";
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
         sync = owner.root.sync;
         ownerSprite = owner as GameSprite;
      }
      
      public function prepareFrames(param1:BitmapData, param2:AnimationAssetView) : void
      {
      }
      
      override public function update() : void
      {
      }
      
      public function startAnimation() : void
      {
         enable();
      }
      
      public function stopAnimation() : void
      {
         disable();
      }
      
      public function selectEnableDisableBitmap(param1:Boolean) : void
      {
      }
   }
}

