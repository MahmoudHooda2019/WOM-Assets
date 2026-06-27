package wom.model.component.behavior
{
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.dto.Point3;
   
   public class BounceEffect extends Behavior
   {
      
      public static const TYPE_ID:String = "BounceEffect";
      
      private var ownerSprite:GameSprite;
      
      private var wait:Number;
      
      private var projectedPosition:Point3;
      
      private var initialY:Number;
      
      private var targetY:Number;
      
      private var factor:Number = 0;
      
      private var sync:FpsSync;
      
      public function BounceEffect()
      {
         super();
      }
      
      override public function get typeId() : String
      {
         return "BounceEffect";
      }
      
      override public function init() : void
      {
         ownerSprite = owner as GameSprite;
         projectedPosition = ownerSprite.position.projected;
         initialY = ownerSprite.position.projected.y;
         targetY = initialY + 15;
         sync = owner.root.sync;
         super.init();
      }
      
      override public function update() : void
      {
         wait -= sync.precise;
         if(wait > 0)
         {
            return;
         }
         wait = 3;
         projectedPosition.y += factor;
         factor += 0.5;
         if(projectedPosition.y >= targetY)
         {
            factor = -factor + 0.5;
         }
         var _loc1_:GameSprite = ownerSprite;
         _loc1_.validator.add(_loc1_);
         undefined;
      }
   }
}

