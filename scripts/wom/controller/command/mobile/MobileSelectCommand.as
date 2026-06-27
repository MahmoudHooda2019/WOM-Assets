package wom.controller.command.mobile
{
   import org.robotlegs.mvcs.StarlingCommand;
   import peak.logging.log;
   import wom.controller.command.util.DictionaryUtil;
   import wom.controller.event.mobile.MobileConstructableOptionsEvent;
   import wom.controller.event.mobile.MobileSelectEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.hiring.HiringInfo;
   import wom.model.game.job.BuildingRepairJob;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.UnitTrainJob;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCannonView;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastCaveView;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastKeeperView;
   import wom.view.ui.mainframe.city.mobile.MCOVBoostView;
   import wom.view.ui.mainframe.city.mobile.MCOVCatapultView;
   import wom.view.ui.mainframe.city.mobile.MCOVCityPlannerView;
   import wom.view.ui.mainframe.city.mobile.MCOVDecorationView;
   import wom.view.ui.mainframe.city.mobile.MCOVDefensiveView;
   import wom.view.ui.mainframe.city.mobile.MCOVEnterView;
   import wom.view.ui.mainframe.city.mobile.MCOVIdleView;
   import wom.view.ui.mainframe.city.mobile.MCOVIncompleteView;
   import wom.view.ui.mainframe.city.mobile.MCOVRepairView;
   import wom.view.ui.mainframe.city.mobile.MCOVResourceView;
   import wom.view.ui.mainframe.city.mobile.MCOVTrapView;
   import wom.view.ui.mainframe.city.mobile.MCOVUpgradeView;
   import wom.view.ui.mainframe.city.mobile.MCOVWallView;
   import wom.view.ui.mainframe.city.mobile.MCOVWorkView;
   
   public class MobileSelectCommand extends StarlingCommand
   {
      
      [Inject]
      public var event:MobileSelectEvent;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileSelectCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc4_:String = null;
         if(userInfo.tutorialsInfo && !DictionaryUtil.isEmpty(userInfo.tutorialsInfo.interactableBuildingInstanceIds) && !(event.instanceId in userInfo.tutorialsInfo.interactableBuildingInstanceIds))
         {
            return;
         }
         var _loc5_:Boolean = false;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.instanceId == event.instanceId)
            {
               _loc5_ = true;
               break;
            }
         }
         if(userInfo.tutorialsInfo && _loc5_ && !DictionaryUtil.isEmpty(userInfo.tutorialsInfo.interactableBuildingTypeIds) && !(_loc2_.buildingTypeId in userInfo.tutorialsInfo.interactableBuildingTypeIds))
         {
            return;
         }
         if(!_loc5_)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVDecorationView(event.instanceId)));
            return;
         }
         var _loc6_:BuildingTypeDIO = domainInfo.getBuilding(_loc2_.buildingTypeId);
         var _loc8_:Boolean = false;
         for each(var _loc7_ in city.buildingRepairJobs)
         {
            if(_loc7_.instanceId == event.instanceId)
            {
               _loc8_ = true;
               break;
            }
         }
         if(_loc8_)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVRepairView(event.instanceId)));
            return;
         }
         var _loc11_:Boolean = false;
         for each(var _loc1_ in city.buildingUpgradeJobs)
         {
            if(_loc1_.instanceId == event.instanceId)
            {
               _loc11_ = true;
               break;
            }
         }
         if(_loc11_)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVUpgradeView(_loc2_.instanceId)));
            return;
         }
         if(_loc2_.incomplete)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVIncompleteView(event.instanceId)));
            return;
         }
         var _loc9_:Boolean = false;
         if(_loc2_.buildingTypeId == 17)
         {
            if(city.activeRecruitJob)
            {
               _loc9_ = true;
            }
         }
         else if(_loc2_.buildingTypeId == 18)
         {
            for each(var _loc3_ in city.unitTrainJobs)
            {
               if(_loc3_.instanceId == event.instanceId)
               {
                  _loc9_ = true;
                  break;
               }
            }
         }
         else if(_loc2_.buildingTypeId == 20)
         {
            for each(var _loc10_ in city.hiringInfoDictionary)
            {
               if(_loc10_.hiringBuildingInstanceId == event.instanceId && _loc10_.activeHiring && !_loc10_.isHiringPaused)
               {
                  _loc9_ = true;
                  break;
               }
            }
         }
         else if(_loc2_.buildingTypeId == 21)
         {
            for each(_loc10_ in city.hiringInfoDictionary)
            {
               if(_loc10_.activeHiring && !_loc10_.isHiringPaused)
               {
                  _loc9_ = true;
                  break;
               }
            }
         }
         if(!event.enterOnRegister && _loc9_)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVWorkView(_loc2_.instanceId)));
            return;
         }
         if(_loc2_.buildingTypeId == 10)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVIdleView(_loc2_.instanceId)));
            return;
         }
         if(_loc2_.buildingTypeId == 15 || _loc6_.kind.id == 11)
         {
            _loc4_ = "IconLumberMBordered";
            switch(_loc2_.buildingTypeId - 12)
            {
               case 0:
                  _loc4_ = "IconStoneMBordered";
                  break;
               case 1:
                  _loc4_ = "IconMightMBordered";
                  break;
               case 2:
                  _loc4_ = "IconIronMBordered";
                  break;
               case 3:
                  _loc4_ = "IconStockPileBig";
            }
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVResourceView(event.instanceId,_loc4_)));
            return;
         }
         if(_loc2_.buildingTypeId == 17 || _loc2_.buildingTypeId == 18 || _loc2_.buildingTypeId == 25 || _loc2_.buildingTypeId == 27 || _loc2_.buildingTypeId == 28 || _loc2_.buildingTypeId == 37 || _loc2_.buildingTypeId == 43 || _loc2_.buildingTypeId == 38 || _loc2_.buildingTypeId == 42 || _loc2_.buildingTypeId == 44)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVEnterView(event.instanceId,event.enterOnRegister,event.windowSpecificAttributes)));
            return;
         }
         if(_loc6_.kind.id == 28 && !(_loc6_.id == 39 || _loc6_.id == 40 || _loc6_.id == 45))
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVDefensiveView(event.instanceId)));
            return;
         }
         if(_loc2_.buildingTypeId == 26)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVCityPlannerView(event.instanceId,event.enterOnRegister,event.windowSpecificAttributes)));
            return;
         }
         if(_loc2_.buildingTypeId == 29)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVBeastCaveView(event.instanceId,event.enterOnRegister,event.windowSpecificAttributes)));
            return;
         }
         if(_loc2_.buildingTypeId == 30)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVBeastKeeperView(event.instanceId,event.enterOnRegister,event.windowSpecificAttributes)));
            return;
         }
         if(_loc2_.buildingTypeId == 23)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVCatapultView(event.instanceId)));
            return;
         }
         if(_loc2_.buildingTypeId == 39 || _loc2_.buildingTypeId == 40)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVTrapView(event.instanceId,_loc2_)));
            return;
         }
         if(_loc2_.buildingTypeId == 19 || _loc2_.buildingTypeId == 20 || _loc2_.buildingTypeId == 21)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVBoostView(event.instanceId,event.enterOnRegister,event.windowSpecificAttributes)));
            return;
         }
         if(_loc2_.buildingTypeId == 41)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVWallView(event.instanceId)));
            return;
         }
         if(_loc6_.id == 45)
         {
            dispatch(new MobileConstructableOptionsEvent("mobileConstructableOptionsShow",new MCOVBeastCannonView(event.instanceId)));
            return;
         }
         log(WomLoggerContexts.GAME,"Unreachable Code Detected > MobileSelectCommand > " + event.instanceId);
      }
   }
}

