package wom.view.mediator.ui.mainframe.city.mobile
{
   import starling.events.Event;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.view.screen.windows.activate.MobileActivateBuildingWindow;
   import wom.view.ui.mainframe.city.mobile.MCOVIncompleteView;
   
   public class MCOVIncompleteViewMediator extends MobileConstructableOptionsViewMediator
   {
      
      [Inject]
      public var incompleteView:MCOVIncompleteView;
      
      public function MCOVIncompleteViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(incompleteView.askFriendsButton,"triggered",onAskFriendsClicked,Event);
      }
      
      private function onAskFriendsClicked(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < city.buildings.length)
         {
            if(city.buildings[_loc3_].buildingTypeId == buildingInfo.buildingTypeId)
            {
               if(!city.buildings[_loc3_].incomplete)
               {
                  _loc2_++;
               }
            }
            _loc3_++;
         }
         dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileActivateBuildingWindow(buildingInfo,buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.PART_REQUIREMENTS_PER_LEVEL.id][_loc2_])));
      }
   }
}

