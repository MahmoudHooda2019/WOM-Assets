package wom.view.mediator.screen
{
   import flash.utils.Dictionary;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.display.ViewportResizeEvent;
   import starling.events.Event;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.WomScreenType;
   import wom.service.RetrieveDevelopersService;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.MobileManualAuthenticationScreen;
   
   public class MobileManualAuthenticationScreenMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileManualAuthenticationScreen;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var retrieveDevelopersService:RetrieveDevelopersService;
      
      public function MobileManualAuthenticationScreenMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         resizeScreen(contextView.stage.stageWidth,contextView.stage.stageHeight);
         addContextListener("resize",onScreenResize,ViewportResizeEvent);
         addContextListener("platformUsersUpdated",updateUserNameTextFields);
         eventMap.mapStarlingListener(view.list,"change",onListItemChange);
      }
      
      private function onListItemChange(param1:Event) : void
      {
         var _loc2_:Dictionary = new Dictionary();
         _loc2_["manuel"] = true;
         dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING,_loc2_));
         retrieveDevelopersService.loadDeveloperDetail(view.list.selectedItem.id);
      }
      
      private function onScreenResize(param1:ViewportResizeEvent) : void
      {
         resizeScreen(contextView.stage.stageWidth,contextView.stage.stageHeight);
      }
      
      private function resizeScreen(param1:int, param2:int) : void
      {
         view.visibleWidth = param1;
         view.visibleHeight = param2;
         view.resizeScreen();
      }
      
      private function updateUserNameTextFields(param1:ModelUpdateEvent) : void
      {
         var _loc2_:Object = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < view.list.dataProvider.length)
         {
            _loc2_ = view.list.dataProvider.getItemAt(_loc3_);
            _loc2_.username = facebookAPIManager.getUserName(_loc2_.id,"",true);
            view.list.dataProvider.updateItemAt(_loc3_);
            _loc3_++;
         }
      }
   }
}

