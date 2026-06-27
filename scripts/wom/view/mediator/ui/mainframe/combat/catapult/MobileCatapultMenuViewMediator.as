package wom.view.mediator.ui.mainframe.combat.catapult
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.util.DateTimeUtil;
   import starling.events.Event;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.combat.CombatEventItemsEvent;
   import wom.controller.event.mobile.MobileCatapultCombatRechargeStartedEvent;
   import wom.controller.event.ui.MobileCatapultMenuEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultCombatRechargePopUp;
   import wom.view.ui.mainframe.combat.catapult.MobileCatapultMenuView;
   
   public class MobileCatapultMenuViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileCatapultMenuView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var cityInfo:CityStatusInfo;
      
      public function MobileCatapultMenuViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.button,"triggered",onViewClicked,Event);
         eventMap.mapStarlingListener(view.button,"change",onViewChanged,Event);
         addContextListener("selected",onSelected,MobileCatapultMenuEvent);
         addContextListener("attackInfoUpdated",onAttackInfoUpdated);
         addContextListener("attackingUnitUpdated",onAttackingUnitsUpdated);
         addContextListener("tick",onGameTick,GameTickEvent);
         addContextListener("gameModeChange",determineViewState,GameModeChangedEvent);
         addContextListener("itemsTabOpened",onItemsTabOpened,CombatEventItemsEvent);
         addContextListener("combatCatapultRechargeStarted",onRechargeStarted);
         determineViewState(null);
      }
      
      private function determineViewState(param1:GameModeChangedEvent) : void
      {
         var _loc6_:Boolean = false;
         var _loc5_:int = 0;
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         if(userInfo.gameMode == GameModeType.ATTACK)
         {
            _loc6_ = checkCatapultLevelAppropriate();
            _loc5_ = int(userInfo.catapultActivationRemainingTimes[view.type].catapultTime);
            _loc2_ = _loc5_ <= 0;
            if(!_loc6_)
            {
               view.switchButtonState(3);
            }
            else if(!_loc2_)
            {
               view.switchButtonState(4);
            }
            else
            {
               view.switchButtonState(0);
            }
            view.refreshButtonAppearance(true);
         }
         else if(userInfo.gameMode == GameModeType.TUSK_HORN)
         {
            _loc4_ = 0;
            for each(var _loc3_ in cityInfo.buildings)
            {
               if(_loc3_.buildingTypeId == 25)
               {
                  _loc4_ = _loc3_.level;
                  break;
               }
            }
            if(view.type == 1 && _loc4_ < 1 || view.type == 2 && _loc4_ < 4 || view.type == 3 && _loc4_ < 7)
            {
               view.switchButtonState(3);
            }
         }
         else if(userInfo.gameMode == GameModeType.VISIT)
         {
            view.switchButtonState(3);
         }
      }
      
      private function checkCatapultLevelAppropriate() : Boolean
      {
         var _loc1_:int = attackInfo.catapultLevel;
         return view.type == 1 && _loc1_ >= 1 || view.type == 2 && _loc1_ >= 2 || view.type == 3 && _loc1_ >= 3;
      }
      
      private function onSelected(param1:MobileCatapultMenuEvent) : void
      {
         if(param1.view != view)
         {
            view.button.isSelected = false;
         }
      }
      
      private function onGameTick(param1:GameTickEvent) : void
      {
         var _loc2_:Number = NaN;
         if(userInfo.gameMode == GameModeType.ATTACK)
         {
            if(view.buttonState == 4)
            {
               _loc2_ = Number(userInfo.catapultActivationRemainingTimes[view.type].catapultTime);
               if(_loc2_ <= 0)
               {
                  view.switchButtonState(0);
               }
               else
               {
                  view.rechargeRemainingTimeTF.text = DateTimeUtil.getFormattedTime(_loc2_).substring(3,8);
               }
            }
            else if(view.buttonState != 2 && view.buttonState != 3)
            {
               view.button.isEnabled = true;
            }
         }
      }
      
      private function onAttackInfoUpdated(param1:ModelUpdateEvent) : void
      {
         if(attackInfo.salvosUsed[view.type])
         {
            view.switchButtonState(2);
            if(view.button.isSelected)
            {
               view.button.isSelected = false;
               dispatch(new MobileCatapultMenuEvent("unselected",view,null));
            }
         }
      }
      
      private function onAttackingUnitsUpdated(param1:ModelUpdateEvent) : void
      {
         if(!attackInfo.salvosUsed[view.type] && view.buttonState == 1)
         {
            if(view.button.isSelected)
            {
               view.button.isSelected = false;
            }
            view.switchButtonState(0);
            dispatch(new MobileCatapultMenuEvent("unselected",view,null));
         }
      }
      
      private function onViewClicked(param1:Event) : void
      {
         if(view.buttonState == 0)
         {
            if(view.catapultMenuTab.activeCatapultMenuOptions == null)
            {
               view.catapultMenuTab.activeCatapultMenuOptions = view.catapultMenuOptions;
            }
            if(view.catapultMenuTab.activeCatapultMenuOptions == view.catapultMenuOptions)
            {
               view.updateCatapultMenuOptionsVisibility(!view.catapultMenuOptions.visible);
            }
            else
            {
               view.catapultMenuTab.activeCatapultMenuOptions.visible = false;
               view.catapultMenuTab.activeCatapultMenuOptions = view.catapultMenuOptions;
               view.updateCatapultMenuOptionsVisibility(true);
               view.drawLayout();
            }
         }
         else if(view.buttonState == 1)
         {
            disableCatapultSelection();
         }
         else if(view.buttonState == 4)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileCatapultCombatRechargePopUp(view.type)));
            view.button.isSelected = true;
         }
      }
      
      private function onRechargeStarted(param1:MobileCatapultCombatRechargeStartedEvent) : void
      {
         if(param1.catapultType == view.type)
         {
            view.button.isEnabled = false;
         }
      }
      
      private function onViewChanged(param1:Event) : void
      {
         if(view.button.isSelected)
         {
            dispatch(new MobileCatapultMenuEvent("selected",view,param1));
         }
         else
         {
            dispatch(new MobileCatapultMenuEvent("unselected",view,param1));
         }
      }
      
      private function disableCatapultSelection() : void
      {
         if(view.button.isSelected)
         {
            view.button.isSelected = false;
         }
         coreManager.setDeployDiameter(0,2);
         view.updateCatapultMenuOptionsVisibility(false);
         dispatch(new MobileCatapultMenuEvent("unselected",view,null));
         view.switchButtonState(0);
      }
      
      private function onItemsTabOpened(param1:CombatEventItemsEvent) : void
      {
         if(view.buttonState == 1)
         {
            disableCatapultSelection();
         }
      }
   }
}

