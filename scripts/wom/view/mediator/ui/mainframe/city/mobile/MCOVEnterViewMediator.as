package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.logging.log;
   import starling.events.Event;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.WomScreenType;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.windows.alliance.mobile.MobileAllianceWindow;
   import wom.view.screen.windows.beast.cave.MobileBeastCaveWindow;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperWindow;
   import wom.view.screen.windows.blacksmith.MobileBlacksmithWindow;
   import wom.view.screen.windows.catapult.MobileCatapultRechargeWindow;
   import wom.view.screen.windows.executionalguillotine.MobileAllianceBarracksWindow;
   import wom.view.screen.windows.executionalguillotine.MobileExecutionalGuillotineWindow;
   import wom.view.screen.windows.executionalguillotine.MobileFriendWatchPostWindow;
   import wom.view.screen.windows.hiringquarters.MobileCentralHiringQuartersWindow;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersWindow;
   import wom.view.screen.windows.mercenarybarracks.MobileMercenaryBarracksWindow;
   import wom.view.screen.windows.pigeonpost.MobilePigeonPostWindow;
   import wom.view.screen.windows.recruitmentchamber.MobileRecruitmentChamberWindow;
   import wom.view.screen.windows.trainingchamber.MobileTrainingChamberWindow;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornWindow;
   import wom.view.screen.windows.watchpost.MobileWatchPostWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVEnterView;
   import wom.view.ui.mainframe.city.tooltip.mobile.MobileBuildingTooltipHousingInfoView;
   
   public class MCOVEnterViewMediator extends MCOVIdleViewMediator
   {
      
      [Inject]
      public var enterView:MCOVEnterView;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MCOVEnterViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(enterView.enterButton,"triggered",onEnterButtonClicked);
         if(enterView.enterOnRegister)
         {
            enterButtonClicked();
         }
      }
      
      private function enterButtonClicked() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(buildingInfo.buildingTypeId == 25)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTuskHornWindow()));
         }
         else if(buildingInfo.buildingTypeId == 26)
         {
            dispatch(new ActivateScreenEvent("activate",WomScreenType.MOBILE_CITY_PLANNER));
         }
         else if(buildingInfo.buildingTypeId == 17)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileRecruitmentChamberWindow(buildingInfo.instanceId,userInfo.serverSpeed,"units" in enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.units : -1)));
         }
         else if(buildingInfo.buildingTypeId == 18)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTrainingChamberWindow(buildingInfo.instanceId,"initialUnitTypeId" in enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.initialUnitTypeId : -1)));
         }
         else if(buildingInfo.buildingTypeId == 44)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBlacksmithWindow(enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.lastModifiedItemIndex : 0)));
         }
         else if(buildingInfo.buildingTypeId == 27)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileExecutionalGuillotineWindow()));
         }
         else if(buildingInfo.buildingTypeId == 37)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileWatchPostWindow(buildingInfo.instanceId,buildingInfo.level)));
         }
         else if(buildingInfo.buildingTypeId == 20)
         {
            _loc1_ = -1;
            _loc2_ = 0;
            while(_loc2_ < city.buildings.length)
            {
               if(city.buildings[_loc2_].buildingTypeId == 21 && city.buildings[_loc2_].level > 0)
               {
                  _loc1_ = city.buildings[_loc2_].instanceId;
                  break;
               }
               _loc2_++;
            }
            if(_loc1_ != -1)
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCentralHiringQuartersWindow(_loc1_,null,"windowEnumerations" in enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.windowEnumerations : null)));
            }
            else
            {
               dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileHiringQuartersWindow(buildingInfo.instanceId,buildingInfo.level,null,"windowEnumerations" in enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.windowEnumerations : null)));
            }
         }
         else if(buildingInfo.buildingTypeId == 21)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCentralHiringQuartersWindow(buildingInfo.instanceId,null,"windowEnumerations" in enterView.windowSpecificAttributes ? enterView.windowSpecificAttributes.windowEnumerations : null)));
         }
         else if(buildingInfo.buildingTypeId == 28)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobilePigeonPostWindow()));
         }
         else if(buildingInfo.buildingTypeId == 19)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileMercenaryBarracksWindow()));
         }
         else if(buildingInfo.buildingTypeId == 43)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAllianceBarracksWindow()));
         }
         else if(buildingInfo.buildingTypeId == 38)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFriendWatchPostWindow()));
         }
         else if(buildingInfo.buildingTypeId == 42)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAllianceWindow()));
         }
         else if(buildingInfo.buildingTypeId == 29)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastCaveWindow(buildingTypeDIO)));
         }
         else if(buildingInfo.buildingTypeId == 30)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileBeastKeeperWindow()));
         }
         else
         {
            if(buildingInfo.buildingTypeId != 23)
            {
               log(WomLoggerContexts.GAME,"ENTER FAIL : WINDOW NOT IMPLEMENTED (Building Type Id :" + buildingInfo.buildingTypeId + ")");
               return;
            }
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCatapultRechargeWindow(buildingInfo.level)));
         }
         cancelSelection();
      }
      
      private function onEnterButtonClicked(param1:Event) : void
      {
         enterButtonClicked();
      }
      
      override protected function updateView() : void
      {
         super.updateView();
         if(buildingInfo.buildingTypeId == 19)
         {
            enterView.addInfoView(new MobileBuildingTooltipHousingInfoView(0,buildingInfo));
         }
         else if(buildingInfo.buildingTypeId == 43)
         {
            enterView.addInfoView(new MobileBuildingTooltipHousingInfoView(2,buildingInfo));
         }
         else if(buildingInfo.buildingTypeId == 37)
         {
            enterView.addInfoView(new MobileBuildingTooltipHousingInfoView(1,buildingInfo));
         }
         else if(buildingInfo.buildingTypeId == 38)
         {
            enterView.addInfoView(new MobileBuildingTooltipHousingInfoView(3,buildingInfo));
         }
      }
   }
}

