package wom.model.component.entity.gamesprite
{
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.ProjectedPosition;
   
   public class Drop extends GameSprite
   {
      
      public static const BASE_VELOCITY:Number = 20;
      
      public static const VELOCITY_VARIATION:Number = 5;
      
      public var target:Point3;
      
      public var dx:Number;
      
      public var dy:Number;
      
      public var state:uint;
      
      public var velocity:Number;
      
      public function Drop(param1:WomGameRoot, param2:Point3, param3:Point3, param4:String)
      {
         super();
         this.target = param3;
         componentManager.add(this.position = new ProjectedPosition());
         componentManager.add(view = new AssetView(2,param4,true));
         this.position.projected.x = param2.x;
         this.position.projected.y = param2.y;
         state = 1;
         velocity = 20 + param1.pseudoRandomGenerator.nextDouble() * 5 * 2 - 5;
      }
      
      override public function init() : void
      {
         super.init();
         var _loc3_:Number = target.x - position.projected.x;
         var _loc2_:Number = target.y - position.projected.y;
         var _loc1_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc2_ * _loc2_);
         dx = _loc3_ * velocity / _loc1_;
         dy = _loc2_ * velocity / _loc1_;
      }
   }
}

