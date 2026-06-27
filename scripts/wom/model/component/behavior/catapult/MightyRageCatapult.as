package wom.model.component.behavior.catapult
{
   import flash.geom.Point;
   import peak.cuckoo.game.GameSprite;
   import peak.cuckoo.game.dto.Point3;
   import wom.model.component.attribute.view.WomFilters;
   import wom.model.component.behavior.battle.BattleManager;
   import wom.model.component.entity.gamesprite.Unit;
   import wom.model.component.structure.BattleField;
   import wom.model.dto.CatapultEffectTypeDTO;
   import wom.model.dto.combat.CatapultInfo;
   
   public class MightyRageCatapult extends BaseCatapult
   {
      
      private var units:Vector.<GameSprite> = new Vector.<GameSprite>();
      
      private var buffDispanserActive:Boolean;
      
      private var armorModifier:Number;
      
      private var speedModifier:Number;
      
      private var buffTime:Number;
      
      private var buffUnits:Vector.<Unit>;
      
      private var spendTime:Number;
      
      private var wait:int;
      
      public function MightyRageCatapult(param1:BattleManager, param2:CatapultInfo)
      {
         super(param1,param2);
      }
      
      override public function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:CatapultEffectTypeDTO = null;
         super.init();
         catapultSound = sfx.assetRepository.getSoundAssetReference("SfxMightyRage").soundAsset.sound;
         buffUnits = new Vector.<Unit>();
         spendTime = 0;
         wait = 60;
         _loc2_ = 0;
         while(_loc2_ < catapultDIO.effectValues.length)
         {
            _loc1_ = catapultDIO.effectValues[_loc2_];
            switch(_loc1_.effectType)
            {
               case "speed_buff":
                  speedModifier = _loc1_.effectValuesPerStage[catapultInfo.size];
                  break;
               case "armor_buff":
                  armorModifier = _loc1_.effectValuesPerStage[catapultInfo.size];
                  break;
               case "buff_time":
                  buffTime = _loc1_.effectValuesPerStage[catapultInfo.size];
            }
            _loc2_++;
         }
      }
      
      override public function update() : void
      {
         var _loc5_:int = 0;
         var _loc3_:Unit = null;
         var _loc11_:* = 0;
         var _loc8_:* = 0;
         var _loc10_:int = 0;
         var _loc1_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc7_:BattleField = null;
         var _loc9_:Unit = null;
         spendTime += sync.precise;
         var _temp_2:* = §§findproperty(wait);
         if((wait = wait - sync.precise) > 0)
         {
            return;
         }
         wait = 60;
         _loc5_ = buffUnits.length - 1;
         while(_loc5_ >= 0)
         {
            _loc3_ = buffUnits[_loc5_];
            _loc3_.data.catapultBuff -= spendTime;
            if(_loc3_.data.catapultBuff <= 0)
            {
               _loc3_.data.armorBuffModifier /= armorModifier;
               _loc3_.data.speedBuffModifier /= speedModifier;
               _loc3_.data.catapultBuff = 0;
               _loc3_.data.calculateStats();
               buffUnits.splice(buffUnits.indexOf(_loc3_),1);
            }
            _loc5_--;
         }
         if(buffDispanserActive)
         {
            duration -= spendTime;
            if(duration < 0)
            {
               buffDispanserActive = false;
               removeEffectAreaCircle();
            }
            _loc1_ = (position.x - radius) / 10;
            _loc6_ = (position.x + radius) / 10;
            _loc2_ = (position.y - radius) / 10;
            _loc4_ = (position.y + radius) / 10;
            if(_loc1_ < 0)
            {
               _loc1_--;
            }
            if(_loc6_ > 0)
            {
               _loc6_++;
            }
            if(_loc2_ < 0)
            {
               _loc2_--;
            }
            if(_loc4_ > 0)
            {
               _loc4_++;
            }
            _loc11_ = _loc1_;
            while(_loc11_ <= _loc6_)
            {
               _loc8_ = _loc2_;
               while(_loc8_ <= _loc4_)
               {
                  _loc7_ = battleManager.battleFieldControl.battleFields[(_loc11_ << 10) + (_loc8_ << 0)];
                  if(_loc7_)
                  {
                     _loc10_ = _loc7_.units.length - 1;
                     while(_loc10_ >= 0)
                     {
                        _loc9_ = _loc7_.units[_loc10_];
                        if(_loc9_.data.buffAvailable)
                        {
                           if((_loc9_.position.point.x - position.x) * (_loc9_.position.point.x - position.x) + (_loc9_.position.point.y - position.y) * (_loc9_.position.point.y - position.y) <= radius * radius)
                           {
                              if(_loc9_.data.catapultBuff <= 0)
                              {
                                 _loc9_.data.armorBuffModifier *= armorModifier;
                                 _loc9_.data.speedBuffModifier *= speedModifier;
                                 _loc9_.data.catapultBuff = buffTime;
                                 _loc9_.data.calculateStats();
                                 buffUnits.push(_loc9_);
                              }
                              else
                              {
                                 _loc9_.data.catapultBuff = buffTime;
                              }
                           }
                        }
                        _loc10_--;
                     }
                  }
                  _loc8_++;
               }
               _loc11_++;
            }
         }
         else if(buffUnits.length == 0)
         {
            disable();
         }
         spendTime = 0;
      }
      
      override public function deployCatapult(param1:Point) : void
      {
         super.deployCatapult(param1);
         buffDispanserActive = true;
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

