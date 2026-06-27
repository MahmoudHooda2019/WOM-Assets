package wom.controller.command.beast
{
   import flash.utils.Dictionary;
   import wom.controller.PCommand;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.factory.DefaultUnitFactory;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.beast.BeastJobScheduler;
   import wom.model.game.beast.FrozenBeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.notification.BeastStatusChangedEventNotification;
   import wom.view.screen.windows.beast.cave.BeastCaveWindow;
   
   public class HandleBeastStatusChangedEventNotificationCommand extends PCommand
   {
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var coreManager:CoreManager;
      
      public function HandleBeastStatusChangedEventNotificationCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Boolean = false;
         var _loc4_:BeastStatusChangedEventNotification = messageReceivedEvent.message as BeastStatusChangedEventNotification;
         var _loc3_:BeastInfo = _loc4_.beastView;
         if(_loc3_ != null)
         {
            _loc3_.jobScheduler = BeastJobScheduler.createBeastJobScheduler(_loc4_.beastJobSchedulerView,domainInfo.getBeast(_loc3_.typeId),userInfo.serverSpeed);
            _loc1_ = false;
            if(city.beastLevelBonusTuples != null && "" + _loc3_.typeId in city.beastLevelBonusTuples)
            {
               _loc3_.instanceId = (city.beastLevelBonusTuples[_loc3_.typeId] as FrozenBeastInfo).instanceId;
               delete city.beastLevelBonusTuples[_loc3_.typeId];
            }
            else if(!city.beast)
            {
               _loc1_ = true;
               _loc3_.instanceId = DefaultUnitFactory.generateUnitId();
            }
            else
            {
               _loc3_.instanceId = city.beast.instanceId;
               coreManager.notifyBeastModelChange(_loc3_);
            }
            _loc3_.status = UnitStatusType.IN_CAVE;
            for each(var _loc2_ in city.buildings)
            {
               if(_loc2_.buildingTypeId == 29)
               {
                  _loc3_.buildingId = _loc2_.instanceId;
                  break;
               }
            }
            if(!city.beast)
            {
               if(_loc1_)
               {
                  coreManager.setBeast(_loc3_);
               }
               else
               {
                  coreManager.sendBeastToBeastCave(_loc3_);
               }
            }
         }
         else if(city.beast != null)
         {
            if(city.beastLevelBonusTuples == null)
            {
               city.beastLevelBonusTuples = new Dictionary();
            }
            city.beastLevelBonusTuples[city.beast.typeId] = new FrozenBeastInfo(city.beast.instanceId,city.beast.level,city.beast.bonusStage);
            coreManager.sendBeastToBeastKeeper(city.beast);
         }
         city.beast = _loc3_;
         if(city.beast != null && city.beastOpenCaveAtNextNotification)
         {
            city.beastOpenCaveAtNextNotification = false;
            dispatch(new PopUpWindowEvent("showPopUpWindow",new BeastCaveWindow(domainInfo.getBuilding(30))));
         }
         dispatch(new ModelUpdateEvent("beastUpdated"));
      }
   }
}

