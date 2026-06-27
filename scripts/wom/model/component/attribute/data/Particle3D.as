package wom.model.component.attribute.data
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   
   public class Particle3D
   {
      
      public static const STATE1:int = 0;
      
      public static const STATE2:int = 1;
      
      public static const STATE3:int = 2;
      
      public var particleSprite:GameSprite;
      
      public var assetName:String;
      
      public var dx:Number;
      
      public var dy:Number;
      
      public var dz:Number;
      
      public var actualPoint:Point3;
      
      public var followPoint:Point;
      
      public var totalTime:Number;
      
      public var stateTime:Number;
      
      public var state:int;
      
      public var state1Duration:int;
      
      public var state2Duration:int;
      
      public var state3Duration:int;
      
      public var rotMul:int;
      
      public var stainScale:Number = 0.3;
      
      public var type:int;
      
      public var bitmapDataCache:Vector.<BitmapData>;
      
      public function Particle3D(param1:GameSprite, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:int = 0)
      {
         super();
         state = 0;
         this.particleSprite = param1;
         this.actualPoint = new Point3(param1.position.projected.x,param1.position.projected.y,param1.position.projected.z);
         this.dx = param2;
         this.dy = param3;
         this.dz = param4;
         stateTime = 0;
         totalTime = 0;
         this.type = param5;
         bitmapDataCache = new Vector.<BitmapData>();
      }
   }
}

