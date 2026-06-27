package wom.view.mediator.screen.windows.beast.keeper
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.beast.BeastStatusType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.job.BuildingUpgradeJobType;
   import wom.model.message.request.CaptureBeastRequest;
   import wom.model.message.request.FreezeBeastRequest;
   import wom.model.message.request.ThawBeastRequest;
   import wom.view.mediator.util.MobileBaseWindowPanelMediator;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperItemView;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperItemViewRenderer;
   import wom.view.screen.windows.beast.keeper.MobileBeastKeeperPanel;
   import wom.view.screen.windows.tavern.MobileTavernWindow;
   
   public class MobileBeastKeeperPanelMediator extends MobileBaseWindowPanelMediator
   {
      
      [Inject]
      public var view:MobileBeastKeeperPanel;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      public function MobileBeastKeeperPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         eventMap.mapStarlingListener(view.beastList,"rendererAdd",onRendererAdded,Event);
         addContextListener("beastUpdated",onBeastUpdated,ModelUpdateEvent);
         view.fillBeasts(city.beast,city.beastLevelBonusTuples,domainInfo.getBeasts());
      }
      
      private function onRendererAdded(param1:Event, param2:MobileBeastKeeperItemViewRenderer = null) : void
      {
         eventMap.mapStarlingListener(param2.beastView.caveButton,"triggered",onActionButtonClicked,Event);
         eventMap.mapStarlingListener(param2.beastView.unleashButton,"triggered",onActionButtonClicked,Event);
         eventMap.mapStarlingListener(param2.beastView.raiseButton,"triggered",onActionButtonClicked,Event);
         eventMap.mapStarlingListener(param2.beastView.getButton,"triggered",onActionButtonClicked,Event);
      }
      
      private function onBeastUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateAllBeastViews(city.beast,city.beastLevelBonusTuples,domainInfo.getBeasts());
      }
      
      private function beastCaveExist() : Boolean
      {
         var _loc2_:BuildingTypeDIO = null;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId == 29)
            {
               _loc2_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
               if(!_loc2_.isHealthy(_loc1_.level,_loc1_.healthPoint))
               {
                  var _temp_2:* = §§findproperty(MobileUINotificationEvent);
                  var _temp_1:* = "mobileUINotificationEventShow";
                  var _loc5_:String = "ui.popups.actionnotpossible.type.89";
                  dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc5_)));
                  return false;
               }
               return true;
            }
         }
         var _temp_5:* = §§findproperty(MobileUINotificationEvent);
         var _temp_4:* = "mobileUINotificationEventShow";
         var _loc6_:String = "ui.popups.actionnotpossible.type.90";
         dispatch(new MobileUINotificationEvent(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc6_)));
         return false;
      }
      
      private function beastKeeperCompleted() : Boolean
      {
         var _loc3_:BuildingInfo = null;
         for each(var _loc2_ in city.buildings)
         {
            if(_loc2_.buildingTypeId == 30)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         if(_loc3_ == null)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc10_:String = "ui.popups.actionnotpossible.type.103";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc10_)));
            return false;
         }
         var _loc1_:BuildingUpgradeJobType = BuildingUpgradeJobType.INVALID_JOB;
         var _loc5_:Boolean = false;
         for each(var _loc4_ in city.buildingUpgradeJobs)
         {
            if(_loc4_.instanceId == _loc3_.instanceId)
            {
               _loc1_ = _loc4_.type;
               _loc5_ = true;
               break;
            }
         }
         if(_loc5_ && _loc4_)
         {
            var _temp_7:* = §§findproperty(MobileUINotificationEvent);
            var _temp_6:* = "mobileUINotificationEventShow";
            var _loc11_:String = "ui.popups.actionnotpossible.type.102";
            dispatch(new MobileUINotificationEvent(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc11_)));
            return false;
         }
         return true;
      }
      
      private function cave(param1:BeastTypeDIO) : void
      {
         if(city.beast == null)
         {
            return;
         }
         var _loc2_:int = int(city.beast.bonusStage > 0 ? param1.healthPointsPerStage[city.beast.bonusStage - 1] : param1.healthPointsPerLevel[city.beast.level - 1]);
         if(city.beast.healthPoints < _loc2_)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc3_:String = "ui.popups.actionnotpossible.type.9";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc3_)));
            return;
         }
         if(beastKeeperCompleted())
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new FreezeBeastRequest()));
         }
      }
      
      private function unleash(param1:BeastTypeDIO) : void
      {
         if(city.beast != null)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "ui.error.thawbeast.2.desc";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         else if(beastCaveExist())
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ThawBeastRequest(param1.id)));
         }
      }
      
      private function raise(param1:BeastTypeDIO) : void
      {
         if(city.beast != null)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "ui.error.raisebeast.cavefirst";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         else if((city.beastLevelBonusTuples == null || !(param1.id in city.beastLevelBonusTuples)) && beastCaveExist())
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new CaptureBeastRequest(param1.id)));
         }
      }
      
      private function onActionButtonClicked(param1:Event) : void
      {
         var _loc2_:BeastStatusType = ((param1.target as MPButton).parent as MobileBeastKeeperItemView).beastStatusType;
         var _loc3_:BeastTypeDIO = ((param1.target as MPButton).parent as MobileBeastKeeperItemView).beastDIO;
         switch(_loc2_)
         {
            case BeastStatusType.IN_CAVE:
               cave(_loc3_);
               break;
            case BeastStatusType.IN_KEEPER:
               unleash(_loc3_);
               break;
            case BeastStatusType.NON_RAISED:
               if(_loc3_.unlocked)
               {
                  raise(_loc3_);
               }
               else
               {
                  dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileTavernWindow()));
                  dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
               }
         }
      }
   }
}

