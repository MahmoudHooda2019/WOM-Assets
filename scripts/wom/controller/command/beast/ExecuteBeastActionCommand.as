package wom.controller.command.beast
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import wom.controller.PCommand;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.beast.BeastActionEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.dto.UnitTypeAmountDTO;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.unit.UnitInfo;
   import wom.model.message.request.EvolveBeastRequest;
   import wom.model.message.request.HealBeastRequest;
   import wom.model.message.request.TrainBeastRequest;
   import wom.view.screen.popups.notenough.MobileNotEnoughPopup;
   
   public class ExecuteBeastActionCommand extends PCommand
   {
      
      [Inject]
      public var beastActionEvent:BeastActionEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function ExecuteBeastActionCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc8_:BeastTypeDIO = null;
         var _loc2_:Dictionary = null;
         var _loc3_:int = 0;
         var _loc5_:Dictionary = null;
         var _loc10_:* = undefined;
         var _loc4_:UnitTypeAmountDTO = null;
         var _loc7_:Boolean = false;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         if(beastActionEvent.actionType == "train")
         {
            if(city.beast == null)
            {
               var _temp_2:* = §§findproperty(MobileUINotificationEvent);
               var _temp_1:* = "mobileUINotificationEventShow";
               var _loc13_:String = "ui.popups.actionnotpossible.type.96";
               dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc13_)));
               return;
            }
            if(city.beast.jobScheduler.preTrainingJob != null)
            {
               var _temp_5:* = §§findproperty(MobileUINotificationEvent);
               var _temp_4:* = "mobileUINotificationEventShow";
               var _loc14_:String = "ui.popups.actionnotpossible.type.95";
               dispatch(new MobileUINotificationEvent(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc14_)));
               return;
            }
            _loc8_ = domainInfo.getBeast(city.beast.typeId);
            _loc2_ = domainInfo.getUnitMap();
            _loc5_ = new Dictionary();
            if(city.beast.level >= _loc8_.maxLevels)
            {
               _loc10_ = city.beast.bonusStage >= _loc8_.maxBonusStages ? _loc8_.trainingCostsPerStage[_loc8_.maxBonusStages - 1] : _loc8_.trainingCostsPerStage[city.beast.bonusStage];
            }
            else
            {
               _loc10_ = _loc8_.trainingCostsPerLevel[city.beast.level - 1];
            }
            _loc3_ = 0;
            while(_loc3_ < _loc10_.length)
            {
               _loc5_[_loc10_[_loc3_].id] = new Vector.<UnitInfo>();
               _loc3_++;
            }
            _loc3_ = 0;
            while(_loc3_ < _loc10_.length)
            {
               _loc4_ = _loc10_[_loc3_];
               for each(var _loc1_ in city.units)
               {
                  if(_loc1_.typeId == _loc4_.id)
                  {
                     _loc5_[_loc4_.id].push(_loc1_);
                  }
                  if(_loc5_[_loc4_.id].length == _loc4_.amount)
                  {
                     break;
                  }
               }
               _loc3_++;
            }
            _loc7_ = true;
            _loc3_ = 0;
            while(_loc3_ < _loc10_.length)
            {
               if(_loc5_[_loc10_[_loc3_].id].length != _loc10_[_loc3_].amount)
               {
                  _loc7_ = false;
                  break;
               }
               _loc3_++;
            }
            if(!_loc7_)
            {
               var _temp_8:* = §§findproperty(MobileUINotificationEvent);
               var _temp_7:* = "mobileUINotificationEventShow";
               var _loc15_:String = "ui.popups.actionnotpossible.type.93";
               dispatch(new MobileUINotificationEvent(_temp_7,peak.i18n.PText.INSTANCE.getText0(_loc15_)));
               return;
            }
            soundPlayer.playSfxById("UseResources");
            dispatch(new OutgoingMessageEvent("outgoingMessage",new TrainBeastRequest(false)));
         }
         else if(beastActionEvent.actionType == "evolve")
         {
            if(city.beast == null)
            {
               var _temp_11:* = §§findproperty(MobileUINotificationEvent);
               var _temp_10:* = "mobileUINotificationEventShow";
               var _loc16_:String = "ui.popups.actionnotpossible.type.96";
               dispatch(new MobileUINotificationEvent(_temp_10,peak.i18n.PText.INSTANCE.getText0(_loc16_)));
               return;
            }
            _loc8_ = domainInfo.getBeast(city.beast.typeId);
            if(city.beast.jobScheduler.preTrainingJob != null && city.beast.level >= _loc8_.maxLevels && city.beast.bonusStage >= _loc8_.maxBonusStages)
            {
               var _temp_16:* = §§findproperty(MobileUINotificationEvent);
               var _temp_15:* = "mobileUINotificationEventShow";
               var _loc17_:String = "ui.popups.actionnotpossible.type.95";
               dispatch(new MobileUINotificationEvent(_temp_15,peak.i18n.PText.INSTANCE.getText0(_loc17_)));
               return;
            }
            if(city.beast.level >= _loc8_.maxLevels)
            {
               _loc9_ = int(city.beast.bonusStage >= _loc8_.maxBonusStages ? _loc8_.levelUpGoldCostsPerStage[_loc8_.maxBonusStages - 1] : _loc8_.levelUpGoldCostsPerStage[city.beast.bonusStage]);
            }
            else
            {
               _loc9_ = _loc8_.levelUpGoldCostsPerLevel[city.beast.level - 1];
            }
            if(userInfo.numberOfGolds < _loc9_)
            {
               dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileNotEnoughPopup("gold")));
               return;
            }
            soundPlayer.playSfxById("PurchaseSuccessful");
            dispatch(new OutgoingMessageEvent("outgoingMessage",new EvolveBeastRequest()));
         }
         else if(beastActionEvent.actionType == "heal")
         {
            if(city.beast == null)
            {
               var _temp_19:* = §§findproperty(MobileUINotificationEvent);
               var _temp_18:* = "mobileUINotificationEventShow";
               var _loc18_:String = "ui.popups.actionnotpossible.type.96";
               dispatch(new MobileUINotificationEvent(_temp_18,peak.i18n.PText.INSTANCE.getText0(_loc18_)));
               return;
            }
            _loc8_ = domainInfo.getBeast(city.beast.typeId);
            _loc6_ = int(city.beast.bonusStage > 0 ? _loc8_.healthPointsPerStage[city.beast.bonusStage - 1] : _loc8_.healthPointsPerLevel[city.beast.level - 1]);
            if(city.beast.healthPoints >= _loc6_)
            {
               var _temp_22:* = §§findproperty(MobileUINotificationEvent);
               var _temp_21:* = "mobileUINotificationEventShow";
               var _loc19_:String = "ui.popups.actionnotpossible.type.94";
               dispatch(new MobileUINotificationEvent(_temp_21,peak.i18n.PText.INSTANCE.getText0(_loc19_)));
               return;
            }
            dispatch(new OutgoingMessageEvent("outgoingMessage",new HealBeastRequest()));
         }
      }
   }
}

