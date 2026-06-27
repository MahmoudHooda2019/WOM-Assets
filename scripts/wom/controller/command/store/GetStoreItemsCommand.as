package wom.controller.command.store
{
   import peak.i18n.PText;
   import peak.i18n.i18nN;
   import peak.util.NumberUtil;
   import wom.controller.PCommand;
   import wom.controller.event.ui.GetStoreItemsEvent;
   import wom.controller.event.ui.StoreItemsReadyEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.WorkerTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.store.ItemCooldownDurationInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.model.game.store.ItemEffectType;
   import wom.model.game.store.StoreItemCategory;
   import wom.model.game.store.StoreItemCurrencyType;
   import wom.model.game.store.StoreItemInfo;
   import wom.model.game.store.StoreUtil;
   
   public class GetStoreItemsCommand extends PCommand
   {
      
      [Inject]
      public var event:GetStoreItemsEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function GetStoreItemsCommand()
      {
         super();
      }
      
      private static function addResourceItems(param1:Vector.<StoreItemInfo>, param2:String, param3:int, param4:int, param5:int) : void
      {
         var _loc11_:Number = 0.1;
         var _loc10_:Number = 0.5;
         var _loc6_:int = param4 + param5 * _loc11_ << 0;
         var _loc9_:int = param4 + param5 * _loc10_ << 0;
         var _loc12_:Boolean = param4 >= param5;
         var _loc7_:Boolean = _loc6_ > param5;
         var _loc13_:String;
         var _loc14_:String;
         var _loc15_:String;
         param1.push(new StoreItemInfo(param3,param2 + "TouchUp",getName(param3),StoreItemCurrencyType.GOLD,getDescription(param3,NumberUtil.format(_loc6_)),_loc7_,StoreUtil.resourcePrice(param5 * _loc11_ << 0),_loc12_ ? (_loc13_ = "ui.windows.store.availability.storagefull",peak.i18n.PText.INSTANCE.getText0(_loc13_)) : (_loc7_ ? (_loc14_ = "ui.windows.store.availability.exceedscapacity",peak.i18n.PText.INSTANCE.getText0(_loc14_)) : (_loc15_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc15_)))));
         param3++;
         var _loc8_:Boolean = _loc9_ > param5;
         var _loc16_:String;
         var _loc17_:String;
         var _loc18_:String;
         param1.push(new StoreItemInfo(param3,param2 + "Boost",getName(param3),StoreItemCurrencyType.GOLD,getDescription(param3,NumberUtil.format(_loc9_)),_loc8_,StoreUtil.resourcePrice(param5 * _loc10_ << 0),_loc12_ ? (_loc16_ = "ui.windows.store.availability.storagefull",peak.i18n.PText.INSTANCE.getText0(_loc16_)) : (_loc8_ ? (_loc17_ = "ui.windows.store.availability.exceedscapacity",peak.i18n.PText.INSTANCE.getText0(_loc17_)) : (_loc18_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc18_)))));
         param3++;
         var _loc19_:String;
         var _loc20_:String;
         param1.push(new StoreItemInfo(param3,param2 + "FillUp",getName(param3),StoreItemCurrencyType.GOLD,getDescription(param3,NumberUtil.format(param5)),_loc12_,_loc12_ ? 0 : StoreUtil.resourcePrice(param5 - param4),_loc12_ ? (_loc19_ = "ui.windows.store.availability.storagefull",peak.i18n.PText.INSTANCE.getText0(_loc19_)) : (_loc20_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc20_))));
      }
      
      public static function getName(param1:int, ... rest) : String
      {
         return i18nN("ui.windows.store.items." + param1 + ".name",rest);
      }
      
      public static function getDescription(param1:int, ... rest) : String
      {
         return i18nN("ui.windows.store.items." + param1 + ".desc",rest);
      }
      
      override public function execute() : void
      {
         switch(event.category)
         {
            case StoreItemCategory.CONSTRUCTION:
               generateStoreConstructionItems();
               break;
            case StoreItemCategory.RESOURCE:
               generateStoreResourceItems();
               break;
            case StoreItemCategory.SPEEDUPS:
               generateStoreSpeedupsItems();
               break;
            case StoreItemCategory.COMBAT:
               generateStoreCombatItems();
               break;
            case StoreItemCategory.BUILDING_SPEEDUPS:
               generateStoreSpeedupsItems(true);
               break;
            case StoreItemCategory.EVENT:
               generateEventStoreItems();
         }
      }
      
      private function generateStoreConstructionItems() : void
      {
         var _loc6_:int = 0;
         var _loc9_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc12_:Vector.<StoreItemInfo> = new Vector.<StoreItemInfo>();
         var _loc1_:WorkerTypeDIO = domainInfo.getWorker();
         if(city.numberOfWorkers < 5)
         {
            var _temp_10:* = _loc12_;
            var _temp_9:* = §§findproperty(StoreItemInfo);
            var _temp_8:* = 1001;
            var _temp_7:* = "ExtraWorker";
            var _temp_6:* = getName(1001);
            var _temp_5:* = StoreItemCurrencyType.GOLD;
            var _temp_4:* = getDescription(1001);
            var _temp_3:* = false;
            var _temp_2:* = _loc1_.calculateGoldToBuy(city.numberOfWorkers,city.workerStaffStatus.length);
            var _temp_1:* = "ui.windows.store.availability.buymore";
            var _loc16_:Number = 5 - city.numberOfWorkers;
            var _loc17_:String = _temp_1;
            _temp_10.push(new StoreItemInfo(_temp_8,_temp_7,_temp_6,_temp_5,_temp_4,_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc17_,_loc16_)));
         }
         var _loc7_:Boolean = 1002 in userInfo.storeItemCooldownDurations;
         var _loc18_:String;
         var _loc19_:String;
         _loc12_.push(new StoreItemInfo(1002,"FasterUpgrade",getName(1002),StoreItemCurrencyType.GOLD,getDescription(1002),_loc7_,225,_loc7_ ? (_loc18_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc18_)) : (_loc19_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc19_)),null,-1,getActiveItemEffectInfo(ItemEffectType.FASTER_UPGRADE),getCooldownDuration(1002)));
         var _loc13_:Array = new Array(0,0,0,0);
         for each(var _loc11_ in city.buildings)
         {
            if(_loc11_.buildingTypeId == 41)
            {
               _loc13_[_loc11_.level - 1]++;
            }
         }
         var _loc3_:int = 1004;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc9_ = 0;
            _loc4_ = 0;
            while(_loc4_ < _loc6_ + 1)
            {
               _loc9_ += _loc13_[_loc4_];
               _loc4_++;
            }
            _loc8_ = _loc3_ + _loc6_;
            _loc12_.push(new StoreItemInfo(_loc8_,"WallUpgrade" + (String(_loc6_ + 1)),getName(_loc8_),StoreItemCurrencyType.GOLD,getDescription(_loc8_,_loc9_),_loc9_ == 0,StoreUtil.calculateWallUpgradePrice(_loc6_ + 1,_loc13_),""));
            _loc6_++;
         }
         var _loc10_:int = city.dimensions.numberOfColumns;
         if(_loc10_ == 200 || _loc10_ == 220 || _loc10_ == 242 || _loc10_ == 268 || _loc10_ == 295)
         {
            _loc5_ = _loc10_ == 200 ? 50 : (_loc10_ == 220 ? 100 : (_loc10_ == 242 ? 150 : (_loc10_ == 268 ? 200 : 250)));
            _loc2_ = _loc10_ == 200 ? 4 : (_loc10_ == 220 ? 3 : (_loc10_ == 242 ? 2 : (_loc10_ == 268 ? 1 : 0)));
            var _temp_28:* = _loc12_;
            var _temp_27:* = §§findproperty(StoreItemInfo);
            var _temp_26:* = 1003;
            var _temp_25:* = "CityExpansion";
            var _temp_24:* = getName(1003);
            var _temp_23:* = StoreItemCurrencyType.GOLD;
            var _temp_22:* = getDescription(1003);
            var _temp_21:* = false;
            var _temp_20:* = _loc5_;
            var _temp_19:* = "ui.windows.store.availability.buymore";
            var _loc20_:int = _loc2_;
            var _loc21_:String = _temp_19;
            _temp_28.push(new StoreItemInfo(_temp_26,_temp_25,_temp_24,_temp_23,_temp_22,_temp_21,_temp_20,peak.i18n.PText.INSTANCE.getText1(_loc21_,_loc20_)));
         }
         else if(_loc10_ == 324)
         {
            var _temp_37:* = _loc12_;
            var _temp_36:* = §§findproperty(StoreItemInfo);
            var _temp_35:* = 1003;
            var _temp_34:* = "CityExpansion";
            var _temp_33:* = getName(1003);
            var _temp_32:* = StoreItemCurrencyType.UNKNOWN;
            var _temp_31:* = getDescription(1003);
            var _temp_30:* = true;
            var _temp_29:* = 0;
            var _loc22_:String = "ui.windows.store.availability.cantbuy";
            _temp_37.push(new StoreItemInfo(_temp_35,_temp_34,_temp_33,_temp_32,_temp_31,_temp_30,_temp_29,peak.i18n.PText.INSTANCE.getText0(_loc22_)));
         }
         dispatch(new StoreItemsReadyEvent("storeItemsReady",_loc12_,event.category));
      }
      
      private function generateStoreResourceItems() : void
      {
         var _loc3_:Vector.<StoreItemInfo> = new Vector.<StoreItemInfo>();
         var _loc5_:int = city.totalResourceCapacity >> 2;
         var _loc2_:int = int(city.resourceAmounts[ResourceType.LUMBER.id]);
         var _loc1_:int = int(city.resourceAmounts[ResourceType.STONE.id]);
         var _loc6_:int = int(city.resourceAmounts[ResourceType.MIGHT.id]);
         var _loc4_:int = int(city.resourceAmounts[ResourceType.IRON.id]);
         addResourceItems(_loc3_,"Lumber",3001,_loc2_,_loc5_);
         addResourceItems(_loc3_,"Stone",3004,_loc1_,_loc5_);
         addResourceItems(_loc3_,"Might",3007,_loc6_,_loc5_);
         addResourceItems(_loc3_,"Iron",3010,_loc4_,_loc5_);
         var _temp_10:* = _loc3_;
         var _temp_9:* = §§findproperty(StoreItemInfo);
         var _temp_8:* = 3013;
         var _temp_7:* = "StockpileBoost";
         var _temp_6:* = getName(3013);
         var _temp_5:* = userInfo.stockpileBoostCount < 10 ? StoreItemCurrencyType.GOLD : StoreItemCurrencyType.UNKNOWN;
         var _temp_4:* = getDescription(3013,NumberUtil.format(StoreUtil.calculateNextBoostedResourceCapacity(city.totalResourceCapacity,userInfo.stockpileBoostCount) >> 2));
         var _temp_3:* = userInfo.stockpileBoostCount >= 10;
         var _temp_2:* = userInfo.stockpileBoostCount * 50 + 50;
         var _temp_1:* = "ui.windows.store.availability.buymore";
         var _loc7_:Number = 10 - userInfo.stockpileBoostCount;
         var _loc8_:String = _temp_1;
         _temp_10.push(new StoreItemInfo(_temp_8,_temp_7,_temp_6,_temp_5,_temp_4,_temp_3,_temp_2,peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_)));
         dispatch(new StoreItemsReadyEvent("storeItemsReady",_loc3_,event.category));
      }
      
      private function generateStoreSpeedupsItems(param1:Boolean = false) : void
      {
         var _loc4_:Boolean = false;
         var _loc2_:Vector.<StoreItemInfo> = new Vector.<StoreItemInfo>();
         var _loc3_:Number = -1;
         if(event.instanceId != -1)
         {
            _loc3_ = calculateRemainingDurationOfJobRelatedWithBuilding();
         }
         if(_loc3_ > 0)
         {
            if(_loc3_ <= 300000)
            {
               var _temp_9:* = _loc2_;
               var _temp_8:* = §§findproperty(StoreItemInfo);
               var _temp_7:* = 2003;
               var _temp_6:* = "FreeFinish";
               var _temp_5:* = getName(2003);
               var _temp_4:* = StoreItemCurrencyType.FREE;
               var _temp_3:* = getDescription(2003);
               var _temp_2:* = false;
               var _temp_1:* = 0;
               var _loc5_:String = "ui.windows.store.availability.buy";
               _temp_9.push(new StoreItemInfo(_temp_7,_temp_6,_temp_5,_temp_4,_temp_3,_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc5_),null,event.instanceId));
            }
            else
            {
               var _temp_18:* = _loc2_;
               var _temp_17:* = §§findproperty(StoreItemInfo);
               var _temp_16:* = 2007;
               var _temp_15:* = "FinishNow";
               var _temp_14:* = getName(2007);
               var _temp_13:* = StoreItemCurrencyType.GOLD;
               var _temp_12:* = getDescription(2007);
               var _temp_11:* = _loc3_ <= 300000;
               var _temp_10:* = calculatePriceOfJobRelatedWithBuilding(_loc3_ / 1000 << 0);
               var _loc6_:String = "ui.windows.store.availability.buy";
               _temp_18.push(new StoreItemInfo(_temp_16,_temp_15,_temp_14,_temp_13,_temp_12,_temp_11,_temp_10,peak.i18n.PText.INSTANCE.getText0(_loc6_),null,event.instanceId));
            }
            _loc4_ = _loc3_ < 300000;
            var _loc7_:String;
            var _loc8_:String;
            _loc2_.push(new StoreItemInfo(2004,"Cut30Min",getName(2004),StoreItemCurrencyType.RECON_POINTS,getDescription(2004),_loc4_,30,_loc4_ ? (_loc7_ = "ui.windows.store.availability.lesserremaining30minutes",peak.i18n.PText.INSTANCE.getText0(_loc7_)) : (_loc8_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc8_)),null,event.instanceId));
            if(!param1)
            {
               addSpeedupBoostItems(_loc2_);
            }
         }
         else if(!param1)
         {
            addSpeedupBoostItems(_loc2_);
         }
         dispatch(new StoreItemsReadyEvent("storeItemsReady",_loc2_,event.category));
      }
      
      private function addSpeedupBoostItems(param1:Vector.<StoreItemInfo>) : void
      {
         var _loc8_:int = determineDamagedBuildingCount();
         var _loc3_:Boolean = _loc8_ > 0;
         if(_loc3_)
         {
            var _loc10_:String;
            param1.push(new StoreItemInfo(2008,"RepairAllBuildings",getName(2008),_loc3_ ? StoreItemCurrencyType.GOLD : StoreItemCurrencyType.UNKNOWN,_loc3_ ? getDescription(2008,_loc8_) : (_loc10_ = "ui.windows.store.items.2008.descnodamaged",peak.i18n.PText.INSTANCE.getText0(_loc10_)),!_loc3_,_loc3_ ? calculateDamagedBuildingsRepairCost() : 0,""));
         }
         var _loc4_:Boolean = 2012 in userInfo.storeItemCooldownDurations;
         var _loc9_:Boolean = 2011 in userInfo.storeItemCooldownDurations || _loc4_;
         var _loc6_:Boolean = 2010 in userInfo.storeItemCooldownDurations || _loc9_;
         var _loc7_:Boolean = 2009 in userInfo.storeItemCooldownDurations || _loc6_;
         var _loc11_:String;
         var _loc12_:String;
         var _loc13_:String;
         param1.push(new StoreItemInfo(2009,"QuickHiring",getName(2009),StoreItemCurrencyType.RECON_POINTS,getDescription(2009),_loc7_,150,_loc7_ ? (_loc6_ ? (_loc11_ = "ui.windows.store.availability.higherbonusalreadypurchased",peak.i18n.PText.INSTANCE.getText0(_loc11_)) : (_loc12_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc12_))) : (_loc13_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc13_)),null,-1,_loc6_ ? null : getItemEffectInfo(ItemEffectType.MERCENARY_DAMAGE_BOOST,10),_loc6_ ? null : getCooldownDuration(2009)));
         var _loc14_:String;
         var _loc15_:String;
         var _loc16_:String;
         param1.push(new StoreItemInfo(2010,"SwiftHiring",getName(2010),StoreItemCurrencyType.GOLD,getDescription(2010),_loc6_,125,_loc6_ ? (_loc9_ ? (_loc14_ = "ui.windows.store.availability.higherbonusalreadypurchased",peak.i18n.PText.INSTANCE.getText0(_loc14_)) : (_loc15_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc15_))) : (_loc16_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc16_)),null,-1,_loc9_ ? null : getItemEffectInfo(ItemEffectType.MERCENARY_DAMAGE_BOOST,10),_loc9_ ? null : getCooldownDuration(2010)));
         var _loc17_:String;
         var _loc18_:String;
         param1.push(new StoreItemInfo(2012,"ExpressHiring",getName(2012),StoreItemCurrencyType.GOLD,getDescription(2012),_loc4_,150,_loc4_ ? (_loc17_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc17_)) : (_loc18_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc18_)),null,-1,getItemEffectInfo(ItemEffectType.MERCENARY_DAMAGE_BOOST,10),getCooldownDuration(2012)));
         var _loc2_:Boolean = 2001 in userInfo.storeItemCooldownDurations;
         var _loc19_:String;
         var _loc20_:String;
         param1.push(new StoreItemInfo(2001,"ProductionBoost1",getName(2001),StoreItemCurrencyType.RECON_POINTS,getDescription(2001),_loc2_,80,_loc2_ ? (_loc19_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc19_)) : (_loc20_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc20_)),null,-1,getActiveItemEffectInfo(ItemEffectType.PRODUCTION_BOOST),getCooldownDuration(2001)));
         var _loc5_:Boolean = 2002 in userInfo.storeItemCooldownDurations;
         var _loc21_:String;
         var _loc22_:String;
         param1.push(new StoreItemInfo(2002,"ProductionBoost2",getName(2002),StoreItemCurrencyType.GOLD,getDescription(2002),_loc5_,200,_loc5_ ? (_loc21_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc21_)) : (_loc22_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc22_)),null,-1,getActiveItemEffectInfo(ItemEffectType.PRODUCTION_BOOST),getCooldownDuration(2002)));
         if(!_loc3_)
         {
            var _loc23_:String;
            param1.push(new StoreItemInfo(2008,"RepairAllBuildings",getName(2008),_loc3_ ? StoreItemCurrencyType.GOLD : StoreItemCurrencyType.UNKNOWN,_loc3_ ? getDescription(2008,_loc8_) : (_loc23_ = "ui.windows.store.items.2008.descnodamaged",peak.i18n.PText.INSTANCE.getText0(_loc23_)),!_loc3_,_loc3_ ? calculateDamagedBuildingsRepairCost() : 0,""));
         }
      }
      
      private function calculateDamagedBuildingsRepairCost() : int
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc1_:Number = 0;
         for each(var _loc2_ in city.buildings)
         {
            _loc3_ = domainInfo.getBuilding(_loc2_.buildingTypeId);
            if(!_loc3_.isHealthy(_loc2_.level,_loc2_.healthPoint))
            {
               _loc5_ = _loc2_.level == 0 ? 0 : _loc2_.level - 1;
               _loc4_ = _loc3_.healthPointsPerLevel[_loc5_];
               _loc1_ += (_loc4_ - _loc2_.healthPoint) / _loc4_ * _loc3_.repairDurationsPerLevel[_loc5_];
            }
         }
         return StoreUtil.buildingPrice(0,_loc1_ / userInfo.serverSpeed);
      }
      
      private function determineDamagedBuildingCount() : int
      {
         var _loc2_:BuildingTypeDIO = null;
         var _loc3_:int = 0;
         for each(var _loc1_ in city.buildings)
         {
            _loc2_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
            if(!_loc2_.isHealthy(_loc1_.level,_loc1_.healthPoint))
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
      
      private function calculateRemainingDurationOfJobRelatedWithBuilding() : Number
      {
         for each(var _loc1_ in city.buildingRepairJobs)
         {
            if(_loc1_.instanceId == event.instanceId)
            {
               return _loc1_.jobCreationTime + _loc1_.durationRemaining - new Date().getTime();
            }
         }
         for each(var _loc2_ in city.buildingUpgradeJobs)
         {
            if(_loc2_.instanceId == event.instanceId)
            {
               return _loc2_.jobCreationTime + _loc2_.durationRemaining - new Date().getTime();
            }
         }
         for each(var _loc4_ in city.unitTrainJobs)
         {
            if(_loc4_.instanceId == event.instanceId)
            {
               return _loc4_.jobCreationTime + _loc4_.durationRemaining - new Date().getTime();
            }
         }
         if(city.activeRecruitJob)
         {
            for each(var _loc3_ in city.buildings)
            {
               if(_loc3_.instanceId == event.instanceId && _loc3_.buildingTypeId == 17)
               {
                  return city.activeRecruitJob.jobCreationTime + city.activeRecruitJob.durationRemaining - new Date().getTime();
               }
            }
         }
         return 0;
      }
      
      private function calculatePriceOfJobRelatedWithBuilding(param1:Number) : Number
      {
         for each(var _loc2_ in city.buildingRepairJobs)
         {
            if(_loc2_.instanceId == event.instanceId)
            {
               return StoreUtil.buildingPrice(0,param1 / userInfo.serverSpeed);
            }
         }
         for each(var _loc3_ in city.buildingUpgradeJobs)
         {
            if(_loc3_.instanceId == event.instanceId)
            {
               return StoreUtil.buildingPrice(0,param1 / userInfo.serverSpeed);
            }
         }
         for each(var _loc5_ in city.unitTrainJobs)
         {
            if(_loc5_.instanceId == event.instanceId)
            {
               return StoreUtil.mercenaryTrainAndRecruitPrice(0,param1 / userInfo.serverSpeed);
            }
         }
         if(city.activeRecruitJob)
         {
            for each(var _loc4_ in city.buildings)
            {
               if(_loc4_.instanceId == event.instanceId && _loc4_.buildingTypeId == 17)
               {
                  return StoreUtil.mercenaryTrainAndRecruitPrice(0,param1 / userInfo.serverSpeed);
               }
            }
         }
         return 0;
      }
      
      private function generateStoreCombatItems() : void
      {
         var _loc11_:Vector.<StoreItemInfo> = new Vector.<StoreItemInfo>();
         var _loc12_:ItemEffectInfo = getActiveItemEffectInfo(ItemEffectType.BATTLE_PROTECTION);
         var _loc14_:Boolean = false;
         for each(var _loc2_ in userInfo.storeItemEffects)
         {
            if(_loc2_.type == ItemEffectType.BEGINNER_PROTECTION)
            {
               _loc14_ = true;
            }
         }
         var _loc8_:Boolean = 4002 in userInfo.storeItemCooldownDurations || _loc14_;
         var _loc18_:String;
         var _loc19_:String;
         var _loc20_:String;
         var _loc21_:String;
         _loc11_.push(new StoreItemInfo(4002,"ShieldDaily",getName(4002),StoreItemCurrencyType.GOLD,getDescription(4002),_loc8_,32,_loc8_ ? (_loc14_ ? (_loc18_ = "ui.windows.store.availability.beginnerprotectionexists",peak.i18n.PText.INSTANCE.getText0(_loc18_)) : (_loc12_ ? (_loc19_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc19_)) : (_loc20_ = "ui.windows.store.availability.itemnotready",peak.i18n.PText.INSTANCE.getText0(_loc20_)))) : (_loc21_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc21_)),null,-1,_loc12_,getCooldownDuration(4002)));
         var _loc5_:Boolean = 4003 in userInfo.storeItemCooldownDurations || _loc14_;
         var _loc22_:String;
         var _loc23_:String;
         var _loc24_:String;
         var _loc25_:String;
         _loc11_.push(new StoreItemInfo(4003,"ShieldWeekly",getName(4003),StoreItemCurrencyType.GOLD,getDescription(4003),_loc5_,250,_loc5_ ? (_loc14_ ? (_loc22_ = "ui.windows.store.availability.beginnerprotectionexists",peak.i18n.PText.INSTANCE.getText0(_loc22_)) : (_loc12_ ? (_loc23_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc23_)) : (_loc24_ = "ui.windows.store.availability.itemnotready",peak.i18n.PText.INSTANCE.getText0(_loc24_)))) : (_loc25_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc25_)),null,-1,_loc12_,getCooldownDuration(4003)));
         var _loc7_:Boolean = 4004 in userInfo.storeItemCooldownDurations || _loc14_;
         var _loc26_:String;
         var _loc27_:String;
         var _loc28_:String;
         var _loc29_:String;
         _loc11_.push(new StoreItemInfo(4004,"ShieldMonthly",getName(4004),StoreItemCurrencyType.GOLD,getDescription(4004),_loc7_,1100,_loc7_ ? (_loc14_ ? (_loc26_ = "ui.windows.store.availability.beginnerprotectionexists",peak.i18n.PText.INSTANCE.getText0(_loc26_)) : (_loc12_ ? (_loc27_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc27_)) : (_loc28_ = "ui.windows.store.availability.itemnotready",peak.i18n.PText.INSTANCE.getText0(_loc28_)))) : (_loc29_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc29_)),null,-1,_loc12_,getCooldownDuration(4004)));
         var _loc9_:Boolean = 4006 in userInfo.storeItemCooldownDurations;
         var _loc4_:Boolean = 4005 in userInfo.storeItemCooldownDurations || 4006 in userInfo.storeItemCooldownDurations;
         var _loc30_:String;
         var _loc31_:String;
         var _loc32_:String;
         _loc11_.push(new StoreItemInfo(4005,"MercDamageBoost1",getName(4005),StoreItemCurrencyType.RECON_POINTS,getDescription(4005),_loc4_,150,_loc4_ ? (_loc9_ ? (_loc30_ = "ui.windows.store.availability.higherbonusalreadypurchased",peak.i18n.PText.INSTANCE.getText0(_loc30_)) : (_loc31_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc31_))) : (_loc32_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc32_)),null,-1,_loc9_ ? null : getItemEffectInfo(ItemEffectType.MERCENARY_DAMAGE_BOOST,10),_loc9_ ? null : getCooldownDuration(4005)));
         var _loc33_:String;
         var _loc34_:String;
         _loc11_.push(new StoreItemInfo(4006,"MercDamageBoost2",getName(4006),StoreItemCurrencyType.GOLD,getDescription(4006),_loc9_,100,_loc9_ ? (_loc33_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc33_)) : (_loc34_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc34_)),null,-1,getItemEffectInfo(ItemEffectType.MERCENARY_DAMAGE_BOOST,25),getCooldownDuration(4006)));
         var _loc15_:Boolean = 4007 in userInfo.storeItemCooldownDurations;
         var _loc35_:String;
         var _loc36_:String;
         _loc11_.push(new StoreItemInfo(4007,"MercHealthBoost",getName(4007),StoreItemCurrencyType.GOLD,getDescription(4007),_loc15_,100,_loc15_ ? (_loc35_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc35_)) : (_loc36_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc36_)),null,-1,getItemEffectInfo(ItemEffectType.MERCENARY_ARMOR_BOOST,30),getCooldownDuration(4005)));
         var _loc10_:Boolean = 4009 in userInfo.storeItemCooldownDurations;
         var _loc6_:Boolean = 4008 in userInfo.storeItemCooldownDurations || 4009 in userInfo.storeItemCooldownDurations;
         var _loc37_:String;
         var _loc38_:String;
         var _loc39_:String;
         _loc11_.push(new StoreItemInfo(4008,"MercSpeedBoost",getName(4008),StoreItemCurrencyType.RECON_POINTS,getDescription(4008),_loc6_,100,_loc6_ ? (_loc10_ ? (_loc37_ = "ui.windows.store.availability.higherbonusalreadypurchased",peak.i18n.PText.INSTANCE.getText0(_loc37_)) : (_loc38_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc38_))) : (_loc39_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc39_)),null,-1,_loc10_ ? null : getItemEffectInfo(ItemEffectType.MERCENARY_SPEED_BOOST,10),_loc10_ ? null : getCooldownDuration(4008)));
         var _loc40_:String;
         var _loc41_:String;
         _loc11_.push(new StoreItemInfo(4009,"MercSpeedBoost",getName(4009),StoreItemCurrencyType.GOLD,getDescription(4009),_loc10_,75,_loc10_ ? (_loc40_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc40_)) : (_loc41_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc41_)),null,-1,getItemEffectInfo(ItemEffectType.MERCENARY_SPEED_BOOST,25),getCooldownDuration(4009)));
         var _loc13_:Boolean = 4010 in userInfo.storeItemCooldownDurations;
         var _loc42_:String;
         var _loc43_:String;
         _loc11_.push(new StoreItemInfo(4010,"ExtraBarrackSpace1",getName(4010),StoreItemCurrencyType.RECON_POINTS,getDescription(4010),_loc13_,180,_loc13_ ? (_loc42_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc42_)) : (_loc43_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc43_)),null,-1,getItemEffectInfo(ItemEffectType.EXTRA_BARRACKS,10),getCooldownDuration(4010)));
         var _loc3_:Boolean = 4011 in userInfo.storeItemCooldownDurations;
         var _loc44_:String;
         var _loc45_:String;
         _loc11_.push(new StoreItemInfo(4011,"ExtraBarrackSpace2",getName(4011),StoreItemCurrencyType.GOLD,getDescription(4011),_loc3_,375,_loc3_ ? (_loc44_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc44_)) : (_loc45_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc45_)),null,-1,getItemEffectInfo(ItemEffectType.EXTRA_BARRACKS,25),getCooldownDuration(4011)));
         var _loc1_:Boolean = 4012 in userInfo.storeItemCooldownDurations;
         var _loc46_:String;
         var _loc47_:String;
         _loc11_.push(new StoreItemInfo(4012,"TowerDamageBoost",getName(4012),StoreItemCurrencyType.GOLD,getDescription(4012),_loc1_,600,_loc1_ ? (_loc46_ = "ui.windows.store.availability.alreadyactivated",peak.i18n.PText.INSTANCE.getText0(_loc46_)) : (_loc47_ = "ui.windows.store.availability.buy",peak.i18n.PText.INSTANCE.getText0(_loc47_)),null,-1,getItemEffectInfo(ItemEffectType.TOWER_DAMAGE_BOOST,25),getCooldownDuration(4012)));
         dispatch(new StoreItemsReadyEvent("storeItemsReady",_loc11_,event.category));
      }
      
      private function generateEventStoreItems() : void
      {
         var _loc1_:Vector.<StoreItemInfo> = new Vector.<StoreItemInfo>();
         _loc1_.push(new EventStoreItemInfo(EventItemType.MERCENARY,8001,"SamuraiTeamMedium","SamuraiTeamLarge",getName(8001),StoreItemCurrencyType.EVENT_POINTS,getDescription(8001),checkItemLocked(8001),25,300,"",null,28,null,null,getEventItemAmount(8001)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.CATAPULT,8003,"AcidRainMedium","AcidRainLarge",getName(8003),StoreItemCurrencyType.EVENT_POINTS,getDescription(8003),checkItemLocked(8003),50,500,"",null,4,null,null,getEventItemAmount(8003)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.MERCENARY,8002,"SiegeTowerMedium","SiegeTowerLarge",getName(8002),StoreItemCurrencyType.EVENT_POINTS,getDescription(8002),checkItemLocked(8002),100,800,"",null,29,null,null,getEventItemAmount(8002)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.MERCENARY,8004,"LongbowmanMedium","LongbowmanLarge",getName(8004),StoreItemCurrencyType.EVENT_POINTS,getDescription(8004),checkItemLocked(8004),100,900,"",null,31,null,null,getEventItemAmount(8004)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.MERCENARY,8005,"CyclopMedium","CyclopLarge",getName(8005),StoreItemCurrencyType.EVENT_POINTS,getDescription(8005),checkItemLocked(8005),100,1500,"",null,30,null,null,getEventItemAmount(8005)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.CATAPULT,8007,"IceShardMedium","IceShardLarge",getName(8007),StoreItemCurrencyType.EVENT_POINTS,getDescription(8007),checkItemLocked(8007),50,1750,"",null,5,null,null,getEventItemAmount(8007)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.MERCENARY,8008,"AcidTowerMedium","AcidTowerLarge",getName(8008),StoreItemCurrencyType.EVENT_POINTS,getDescription(8008),checkItemLocked(8008),100,2000,"",null,34,null,null,getEventItemAmount(8008)));
         _loc1_.push(new EventStoreItemInfo(EventItemType.CATAPULT,8009,"HealAuraMedium","HealAuraLarge",getName(8009),StoreItemCurrencyType.EVENT_POINTS,getDescription(8009),checkItemLocked(8009),50,2500,"",null,6,null,null,getEventItemAmount(8009)));
         dispatch(new StoreItemsReadyEvent("storeItemsReady",_loc1_,event.category));
      }
      
      private function checkItemLocked(param1:int) : Boolean
      {
         for each(var _loc2_ in userInfo.unlockedEventItems)
         {
            if(param1 == _loc2_)
            {
               return false;
            }
         }
         return true;
      }
      
      private function getCooldownDuration(param1:int) : ItemCooldownDurationInfo
      {
         return param1 in userInfo.storeItemCooldownDurations ? userInfo.storeItemCooldownDurations[param1] : null;
      }
      
      private function getItemEffectInfo(param1:ItemEffectType, param2:int) : ItemEffectInfo
      {
         for each(var _loc3_ in userInfo.storeItemEffects)
         {
            if(_loc3_.type.id == param1.id && param2 == _loc3_.bonusPercent)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function getActiveItemEffectInfo(param1:ItemEffectType) : ItemEffectInfo
      {
         var _loc3_:ItemEffectInfo = null;
         for each(var _loc2_ in userInfo.storeItemEffects)
         {
            if(_loc2_.type.id == param1.id)
            {
               if(!_loc3_ || _loc3_.bonusPercent < _loc2_.bonusPercent)
               {
                  _loc3_ = _loc2_;
               }
            }
         }
         return _loc3_;
      }
      
      private function getEventItemAmount(param1:int) : int
      {
         var _loc4_:Vector.<EventInventoryItemInfo> = null;
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.buildingTypeId == 44)
            {
               _loc4_ = _loc3_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id] as Vector.<EventInventoryItemInfo>;
            }
         }
         if(_loc4_ == null)
         {
            return 0;
         }
         var _loc2_:int = 0;
         for each(var _loc5_ in _loc4_)
         {
            if(_loc5_.id == param1 && _loc5_.isReady())
            {
               _loc2_++;
            }
         }
         return _loc2_;
      }
   }
}

