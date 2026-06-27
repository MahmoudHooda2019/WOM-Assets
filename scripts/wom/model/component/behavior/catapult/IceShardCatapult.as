package wom.model.component.behavior.catapult
{
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.attribute.view.CompositeView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.behavior.TowerAnimationManager;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.tower.BeastCannon;
   import wom.model.component.behavior.battle.tower.TowerDefense;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Drop;
   import wom.model.component.structure.BattleField;
   import wom.model.dto.combat.CatapultInfo;
   
   public class IceShardCatapult extends BaseCatapult
   {
      
      public static const CACHE_COUNT:int = 10;
      
      public static const DROP_GROW_TIME:int = 30;
      
      public static const DROP_DISPOSAL_TIME:int = 180;
      
      public static const DROP_DISTANCE_X:int = 300;
      
      public static const DROP_DISTANCE_Y:int = 900;
      
      private static var IceShardStaticGrow:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private static var IceShardStaticFade:Vector.<BitmapData> = new Vector.<BitmapData>();
      
      private var throwingEnabled:Boolean;
      
      protected var hittingEnabled:Boolean;
      
      protected var offset:Point;
      
      protected var drops:Vector.<Drop>;
      
      public var collidedEntities:Dictionary;
      
      public var buildingsToFreeze:Vector.<TowerDefense>;
      
      private var freezed:Boolean;
      
      public function IceShardCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxMightyRage").soundAsset.sound;
         drops = new Vector.<Drop>();
         freezed = false;
         offset = new Point(23,39);
      }
      
      override public function update() : void
      {
         var _loc6_:int = 0;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc5_:Point3 = null;
         var _loc4_:Point3 = null;
         var _loc3_:Drop = null;
         handleDrops();
         if(throwingEnabled)
         {
            _loc6_ = 0;
            while(_loc6_ <= 5)
            {
               _loc1_ = Math.random() * 2 * 3.141592653589793;
               _loc2_ = Math.random() + Math.random();
               _loc2_ = (_loc2_ > 1 ? 2 - _loc2_ : _loc2_) * radius;
               _loc5_ = new Point3(position.x + _loc2_ * Math.cos(_loc1_),position.y + _loc2_ * Math.sin(_loc1_));
               _loc4_ = new Point3();
               womRoot.projection.transform(_loc5_,_loc4_);
               _loc4_.x -= offset.x;
               _loc4_.y -= offset.y;
               _loc3_ = new Drop(womRoot,new Point3(_loc4_.x - 300,_loc4_.y - 900),_loc4_,"IceShardCracks");
               womRoot.addChild(_loc3_);
               _loc3_.init();
               (womRoot.layers[4] as Layer).add(_loc3_);
               drops.push(_loc3_);
               _loc6_++;
            }
         }
         if(hittingEnabled)
         {
            duration -= sync.precise;
            if(duration < 0 && throwingEnabled)
            {
               throwingEnabled = false;
            }
            if(!freezed)
            {
               freeze();
            }
         }
         if(drops.length == 0 && !throwingEnabled)
         {
            disable();
         }
      }
      
      private function defreeze() : void
      {
         var _loc1_:Building = null;
         var _loc3_:TowerAnimationManager = null;
         for each(var _loc2_ in buildingsToFreeze)
         {
            if(_loc2_.owner)
            {
               _loc1_ = _loc2_.owner as Building;
               if(_loc1_ && _loc1_.composite && _loc1_.data.buildingInfo.healthPoint > 0)
               {
                  (_loc1_.composite.view as CompositeView).colorFilter();
                  var _temp_4:* = _loc2_.tm;
                  var _loc4_:WorkerThread;
                  var _loc8_:Number = (_loc4_ = womRoot.tds)._value;
                  var _loc5_:WorkerThread = _temp_4;
                  _loc5_._value = _loc8_;
                  _loc1_.composite.interactive = true;
                  if("TowerAnimationManager" in _loc1_.componentManager)
                  {
                     _loc3_ = _loc1_.componentManager["TowerAnimationManager"] as TowerAnimationManager;
                     _loc3_.exitAttackMode();
                     _loc3_.enable();
                  }
                  if(_loc1_.data.buildingTypeDIO.id == 45)
                  {
                     (_loc1_.componentManager["TowerDefense"] as BeastCannon).defreeze();
                  }
               }
            }
         }
         freezed = false;
      }
      
      private function freeze() : void
      {
         var _loc1_:Building = null;
         for each(var _loc2_ in buildingsToFreeze)
         {
            if(_loc2_.owner)
            {
               _loc1_ = _loc2_.owner as Building;
               if(_loc1_ && _loc1_.composite && _loc1_.data.buildingInfo.healthPoint > 0)
               {
                  (_loc1_.composite.view as CompositeView).colorFilter(8316141);
                  _loc2_.stopAttack();
                  if("TowerAnimationManager" in _loc1_.componentManager)
                  {
                     (_loc1_.componentManager["TowerAnimationManager"] as TowerAnimationManager).pauseTurning();
                  }
                  var _temp_3:* = _loc2_.tm;
                  var _loc7_:Number = womRoot.tdst._value;
                  var _loc4_:WorkerThread = _temp_3;
                  _loc4_._value = _loc7_;
                  _loc1_.composite.interactive = false;
                  if(_loc1_.data.buildingTypeDIO.id == 45)
                  {
                     (_loc1_.componentManager["TowerDefense"] as BeastCannon).freeze();
                  }
               }
            }
         }
         freezed = true;
      }
      
      private function handleDrops() : void
      {
         var _loc3_:int = 0;
         var _loc1_:Drop = null;
         var _loc2_:Boolean = false;
         _loc3_ = drops.length - 1;
         while(_loc3_ >= 0)
         {
            _loc1_ = drops[_loc3_];
            switch(int(_loc1_.state) - 1)
            {
               case 0:
                  _loc2_ = true;
                  if(_loc1_.position.projected.x < _loc1_.target.x)
                  {
                     _loc1_.position.projected.x += _loc1_.dx * sync.precise;
                     _loc1_.position.projected.y += _loc1_.dy * sync.precise;
                  }
                  else
                  {
                     hittingEnabled = true;
                     _loc1_.position.projected = _loc1_.target;
                     _loc1_.state = 2;
                     (womRoot.layers[4] as Layer).remove(_loc1_);
                     _loc1_.position.projected.y += 20;
                     (_loc1_.view as AssetView).changeAsset("IceShardDrop");
                     _loc1_.velocity = 0;
                     _loc1_.dx = 0;
                     (womRoot.layers[2] as Layer).add(_loc1_);
                     _loc1_.view.scaleFixed(0);
                  }
                  var _loc4_:Drop = _loc1_;
                  _loc4_.validator.add(_loc4_);
                  undefined;
                  break;
               case 1:
                  _loc1_.dx += sync.precise;
                  if(_loc1_.dx >= 30)
                  {
                     _loc1_.view.scaleFixed(1);
                     _loc1_.velocity = 0;
                     _loc1_.dx = 0;
                     _loc1_.state = 3;
                  }
                  else
                  {
                     _loc1_.view.scaleFixed(_loc1_.dx / 30);
                  }
                  break;
               case 2:
                  _loc1_.dx += sync.precise;
                  if(_loc1_.dx >= 180)
                  {
                     drops.splice(_loc3_,1);
                     (womRoot.layers[2] as Layer).remove(_loc1_);
                     womRoot.removeChild(_loc1_);
                     _loc1_.destroy();
                  }
                  else
                  {
                     _loc1_.view.alphaFilter(1 - _loc1_.dx / 180);
                  }
            }
            _loc3_--;
         }
         if(!_loc2_ && hittingEnabled)
         {
            if(soundContainer)
            {
               sfx.catapultFinished(soundContainer);
               soundContainer = null;
            }
            removeEffectAreaCircle();
            defreeze();
            hittingEnabled = false;
         }
      }
      
      override public function deployCatapult(param1:Point) : void
      {
         super.deployCatapult(param1);
         throwingEnabled = true;
         drawEffectAreaCircle();
         enable();
      }
      
      override public function collideDeployCircle(param1:Point3) : void
      {
         var _loc11_:* = 0;
         var _loc10_:* = 0;
         var _loc9_:int = 0;
         var _loc7_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Boolean = false;
         var _loc4_:Building = null;
         var _loc19_:Dictionary = new Dictionary();
         var _loc2_:int = (param1.x - radius) / 10;
         var _loc8_:int = (param1.x + radius) / 10;
         var _loc3_:int = (param1.y - radius) / 10;
         var _loc15_:int = (param1.y + radius) / 10;
         if(_loc2_ < 0)
         {
            _loc2_--;
         }
         if(_loc8_ > 0)
         {
            _loc8_++;
         }
         if(_loc3_ < 0)
         {
            _loc3_--;
         }
         if(_loc15_ > 0)
         {
            _loc15_++;
         }
         var _loc18_:BattleField = null;
         _loc11_ = _loc2_;
         while(_loc11_ <= _loc8_)
         {
            _loc10_ = _loc3_;
            while(_loc10_ <= _loc15_)
            {
               _loc18_ = battleManager.battleFieldControl.battleFields[(_loc11_ << 10) + (_loc10_ << 0)];
               if(_loc18_)
               {
                  for each(_loc4_ in _loc18_.buildings)
                  {
                     _loc9_ = _loc4_.data.buildingTypeDIO.id;
                     if(!_loc4_.data.buildingTypeDIO.indestructable && _loc4_.data.buildingInfo.healthPoint > 0 && _loc9_ >= 31 && _loc9_ <= 36 || _loc9_ == 45)
                     {
                        if(!_loc19_[_loc4_.id])
                        {
                           _loc7_ = _loc4_.position.point.x + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc12_ = _loc4_.position.point.y + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc5_ = (_loc7_ - param1.x) * (_loc7_ - param1.x) + (_loc12_ - param1.y) * (_loc12_ - param1.y);
                           _loc16_ = radius + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc17_ = _loc5_ <= _loc16_ * _loc16_;
                           if(!_loc17_)
                           {
                              _loc5_ = Math.sqrt(_loc5_);
                              _loc14_ = radius / _loc5_;
                              _loc6_ = _loc14_ * (_loc7_ - param1.x) + param1.x;
                              _loc13_ = _loc14_ * (_loc12_ - param1.y) + param1.y;
                           }
                           if(_loc17_ || _loc6_ > _loc4_.position.point.x && _loc6_ < _loc4_.position.point.x + _loc4_.data.buildingTypeDIO.baseSize && _loc13_ > _loc4_.position.point.y && _loc13_ < _loc4_.position.point.y + _loc4_.data.buildingTypeDIO.baseSize)
                           {
                              _loc19_[_loc4_.id] = _loc4_;
                              (_loc4_.composite.view as CompositeView).colorFilter(8316141);
                           }
                        }
                     }
                  }
               }
               _loc10_++;
            }
            _loc11_++;
         }
         if(collidedEntities)
         {
            for each(_loc4_ in collidedEntities)
            {
               if(!(_loc4_.id in _loc19_))
               {
                  (_loc4_.composite.view as CompositeView).colorFilter();
               }
            }
         }
         collidedEntities = _loc19_;
      }
      
      override public function resetCollusionFilters() : void
      {
         var _loc1_:TowerDefense = null;
         buildingsToFreeze = new Vector.<TowerDefense>();
         if(collidedEntities)
         {
            for each(var _loc2_ in collidedEntities)
            {
               (_loc2_.composite.view as CompositeView).colorFilter();
               _loc1_ = _loc2_.componentManager["TowerDefense"] as TowerDefense;
               if(_loc1_)
               {
                  buildingsToFreeze.push(_loc1_);
               }
            }
         }
         buildingsToFreeze.sort(sortBuildings);
      }
      
      private function sortBuildings(param1:TowerDefense, param2:TowerDefense) : int
      {
         return (param1.owner as Building).data.buildingInfo.instanceId < (param2.owner as Building).data.buildingInfo.instanceId ? -1 : 1;
      }
   }
}

