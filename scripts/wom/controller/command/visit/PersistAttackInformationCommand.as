package wom.controller.command.visit
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.PartInfoDTO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.event.EventItemType;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.model.game.store.EventInventoryItemInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.unit.UnitTypeInfo;
   
   public class PersistAttackInformationCommand extends PCommand
   {
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function PersistAttackInformationCommand()
      {
         super();
      }
      
      protected function persistAttackingInformation() : void
      {
         var _loc11_:* = null;
         var _loc15_:BuildingTypeDIO = null;
         var _loc13_:BuildingTypeInfo = null;
         var _loc14_:int = 0;
         var _loc7_:int = 0;
         var _loc17_:Boolean = false;
         var _loc8_:int = 0;
         var _loc1_:InventoryItemDTO = null;
         var _loc3_:int = 0;
         var _loc6_:UnitInfo = null;
         attackInfo.reset();
         attackInfo.mostNeededPartId = -1;
         var _loc12_:Dictionary = new Dictionary();
         var _loc16_:Vector.<int> = new Vector.<int>();
         for each(_loc11_ in city.buildings)
         {
            _loc15_ = domainInfo.getBuilding(_loc11_.buildingTypeId);
            _loc13_ = city.buildingTypes[_loc11_.buildingTypeId];
            _loc14_ = _loc15_.kind.id;
            if((_loc14_ == 11 || _loc14_ == 12) && _loc11_.incomplete)
            {
               for each(var _loc10_ in _loc15_.buildingSpecificInfo[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id][_loc13_.currentInstanceCount - 1])
               {
                  _loc7_ = _loc10_.id;
                  _loc17_ = false;
                  _loc8_ = 0;
                  while(_loc8_ < userInfo.items.length)
                  {
                     _loc1_ = userInfo.items[_loc8_];
                     if(_loc1_.category == InventoryItemCategory.PARTS && _loc1_.id == _loc7_)
                     {
                        _loc17_ = true;
                        if(_loc1_.amount < _loc10_.amount)
                        {
                           _loc12_[_loc7_] = true;
                        }
                        break;
                     }
                     _loc8_++;
                  }
                  if(!_loc17_ && _loc10_.amount > 0)
                  {
                     _loc12_[_loc7_] = true;
                  }
               }
            }
         }
         for(var _loc18_ in _loc12_)
         {
            _loc16_.push(int(_loc18_));
         }
         if(_loc16_.length == 0)
         {
            _loc3_ = 100;
            _loc7_ = 10;
            while(_loc7_ < 30)
            {
               _loc17_ = false;
               _loc8_;
               while(_loc8_ < userInfo.items.length)
               {
                  _loc1_ = userInfo.items[_loc8_];
                  if(_loc7_ == _loc1_.id)
                  {
                     _loc17_ = true;
                     if(_loc1_.amount < _loc3_)
                     {
                        _loc16_ = new Vector.<int>();
                        _loc16_.push(_loc7_);
                        _loc3_ = _loc1_.amount;
                     }
                     else if(_loc1_.amount == _loc3_)
                     {
                        _loc16_.push(_loc7_);
                     }
                     break;
                  }
                  _loc8_++;
               }
               if(!_loc17_)
               {
                  if(0 < _loc3_)
                  {
                     _loc16_ = new Vector.<int>();
                     _loc16_.push(_loc7_);
                     _loc3_ = 0;
                  }
                  else if(0 == _loc3_)
                  {
                     _loc16_.push(_loc7_);
                  }
               }
               _loc7_++;
            }
         }
         if(_loc16_.length == 0)
         {
            _loc16_.push(10);
         }
         attackInfo.mostNeededPartId = _loc16_[Math.floor(Math.random() * _loc16_.length)];
         if(city.beast)
         {
            attackInfo.beast = city.beast;
            attackInfo.beast.status = UnitStatusType.WAITING_TO_DEPLOY;
         }
         else
         {
            attackInfo.beast = null;
         }
         attackInfo.units = new Vector.<UnitInfo>();
         for each(var _loc9_ in city.units)
         {
            if(_loc9_.status != UnitStatusType.IN_WATCH_POST && _loc9_.status != UnitStatusType.DEFENDING)
            {
               _loc6_ = _loc9_.clone();
               _loc6_.status = UnitStatusType.WAITING_TO_DEPLOY;
               attackInfo.units.push(_loc6_);
            }
         }
         attackInfo.unitTypes = new Dictionary();
         for each(var _loc4_ in city.unitTypes)
         {
            attackInfo.unitTypes[_loc4_.unitTypeId] = new UnitTypeInfo(_loc4_.unitTypeId,_loc4_.currentLevel,true,false,false,false,false,0,0,0);
         }
         addDeployableEventItemsIntoUnitsAndTypes();
         var _loc5_:int = 0;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 23)
            {
               _loc5_ = _loc2_.level;
            }
         }
         attackInfo.attackingUserResourceCapacity = city.totalResourceCapacity;
         attackInfo.attackingUserResources = city.resourceAmounts;
         attackInfo.catapultLevel = _loc5_;
      }
      
      private function addDeployableEventItemsIntoUnitsAndTypes() : void
      {
         var _loc7_:EventItemDIO = null;
         var _loc1_:UnitTypeDIO = null;
         var _loc5_:UnitTypeInfo = null;
         var _loc4_:int = 0;
         var _loc6_:Vector.<EventInventoryItemInfo> = null;
         for each(var _loc3_ in city.buildings)
         {
            if(_loc3_.buildingTypeId == 44)
            {
               _loc6_ = _loc3_.buildingSpecificInfo[BuildingSpecificInfoType.EVENT_ITEM_INVENTORY.id] as Vector.<EventInventoryItemInfo>;
            }
         }
         var _loc2_:Dictionary = new Dictionary();
         for each(var _loc8_ in _loc6_)
         {
            _loc7_ = domainInfo.getEventItem(_loc8_.id);
            if(_loc7_.itemType == EventItemType.MERCENARY.id && !_loc7_.warBuilding)
            {
               _loc1_ = domainInfo.getUnit(_loc7_.relatedId);
               _loc5_ = city.unitTypes[_loc1_.id];
               _loc4_ = _loc5_.currentLevel - 1;
               attackInfo.units.push(new UnitInfo(DefaultUnitFactory.generateUnitId(),UnitStatusType.WAITING_TO_DEPLOY,-1,_loc7_.relatedId,_loc1_.healthPointsPerLevel[_loc4_],1,1,1));
               attackInfo.unitTypes[_loc7_.relatedId] = _loc5_;
            }
            if(_loc8_.isReady())
            {
               if(!(_loc8_.id in _loc2_))
               {
                  _loc2_[_loc8_.id] = 0;
               }
               _loc2_[_loc8_.id]++;
            }
         }
         attackInfo.eventItemCounts = _loc2_;
      }
   }
}

