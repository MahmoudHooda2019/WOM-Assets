package wom.model.component.behavior.catapult
{
   import flash.geom.Matrix;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   
   public class DeployCircleGlow extends Behavior
   {
      
      public static const TYPE_ID:String = "DeployCircleGlow";
      
      private var _type:int;
      
      private var ownerSprite:GameSprite;
      
      private var radius:int;
      
      private var rotation:Number = 0;
      
      private var lift:Number = 30;
      
      private var targetY:Number;
      
      private var rotationMatrix:Matrix = new Matrix();
      
      private var sync:FpsSync;
      
      private var scaleX:Number;
      
      private var scaleY:Number;
      
      private var offsetX:Number;
      
      private var offsetY:Number;
      
      public function DeployCircleGlow(param1:Number, param2:Number, param3:int)
      {
         super();
         _type = param3;
         this.radius = param1;
         priority = 0;
         this.targetY = param2 - lift;
      }
      
      override public function get typeId() : String
      {
         return "DeployCircleGlow";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         ownerSprite = owner as GameSprite;
         scaleX = radius / 360;
         scaleY = radius / 720;
         offsetX = (radius - 360) / 2;
         offsetY = (radius - 720) / 4;
         update();
      }
      
      override public function update() : void
      {
         rotation -= 0.0125 * sync.precise;
         lift -= 1;
         if(lift <= 0)
         {
            if(lift > -60)
            {
               return;
            }
            lift = 30;
         }
         rotationMatrix.identity();
         rotationMatrix.rotate(rotation);
         rotationMatrix.scale(scaleX,scaleY);
         rotationMatrix.translate(offsetX,offsetY);
         ownerSprite.view.applyMatrix(rotationMatrix);
         ownerSprite.position.projected.y = targetY + lift;
         var _loc1_:GameSprite = ownerSprite;
         _loc1_.validator.add(_loc1_);
         undefined;
         ownerSprite.view.alphaFilter(lift / 30);
      }
   }
}

