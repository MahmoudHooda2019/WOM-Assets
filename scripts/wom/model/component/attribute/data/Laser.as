package wom.model.component.attribute.data
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeChildRenderBounds;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.sort.ZSort;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.signal.Signal0;
   import wom.model.component.attribute.ProjectedPosition;
   import wom.model.component.attribute.projection.HeightRevertedBuildingPartProjectionDeprecated;
   import wom.model.component.behavior.LineAnimationManager;
   import wom.model.component.entity.gamesprite.Building;
   
   public class Laser
   {
      
      public static const GLOW_INCREASE:int = 0;
      
      public static const GLOW_TOP:int = 1;
      
      public static const GLOW_DECREASE:int = 2;
      
      public static const END:int = 3;
      
      public var lineStrips:Vector.<Particle3D>;
      
      public var manager:LineAnimationManager;
      
      public var projectedStart:Point;
      
      public var newStripProjectedPosition:Point3;
      
      public var currentEnd:Point;
      
      public var xDir:Number;
      
      public var yDir:Number;
      
      public var nox:Number;
      
      public var noy:Number;
      
      public var oox:Number;
      
      public var ooy:Number;
      
      public var lineLength:Number = 2000;
      
      public var stripLength:Number;
      
      public var stripTickness:Number;
      
      public var time:int = 0;
      
      public var wait:int = 0;
      
      public var updatesPerLineStrip:int = 1;
      
      public var currentLength:int = 0;
      
      public const CACHE_COUNT:int = 10;
      
      public var state1EndTime:int = 25;
      
      public var state2EndTime:int = 50;
      
      public var state3EndTime:int = 75;
      
      public var hit:Signal0;
      
      public var shrink:Signal0;
      
      internal var duration1:Number;
      
      internal var duration2:Number;
      
      internal var duration3:Number;
      
      public var testAngle:Number;
      
      private var ownerBuilding:Building;
      
      private var startLine:Boolean;
      
      private var transformation:Matrix = new Matrix();
      
      private var reference:StarlingAtlasReference;
      
      public function Laser(param1:Building, param2:LineAnimationManager, param3:Point, param4:Point)
      {
         super();
         this.ownerBuilding = param1;
         startLine = true;
         hit = new Signal0();
         shrink = new Signal0();
         duration1 = state1EndTime / 10;
         duration2 = (state2EndTime - state1EndTime) / 10;
         duration3 = (state3EndTime - state2EndTime) / 10;
         reference = param1.root.atlasManager.getAtlasReference("LightRay");
         stripLength = reference.width;
         stripTickness = reference.height;
         lineStrips = new Vector.<Particle3D>();
         this.manager = param2;
         this.projectedStart = param3;
         this.currentEnd = param3;
         var _loc7_:Number = reference.width - 1;
         var _loc5_:Number = param4.x - param3.x;
         var _loc6_:Number = param3.y - param4.y;
         xDir = _loc5_ == 0 ? 0 : _loc5_ / Math.abs(_loc5_);
         yDir = _loc6_ == 0 ? 0 : -_loc6_ / Math.abs(_loc6_);
         testAngle = Math.atan(_loc6_ / _loc5_);
         if(xDir == -1)
         {
            testAngle += 3.141592653589793;
         }
         else if(yDir == 1)
         {
            testAngle += 2 * 3.141592653589793;
         }
         oox = _loc7_ * Math.cos(testAngle);
         ooy = -_loc7_ * Math.sin(testAngle);
         nox = oox < 0 ? oox : 0;
         noy = ooy < 0 ? ooy : 0;
         transformation.translate(reference.width / 2,0);
         transformation.rotate(-testAngle);
         transformation.translate(-reference.width / 2,0);
         transformation.translate(-nox + stripTickness,-noy + stripTickness);
         newStripProjectedPosition = calculateNewStripPosition(currentEnd);
      }
      
      public function calculateNewStripPosition(param1:Point) : Point3
      {
         return new Point3(param1.x + nox - stripTickness,param1.y + noy - stripTickness);
      }
      
      public function calculateNewEnd(param1:Point) : Point
      {
         return new Point(param1.x + oox,param1.y + ooy);
      }
      
      public function addNewLineStrip() : void
      {
         var _loc4_:Particle3D = null;
         var _loc1_:Position = null;
         var _loc5_:Number = NaN;
         var _loc6_:CompositeView = null;
         var _loc3_:ProjectedPosition = null;
         var _loc2_:GameSprite = new GameSprite();
         if(startLine)
         {
            _loc1_ = new Position(new Point3());
            _loc2_.componentManager.add(_loc2_.position = _loc1_);
            _loc2_.componentManager.add(_loc2_.view = new AssetView(4,"LightRay",true));
            _loc2_.componentManager.add(_loc2_.bounds = new CompositeChildRenderBounds());
            _loc2_.componentManager.add(new HeightRevertedBuildingPartProjectionDeprecated());
            _loc2_.composite = ownerBuilding;
            ownerBuilding.addChild(_loc2_);
            _loc2_.init();
            _loc1_.refreshPosition();
            _loc1_.projected.x = newStripProjectedPosition.x - ownerBuilding.position.projected.x;
            _loc1_.projected.y = newStripProjectedPosition.y - ownerBuilding.position.projected.y;
            _loc5_ = testAngle / 3.14 * 180;
            if(_loc5_ < 180 && _loc5_ > 0)
            {
               _loc1_.projected.z = -2;
            }
            else
            {
               _loc1_.projected.z = 990;
            }
            _loc6_ = ownerBuilding.view as CompositeView;
            _loc6_.addChild(_loc2_);
            _loc6_.children.sort(ZSort.compareZ);
            ownerBuilding.root.validator.add(_loc2_);
            _loc4_ = new Particle3D(_loc2_);
            lineStrips.push(_loc4_);
            currentEnd = calculateNewEnd(currentEnd);
            newStripProjectedPosition = calculateNewStripPosition(currentEnd);
            currentLength += stripLength;
            startLine = false;
            _loc2_.view.applyMatrix(transformation);
         }
         else
         {
            _loc3_ = new ProjectedPosition();
            _loc3_.projected = newStripProjectedPosition;
            _loc2_.componentManager.add(_loc2_.position = _loc3_);
            _loc2_.componentManager.add(_loc2_.view = new AssetView(4,"LightRay",true));
            manager.owner.addChild(_loc2_);
            manager.owner.root.layers[4].add(_loc2_);
            _loc2_.init();
            _loc4_ = new Particle3D(_loc2_);
            lineStrips.push(_loc4_);
            currentEnd = calculateNewEnd(currentEnd);
            newStripProjectedPosition = calculateNewStripPosition(currentEnd);
            currentLength += stripLength;
            _loc2_.view.applyMatrix(transformation);
         }
      }
      
      public function update() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         wait = wait - 1;
         var _loc2_:int = 0;
         if(wait <= 0)
         {
            if(currentLength < lineLength)
            {
               addNewLineStrip();
            }
            wait = updatesPerLineStrip;
         }
         if(time < state1EndTime)
         {
            _loc3_ = 0;
            while(_loc3_ < lineStrips.length)
            {
               _loc1_ = time / duration1;
               lineStrips[_loc3_].particleSprite.view.alphaFilter((_loc1_ + 1) / 10);
               _loc3_++;
            }
         }
         else if(time < state2EndTime)
         {
            if(_loc2_ != 1)
            {
               _loc2_ = 1;
               hit.dispatch();
            }
         }
         else
         {
            if(time >= state3EndTime)
            {
               return 3;
            }
            _loc3_ = 0;
            while(_loc3_ < lineStrips.length)
            {
               _loc1_ = 9 - (time - state2EndTime) / duration3;
               lineStrips[_loc3_].particleSprite.view.alphaFilter((_loc1_ + 1) / 10);
               _loc3_++;
            }
            if(_loc2_ != 2)
            {
               shrink.dispatch();
            }
            _loc2_ = 2;
         }
         time = time + 1;
         return _loc2_;
      }
   }
}

