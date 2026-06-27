package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.attribute.view.AssetView;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Drop;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.dto.combat.CatapultInfo;
   import wom.model.game.unit.UnitStatusType;
   
   public class AcidRainCatapult extends BaseCatapult
   {
      
      public static const CACHE_COUNT:int = 10;
      
      public static const DROP_GROW_TIME:int = 30;
      
      public static const DROP_DISPOSAL_TIME:int = 180;
      
      public static const DROP_DISTANCE_X:int = 300;
      
      public static const DROP_DISTANCE_Y:int = 900;
      
      private const CHECK_INTERVAL:int = 6;
      
      private var units:Vector.<Unit>;
      
      private var throwingEnabled:Boolean;
      
      protected var hittingEnabled:Boolean;
      
      private var spendTime:Number;
      
      private var wait:int;
      
      protected var offset:Point;
      
      protected var drops:Vector.<Drop>;
      
      private var totalDamageGoal:Number;
      
      private var hitPerFrame:Number;
      
      private var weightOfNextHit:Number;
      
      private var indexList:Vector.<Number>;
      
      private var deployed:Boolean = false;
      
      public function AcidRainCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxMightyRage").soundAsset.sound;
         units = new Vector.<Unit>();
         drops = new Vector.<Drop>();
         offset = new Point(23,39);
         totalDamageGoal = catapultDIO.effectValues[0].effectValuesPerStage[catapultInfo.size];
         hitPerFrame = totalDamageGoal / duration;
         weightOfNextHit = 0;
         spendTime = 0;
         wait = 60;
      }
      
      override public function update() : void
      {
         var _loc7_:int = 0;
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc6_:Point3 = null;
         var _loc5_:Point3 = null;
         var _loc3_:Drop = null;
         var _loc4_:Number = NaN;
         handleDrops();
         if(throwingEnabled)
         {
            _loc7_ = 0;
            while(_loc7_ <= 5)
            {
               _loc1_ = Math.random() * 2 * 3.141592653589793;
               _loc2_ = Math.random() + Math.random();
               _loc2_ = (_loc2_ > 1 ? 2 - _loc2_ : _loc2_) * radius;
               _loc6_ = new Point3(position.x + _loc2_ * Math.cos(_loc1_),position.y + _loc2_ * Math.sin(_loc1_));
               _loc5_ = new Point3();
               womRoot.projection.transform(_loc6_,_loc5_);
               _loc5_.x -= offset.x;
               _loc5_.y -= offset.y;
               _loc3_ = new Drop(womRoot,new Point3(_loc5_.x - 300,_loc5_.y - 900),_loc5_,"AcidRainDrop");
               womRoot.addChild(_loc3_);
               _loc3_.init();
               (womRoot.layers[4] as Layer).add(_loc3_);
               drops.push(_loc3_);
               _loc7_++;
            }
         }
         if(hittingEnabled)
         {
            duration -= sync.precise;
            wait -= sync.precise;
            weightOfNextHit += sync.precise;
            if(wait > 0)
            {
               return;
            }
            wait = 6;
            if(duration < 0 && throwingEnabled)
            {
               throwingEnabled = false;
            }
            _loc4_ = weightOfNextHit * hitPerFrame;
            _loc4_ = _loc4_ > totalDamageGoal ? totalDamageGoal : _loc4_;
            totalDamageGoal -= _loc4_;
            weightOfNextHit = 0;
            hit(_loc4_);
         }
         if(drops.length == 0 && !throwingEnabled)
         {
            disable();
         }
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
                     _loc1_.position.projected.x += 20;
                     _loc1_.position.projected.y += 11;
                     (_loc1_.view as AssetView).changeAsset("AcidRainFoam2");
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
            hitLastDamage();
            hittingEnabled = false;
         }
      }
      
      private function hitLastDamage() : void
      {
         hit(totalDamageGoal);
         if(soundContainer)
         {
            sfx.catapultFinished(soundContainer);
            soundContainer = null;
         }
         removeEffectAreaCircle();
      }
      
      private function hit(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BattleField = null;
         var _loc5_:int = 0;
         var _loc3_:Unit = null;
         if(param1 == 0)
         {
            return;
         }
         _loc5_ = 0;
         while(_loc5_ < indexList.length)
         {
            _loc2_ = battleManager.battleFieldControl.battleFields[indexList[_loc5_]];
            if(_loc2_)
            {
               _loc4_ = _loc2_.defenceUnits.length - 1;
               while(_loc4_ >= 0)
               {
                  _loc3_ = _loc2_.defenceUnits[_loc4_];
                  if((_loc3_.position.point.x - position.x) * (_loc3_.position.point.x - position.x) + (_loc3_.position.point.y - position.y) * (_loc3_.position.point.y - position.y) <= radius * radius)
                  {
                     if(_loc3_.data.info.healthPoints > 0 && _loc3_.data.info.status != UnitStatusType.IN_WATCH_POST)
                     {
                        _loc3_.underAttack.hit(param1);
                     }
                  }
                  _loc4_--;
               }
            }
            _loc5_++;
         }
      }
      
      override public function deployCatapult(param1:Point) : void
      {
         deployed = true;
         super.deployCatapult(param1);
         throwingEnabled = true;
         drawEffectAreaCircle();
         enable();
      }
      
      override public function collideDeployCircle(param1:Point3) : void
      {
         var _loc10_:* = 0;
         var _loc7_:* = 0;
         var _loc9_:int = 0;
         var _loc6_:BattleField = null;
         var _loc8_:Unit = null;
         _loc9_ = units.length - 1;
         while(_loc9_ >= 0)
         {
            units[_loc9_].filterManager.removeFilter(WomFilters.PURPLE_FILTER);
            _loc9_--;
         }
         var _loc2_:int = (param1.x - radius) / 10;
         var _loc5_:int = (param1.x + radius) / 10;
         var _loc3_:int = (param1.y - radius) / 10;
         var _loc4_:int = (param1.y + radius) / 10;
         if(_loc2_ < 0)
         {
            _loc2_--;
         }
         if(_loc5_ > 0)
         {
            _loc5_++;
         }
         if(_loc3_ < 0)
         {
            _loc3_--;
         }
         if(_loc4_ > 0)
         {
            _loc4_++;
         }
         _loc10_ = _loc2_;
         while(_loc10_ <= _loc5_)
         {
            _loc7_ = _loc3_;
            while(_loc7_ <= _loc4_)
            {
               _loc6_ = battleManager.battleFieldControl.battleFields[(_loc10_ << 10) + (_loc7_ << 0)];
               if(_loc6_)
               {
                  _loc9_ = _loc6_.defenceUnits.length - 1;
                  while(_loc9_ >= 0)
                  {
                     _loc8_ = _loc6_.defenceUnits[_loc9_];
                     if(_loc8_.data.buffAvailable)
                     {
                        if((_loc8_.position.point.x - param1.x) * (_loc8_.position.point.x - param1.x) + (_loc8_.position.point.y - param1.y) * (_loc8_.position.point.y - param1.y) <= radius * radius)
                        {
                           _loc8_.filterManager.addFilter(WomFilters.PURPLE_FILTER);
                           units.push(_loc8_);
                        }
                     }
                     _loc9_--;
                  }
               }
               _loc7_++;
            }
            _loc10_++;
         }
      }
      
      override public function resetCollusionFilters() : void
      {
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc5_:* = 0;
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc6_ = units.length - 1;
         while(_loc6_ >= 0)
         {
            units[_loc6_].filterManager.removeFilter(WomFilters.PURPLE_FILTER);
            (units[_loc6_] as Unit).data.calculateStats();
            _loc6_--;
         }
         if(deployed)
         {
            indexList = new Vector.<Number>();
            _loc1_ = (position.x - radius) / 10;
            _loc4_ = (position.x + radius) / 10;
            _loc2_ = (position.y - radius) / 10;
            _loc3_ = (position.y + radius) / 10;
            if(_loc1_ < 0)
            {
               _loc1_--;
            }
            if(_loc4_ > 0)
            {
               _loc4_++;
            }
            if(_loc2_ < 0)
            {
               _loc2_--;
            }
            if(_loc3_ > 0)
            {
               _loc3_++;
            }
            _loc7_ = _loc1_;
            while(_loc7_ <= _loc4_)
            {
               _loc5_ = _loc2_;
               while(_loc5_ <= _loc3_)
               {
                  indexList.push((_loc7_ << 10) + (_loc5_ << 0));
                  _loc5_++;
               }
               _loc7_++;
            }
         }
      }
   }
}

