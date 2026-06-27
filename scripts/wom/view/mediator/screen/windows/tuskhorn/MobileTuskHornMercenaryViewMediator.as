package wom.view.mediator.screen.windows.tuskhorn
{
   import flash.utils.getTimer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ui.TuskHornSelectMercenaryEvent;
   import wom.view.mediator.ui.common.MobileMercenaryButtonViewMediator;
   import wom.view.screen.windows.tuskhorn.MobileTuskHornMercenaryView;
   
   public class MobileTuskHornMercenaryViewMediator extends MobileMercenaryButtonViewMediator
   {
      
      [Inject]
      public var view:MobileTuskHornMercenaryView;
      
      private var pressDownCount:int;
      
      private var mouseDownForPlusButton:Boolean = false;
      
      private var mouseDownForMinusButton:Boolean = false;
      
      private var lastEventHandledTime:Number;
      
      public function MobileTuskHornMercenaryViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         pressDownCount = 0;
         addViewListener("enterFrame",onEnterFrame,Event);
         eventMap.mapStarlingListener(view.mercButton,"touch",onTouchMercenary,TouchEvent);
         eventMap.mapStarlingListener(view.subButton,"touch",onTouchCancelMercenary,TouchEvent);
         eventMap.mapStarlingListener(view.mercButton,"triggered",onPlusButtonClicked,Event);
         eventMap.mapStarlingListener(view.subButton,"triggered",onMinusButtonClicked,Event);
      }
      
      private function onTouchMercenary(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.mercButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForPlusButton = true;
            lastEventHandledTime = getTimer() + 250;
         }
         var _loc3_:Touch = param1.getTouch(view.mercButton,"ended");
         if(_loc3_)
         {
            mouseDownForPlusButton = false;
         }
      }
      
      private function onTouchCancelMercenary(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.subButton,"began");
         if(_loc2_)
         {
            pressDownCount = 0;
            mouseDownForMinusButton = true;
            lastEventHandledTime = getTimer() + 250;
         }
         var _loc3_:Touch = param1.getTouch(view.subButton,"ended");
         if(_loc3_)
         {
            mouseDownForMinusButton = false;
         }
      }
      
      private function plusButtonClicked() : void
      {
         eventDispatcher.dispatchEvent(new TuskHornSelectMercenaryEvent("plus",view.unitTypeDIO.id));
      }
      
      private function onPlusButtonClicked(param1:Event) : void
      {
         plusButtonClicked();
      }
      
      private function minusButtonClicked() : void
      {
         eventDispatcher.dispatchEvent(new TuskHornSelectMercenaryEvent("minus",view.unitTypeDIO.id));
      }
      
      private function onMinusButtonClicked(param1:Event) : void
      {
         minusButtonClicked();
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(mouseDownForPlusButton)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               plusButtonClicked();
            }
         }
         if(mouseDownForMinusButton)
         {
            if(getTimer() > lastEventHandledTime + (pressDownCount > 5 ? 10 : 50))
            {
               pressDownCount = pressDownCount + 1;
               lastEventHandledTime = getTimer();
               minusButtonClicked();
            }
         }
      }
   }
}

