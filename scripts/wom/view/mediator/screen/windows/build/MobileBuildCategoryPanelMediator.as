package wom.view.mediator.screen.windows.build
{
   import feathers.data.ListCollection;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPItemRenderer;
   import starling.events.Event;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.BuildPageReadyEvent;
   import wom.controller.event.ui.GetBuildPageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PageReadyEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.view.screen.windows.build.MobileBuildCategoryPanel;
   import wom.view.screen.windows.build.MobileBuildShowcaseConstructableItemRenderer;
   import wom.view.screen.windows.build.MobileConstructBuildingWindow;
   
   public class MobileBuildCategoryPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildCategoryPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileBuildCategoryPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("buildPageReady",onPageReady);
         eventMap.mapStarlingListener(view.buildingViewList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.buildingViewList,"rendererRemove",onRendererRemoved,Event);
         addContextListener("getBuildShowcaseViewPosition",onBuildShowcaseViewPositionRequested,TutorialReferencePositionEvent);
         setTimeout(requestPageWithDelay,1);
      }
      
      private function requestPageWithDelay() : void
      {
         requestPage(0);
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onRendererAdded(param1:Event, param2:MPItemRenderer) : void
      {
         eventMap.mapStarlingListener(param2,"triggered",onItemClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MPItemRenderer) : void
      {
         eventMap.unmapStarlingListener(param2,"triggered",onItemClicked,Event);
      }
      
      private function onItemClicked(param1:Event) : void
      {
         var _loc2_:MobileBuildShowcaseConstructableItemRenderer = param1.target as MobileBuildShowcaseConstructableItemRenderer;
         if(_loc2_)
         {
            if(!(_loc2_.buildingTypeInfo.currentInstanceCount < _loc2_.buildingTypeDIO.maxInstances || _loc2_.buildingTypeDIO.multibuild && _loc2_.buildingTypeInfo.currentInstanceCount < _loc2_.buildingTypeDIO.multipleInstancePrerequisites[_loc2_.buildingTypeDIO.multipleInstancePrerequisites.length - 1].maxInstances))
            {
               return;
            }
            dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view.parent));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileConstructBuildingWindow(_loc2_.buildingTypeInfo,_loc2_.buildingTypeDIO)));
         }
      }
      
      protected function onPageReady(param1:PageReadyEvent) : void
      {
         var _loc3_:BuildPageReadyEvent = null;
         var _loc2_:* = undefined;
         if(param1 is BuildPageReadyEvent)
         {
            _loc3_ = param1 as BuildPageReadyEvent;
            if(_loc3_.buildMenuCategory.id == view.category.id)
            {
               _loc2_ = new Vector.<Object>();
               for each(var _loc4_ in param1.items)
               {
                  _loc2_.push({
                     "typeInfo":city.buildingTypes[_loc4_.id],
                     "dio":_loc4_
                  });
               }
               view.updateWithItemList(_loc2_,true);
            }
         }
      }
      
      protected function requestPage(param1:int) : void
      {
         dispatch(new GetBuildPageEvent("getBuildPage",param1,2147483647,view.category));
      }
      
      private function onBuildShowcaseViewPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Object = null;
         var _loc6_:BuildingTypeDIO = null;
         var _loc4_:ListCollection = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:Point = null;
         if("buildingTypeId" in param1.additionalInfo && view.buildingViewList && view.buildingViewList.dataProvider)
         {
            _loc3_ = int(param1.additionalInfo["buildingTypeId"]);
            _loc4_ = view.buildingViewList.dataProvider;
            _loc7_ = _loc4_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc2_ = _loc4_.getItemAt(_loc8_);
               if("dio" in _loc2_ && _loc2_.dio != null)
               {
                  _loc6_ = BuildingTypeDIO(_loc2_.dio);
                  if(_loc6_.id == _loc3_)
                  {
                     view.buildingViewList.scrollToPageIndex("hpi" in param1.additionalInfo ? param1.additionalInfo["hpi"] : 0,"vpi" in param1.additionalInfo ? param1.additionalInfo["vpi"] : 0);
                     view.buildingViewList.horizontalScrollPolicy = "off";
                     view.buildingViewList.verticalScrollPolicy = "off";
                     _loc5_ = view.buildingViewList.localToGlobal(new Point(0,0));
                     dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc5_,param1.additionalInfo));
                     break;
                  }
               }
               _loc8_++;
            }
         }
      }
   }
}

