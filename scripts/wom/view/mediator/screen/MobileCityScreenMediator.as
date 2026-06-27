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
   import wom.model.component.CoreManager;
   import wom.model.game.WomGameRootHolder;
   import wom.view.screen.MobileCityScreen;
   
   public class MobileCityScreenMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCityScreen;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      public function MobileCityScreenMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addViewListener("addedToStage",onAddedToStage);
         Environment.stage.addEventListener("enterFrame",onNativeEnterFrame,false,0,true);
         Environment.starling.shareContext = true;
         gameRootHolder.gameRoot.active = true;
         gameRootHolder.gameRoot.continueUserInteract();
      }
      
      override public function onRemove() : void
      {
         Environment.stage.removeEventListener("enterFrame",onNativeEnterFrame);
         Environment.starling.shareContext = false;
         gameRootHolder.gameRoot.active = false;
         gameRootHolder.gameRoot.stopUserInteract();
      }
      
      private function onAddedToStage(param1:starling.events.Event) : void
      {
         eventMap.mapListener(Environment.stage,"keyDown",gameRootHolder.gameRoot.keyPressed,KeyboardEvent);
         onStageResize();
         eventMap.mapStarlingListener(view.stage,"resize",onStageResize);
         addContextListener("stopRoot",onStopRoot,StopRootUpdaterEvent);
      }
      
      private function onStageResize(param1:starling.events.Event = null) : void
      {
         var _loc4_:int = view.stage.stageWidth - 0 * 2;
         var _loc3_:int = view.stage.stageHeight - 0 * 2;
         var _loc2_:Number = Starling.current.contentScaleFactor;
         gameRootHolder.gameRoot.render.canvasRect = new Rectangle(0 * _loc2_,0 * _loc2_,_loc4_ * _loc2_,_loc3_ * _loc2_);
         var _loc5_:Viewport = gameRootHolder.gameRoot.viewport;
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
      
      protected function onNativeEnterFrame(param1:flash.events.Event) : void
      {
         gameRootHolder.gameRoot.update();
      }
   }
}

