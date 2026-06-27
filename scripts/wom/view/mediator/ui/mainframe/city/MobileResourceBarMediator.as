package wom.view.mediator.ui.mainframe.city
{
   import flash.events.TimerEvent;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.config.DocumentConfiguration;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.league.LeagueManager;
   import wom.model.game.resource.ResourceType;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.ui.mainframe.city.MobileResourceBar;
   import wom.view.ui.tooltip.MobileResourceBarTooltipView;
   
   public class MobileResourceBarMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileResourceBar;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:DocumentConfiguration;
      
      [Inject]
      public var leagueManager:LeagueManager;
      
      public function MobileResourceBarMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.resourceAddButton,"triggered",onResourceAddButtonClicked,Event);
         eventMap.mapListener(view.resourceChangeTimer,"timerComplete",onResourceChangeTimerComplete,TimerEvent);
         if(userInfo.gameMode == GameModeType.NORMAL || userInfo.gameMode == GameModeType.UNKNOWN)
         {
            eventMap.mapStarlingListener(view.icon,"touch",onTab,TouchEvent);
            addContextListener("mobileTooltipEventClose",onTooltipClosed,MobileTooltipEvent);
         }
      }
      
      private function onResourceChangeTimerComplete(param1:TimerEvent) : void
      {
         view.reverseTween();
      }
      
      private function onResourceAddButtonClicked(param1:Event) : void
      {
         if(Boolean(view.addResourceAction))
         {
            view.addResourceAction();
         }
         else
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileStoreWindow(0,1)));
         }
      }
      
      public function onTick(param1:Event) : void
      {
         var _loc7_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:Number = NaN;
         var _loc6_:BuildingTypeDIO = null;
         var _loc8_:ResourceType = null;
         if(city.resourceAmounts)
         {
            _loc7_ = city.totalResourceCapacity / 4;
            _loc3_ = int(city.resourceAmounts[view.resourceType.id]);
            _loc5_ = 0;
            _loc9_ = 1;
            for each(var _loc4_ in city.buildings)
            {
               _loc6_ = domainInfo.getBuilding(_loc4_.buildingTypeId);
               _loc8_ = _loc6_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id];
               Event;
               if(_loc8_ && _loc8_.id == view.resourceType.id && _loc4_.level > 0 && checkNoUpgradeOrRepairJobExists(_loc4_.instanceId))
               {
                  _loc5_ += _loc6_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCTION_AMOUNTS_PER_HOUR_PER_LEVEL.id][_loc4_.level - 1] as int;
               }
            }
            _loc9_ *= userInfo.productionBoostModifier;
            if(view.resourceType == ResourceType.IRON)
            {
               if(documentConfiguration.hasParameter("iron_event_timer") && documentConfiguration.getParameter("iron_event_timer") > 0 && documentConfiguration.getParameter("iron_event_timer") < 7 * 86400000)
               {
                  _loc9_ *= 3;
               }
               if(leagueManager.myLeague != null)
               {
                  _loc9_ *= 1 + leagueManager.myLeague.levelDIO.ironProductionBonusPercentage / 100;
               }
            }
            if(userInfo.gameMode == GameModeType.NORMAL && view.tooltip)
            {
               view.tooltip.updateWithData(_loc7_,_loc3_,_loc5_ * _loc9_);
            }
         }
      }
      
      private function checkNoUpgradeOrRepairJobExists(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         _loc2_ = city.buildingUpgradeJobs.length - 1;
         while(_loc2_ >= 0)
         {
            if(city.buildingUpgradeJobs[_loc2_].instanceId == param1)
            {
               return false;
            }
            _loc2_--;
         }
         _loc2_ = city.buildingRepairJobs.length - 1;
         while(_loc2_ >= 0)
         {
            if(city.buildingRepairJobs[_loc2_].instanceId == param1)
            {
               return false;
            }
            _loc2_--;
         }
         return true;
      }
      
      private function onTooltipClosed(param1:MobileTooltipEvent) : void
      {
         removeContextListener("tick",onTick);
      }
      
      private function onTab(param1:Event) : void
      {
         var _loc2_:Touch = (param1 as TouchEvent).getTouch(view,"ended");
         if(_loc2_)
         {
            view.tooltip = new MobileResourceBarTooltipView(view.resourceType);
            dispatch(new MobileTooltipEvent("mobileTooltipEventShow",view.tooltip,view.parent.x + view.x - (294 - view.width >> 1),70 + view.y));
            onTick(null);
         }
      }
   }
}

