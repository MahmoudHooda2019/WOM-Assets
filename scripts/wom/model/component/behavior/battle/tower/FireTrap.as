package wom.model.component.behavior.battle.tower
{
   import flash.geom.Matrix;
   import flash.media.Sound;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.attribute.Position;
   import peak.cuckoo.game.attribute.projection.IsoProjection;
   import peak.cuckoo.game.attribute.view.AnimationAssetView;
   import peak.cuckoo.game.behavior.animation.ActionAnimation;
   import peak.cuckoo.game.dto.Point3;
   import peak.resource.atlas.starling.StarlingAtlasReference;
   import peak.util.ValidationRecorder;
   import peak.util.ValidationVerifier;
   import wom.model.component.WomGameRoot;
   import wom.model.component.attribute.SfxManager;
   import wom.model.component.attribute.data.BuildingData;
   import wom.model.component.attribute.projection.VoidProjection;
   import wom.model.component.attribute.viewManager.BuildingViewManager;
   import wom.model.component.behavior.battle.*;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   
   public class FireTrap extends TowerDefense
   {
      
      public static const RANGE:int = 6;
      
      public static const TRIGGER_RANGE:int = 3;
      
      private var bd:BuildingData;
      
      private var damage:Number;
      
      private var triggerRange:int;
      
      private var flameSprite:GameSprite;
      
      private var actionAnimation:ActionAnimation;
      
      private var sfx:SfxManager;
      
      private var trapSound:Sound;
      
      private var rootProjection:IsoProjection;
      
      public function FireTrap(param1:BattleManager)
      {
         super(param1,1);
      }
      
      override public function init() : void
      {
         r = 6;
         triggerRange = 3;
         super.init();
         bd = (owner as Building).data;
         damage = bd.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGE.id];
         actionAnimation = new owner.root.render.renderSpecificActionAnimation(4,114);
         owner.componentManager.add(actionAnimation);
         actionAnimation.init();
         var _loc7_:StarlingAtlasReference = owner.root.atlasManager.getAtlasReference("B33Animation-0");
         flameSprite = new GameSprite();
         flameSprite.componentManager.add(actionAnimation);
         var _loc3_:WomGameRoot = owner.root as WomGameRoot;
         var _loc6_:AnimationAssetView = new AnimationAssetView("B33Animation",4,true);
         flameSprite.componentManager.add(flameSprite.view = _loc6_);
         flameSprite.componentManager.add(flameSprite.position = new Position(new Point3()));
         flameSprite.componentManager.add(new VoidProjection());
         _loc3_.addChild(flameSprite);
         flameSprite.init();
         var _loc2_:int = _loc7_.width;
         var _loc4_:int = _loc7_.height;
         var _loc1_:Number = 1.5707963267948966;
         var _loc5_:Matrix = new Matrix();
         _loc5_.rotate(-_loc1_);
         _loc5_.translate((_loc4_ - _loc2_) / 2,(_loc2_ - _loc4_) / 2);
         actionAnimation.setMatrix(_loc5_);
         sfx = womRoot.sfxManager;
         trapSound = sfx.assetRepository.getSoundAssetReference("FlamerTowerAttack").soundAsset.sound;
      }
      
      override public function startAttack() : void
      {
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc8_:* = undefined;
         var _loc7_:int = 0;
         var _loc1_:Unit = null;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Boolean = false;
         _loc9_ = iS;
         while(_loc9_ <= iF)
         {
            _loc6_ = jS;
            while(_loc6_ <= jF)
            {
               _loc8_ = (b.battleFieldControl.battleFields[(_loc9_ << 10) + (_loc6_ << 0)] as BattleField).units;
               _loc7_ = _loc8_.length - 1;
               while(_loc7_ >= 0)
               {
                  _loc1_ = _loc8_[_loc7_];
                  if(_loc1_.data.typeDIO.id == 21 || _loc1_.data.typeDIO.id == 20 || _loc1_.data.typeDIO.id == 19 || _loc1_.data.typeDIO.id == 24 || _loc1_.data.typeDIO.id == 23 || _loc1_.data.isBeast)
                  {
                     _loc2_ = _loc1_.position.point.x - position.x;
                     _loc3_ = _loc1_.position.point.y - position.y;
                     if(_loc2_ < 0)
                     {
                        _loc2_ *= -1;
                     }
                     if(_loc3_ < 0)
                     {
                        _loc3_ *= -1;
                     }
                     if(_loc2_ <= r && _loc3_ <= r)
                     {
                        _loc1_.underAttack.hit(damage);
                        _loc4_ = true;
                     }
                  }
                  _loc7_--;
               }
               _loc6_++;
            }
            _loc9_++;
         }
         if(!_loc4_)
         {
            return;
         }
         sfx.trapActivate(trapSound,ownerBuilding);
         b.battleFieldControl.removeTowerFromCheckGrid(this);
         bd.buildingInfo.healthPoint = 0;
         b.notifier.notifyTrapActivated(ownerBuilding);
         var _loc5_:BuildingViewManager = new BuildingViewManager(ownerBuilding,bd.buildingTypeDIO);
         owner.componentManager.add(_loc5_);
         _loc5_.init();
         ownerBuilding.root.layers[3].add(ownerBuilding);
         var _loc11_:Building = ownerBuilding;
         _loc11_.validator.add(_loc11_);
         undefined;
         flameSprite.position.projected.x = ownerBuilding.position.projected.x - 2;
         flameSprite.position.projected.y = ownerBuilding.position.projected.y - 128;
         owner.root.layers[4].add(flameSprite);
         var _loc12_:GameSprite = flameSprite;
         _loc12_.validator.add(_loc12_);
         undefined;
         actionAnimation.setFrame(0);
         actionAnimation.setStopFrame(6);
         actionAnimation.animationFinished.addFunctionOnce(flameBurned);
         actionAnimation.loop = false;
         actionAnimation.fpsChangeRate = 4;
         actionAnimation.startAnimation();
      }
      
      private function flameBurned() : void
      {
         owner.root.layers[4].remove(flameSprite);
      }
      
      override public function update() : void
      {
      }
      
      override public function stopAttack(param1:Boolean = true) : void
      {
      }
      
      override public function checkUnitToAttack(param1:Unit) : int
      {
         if(!(param1.data.typeDIO.id == 21 || param1.data.typeDIO.id == 20 || param1.data.typeDIO.id == 19 || param1.data.typeDIO.id == 24 || param1.data.typeDIO.id == 23 || param1.data.isBeast))
         {
            var _loc4_:WorkerThread = womRoot.tdrd;
            return _loc4_._value;
         }
         var _loc2_:Number = param1.position.point.x - position.x;
         var _loc3_:Number = param1.position.point.y - position.y;
         if(_loc2_ < 0)
         {
            _loc2_ *= -1;
         }
         if(_loc3_ < 0)
         {
            _loc3_ *= -1;
         }
         if(_loc2_ <= triggerRange && _loc3_ <= triggerRange)
         {
            tu = param1;
         }
         var _loc5_:WorkerThread = womRoot.tdrg;
         return _loc5_._value;
      }
   }
}

