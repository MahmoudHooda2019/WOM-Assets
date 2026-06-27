package wom.view.mediator.ui.tooltip
{
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.ui.MobileStarlingTooltipEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.game.WomGameRootHolder;
   import wom.view.ui.tooltip.MobileTooltipLayer;
   
   public class MobileTooltipLayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTooltipLayer;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function MobileTooltipLayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("mobileTooltipEventShow",onTooltipShow,MobileTooltipEvent);
         addContextListener("mobileTooltipEventClose",onTooltipClose,MobileTooltipEvent);
         eventMap.mapStarlingListener(view,"closeTooltipTriggered",onCloseTooltipTriggered,MobileStarlingTooltipEvent);
      }
      
      private function onCloseTooltipTriggered(param1:MobileStarlingTooltipEvent) : void
      {
         gameRootHolder.gameRoot.hideRangeInSpyModeIfApplicable();
      }
      
      private function onTooltipClose(param1:MobileTooltipEvent) : void
      {
         view.clear();
      }
      
      private function onTooltipShow(param1:MobileTooltipEvent) : void
      {
         view.showTooltip(param1.tooltipView,param1.x,param1.y);
      }
   }
}

