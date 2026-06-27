package wom.controller.command.model
{
   import peak.resource.SoundPlayer;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.hiring.HiringQueueInfo;
   import wom.model.game.hiring.HiringSlotView;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.message.request.FinishAllHiresRequest;
   import wom.model.message.request.GetHiringStatusRequest;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   
   public class FinishAllHiresCommand extends BaseHiringCommand
   {
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function FinishAllHiresCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:HiringQueueInfo = null;
         var _loc11_:int = 0;
         var _loc10_:HiringInfo = null;
         var _loc7_:int = 0;
         var _loc5_:UnitTypeInfo = null;
         var _loc2_:UnitTypeDIO = null;
         var _loc8_:int = 0;
         var _loc4_:Vector.<HiringInfo> = sortHiringInfoList();
         var _loc3_:int = BaseHiringCommand.calculateRemainingBarracksSpace(domainInfo,city,userInfo);
         var _loc9_:Boolean = false;
         _loc11_ = 0;
         while(_loc11_ < _loc4_.length && !_loc9_)
         {
            _loc10_ = _loc4_[_loc11_];
            if(_loc3_ > 0 && (event.centralHiring || _loc10_.hiringBuildingInstanceId == event.instanceId))
            {
               _loc1_ = _loc10_.hiringQueue;
               if(_loc10_.activeHiring)
               {
                  _loc7_ = _loc10_.activeHiring.unitTypeId;
                  _loc5_ = city.unitTypes[_loc7_];
                  _loc2_ = domainInfo.getUnit(_loc7_);
                  _loc8_ = _loc2_.spacesPerLevel[_loc5_.currentLevel - 1];
                  if(_loc3_ < _loc8_)
                  {
                     _loc9_ = true;
                     break;
                  }
                  _loc3_ -= _loc8_;
               }
            }
            _loc11_++;
         }
         if(_loc1_)
         {
            for each(var _loc6_ in _loc1_.hiringSlots)
            {
               _loc5_ = city.unitTypes[_loc6_.unitId];
               _loc2_ = domainInfo.getUnit(_loc6_.unitId);
               _loc8_ = _loc2_.spacesPerLevel[_loc5_.currentLevel - 1] * _loc6_.numberOfUnits;
               if(_loc3_ < _loc8_)
               {
                  _loc9_ = true;
                  break;
               }
               _loc3_ -= _loc8_;
            }
         }
         soundPlayer.playSfxById("PurchaseSuccessful");
         dispatch(new OutgoingMessageEvent("outgoingMessage",new FinishAllHiresRequest(event.instanceId)));
         if(_loc9_)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileActionNotPossiblePopup(83)));
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetHiringStatusRequest(event.instanceId)));
         }
      }
   }
}

