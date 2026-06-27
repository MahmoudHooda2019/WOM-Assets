package wom.view.mediator.screen
{
   import flash.events.Event;
   import flash.geom.Rectangle;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.core.Starling;
   import starling.events.Event;
   import wom.Environment;
   import wom.controller.event.StopRootUpdaterEvent;
   import wom.model.component.WomPlannerRootV2;
   import wom.view.screen.MobileCityPlannerScreen;
   
   public class MobileCityPlannerScreenMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCityPlannerScreen;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var plannerRoot:WomPlannerRootV2;
      
      public function MobileCityPlannerScreenMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         plannerRoot.init();
         addViewListener("addedToStage",onAddedToStage);
         Environment.stage.addEventListener("enterFrame",onNativeEnterFrame);
         Environment.starling.shareContext = true;
         plannerRoot.active = true;
         plannerRoot.continueUserInteract();
      }
      
      override public function onRemove() : void
      {
         Environment.stage.removeEventListener("enterFrame",onNativeEnterFrame);
         Environment.starling.shareContext = false;
         plannerRoot.active = false;
         plannerRoot.reset();
         plannerRoot.stopUserInteract();
      }
      
      private function onAddedToStage(param1:starling.events.Event) : void
      {
         onStageResize();
         eventMap.mapStarlingListener(view.stage,"resize",onStageResize);
         addContextListener("stopRoot",onStopRoot,StopRootUpdaterEvent);
      }
      
      private function onStageResize(param1:starling.events.Event = null) : void
      {
         var _loc4_:int = view.stage.stageWidth - 0 * 2;
         var _loc3_:int = view.stage.stageHeight - 0 * 2;
         var _loc2_:Number = Starling.current.contentScaleFactor;
         plannerRoot.render.canvasRect = new Rectangle(0 * _loc2_,0 * _loc2_,_loc4_ * _loc2_,_loc3_ * _loc2_);
         var _loc5_:Viewport = plannerRoot.viewport;
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
      
      private function onNativeEnterFrame(param1:flash.events.Event) : void
      {
         plannerRoot.update();
      }
   }
}

