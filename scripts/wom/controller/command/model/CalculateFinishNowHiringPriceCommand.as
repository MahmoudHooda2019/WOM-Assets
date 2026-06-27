package wom.controller.command.model
{
   import flash.utils.Dictionary;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringPauseReasonType;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.finishnow.MobileFinishNowHiringPopUp;
   
   public class CalculateFinishNowHiringPriceCommand extends BaseHiringCommand
   {
      
      public function CalculateFinishNowHiringPriceCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc15_:HiringQueueInfo = null;
         var _loc9_:int = 0;
         var _loc6_:UnitTypeInfo = null;
         var _loc2_:UnitTypeDIO = null;
         var _loc12_:int = 0;
         var _loc8_:Boolean = false;
         var _loc20_:Dictionary = null;
         var _loc22_:Boolean = false;
         var _loc1_:int = 0;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc21_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc14_:Number = 0;
         var _loc11_:Dictionary = new Dictionary();
         var _loc3_:Vector.<HiringInfo> = sortHiringInfoList();
         var _loc16_:int = BaseHiringCommand.calculateRemainingBarracksSpace(domainInfo,city,userInfo);
         var _loc17_:Number = userInfo.hiringSpeedModifier;
         for each(var _loc13_ in _loc3_)
         {
            if(event.centralHiring || _loc13_.hiringBuildingInstanceId == event.instanceId)
            {
               _loc15_ = _loc13_.hiringQueue;
               if(_loc13_.activeHiring)
               {
                  _loc9_ = _loc13_.activeHiring.unitTypeId;
                  _loc6_ = city.unitTypes[_loc9_];
                  _loc2_ = domainInfo.getUnit(_loc9_);
                  _loc12_ = _loc2_.spacesPerLevel[_loc6_.currentLevel - 1];
                  if(_loc16_ >= _loc12_)
                  {
                     _loc16_ -= _loc12_;
                     _loc14_ += StoreUtil.mercenaryHiringPrice((_loc13_.activeHiring.jobCreationTime + _loc13_.activeHiring.remainingDuration - new Date().time) * _loc17_ / (1000 * userInfo.serverSpeed));
                     if(!(_loc9_ in _loc11_))
                     {
                        _loc11_[_loc9_] = 0;
                     }
                     _loc11_[_loc9_]++;
                     _loc21_ = true;
                  }
                  else
                  {
                     _loc10_ = true;
                  }
               }
               else if(_loc13_.isHiringPaused && _loc13_.pauseReason == HiringPauseReasonType.BARRACKS_CAPACITY_FULL)
               {
                  _loc10_ = true;
               }
            }
         }
         if(_loc15_)
         {
            _loc8_ = false;
            _loc20_ = new Dictionary();
            while(!_loc8_)
            {
               _loc22_ = false;
               for each(var _loc7_ in _loc15_.hiringSlots)
               {
                  if(!(_loc7_.slotIndex in _loc20_))
                  {
                     _loc20_[_loc7_.slotIndex] = 0;
                  }
                  _loc1_ = int(_loc20_[_loc7_.slotIndex]);
                  if(_loc1_ < _loc7_.numberOfUnits)
                  {
                     _loc6_ = city.unitTypes[_loc7_.unitId];
                     _loc2_ = domainInfo.getUnit(_loc7_.unitId);
                     _loc12_ = _loc2_.spacesPerLevel[_loc6_.currentLevel - 1];
                     if(_loc16_ >= _loc12_)
                     {
                        _loc16_ -= _loc12_;
                        _loc5_ = _loc2_.hiringDurationPerLevelInSecs[_loc6_.currentLevel - 1];
                        _loc14_ += StoreUtil.mercenaryHiringPrice(_loc5_ / userInfo.serverSpeed);
                        if(!(_loc7_.unitId in _loc11_))
                        {
                           _loc11_[_loc7_.unitId] = 0;
                        }
                        _loc11_[_loc7_.unitId]++;
                        if(!_loc22_)
                        {
                           _loc22_ = true;
                        }
                        _loc20_[_loc7_.slotIndex]++;
                        _loc21_ = true;
                     }
                     else
                     {
                        _loc10_ = true;
                     }
                  }
               }
               _loc8_ = !_loc22_;
            }
         }
         var _loc18_:Vector.<UnitTypeAmountDTO> = new Vector.<UnitTypeAmountDTO>();
         for(var _loc19_ in _loc11_)
         {
            _loc18_.push(new UnitTypeAmountDTO(int(_loc19_),_loc11_[_loc19_]));
         }
         if(_loc14_ > 0 && _loc14_ < 1)
         {
            _loc14_ = 1;
         }
         else
         {
            _loc4_ = _loc14_ - (_loc14_ << 0);
            _loc14_ = _loc4_ > 0.5 ? _loc14_ + 1 << 0 : _loc14_ << 0;
         }
         if(_loc14_ > 0)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileFinishNowHiringPopUp(_loc14_,_loc18_,event.instanceId,event.centralHiring,!userInfo.mandatoryTutorialCompleted)));
            return;
         }
         if(_loc10_ && _loc18_.length == 0)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(83)));
         }
      }
   }
}

