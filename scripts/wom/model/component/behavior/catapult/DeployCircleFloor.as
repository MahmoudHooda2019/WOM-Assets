package wom.model.component.behavior.catapult
{
   import flash.geom.Matrix;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.behavior.FpsSync;
   
   public class DeployCircleFloor extends Behavior
   {
      
      public static const TYPE_ID:String = "DeployCircleFloor";
      
      private var ownerSprite:GameSprite;
      
      private var radius:int;
      
      private var rotation:Number = 0;
      
      private var filter:uint;
      
      private var rotationMatrix:Matrix = new Matrix();
      
      private var sync:FpsSync;
      
      private var scaleX:Number;
      
      private var scaleY:Number;
      
      private var offsetX:Number;
      
      private var offsetY:Number;
      
      private var _type:int;
      
      public function DeployCircleFloor(param1:Number, param2:int)
      {
         super();
         this.radius = param1;
         priority = 0;
         _type = param2;
      }
      
      override public function get typeId() : String
      {
         return "DeployCircleFloor";
      }
      
      override public function init() : void
      {
         super.init();
         sync = owner.root.sync;
         ownerSprite = owner as GameSprite;
         switch(_type - 1)
         {
            case 0:
               filter = 7687680;
               break;
            case 1:
               filter = 7896191;
               break;
            case 2:
               filter = 1744624;
               break;
            case 3:
               filter = 10118108;
               break;
            case 4:
               filter = 8316141;
               break;
            case 5:
               filter = 9299968;
               break;
            default:
               return;
         }
         scaleX = radius / 360;
         scaleY = radius / 720;
         offsetX = (radius - 360) / 2;
         offsetY = (radius - 720) / 4;
         ownerSprite.view.colorFilter(filter);
         update();
      }
      
      override public function update() : void
      {
         rotation -= 0.0125 * sync.precise;
         rotationMatrix.identity();
         rotationMatrix.rotate(rotation);
         rotationMatrix.scale(scaleX,scaleY);
         rotationMatrix.translate(offsetX,offsetY);
         ownerSprite.view.applyMatrix(rotationMatrix);
      }
   }
}

