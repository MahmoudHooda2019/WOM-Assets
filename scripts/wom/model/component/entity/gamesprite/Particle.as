package wom.model.component.entity.gamesprite
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import peak.signal.Signal0;
   import wom.model.component.attribute.ProjectedPosition;
   
   public class Particle extends GameSprite
   {
      
      public var startPoint:Point;
      
      public var targetPoint:Point;
      
      public var targetOffset:Point;
      
      public var hit:Signal0;
      
      public var velocityPerFrame:Number;
      
      public var guided:Boolean;
      
      public var lastPoint:Boolean = false;
      
      public var dx:Number;
      
      public var dy:Number;
      
      public var differenceCalculated:Boolean;
      
      public var testAngle:Number = 0;
      
      public function Particle(param1:Point, param2:Point, param3:Point, param4:Number, param5:String, param6:Boolean, param7:Boolean)
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc11_:Number = NaN;
         super();
         this.startPoint = param1;
         this.targetPoint = param2;
         this.targetOffset = param3;
         this.velocityPerFrame = param4;
         this.guided = param7;
         this.differenceCalculated = false;
         componentManager.add(position = new ProjectedPosition());
         position.projected = new Point3(param1.x,param1.y,0);
         if(!param5)
         {
            param5 = "GatlingDart";
         }
         if(param6)
         {
            _loc9_ = param2.x + param3.x - param1.x;
            _loc10_ = param1.y - (param2.y + param3.y);
            _loc8_ = _loc9_ == 0 ? 0 : _loc9_ / Math.abs(_loc9_);
            _loc11_ = _loc10_ == 0 ? 0 : -_loc10_ / Math.abs(_loc10_);
            testAngle = Math.atan(_loc10_ / _loc9_) * -1;
            if(_loc8_ == -1)
            {
               testAngle += 3.141592653589793;
            }
            else if(_loc11_ == 1)
            {
               testAngle += 2 * 3.141592653589793;
            }
            componentManager.add(view = new AssetView(4,param5,true));
         }
         else
         {
            componentManager.add(view = new AssetView(4,param5));
         }
         hit = new Signal0();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}

