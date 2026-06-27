package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.cuckoo.game.Layer;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.behavior.battle.underatack.UnderAttackBuilding;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.entity.gamesprite.Drop;
   import wom.model.component.structure.BattleField;
   import wom.model.dto.combat.CatapultInfo;
   
   public class RainingTypeCatapault extends BaseCatapult
   {
      
      public static const DROP_DISPOSAL_TIME:int = 60;
      
      public static const DROP_DISTANCE_X:int = 300;
      
      public static const DROP_DISTANCE_Y:int = 900;
      
      private const CHECK_INTERVAL:int = 6;
      
      public var collidedEntities:Dictionary;
      
      public var buildingsToAttack:Vector.<Building>;
      
      private var throwingEnabled:Boolean;
      
      protected var hittingEnabled:Boolean;
      
      private var wait:Number;
      
      protected var offset:Point;
      
      protected var drops:Vector.<Drop>;
      
      private var totalDamageGoal:Number;
      
      private var hitPerFrame:Number;
      
      private var weightOfNextHit:Number;
      
      private var WALL_DAMAGE_MODIFIER:Number = 0.46;
      
      public function RainingTypeCatapault(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         wait = 6;
         drops = new Vector.<Drop>();
         totalDamageGoal = catapultDIO.effectValues[0].effectValuesPerStage[catapultInfo.size];
         if(catapultInfo.size == catapultDIO.maxStage - 1)
         {
            switch(catapultInfo.type - 1)
            {
               case 0:
                  WALL_DAMAGE_MODIFIER = 0.26;
                  break;
               case 1:
                  WALL_DAMAGE_MODIFIER = 0.3;
            }
         }
         hitPerFrame = totalDamageGoal / duration;
         weightOfNextHit = 0;
      }
      
      override public function update() : void
      {
         var _loc9_:int = 0;
         var _loc1_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Point3 = null;
         var _loc7_:Point3 = null;
         var _loc4_:Drop = null;
         var _loc6_:Number = NaN;
         var _loc2_:Number = NaN;
         handleDrops();
         if(throwingEnabled)
         {
            _loc9_ = 0;
            while(_loc9_ <= catapultInfo.size)
            {
               _loc1_ = Math.random() * 2 * 3.141592653589793;
               _loc3_ = Math.random() + Math.random();
               _loc3_ = (_loc3_ > 1 ? 2 - _loc3_ : _loc3_) * radius;
               _loc8_ = new Point3(position.x + _loc3_ * Math.cos(_loc1_),position.y + _loc3_ * Math.sin(_loc1_));
               _loc7_ = new Point3();
               womRoot.projection.transform(_loc8_,_loc7_);
               _loc7_.x -= offset.x;
               _loc7_.y -= offset.y;
               _loc4_ = new Drop(womRoot,new Point3(_loc7_.x - 300,_loc7_.y - 900),_loc7_,getAssetId());
               womRoot.addChild(_loc4_);
               _loc4_.init();
               (womRoot.layers[4] as Layer).add(_loc4_);
               drops.push(_loc4_);
               _loc9_++;
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
            _loc6_ = weightOfNextHit * hitPerFrame;
            _loc6_ = _loc6_ > totalDamageGoal ? totalDamageGoal : _loc6_;
            totalDamageGoal -= _loc6_;
            weightOfNextHit = 0;
            _loc2_ = _loc6_ * WALL_DAMAGE_MODIFIER;
            for each(var _loc5_ in buildingsToAttack)
            {
               _loc5_.underAttack.hit(_loc5_.data.buildingTypeDIO.id == 41 ? _loc2_ : _loc6_,0,false,true);
            }
         }
         if(drops.length == 0 && !throwingEnabled)
         {
            disable();
         }
      }
      
      protected function hitLastDamage() : void
      {
         var _loc3_:Number = totalDamageGoal;
         var _loc1_:Number = _loc3_ * WALL_DAMAGE_MODIFIER;
         for each(var _loc2_ in buildingsToAttack)
         {
            _loc2_.underAttack.hit(_loc2_.data.buildingTypeDIO.id == 41 ? _loc1_ : _loc3_,0,false,true);
         }
         if(soundContainer)
         {
            sfx.catapultFinished(soundContainer);
            soundContainer = null;
         }
         removeEffectAreaCircle();
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
         var _loc10_:* = 0;
         var _loc9_:* = 0;
         var _loc7_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Boolean = false;
         var _loc4_:Building = null;
         var _loc18_:Dictionary = new Dictionary();
         var _loc2_:int = (param1.x - radius) / 10;
         var _loc8_:int = (param1.x + radius) / 10;
         var _loc3_:int = (param1.y - radius) / 10;
         var _loc14_:int = (param1.y + radius) / 10;
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
         if(_loc14_ > 0)
         {
            _loc14_++;
         }
         var _loc17_:BattleField = null;
         _loc10_ = _loc2_;
         while(_loc10_ <= _loc8_)
         {
            _loc9_ = _loc3_;
            while(_loc9_ <= _loc14_)
            {
               _loc17_ = battleManager.battleFieldControl.battleFields[(_loc10_ << 10) + (_loc9_ << 0)];
               if(_loc17_)
               {
                  for each(_loc4_ in _loc17_.buildings)
                  {
                     if(!_loc4_.data.buildingTypeDIO.indestructable && _loc4_.data.buildingInfo.healthPoint > 0)
                     {
                        if(!_loc18_[_loc4_.id])
                        {
                           _loc7_ = _loc4_.position.point.x + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc11_ = _loc4_.position.point.y + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc5_ = (_loc7_ - param1.x) * (_loc7_ - param1.x) + (_loc11_ - param1.y) * (_loc11_ - param1.y);
                           _loc15_ = radius + (_loc4_.data.buildingTypeDIO.baseSize >> 1);
                           _loc16_ = _loc5_ <= _loc15_ * _loc15_;
                           if(!_loc16_)
                           {
                              _loc5_ = Math.sqrt(_loc5_);
                              _loc13_ = radius / _loc5_;
                              _loc6_ = _loc13_ * (_loc7_ - param1.x) + param1.x;
                              _loc12_ = _loc13_ * (_loc11_ - param1.y) + param1.y;
                           }
                           if(_loc16_ || _loc6_ > _loc4_.position.point.x && _loc6_ < _loc4_.position.point.x + _loc4_.data.buildingTypeDIO.baseSize && _loc12_ > _loc4_.position.point.y && _loc12_ < _loc4_.position.point.y + _loc4_.data.buildingTypeDIO.baseSize)
                           {
                              _loc18_[_loc4_.id] = _loc4_;
                              _loc4_.composite.filterManager.addFilter(WomFilters.GRAY_FILTER);
                           }
                        }
                     }
                  }
               }
               _loc9_++;
            }
            _loc10_++;
         }
         if(collidedEntities)
         {
            for each(_loc4_ in collidedEntities)
            {
               if(!(_loc4_.id in _loc18_))
               {
                  _loc4_.composite.filterManager.removeFilter(WomFilters.GRAY_FILTER);
               }
            }
         }
         collidedEntities = _loc18_;
      }
      
      override public function resetCollusionFilters() : void
      {
         buildingsToAttack = new Vector.<Building>();
         if(collidedEntities)
         {
            for each(var _loc1_ in collidedEntities)
            {
               _loc1_.filterManager.removeFilter(WomFilters.GRAY_FILTER);
               buildingsToAttack.push(_loc1_);
               if(!_loc1_.underAttack)
               {
                  _loc1_.componentManager.add(_loc1_.underAttack = new UnderAttackBuilding(battleManager));
                  _loc1_.underAttack.init();
               }
            }
         }
         buildingsToAttack.sort(sortBuildings);
      }
      
      private function sortBuildings(param1:Building, param2:Building) : int
      {
         return param1.data.buildingInfo.instanceId < param2.data.buildingInfo.instanceId ? -1 : 1;
      }
      
      protected function handleDrops() : void
      {
      }
      
      protected function getAssetId() : String
      {
         return "";
      }
   }
}

