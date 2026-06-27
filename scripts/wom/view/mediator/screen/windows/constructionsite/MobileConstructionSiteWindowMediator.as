package wom.view.mediator.screen.windows.constructionsite
{
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.FortificationInfoDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.request.BuyItemRequest;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.constructionsite.MobileConstructionSiteWindow;
   
   public class MobileConstructionSiteWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileConstructionSiteWindow;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileConstructionSiteWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("jobsInfoUpdated",onJobsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.abandonButton,"triggered",onCancelButtonClicked,Event);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onFinishNowButtonClicked,Event);
         eventMap.mapStarlingListener(view.shortenWithRPButton,"triggered",onShortenWithRPButtonClicked,Event);
         eventMap.mapStarlingListener(view.imageAsset,"change",onAssetChanged,Event);
      }
      
      private function onJobsUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:BuildingUpgradeJob = null;
         log(WomLoggerContexts.GAME,"Jobs updated");
         _loc3_ = 0;
         while(_loc3_ < city.buildingUpgradeJobs.length)
         {
            _loc2_ = city.buildingUpgradeJobs[_loc3_];
            if(view.job.instanceId == _loc2_.instanceId)
            {
               view.updateUpgradeJob(_loc2_);
            }
            _loc3_++;
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(view.remainingTime <= 0)
         {
            closeWindow();
         }
         else
         {
            view.updateView();
         }
      }
      
      private function onCancelButtonClicked(param1:Event) : void
      {
         var _loc2_:* = undefined;
         var _loc8_:FortificationInfoDIO = null;
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = false;
         for each(var _loc5_ in city.buildingUpgradeJobs)
         {
            if(_loc5_.instanceId == view.buildingInfo.instanceId)
            {
               if(_loc5_.type == BuildingUpgradeJobType.FORTIFY)
               {
                  _loc3_ = true;
                  break;
               }
               if(_loc5_.type == BuildingUpgradeJobType.UPGRADE)
               {
                  _loc4_ = true;
                  break;
               }
            }
         }
         if(_loc4_)
         {
            _loc2_ = view.buildingTypeDIO.resourceCosts[view.buildingInfo.level == 0 ? 0 : view.buildingInfo.level];
         }
         else if(_loc3_)
         {
            _loc8_ = view.buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.FORTIFICATION_INFO.id] as FortificationInfoDIO;
            _loc2_ = _loc8_.resourceCosts[view.buildingInfo.fortificationLevel == 0 ? 0 : view.buildingInfo.fortificationLevel - 1];
         }
         else
         {
            _loc2_ = view.buildingTypeDIO.resourceCosts[view.buildingInfo.level == 0 ? 0 : view.buildingInfo.level - 1];
         }
         for each(var _loc7_ in _loc2_)
         {
            if(city.resourceAmounts[_loc7_.resourceType] + _loc7_.resourceAmount > city.totalResourceCapacity >> 2)
            {
               _loc6_ = true;
               break;
            }
         }
         closeWindow();
      }
      
      private function onShortenWithRPButtonClicked(param1:Event) : void
      {
         if(view.remainingTime > 300000)
         {
            if(userInfo.reconPoints >= 30)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2004,view.buildingInfo.instanceId)));
            }
         }
      }
      
      private function onFinishNowButtonClicked(param1:Event) : void
      {
         if(view.remainingTime < 300000)
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2003,view.buildingInfo.instanceId)));
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new BuyItemRequest(2007,view.buildingInfo.instanceId)));
         }
         closeWindow();
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
      }
   }
}

