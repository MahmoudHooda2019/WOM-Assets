package wom.view.mediator.ui.tutorial.mobile
{
   import flash.geom.Point;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.view.ui.tutorial.mobile.MobileGenericTutorialWindow;
   
   public class MobileGenericTutorialWindowMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileGenericTutorialWindow;
      
      [Inject]
      public var injector:IInjector;
      
      public function MobileGenericTutorialWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         addViewListener("getPosition",onGetPosition,Event);
         addViewListener("positionReady",onPositionReady,Event);
         addContextListener("getTutorialDoneButtonPosition",onTutorialDoneButtonPositionRequested,TutorialReferencePositionEvent);
      }
      
      private function onTutorialDoneButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:Point = null;
         if(view.doneButton)
         {
            _loc2_ = view.doneButton.localToGlobal(new Point());
            _loc2_.x += view.doneButton.width - 50;
            dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_,param1.additionalInfo));
         }
      }
      
      private function onGetPosition(param1:Event) : void
      {
         var _loc2_:Object = param1.data;
         dispatch(new TutorialReferencePositionEvent(_loc2_.actionType,_loc2_.objectToBeAligned,null,_loc2_.additionalInfo));
      }
      
      private function onPositionReady(param1:Event) : void
      {
         var _loc2_:Object = param1.data;
         dispatch(new TutorialReferencePositionEvent("positionReady",_loc2_.objectToBeAligned,_loc2_.position));
      }
   }
}

