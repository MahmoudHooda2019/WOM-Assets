package wom.view.mediator.screen.windows.build
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPItemRenderer;
   import starling.events.Event;
   import wom.controller.event.ui.BuildDecorationPageReadyEvent;
   import wom.controller.event.ui.GetBuildDecorationPageEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PageReadyEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.view.screen.windows.build.MobileBuildDecorationCategoryPanel;
   import wom.view.screen.windows.build.MobileBuildShowcaseConstructableItemRenderer;
   
   public class MobileBuildDecorationCategoryPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileBuildDecorationCategoryPanel;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function MobileBuildDecorationCategoryPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addContextListener("buildDecorationPageReady",onPageReady);
         eventMap.mapStarlingListener(view.decorationViewList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.decorationViewList,"rendererRemove",onRendererRemoved,Event);
         requestPage(0);
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
            dispatch(new MobilePopUpWindowEvent("closePopUpWindow",view.parent.parent));
            coreManager.startBuildDecoration(_loc2_.decorationVariationInfo);
         }
      }
      
      protected function onPageReady(param1:PageReadyEvent) : void
      {
         var _loc3_:BuildDecorationPageReadyEvent = null;
         var _loc2_:* = undefined;
         if(param1 is BuildDecorationPageReadyEvent)
         {
            _loc3_ = param1 as BuildDecorationPageReadyEvent;
            if(_loc3_.buildMenuCategory.id == view.category.id)
            {
               _loc2_ = new Vector.<Object>();
               for each(var _loc4_ in param1.items)
               {
                  _loc2_.push({"decorationVariationInfo":_loc4_});
               }
               view.updateWithItemList(_loc2_);
            }
         }
      }
      
      protected function requestPage(param1:int) : void
      {
         dispatch(new GetBuildDecorationPageEvent("getBuildDecorationPage",param1,2147483647,view.category));
      }
   }
}

