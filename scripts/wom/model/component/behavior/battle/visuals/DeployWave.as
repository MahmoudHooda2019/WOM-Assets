package wom.model.component.behavior.battle.visuals
{
   import flash.geom.Point;
   import peak.cuckoo.core.Behavior;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.bounds.RenderBounds;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.behavior.FpsSync;
   import peak.cuckoo.game.behavior.render.gpu.GpuTransformableImage;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.projection.VoidProjection;
   
   public class DeployWave extends Behavior
   {
      
      public static const TYPE_ID:String = "BaseRender";
      
      private const DEPLOY_ANIMATION_TIME:Number = 60;
      
      private const WAVE_ANIMATION_TIME:Number = 15;
      
      private var gpuImage:GpuTransformableImage;
      
      private var womRoot:WomGameRoot;
      
      private var wait:Number;
      
      private var sync:FpsSync;
      
      public var x:Number;
      
      public var y:Number;
      
      private var collide:Boolean;
      
      private var nearest:Number;
      
      private var diameter:int;
      
      private var ownerSprite:GameSprite;
      
      private var reference:StarlingAtlasReference;
      
      private var waves:Vector.<Wave> = new Vector.<Wave>();
      
      private var factor:Number;
      
      public function DeployWave(param1:Point, param2:Boolean, param3:Number, param4:int)
      {
         super();
         priority = 0;
         this.x = param1.x;
         this.y = param1.y;
         this.collide = param2;
         this.nearest = param3;
         this.diameter = param4;
      }
      
      override public function get typeId() : String
      {
         return "BaseRender";
      }
      
      override public function init() : void
      {
         super.init();
         womRoot = owner.root as WomGameRoot;
         sync = womRoot.sync;
         ownerSprite = owner as GameSprite;
         gpuImage = ownerSprite.view.gpuTransformableImage;
         reference = womRoot.atlasManager.getAtlasReference("TowerRange");
      }
      
      override public function update() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Wave = null;
         var _loc2_:Number = NaN;
         _loc3_ = waves.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = waves[_loc3_];
            _loc1_.scale += sync.precise;
            _loc2_ = _loc1_.scale / 15;
            _loc1_.gameSprite.view.scaleFixed(_loc2_ * factor);
            _loc1_.gameSprite.view.rgbaFilterNumber(collide ? 1 : 1,collide ? 1 - _loc2_ : 1,collide ? 1 - _loc2_ : 0,1 - _loc2_);
            if(_loc2_ >= 1)
            {
               (womRoot.layers[4] as Layer).remove(_loc1_.gameSprite);
               _loc1_.gameSprite.destroy();
               waves.splice(_loc3_,1);
            }
            _loc3_--;
         }
         wait -= sync.precise;
         if(wait > 0)
         {
            ownerSprite.view.alphaFilter(wait / 60);
            return;
         }
         (womRoot.layers[2] as Layer).remove(ownerSprite);
         ownerSprite.destroy();
         womRoot.battleManager.mobileDeployWaves.splice(womRoot.battleManager.mobileDeployWaves.indexOf(this),1);
      }
      
      public function setNewDeploy(param1:Number, param2:Number) : void
      {
         wait = 60;
         var _loc4_:GameSprite = new GameSprite();
         _loc4_.componentManager.add(_loc4_.view = new AssetView(4,"TowerRange",true));
         _loc4_.componentManager.add(new VoidProjection());
         _loc4_.componentManager.add(_loc4_.bounds = new RenderBounds());
         _loc4_.componentManager.add(_loc4_.position = new Position(new Point3()));
         _loc4_.position.projected.x = param1 - reference.width / 2;
         _loc4_.position.projected.y = param2 - reference.height / 2;
         owner.addChild(_loc4_);
         _loc4_.init();
         (womRoot.layers[4] as Layer).add(_loc4_);
         var _loc3_:Wave = new Wave();
         _loc3_.gameSprite = _loc4_;
         _loc3_.limit = nearest;
         waves.push(_loc3_);
      }
      
      override protected function start() : void
      {
         super.start();
         wait = 60;
         if(collide)
         {
            gpuImage.updateColorFilter(11141120);
         }
         factor = (diameter - 2) * (womRoot.projection as IsoProjection).pitchX / reference.width;
         gpuImage.scale(factor,factor);
         setNewDeploy(x,y);
      }
   }
}

import peak.cuckoo.game.GameSprite;

class Wave
{
   
   public var scale:Number = 0;
   
   public var limit:Number = 0;
   
   public var gameSprite:GameSprite;
   
   public function Wave()
   {
      super();
   }
}
