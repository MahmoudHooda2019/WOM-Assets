package wom.view.mediator.ui.mainframe.city
{
   import flash.utils.Timer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.store.ItemEffectInfo;
   import wom.view.ui.mainframe.city.MobileProtectionPanel;
   import wom.view.ui.tooltip.MobileInformativeTooltipView;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileProtectionPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileProtectionPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      private var tickAdded:Boolean;
      
      internal var timer:Timer;
      
      public function MobileProtectionPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         tickAdded = false;
         injector.injectInto(view);
         addContextListener("storeItemEffectsUpdated",onDetermineProtectionEffect);
         addContextListener("damageProtectionChanged",onDetermineProtectionEffect);
         addContextListener("mandatoryTutorialsCompleted",mandatoryTutorialsCompleted,TutorialEvent);
         eventMap.mapStarlingListener(view,"touch",onTab,TouchEvent);
         addContextListener("mobileTooltipEventClose",onTooltipClosed,MobileTooltipEvent);
         determineProtectionEffect();
      }
      
      private function onTooltipClosed(param1:MobileTooltipEvent) : void
      {
         removeContextListener("tick",onTick);
      }
      
      private function onTab(param1:Event) : void
      {
         var _loc2_:Touch = (param1 as TouchEvent).getTouch(view,"ended");
         if(_loc2_)
         {
            view.tooltip = new MobileInformativeTooltipView("protection",352,127);
            dispatch(new MobileTooltipEvent("mobileTooltipEventShow",view.tooltip,view.x - 42,view.y + 67));
            onTick(null);
         }
      }
      
      private function determineProtectionEffect() : void
      {
         var _loc1_:ItemEffectInfo = userInfo ? userInfo.activeDamageProtectionWithBegginerProtection : null;
         if(_loc1_)
         {
            addTickListener();
         }
         else
         {
            removeTickListener();
         }
      }
      
      private function onDetermineProtectionEffect(param1:ModelUpdateEvent) : void
      {
         determineProtectionEffect();
      }
      
      private function removeTickListener() : void
      {
         if(tickAdded)
         {
            tickAdded = false;
            removeContextListener("tick",onTick,GameTickEvent);
         }
         view.visible = false;
      }
      
      private function addTickListener() : void
      {
         if(!tickAdded)
         {
            tickAdded = true;
            addContextListener("tick",onTick,GameTickEvent);
         }
         view.visible = true;
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:ItemEffectInfo = userInfo ? userInfo.activeDamageProtectionWithBegginerProtection : null;
         if(_loc2_)
         {
            _loc3_ = _loc2_.durationRemaining + _loc2_.creationDate - new Date().getTime();
            if(_loc3_ < 0)
            {
               removeTickListener();
            }
            else
            {
               view.updateRemainingDuration(LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(_loc3_));
            }
         }
         else
         {
            removeTickListener();
         }
      }
      
      private function mandatoryTutorialsCompleted(param1:TutorialEvent) : void
      {
         removeContextListener("mandatoryTutorialsCompleted",mandatoryTutorialsCompleted,TutorialEvent);
         view.updateRemainingDuration(LocalizedDateTimeUtil.getUserFriendlyTimeWithoutSeconds(259199832));
         view.visible = true;
      }
   }
}

