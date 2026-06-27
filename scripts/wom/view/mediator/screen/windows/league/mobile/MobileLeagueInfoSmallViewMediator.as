package wom.view.mediator.screen.windows.league.mobile
{
   import flash.events.Event;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import wom.controller.event.ModelUpdateEvent;
   import wom.view.screen.windows.league.mobile.MobileLeagueInfoSmallView;
   
   public class MobileLeagueInfoSmallViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileLeagueInfoSmallView;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileLeagueInfoSmallViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.leagueAsset,"change",onAssetChanged,Event);
         if(!view.leagueAssetOnly)
         {
            eventMap.mapStarlingListener(view.minBPToJoinIcon,"change",onAssetChanged,Event);
         }
      }
      
      private function onAssetChanged(param1:Event) : void
      {
         view.drawLayout();
         dispatch(new ModelUpdateEvent("leagueInfoViewUpdated"));
      }
   }
}

