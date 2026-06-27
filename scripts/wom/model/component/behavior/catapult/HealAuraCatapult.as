package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.dto.combat.CatapultInfo;
   
   public class HealAuraCatapult extends BaseCatapult
   {
      
      private var units:Vector.<Unit>;
      
      private var totalHealGoal:Number;
      
      private var wait:Number;
      
      private var spendTime:Number;
      
      private var indexList:Vector.<Number>;
      
      private var healAuraActive:Boolean;
      
      public function HealAuraCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxMightyRage").soundAsset.sound;
         units = new Vector.<Unit>();
         totalHealGoal = catapultDIO.effectValues[0].effectValuesPerStage[catapultInfo.size];
         spendTime = 0;
         wait = 60;
      }
      
      override public function update() : void
      {
         spendTime += sync.precise;
         var _temp_2:* = §§findproperty(wait);
         if((wait = wait - sync.precise) > 0)
         {
            return;
         }
         wait = 60;
         if(healAuraActive)
         {
            duration -= spendTime;
            if(duration < 0 && healAuraActive)
            {
               healAuraActive = false;
            }
            heal(totalHealGoal);
         }
         else
         {
            removeEffectAreaCircle();
            disable();
         }
         spendTime -= 60;
      }
      
      private function heal(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc2_:BattleField = null;
         var _loc5_:int = 0;
         var _loc3_:Unit = null;
         _loc5_ = 0;
         while(_loc5_ < indexList.length)
         {
            _loc2_ = battleManager.battleFieldControl.battleFields[indexList[_loc5_]];
            if(_loc2_)
            {
               _loc4_ = _loc2_.units.length - 1;
               while(_loc4_ >= 0)
               {
                  _loc3_ = _loc2_.units[_loc4_];
                  if((_loc3_.position.point.x - position.x) * (_loc3_.position.point.x - position.x) + (_loc3_.position.point.y - position.y) * (_loc3_.position.point.y - position.y) <= radius * radius)
                  {
                     var _loc6_:WorkerThread;
                     if(_loc3_.data.info.healthPoints > 0 && _loc3_.data.info.healthPoints < (_loc6_ = _loc3_.data.maxHealthPoint)._value)
                     {
                        _loc3_.underAttack.heal(param1);
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
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         super.deployCatapult(param1);
         healAuraActive = true;
         drawEffectAreaCircle();
         enable();
         var _loc2_:int = (position.x - radius) / 10;
         var _loc5_:int = (position.x + radius) / 10;
         var _loc3_:int = (position.y - radius) / 10;
         var _loc4_:int = (position.y + radius) / 10;
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
         indexList = new Vector.<Number>();
         _loc7_ = _loc2_;
         while(_loc7_ <= _loc5_)
         {
            _loc6_ = _loc3_;
            while(_loc6_ <= _loc4_)
            {
               indexList.push((_loc7_ << 10) + (_loc6_ << 0));
               _loc6_++;
            }
            _loc7_++;
         }
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
            units[_loc9_].filterManager.removeFilter(WomFilters.GRAY_FILTER);
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
                  _loc9_ = _loc6_.units.length - 1;
                  while(_loc9_ >= 0)
                  {
                     _loc8_ = _loc6_.units[_loc9_];
                     if(_loc8_.data.buffAvailable)
                     {
                        if((_loc8_.position.point.x - param1.x) * (_loc8_.position.point.x - param1.x) + (_loc8_.position.point.y - param1.y) * (_loc8_.position.point.y - param1.y) <= radius * radius)
                        {
                           _loc8_.filterManager.addFilter(WomFilters.GRAY_FILTER);
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
         var _loc1_:int = 0;
         _loc1_ = units.length - 1;
         while(_loc1_ >= 0)
         {
            units[_loc1_].filterManager.removeFilter(WomFilters.GRAY_FILTER);
            (units[_loc1_] as Unit).data.calculateStats();
            _loc1_--;
         }
      }
   }
}

