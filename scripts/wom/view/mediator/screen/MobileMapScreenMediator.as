package wom.view.mediator.screen
{
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Rectangle;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.core.Starling;
   import starling.events.Event;
   import wom.Environment;
   import wom.controller.event.StopRootUpdaterEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.ui.GetMapListWindowEvent;
   import wom.controller.event.ui.TownOptionsMenuEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.WomCampaignRoot;
   import wom.model.game.UserInfo;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.MobileMapScreen;
   
   public class MobileMapScreenMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileMapScreen;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var campaignRoot:WomCampaignRoot;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function MobileMapScreenMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         trace("MobileMapScreenMediator onRegister");
         injector.injectInto(view);
         campaignRoot.init();
         addViewListener("addedToStage",onAddedToStage);
         addContextListener("triggerWithoutShowing",enterTown,TownOptionsMenuEvent);
         Environment.stage.addEventListener("enterFrame",onNativeEnterFrame,false,0,true);
         Environment.starling.shareContext = true;
         campaignRoot.active = true;
         campaignRoot.continueUserInteract();
      }
      
      override public function onRemove() : void
      {
         trace("MobileMapScreenMediator onRemove");
         Environment.stage.removeEventListener("enterFrame",onNativeEnterFrame);
         Environment.starling.shareContext = false;
         campaignRoot.active = false;
         campaignRoot.reset();
         campaignRoot.stopUserInteract();
      }
      
      private function enterTown(param1:TownOptionsMenuEvent) : void
      {
         userInfo.fromMap = true;
         if(userInfo.mandatoryTutorialCompleted)
         {
            kontagentApi.trackUIEvent("war_menu","scout");
            kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"visit_button"});
            dispatch(new StartVisitEvent("startVisit",param1.mapTileData.mapMemberInfo.profile,param1.mapTileData.mapMemberInfo.profile.isNpc,true,true,true));
         }
         else
         {
            kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"attack_button"});
            kontagentApi.trackUIEvent("war_menu","attack");
            dispatch(new StartAttackEvent("startAttack",param1.mapTileData.mapMemberInfo.profile,param1.mapTileData.mapMemberInfo.profile.isNpc,false,true,true,false,true));
         }
      }
      
      private function onAddedToStage(param1:starling.events.Event) : void
      {
         eventMap.mapListener(Environment.stage,"keyDown",campaignRoot.keyPressed,KeyboardEvent);
         onStageResize();
         eventMap.mapStarlingListener(view.stage,"resize",onStageResize);
         addContextListener("stopRoot",onStopRoot,StopRootUpdaterEvent);
      }
      
      private function onStageResize(param1:starling.events.Event = null) : void
      {
         var _loc4_:int = view.stage.stageWidth - 0 * 2;
         var _loc3_:int = view.stage.stageHeight - 0 * 2;
         var _loc2_:Number = Starling.current.contentScaleFactor;
         campaignRoot.render.canvasRect = new Rectangle(0 * _loc2_,0 * _loc2_,_loc4_ * _loc2_,_loc3_ * _loc2_);
         var _loc5_:Viewport = campaignRoot.viewport;
         if(_loc5_.rect.x < _loc5_.bounds.x || _loc5_.rect.x + _loc5_.rect.width > _loc5_.bounds.x + _loc5_.bounds.width || _loc5_.rect.y < _loc5_.bounds.y || _loc5_.rect.y + _loc5_.rect.height > _loc5_.bounds.y + _loc5_.bounds.height)
         {
            _loc5_.moveTo(_loc5_.rect.x,_loc5_.rect.y);
         }
         undefined;
      }
      
      private function onStopRoot(param1:StopRootUpdaterEvent) : void
      {
         Environment.stage.removeEventListener("enterFrame",onNativeEnterFrame);
      }
      
      private function onMapReady(param1:GetMapListWindowEvent) : void
      {
         if(view.openMapListWindowAfterInitialization)
         {
            view.openMapListWindowAfterInitialization = false;
            dispatch(new GetMapListWindowEvent("showMapListWindow"));
         }
      }
      
      protected function onNativeEnterFrame(param1:flash.events.Event) : void
      {
         campaignRoot.update();
      }
   }
}

