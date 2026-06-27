package wom.model.component.behavior
{
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.compositeBased.CompositeRenderBounds;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.behavior.Validator;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.AssetRepository;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.ProjectedPosition;
   import wom.model.component.attribute.data.Particle3D;
   import wom.model.component.attribute.projection.VoidProjection;
   import wom.model.component.attribute.viewManager.FloatingTextViewManager;
   import wom.model.component.structure.FloatingTextStack;
   
   public class Particle3DAnimationManager extends Behavior
   {
      
      public static var gravity:Number = -0.5;
      
      public static const BLOOD:int = 1;
      
      public static const SOIL:int = 2;
      
      public static const FLOATING_TEXT:int = 3;
      
      public static const SWELL:int = 4;
      
      public static const PERSISTENT_SOIL:int = 5;
      
      public static const BLOOD_LIMIT:int = 500;
      
      public static const FLOATING_TEXT_LIMIT:int = 100;
      
      public static const SOIL_LIMIT:int = 500;
      
      public static const SWELL_LIMIT:int = 100;
      
      public static const PERSISTENT_SOIL_LIMIT:int = 100;
      
      public static const TYPE_ID:String = "Particle3DAnimationManager";
      
      public var bloodParticlePool:Vector.<Particle3D>;
      
      public var floatingParticlePool:Vector.<Particle3D>;
      
      public var soilParticlePool:Vector.<Particle3D>;
      
      public var swellParticlePool:Vector.<Particle3D>;
      
      public var persistentSoilParticlePool:Vector.<Particle3D>;
      
      public var spillX:Number = 0.5;
      
      public var spillY:Number = 0.25;
      
      public var spillZ:Number = 0.5;
      
      public var baseVelocity:Number = 10;
      
      public var baseSize:Number = 5;
      
      public const DROP_SCALE:Number = 0.2;
      
      public const MAX_STAIN_SCALE:Number = 0.6;
      
      public const MAX_SPREAD:Number = 1;
      
      public const MAX_ALPHA:Number = 0.85;
      
      public const MAX_TIME_SEC:Number = 60;
      
      public var assetRepository:AssetRepository;
      
      internal var particle:Particle3D;
      
      internal var particleSprite:GameSprite;
      
      internal var projected:Point3;
      
      internal var mili:Number;
      
      internal var sec:Number;
      
      internal var scale:Number;
      
      internal var size:int;
      
      internal var matrix:Matrix;
      
      internal var colorTransform:ColorTransform = new ColorTransform();
      
      private var validator:Validator;
      
      private var womRoot:WomGameRoot;
      
      public function Particle3DAnimationManager()
      {
         super();
         bloodParticlePool = new Vector.<Particle3D>();
         floatingParticlePool = new Vector.<Particle3D>();
         soilParticlePool = new Vector.<Particle3D>();
         swellParticlePool = new Vector.<Particle3D>();
         persistentSoilParticlePool = new Vector.<Particle3D>();
         priority = 0;
      }
      
      override public function get typeId() : String
      {
         return "Particle3DAnimationManager";
      }
      
      override public function init() : void
      {
         super.init();
         startEnabled = false;
         womRoot = owner.root as WomGameRoot;
         assetRepository = womRoot.assetRepository;
         validator = owner.root.validator;
      }
      
      override public function update() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < bloodParticlePool.length)
         {
            particle = bloodParticlePool[_loc1_];
            particleSprite = particle.particleSprite;
            projected = particleSprite.position.projected;
            mili = new Date().getTime() - particle.stateTime;
            sec = mili / 1000;
            if(particle.state == 0)
            {
               if(projected.z < -10)
               {
                  particle.state = 1;
                  particle.stateTime = new Date().getTime();
                  owner.root.layers[4].remove(particle.particleSprite);
                  (particleSprite.view as AssetView).changeAsset("Bloodstain");
                  owner.root.layers[2].add(particle.particleSprite);
                  particle.state2Duration = Math.random() * 1000 + 1000;
                  particle.stainScale = Math.random() * 0.2 + 0.5;
                  particleSprite.view.scaleFixed(0.2);
               }
               else
               {
                  projected.x += particle.dx;
                  particle.actualPoint.y += particle.dy;
                  projected.z += particle.dz;
                  projected.y = particle.actualPoint.y - projected.z;
                  particle.dz += Particle3DAnimationManager.gravity;
                  validator.add(particle.particleSprite);
               }
            }
            else if(particle.state == 1)
            {
               if(mili >= particle.state2Duration)
               {
                  particle.state = 2;
               }
               else
               {
                  scale = 0.2 + (particle.stainScale - 0.2) * mili / particle.state2Duration;
                  particleSprite.view.scaleFixed(scale);
                  if(scale > 0.6)
                  {
                     particleSprite.view.alphaFilter((0.6 - scale) / (1 - 0.6) + 0.85);
                  }
                  else
                  {
                     particleSprite.view.alphaFilter(0.85);
                  }
               }
            }
            else if(particle.state == 2)
            {
               if(sec >= 60)
               {
                  bloodParticlePool.splice(_loc1_,1);
                  owner.root.removeChild(particleSprite);
                  owner.root.layers[2].remove(particleSprite);
                  particleSprite.destroy();
               }
               else
               {
                  scale = particle.stainScale + (1 - particle.stainScale) * sec / 60;
                  particleSprite.view.scaleFixed(scale);
                  if(scale > 0.6)
                  {
                     particleSprite.view.alphaFilter((1 - scale) / (1 - 0.6) * 0.85);
                  }
               }
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < floatingParticlePool.length)
         {
            particle = floatingParticlePool[_loc1_];
            particleSprite = particle.particleSprite;
            projected = particleSprite.position.projected;
            if(particle.state == 0)
            {
               if(particle.stateTime > particle.state1Duration)
               {
                  particle.stateTime = 0;
                  particle.state = 1;
                  particle.dy /= 20;
               }
               else
               {
                  projected.x = particle.followPoint.x + particle.actualPoint.x;
                  projected.y = particle.followPoint.y + particle.actualPoint.y;
                  particle.actualPoint.y += particle.dy;
                  if(particle.stateTime % (particle.state1Duration / 5) == 0)
                  {
                     particleSprite.view.alphaFilter(particle.dz = particle.stateTime / particle.state1Duration);
                  }
                  validator.add(particle.particleSprite);
               }
            }
            else if(particle.state == 1)
            {
               if(particle.stateTime > particle.state2Duration)
               {
                  particle.stateTime = 0;
                  particle.state = 2;
               }
               else
               {
                  projected.x = particle.followPoint.x + particle.actualPoint.x;
                  projected.y = particle.followPoint.y + particle.actualPoint.y;
                  particle.actualPoint.y += particle.dy;
                  validator.add(particle.particleSprite);
               }
            }
            else if(particle.state == 2)
            {
               if(particle.stateTime > particle.state3Duration)
               {
                  floatingParticlePool.splice(_loc1_,1);
                  (owner.root.layers[3] as Layer).remove(particleSprite);
                  owner.root.removeChild(particleSprite);
                  particleSprite.destroy();
               }
               else
               {
                  if(particle.stateTime % (particle.state3Duration / 5) == 0)
                  {
                     particleSprite.view.alphaFilter(1 - particle.stateTime / particle.state3Duration);
                  }
                  projected.x = particle.followPoint.x + particle.actualPoint.x;
                  projected.y = particle.followPoint.y + particle.actualPoint.y;
                  particle.actualPoint.y += particle.dy;
                  validator.add(particle.particleSprite);
               }
            }
            particle.stateTime++;
            particle.totalTime++;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < soilParticlePool.length)
         {
            particle = soilParticlePool[_loc1_];
            particleSprite = particle.particleSprite;
            projected = particleSprite.position.projected;
            if(projected.z < -10)
            {
               soilParticlePool.splice(_loc1_,1);
               owner.root.removeChild(particleSprite);
               owner.root.layers[4].remove(particleSprite);
               particleSprite.destroy();
            }
            else
            {
               projected.x += particle.dx;
               particle.actualPoint.y += particle.dy;
               projected.z += particle.dz;
               projected.y = particle.actualPoint.y - projected.z;
               particle.dz += Particle3DAnimationManager.gravity;
               validator.add(particle.particleSprite);
            }
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < swellParticlePool.length)
         {
            particle = swellParticlePool[_loc1_];
            particleSprite = particle.particleSprite;
            projected = particleSprite.position.projected;
            if(particle.state == 0)
            {
               if(particle.stateTime > particle.state1Duration)
               {
                  particle.state = 1;
                  particle.stateTime = 0;
               }
               else if(particle.stateTime % 2 == 0)
               {
                  scale = particle.stateTime / particle.state1Duration;
                  particleSprite.view.scaleFixed(scale);
               }
            }
            if(particle.state == 1)
            {
               if(particle.stateTime > particle.state2Duration)
               {
                  particle.state = 2;
                  particle.stateTime = 0;
               }
            }
            if(particle.state == 2)
            {
               if(particle.stateTime > particle.state3Duration)
               {
                  swellParticlePool.splice(_loc1_,1);
                  owner.root.removeChild(particleSprite);
                  owner.root.layers[2].remove(particleSprite);
                  particleSprite.destroy();
               }
               else if(particle.stateTime % 2 == 0)
               {
                  scale = (particle.state3Duration - particle.stateTime) / 30;
                  particleSprite.view.scaleFixed(scale);
               }
            }
            particle.stateTime++;
            particle.totalTime++;
            _loc1_++;
         }
         _loc1_ = 0;
         while(_loc1_ < persistentSoilParticlePool.length)
         {
            particle = persistentSoilParticlePool[_loc1_];
            particleSprite = particle.particleSprite;
            projected = particleSprite.position.projected;
            if(particle.state == 0)
            {
               if(projected.z < -10)
               {
                  particle.state = 1;
                  particle.stateTime = 0;
                  owner.root.layers[4].remove(particleSprite);
                  owner.root.layers[2].add(particleSprite);
               }
               else
               {
                  projected.x += particle.dx;
                  particle.actualPoint.y += particle.dy;
                  projected.z += particle.dz;
                  projected.y = particle.actualPoint.y - projected.z;
                  particle.dz += Particle3DAnimationManager.gravity;
                  validator.add(particle.particleSprite);
               }
            }
            else if(particle.state == 1)
            {
               if(particle.stateTime > particle.state2Duration)
               {
                  persistentSoilParticlePool.splice(_loc1_,1);
                  owner.root.removeChild(particleSprite);
                  owner.root.layers[2].remove(particleSprite);
                  particleSprite.destroy();
               }
            }
            particle.stateTime++;
            _loc1_++;
         }
      }
      
      public function displayFloatingText(param1:Point, param2:int, param3:String, param4:String, param5:FloatingTextStack) : void
      {
         switch(param2 - 1)
         {
            case 0:
               newFloatingText(param1,param3,16711680,null,param5);
               break;
            case 1:
               newFloatingText(param1,param3,65280,null,param5);
               break;
            case 2:
               newFloatingText(param1,param3,15957051,"CollectedLumber",param5);
               break;
            case 3:
               newFloatingText(param1,param3,14407118,"CollectedStone",param5);
               break;
            case 4:
               newFloatingText(param1,param3,1748735,"CollectedMight",param5);
               break;
            case 5:
               newFloatingText(param1,param3,13750737,"CollectedIron",param5);
               break;
            case 6:
               newFloatingText(param1,param3,15957051,"CollectedLumber",param5);
               break;
            case 7:
               newFloatingText(param1,param3,14407118,"CollectedStone",param5);
               break;
            case 8:
               newFloatingText(param1,param3,1748735,"CollectedMight",param5);
               break;
            case 9:
               newFloatingText(param1,param3,13750737,"CollectedIron",param5);
               break;
            case 10:
               newFloatingText(param1,param3,16442003,"CollectedGold",param5);
               break;
            case 11:
               newFloatingText(param1,param3,16711680,"CollectedRp",param5);
               break;
            case 12:
               newFloatingText(param1,param3,13750737,param4,param5,150,40);
         }
      }
      
      private function newFloatingText(param1:Point, param2:String, param3:uint, param4:String = null, param5:FloatingTextStack = null, param6:Number = 50, param7:int = 20, param8:Boolean = true, param9:int = 20, param10:int = 20, param11:int = 20) : void
      {
         var _loc15_:FloatingTextViewManager = null;
         var _loc16_:FloatingTextViewManager = null;
         if(floatingParticlePool.length >= 100)
         {
            particleSprite = floatingParticlePool.shift().particleSprite;
            (owner.root.layers[particleSprite.view.layerId] as Layer).remove(particleSprite);
            owner.root.removeChild(particleSprite);
            particleSprite.destroy();
         }
         if(param5 && param5.lastFloatingText && param5.lastFloatingText.particleSprite.view && param5.lastFloatingText.state < 2)
         {
            _loc15_ = param5.lastFloatingText.particleSprite.componentManager["FloatingTextViewManager"] as FloatingTextViewManager;
            _loc15_.changeText(param2,_loc15_.resourceImage != param4 ? "CollectedResource" : null);
            param5.lastFloatingText.particleSprite.view.alphaFilter(param5.lastFloatingText.dz);
            return;
         }
         var _loc14_:GameSprite = new GameSprite();
         var _loc12_:ProjectedPosition = new ProjectedPosition();
         _loc12_.projected = new Point3(param1.x,param1.y);
         _loc14_.componentManager.add(_loc14_.view = new CompositeView());
         _loc14_.componentManager.add(_loc14_.position = _loc12_);
         _loc14_.componentManager.add(_loc14_.bounds = new CompositeRenderBounds());
         _loc14_.componentManager.add(new VoidProjection());
         _loc14_.componentManager.add(_loc16_ = new FloatingTextViewManager());
         _loc14_.composite = _loc14_;
         owner.root.addChild(_loc14_);
         _loc14_.init();
         (owner.root.layers[3] as Layer).add(_loc14_);
         _loc16_.addText(param2,param3,param4,param8,param7);
         param1.x -= _loc16_.usedWidth / 2;
         var _loc13_:Particle3D = new Particle3D(_loc14_,0,-param6 / param9,0,3);
         _loc13_.actualPoint = new Point3(0,0,0);
         _loc13_.followPoint = param1;
         _loc13_.state1Duration = param9;
         _loc13_.state2Duration = param10;
         _loc13_.state3Duration = param11;
         floatingParticlePool.push(_loc13_);
         if(param5)
         {
            param5.lastFloatingText = _loc13_;
         }
         _loc14_.view.alphaFilter(_loc13_.dz = 0);
         enable();
      }
      
      public function spillBlood(param1:Point) : void
      {
         var _loc8_:int = 0;
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:int = 0;
         if(womRoot.bloodDisabled)
         {
            return;
         }
         var _loc2_:int = Math.random() * 6 + 10;
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc8_ = baseSize * (Math.random() + 0.5);
            _loc6_ = baseVelocity * (Math.random() + 0.5);
            _loc3_ = spillX * (Math.random() * 2 - 1) * _loc6_;
            _loc4_ = spillY * (Math.random() * 2 - 1) * _loc6_;
            _loc5_ = spillZ * Math.random() * _loc6_;
            throwBloodParticle(param1,_loc8_,_loc3_,_loc4_,_loc5_);
            _loc7_++;
         }
         enable();
      }
      
      public function spillSoil(param1:Point3) : void
      {
         var _loc6_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:int = 0;
         var _loc2_:int = Math.random() * 6 + 10;
         _loc7_ = 0;
         while(_loc7_ < _loc2_)
         {
            _loc6_ = baseVelocity * (Math.random() + 0.5);
            _loc3_ = spillX * (Math.random() * 2 - 1) * _loc6_;
            _loc4_ = spillY * (Math.random() * 2 - 1) * _loc6_;
            _loc5_ = spillZ * Math.random() * _loc6_;
            throwSoilParticle(param1,_loc3_,_loc4_,_loc5_);
            _loc7_++;
         }
         enable();
      }
      
      public function spillSoilFromUnderground(param1:Point3) : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:int = 0;
         var _loc2_:Particle3D = null;
         var _loc3_:int = 4 * (Math.random() + 0.5);
         _loc10_ = 0;
         while(_loc10_ < _loc3_)
         {
            _loc9_ = 10 * (Math.random() - 0.5);
            _loc6_ = 10 * (Math.random() - 0.5);
            _loc8_ = baseVelocity / 2 * (Math.random() + 0.5);
            _loc4_ = spillX * (Math.random() * 2 - 1) * _loc8_;
            _loc5_ = spillY * (Math.random() * 2 - 1) * _loc8_;
            _loc7_ = spillZ * Math.random() * _loc8_;
            _loc2_ = throwSoilParticle(new Point3(param1.x + _loc9_,param1.y + _loc6_),_loc4_,_loc5_,_loc7_);
            _loc2_.type = 5;
            _loc2_.state2Duration = 500;
            _loc10_++;
         }
         enable();
      }
      
      public function spillStoneFromUnderground(param1:Point3) : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:int = 0;
         var _loc2_:Particle3D = null;
         var _loc3_:int = 2 * (Math.random() + 0.5);
         _loc10_ = 0;
         while(_loc10_ < _loc3_)
         {
            _loc9_ = 10 * (Math.random() - 0.5);
            _loc6_ = 10 * (Math.random() - 0.5);
            _loc8_ = baseVelocity / 2 * (Math.random() + 0.5);
            _loc4_ = spillX * (Math.random() * 2 - 1) * _loc8_;
            _loc5_ = spillY * (Math.random() * 2 - 1) * _loc8_;
            _loc7_ = spillZ * Math.random() * _loc8_;
            _loc2_ = throwStoneParticle(new Point3(param1.x + _loc9_,param1.y + _loc6_),_loc4_,_loc5_,_loc7_);
            _loc2_.type = 5;
            _loc2_.state2Duration = 1000;
            _loc10_++;
         }
         enable();
      }
      
      public function groundSwell(param1:Point3) : void
      {
         if(swellParticlePool.length >= 100)
         {
            particleSprite = swellParticlePool.shift().particleSprite;
            (owner.root.layers[particleSprite.view.layerId] as Layer).remove(particleSprite);
            owner.root.removeChild(particleSprite);
            particleSprite.destroy();
         }
         var _loc4_:int = Math.random() * 4 + 1;
         var _loc6_:int = Math.random() * 8;
         var _loc7_:GameSprite = new GameSprite();
         var _loc3_:String = "GroundSwell" + _loc4_;
         _loc7_.componentManager.add(_loc7_.view = new AssetView(2,_loc3_,true));
         var _loc2_:Position = new ProjectedPosition();
         _loc2_.projected = new Point3(param1.x,param1.y,param1.z);
         _loc7_.componentManager.add(_loc7_.position = _loc2_);
         owner.root.addChild(_loc7_);
         _loc7_.init();
         owner.root.layers[2].add(_loc7_);
         var _loc5_:Particle3D = new Particle3D(_loc7_,0,0,0,4);
         _loc5_.assetName = _loc3_;
         _loc5_.rotMul = _loc6_;
         _loc5_.particleSprite.view.rotate(-_loc5_.rotMul * 3.141592653589793 / 4);
         _loc5_.particleSprite.view.scaleFixed(0);
         _loc5_.state1Duration = 30;
         _loc5_.state2Duration = 500;
         _loc5_.state3Duration = 30;
         swellParticlePool.push(_loc5_);
         enable();
      }
      
      public function throwBloodParticle(param1:Point, param2:int, param3:Number, param4:Number, param5:Number) : void
      {
         if(bloodParticlePool.length >= 500)
         {
            particleSprite = bloodParticlePool.shift().particleSprite;
            (owner.root.layers[particleSprite.view.layerId] as Layer).remove(particleSprite);
            owner.root.removeChild(particleSprite);
            particleSprite.destroy();
         }
         var _loc7_:GameSprite = new GameSprite();
         _loc7_.componentManager.add(_loc7_.view = new AssetView(4,"BloodDrop",true));
         var _loc6_:Position = new ProjectedPosition();
         _loc6_.projected = new Point3(param1.x - 25,param1.y - 25,0);
         _loc7_.componentManager.add(_loc7_.position = _loc6_);
         owner.root.addChild(_loc7_);
         owner.root.layers[4].add(_loc7_);
         _loc7_.init();
         _loc7_.view.scaleFixed(param2 / (baseSize * 4));
         var _loc8_:Particle3D = new Particle3D(_loc7_,param3,param4,param5,1);
         bloodParticlePool.push(_loc8_);
      }
      
      public function throwSoilParticle(param1:Point3, param2:Number, param3:Number, param4:Number) : Particle3D
      {
         if(soilParticlePool.length >= 500)
         {
            particleSprite = soilParticlePool.shift().particleSprite;
            (owner.root.layers[particleSprite.view.layerId] as Layer).remove(particleSprite);
            owner.root.removeChild(particleSprite);
            particleSprite.destroy();
         }
         var _loc8_:GameSprite = new GameSprite();
         var _loc9_:int = (Math.random() * 4 >> 0) + 1;
         var _loc6_:String = "Soil" + _loc9_;
         _loc8_.componentManager.add(_loc8_.view = new AssetView(2,_loc6_,false));
         var _loc5_:Position = new ProjectedPosition();
         _loc5_.projected = new Point3(param1.x,param1.y,param1.z);
         _loc8_.componentManager.add(_loc8_.position = _loc5_);
         owner.root.addChild(_loc8_);
         owner.root.layers[4].add(_loc8_);
         _loc8_.init();
         var _loc7_:Particle3D = new Particle3D(_loc8_,param2,param3,param4,2);
         soilParticlePool.push(_loc7_);
         return _loc7_;
      }
      
      public function throwStoneParticle(param1:Point3, param2:Number, param3:Number, param4:Number) : Particle3D
      {
         if(persistentSoilParticlePool.length >= 100)
         {
            particleSprite = persistentSoilParticlePool.shift().particleSprite;
            (owner.root.layers[particleSprite.view.layerId] as Layer).remove(particleSprite);
            owner.root.removeChild(particleSprite);
            particleSprite.destroy();
         }
         var _loc8_:GameSprite = new GameSprite();
         var _loc9_:int = (Math.random() * 4 >> 0) + 1;
         var _loc6_:String = "StonePart" + _loc9_;
         _loc8_.componentManager.add(_loc8_.view = new AssetView(2,_loc6_,false));
         var _loc5_:Position = new ProjectedPosition();
         _loc5_.projected = new Point3(param1.x,param1.y,param1.z);
         _loc8_.componentManager.add(_loc8_.position = _loc5_);
         owner.root.addChild(_loc8_);
         owner.root.layers[4].add(_loc8_);
         _loc8_.init();
         var _loc7_:Particle3D = new Particle3D(_loc8_,param2,param3,param4,5);
         persistentSoilParticlePool.push(_loc7_);
         return _loc7_;
      }
      
      public function clearAll() : void
      {
         clearParticlePool(bloodParticlePool);
         clearParticlePool(floatingParticlePool);
         clearParticlePool(soilParticlePool);
         clearParticlePool(swellParticlePool);
         clearParticlePool(persistentSoilParticlePool);
      }
      
      private function clearParticlePool(param1:Vector.<Particle3D>) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Particle3D = null;
         var _loc2_:GameSprite = null;
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            _loc3_ = param1[_loc4_];
            _loc2_ = _loc3_.particleSprite;
            param1.splice(_loc4_,1);
            owner.root.removeChild(_loc2_);
            owner.root.layers[_loc2_.view.layerId].remove(_loc2_);
            _loc2_.destroy();
            _loc4_++;
         }
         param1 = new Vector.<Particle3D>();
      }
      
      override public function destroy() : void
      {
         disable();
      }
   }
}

