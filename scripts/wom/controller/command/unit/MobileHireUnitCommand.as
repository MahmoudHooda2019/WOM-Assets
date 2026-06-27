package wom.controller.command.unit
{
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import wom.controller.PCommand;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobileHiringQuarterHireEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.job.UnitHireJob;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.HireUnitRequest;
   import wom.model.resource.ListColumnType;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.unit.MobileNotEnoughResourcePopUp;
   
   public class MobileHireUnitCommand extends PCommand
   {
      
      private static const MAX_UNIT_COUNT_IN_SLOT:int = 20;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var event:MobileHiringQuarterHireEvent;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      private var centralHiring:Boolean;
      
      public function MobileHireUnitCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:int = 0;
         var _loc2_:BuildingInfo = null;
         var _loc1_:Boolean = false;
         var _loc5_:HiringInfo = null;
         var _loc4_:Boolean = false;
         centralHiring = false;
         _loc3_ = 0;
         while(_loc3_ < city.buildings.length && !_loc4_)
         {
            _loc2_ = city.buildings[_loc3_];
            if(_loc2_.instanceId == event.instanceId)
            {
               _loc4_ = true;
               if(_loc2_.buildingTypeId == 21)
               {
                  centralHiring = true;
               }
            }
            _loc3_++;
         }
         if(!checkResourceAndRecruitmentConstraints())
         {
            return;
         }
         if(!_loc4_ && event.instanceId in city.hiringInfoDictionary)
         {
            delete city.hiringInfoDictionary[event.instanceId];
         }
         else
         {
            _loc1_ = false;
            if(!centralHiring)
            {
               _loc5_ = city.hiringInfoDictionary[event.instanceId];
               if(_loc5_)
               {
                  _loc1_ = hireMercenary(_loc5_);
               }
               else
               {
                  log(LoggerContexts.UNEXPECTED,"HiringInfo is missing for instance id: " + event.instanceId);
               }
            }
            else
            {
               _loc1_ = hireMercenaryFromCentral();
            }
            if(_loc1_)
            {
               var _loc6_:int = ResourceType.IRON.id;
               var _loc7_:Number = city.hiringSessionResourceAmounts[_loc6_] - getUnitHireCost(event.unitAmounts[0].id);
               city.hiringSessionResourceAmounts[_loc6_] = _loc7_;
               dispatch(new OutgoingMessageEvent("outgoingMessage",new HireUnitRequest(event.instanceId,event.unitAmounts)));
               dispatch(new ModelUpdateEvent("hiringInfoUpdated"));
               coreManager.manageMercenaryBarracksNotEnoughSpaceIndicator();
               coreManager.manageHiringQuartersAnimations();
               log(WomLoggerContexts.GAME,"========[[[[[[ UNIT HIRED: " + event.unitAmounts[0].id + " ]]]]]]========");
            }
         }
      }
      
      private function hireMercenaryFromCentral() : Boolean
      {
         var _loc10_:String = null;
         var _loc9_:HiringInfo = null;
         var _loc3_:int = 0;
         var _loc6_:Number = NaN;
         var _loc2_:HiringQueueInfo = null;
         var _loc8_:int = 0;
         var _loc5_:HiringSlotView = null;
         var _loc4_:Boolean = false;
         var _loc7_:Vector.<int> = new Vector.<int>();
         for(var _loc1_ in city.hiringInfoDictionary)
         {
            _loc7_.push(_loc1_);
         }
         _loc7_.sort(sortKeys);
         _loc3_ = 0;
         while(_loc3_ < _loc7_.length && !_loc4_)
         {
            _loc10_ = String(_loc7_[_loc3_]);
            _loc9_ = city.hiringInfoDictionary[_loc10_];
            if(!_loc9_.activeHiring && !_loc9_.isHiringPaused && !_loc4_)
            {
               _loc6_ = domainInfo.getUnit(event.unitAmounts[0].id).hiringDurationPerLevelInSecs[(city.unitTypes[event.unitAmounts[0].id] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed;
               _loc9_.activeHiring = new UnitHireJob(event.unitAmounts[0].id,0,_loc6_ * 1000 / userInfo.hiringSpeedModifier >> 0,_loc9_.hiringBuildingInstanceId,new Date().getTime(),_loc6_);
               _loc4_ = true;
               log(WomLoggerContexts.GAME,"======[[[[[ NEW ACTIVE SLOT CREATED ]]]]]=====");
            }
            if(_loc4_)
            {
               break;
            }
            _loc3_++;
         }
         if(!_loc4_)
         {
            _loc2_ = city.hiringInfoDictionary[_loc7_[0]].hiringQueue;
            _loc8_ = _loc2_.hiringSlots.length - 1;
            if(_loc8_ >= 0)
            {
               _loc5_ = _loc2_.hiringSlots[_loc8_];
               if(_loc5_ && _loc5_.unitId == event.unitAmounts[0].id && _loc5_.numberOfUnits < 20)
               {
                  _loc5_.numberOfUnits++;
                  _loc4_ = true;
                  log(WomLoggerContexts.GAME,"======[[[[[ UNIT COUNT INCREASED TO " + _loc5_.numberOfUnits + " ]]]]]=====");
               }
            }
            if(_loc2_.hiringSlots.length < _loc2_.maxNumberOfHiringSlots && !_loc4_)
            {
               _loc2_.hiringSlots.push(new HiringSlotView(_loc2_.hiringSlots.length + 1,event.unitAmounts[0].id,1));
               _loc4_ = true;
               log(WomLoggerContexts.GAME,"======[[[[[ NEW QUEUE SLOT CREATED ]]]]]=====");
            }
            for each(_loc9_ in city.hiringInfoDictionary)
            {
               _loc9_.hiringQueue = _loc2_;
            }
         }
         return _loc4_;
      }
      
      private function sortKeys(param1:int, param2:int) : int
      {
         return ListColumnType.compareNumbers(param1,param2,-1);
      }
      
      private function hireMercenary(param1:HiringInfo) : Boolean
      {
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:HiringSlotView = null;
         var _loc2_:Boolean = false;
         if(!param1.activeHiring && !param1.isHiringPaused)
         {
            _loc4_ = domainInfo.getUnit(event.unitAmounts[0].id).hiringDurationPerLevelInSecs[(city.unitTypes[event.unitAmounts[0].id] as UnitTypeInfo).currentLevel - 1] / userInfo.serverSpeed;
            param1.activeHiring = new UnitHireJob(event.unitAmounts[0].id,0,_loc4_ * 1000 / userInfo.hiringSpeedModifier >> 0,event.instanceId,new Date().getTime(),_loc4_);
            _loc2_ = true;
         }
         else
         {
            _loc5_ = 0;
            while(_loc5_ < param1.hiringQueue.hiringSlots.length && !_loc2_)
            {
               _loc3_ = param1.hiringQueue.hiringSlots[_loc5_];
               if(_loc3_.unitId == event.unitAmounts[0].id && _loc3_.numberOfUnits < 20)
               {
                  _loc3_.numberOfUnits++;
                  _loc2_ = true;
               }
               _loc5_++;
            }
            if(param1.hiringQueue.hiringSlots.length < param1.hiringQueue.maxNumberOfHiringSlots && !_loc2_)
            {
               param1.hiringQueue.hiringSlots.push(new HiringSlotView(param1.hiringQueue.hiringSlots.length + 1,event.unitAmounts[0].id,1));
               _loc2_ = true;
            }
         }
         return _loc2_;
      }
      
      private function checkResourceAndRecruitmentConstraints() : Boolean
      {
         var _loc5_:Boolean = false;
         var _loc4_:HiringQueueInfo = null;
         var _loc6_:int = 0;
         var _loc3_:HiringSlotView = null;
         var _loc1_:UnitTypeDIO = domainInfo.getUnit(event.unitAmounts[0].id);
         var _loc2_:UnitTypeInfo = city.unitTypes[event.unitAmounts[0].id];
         if(_loc2_.recruited)
         {
            if(getUnitHireCost(event.unitAmounts[0].id) > city.hiringSessionResourceAmounts[ResourceType.IRON.id])
            {
               if(!userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup || !(userInfo.tutorialsInfo.additionalInfo.lastOpenedSecondaryPopup is MobileNotEnoughResourcePopUp))
               {
                  dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughResourcePopUp(_loc1_.id,ResourceType.IRON)));
                  log(WomLoggerContexts.GAME,"=====[[[[[ IRON NOT ENOUGH POPUP OPENED ]]]]]=====");
               }
               return false;
            }
            if(centralHiring)
            {
               return true;
            }
            _loc5_ = false;
            _loc4_ = (city.hiringInfoDictionary[event.instanceId] as HiringInfo).hiringQueue;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.hiringSlots.length)
            {
               _loc3_ = _loc4_.hiringSlots[_loc6_];
               if(_loc3_.numberOfUnits == 0 || _loc3_.numberOfUnits < 20 && _loc3_.unitId == _loc1_.id)
               {
                  _loc5_ = true;
               }
               _loc6_++;
            }
            if(_loc6_ < _loc4_.maxNumberOfHiringSlots)
            {
               _loc5_ = true;
            }
            return _loc5_;
         }
         return false;
      }
      
      private function getUnitHireCost(param1:int) : int
      {
         var _loc4_:int = 0;
         var _loc3_:Number = NaN;
         var _loc5_:UnitTypeInfo = city.unitTypes[param1];
         var _loc2_:UnitTypeDIO = domainInfo.getUnit(param1);
         if(_loc5_.recruited)
         {
            _loc4_ = _loc5_.currentLevel - 1;
            return _loc2_.hiringCostsPerLevel[_loc4_][0].resourceAmount;
         }
         return -1;
      }
   }
}

