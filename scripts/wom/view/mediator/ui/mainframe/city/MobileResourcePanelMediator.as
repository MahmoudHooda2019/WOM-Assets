package wom.view.mediator.ui.mainframe.city
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.view.ui.mainframe.city.MobileResourceBar;
   import wom.view.ui.mainframe.city.MobileResourcePanel;
   
   public class MobileResourcePanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileResourcePanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileResourcePanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("cityLoaded",onResourcesOrCapacityUpdated,ModelUpdateEvent);
         addContextListener("resourcesUpdated",onResourcesOrCapacityUpdated,ModelUpdateEvent);
         addContextListener("resourceCapacityUpdated",onResourcesOrCapacityUpdated,ModelUpdateEvent);
         addContextListener("lootedResourcesUpdated",onResourcesOrCapacityUpdated,ModelUpdateEvent);
         for each(var _loc1_ in view.resourceBars)
         {
            eventMap.mapStarlingListener(_loc1_,"AnimationCompletedEvent",onAnimationCompleted,Event);
         }
         setResourceAmounts();
      }
      
      private function onAnimationCompleted(param1:Event) : void
      {
         view.animationCompletedForResourceBar();
      }
      
      private function onResourcesOrCapacityUpdated(param1:ModelUpdateEvent) : void
      {
         setResourceAmounts();
      }
      
      private function setResourceAmounts() : void
      {
         var _loc3_:Array = null;
         var _loc5_:BuildingTypeDIO = null;
         var _loc4_:ResourceType = null;
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            if(city.resourceAmounts && city.totalResourceCapacity)
            {
               view.updateWithResourceInfo(city.resourceAmounts,city.totalResourceCapacity,userInfo.gameMode,userInfo.mandatoryTutorialCompleted);
            }
         }
         else if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            _loc3_ = [];
            for each(var _loc6_ in ResourceType.resourceTypes)
            {
               _loc3_[_loc6_.id] = attackInfo.lootedHarvestedResources[_loc6_.id];
            }
            for(var _loc2_ in attackInfo.lootedUnharvestedResources)
            {
               for each(var _loc1_ in city.buildings)
               {
                  if(_loc1_.instanceId == int(_loc2_))
                  {
                     _loc5_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
                     _loc4_ = _loc5_.buildingSpecificInfo[BuildingSpecificInfoType.PRODUCED_RESOURCE.id] as ResourceType;
                     var _loc8_:int = _loc4_.id;
                     var _loc7_:Number = _loc3_[_loc8_] + attackInfo.lootedUnharvestedResources[_loc2_];
                     _loc3_[_loc8_] = _loc7_;
                     break;
                  }
               }
            }
            view.updateWithResourceInfo(_loc3_,0,userInfo.gameMode,userInfo.mandatoryTutorialCompleted);
         }
      }
   }
}

