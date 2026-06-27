package wom.view.mediator.ui.mainframe.visit
{
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.mediator.ui.mainframe.MobileUILayerMediator;
   import wom.view.ui.mainframe.visit.MobileVisitUILayer;
   
   public class MobileVisitUILayerMediator extends MobileUILayerMediator
   {
      
      [Inject]
      public var view:MobileVisitUILayer;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function MobileVisitUILayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.settingsView,"touch",onSettingsClicked,TouchEvent);
      }
      
      private function onSettingsClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.settingsView,"ended");
         if(_loc2_)
         {
            dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(203,{})));
         }
      }
   }
}

