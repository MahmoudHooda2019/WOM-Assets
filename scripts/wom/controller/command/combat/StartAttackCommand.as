package wom.controller.command.combat
{
   import wom.controller.command.visit.PersistAttackInformationCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.CoreManager;
   import wom.model.domain.domaininfoobject.CatapultTypeDIO;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.CatapultTimeDTO;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.beast.BeastInfo;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.resource.ResourceType;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.message.request.StartAttackRequest;
   import wom.model.message.request.StartQuickAttackRequest;
   import wom.model.message.request.alliance.TournamentAttackRequest;
   import wom.view.screen.popups.attack.MobileAttackWarnPopup;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   
   public class StartAttackCommand extends PersistAttackInformationCommand
   {
      
      public static const RESOURCE_CAPACITY_WARN_RATIO:Number = 0.8;
      
      [Inject]
      public var event:StartAttackEvent;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      public function StartAttackCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc1_:Boolean = false;
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            userInfo.redirectToMap = event.fromMap;
            userInfo.mapInCampaignMode = event.fromCampaign;
         }
         if(checkAttackConstraints())
         {
            return;
         }
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            for each(var _loc4_ in ResourceType.resourceTypes)
            {
               _loc3_ += city.resourceAmounts[_loc4_.id];
            }
            _loc2_ = city.totalResourceCapacity;
         }
         else
         {
            for each(_loc4_ in ResourceType.resourceTypes)
            {
               _loc3_ += attackInfo.attackingUserResources[_loc4_.id];
            }
            _loc2_ = attackInfo.attackingUserResourceCapacity;
         }
         if(!event.tearProtection && !event.npc && userInfo.activeDamageProtectionWithBegginerProtection)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileAttackWarnPopup(true,event.profile,event.npc,event.isQuickAttack,event.isTournamentAttack,event.isTournamentAttackByGold),0,null,null,false,userInfo.delayPopups));
         }
         else if(event.checkResources && _loc3_ > _loc2_ * 0.8)
         {
            dispatch(new MobilePopUpWindowEvent("showSecondaryPopUpWindow",new MobileAttackWarnPopup(false,event.profile,event.npc,event.isQuickAttack,event.isTournamentAttack,event.isTournamentAttackByGold),0,null,null,false,userInfo.delayPopups));
         }
         else
         {
            if(userInfo.gameMode == GameModeType.NORMAL)
            {
               persistAttackingInformation();
            }
            _loc1_ = userInfo.gameMode == GameModeType.VISIT && visitInfo.isScout && (visitInfo.landlord.isNpc && visitInfo.landlord.npcId == event.profile.npcId || !visitInfo.landlord.isNpc && visitInfo.landlord.gameId == event.profile.gameId);
            if(!_loc1_)
            {
               dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
            }
            if(event.isTournamentAttack)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new TournamentAttackRequest(event.isTournamentAttackByGold)));
            }
            else
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",event.isQuickAttack ? new StartQuickAttackRequest() : (_loc1_ ? new StartAttackRequest(event.profile,city.version) : new StartAttackRequest(event.profile))));
            }
         }
      }
      
      protected function checkAttackConstraints() : Boolean
      {
         var _loc1_:Boolean = checkAttackingToolExists();
         if(!_loc1_)
         {
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAlreadyUnderAttackPopUp(1000,false),0,null,null,false,userInfo.delayPopups));
            return true;
         }
         return false;
      }
      
      private function checkAttackingToolExists() : Boolean
      {
         return checkBeastExists() || checkUnitExists() || checkCatapultLevel();
      }
      
      private function checkBeastExists() : Boolean
      {
         return userInfo.gameMode == GameModeType.NORMAL ? city.beast : attackInfo.beast;
      }
      
      private function checkUnitExists() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Vector.<UnitInfo> = userInfo.gameMode == GameModeType.NORMAL ? city.units : attackInfo.units;
         for each(var _loc1_ in _loc3_)
         {
            if(_loc1_.status != UnitStatusType.IN_WATCH_POST && _loc1_.status != UnitStatusType.DEFENDING)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_;
      }
      
      private function checkCatapultLevel() : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc2_:int = 0;
         var _loc3_:Array = userInfo.gameMode == GameModeType.NORMAL ? city.resourceAmounts : attackInfo.attackingUserResources;
         if(userInfo.gameMode == GameModeType.NORMAL)
         {
            for each(var _loc1_ in city.buildings)
            {
               if(_loc1_.buildingTypeId == 23)
               {
                  _loc2_ = _loc1_.level;
                  break;
               }
            }
         }
         else
         {
            _loc2_ = attackInfo.catapultLevel;
         }
         if(_loc2_ > 0 && checkCostAndRemainingTimeForCatapultResourceType(_loc3_,ResourceType.LUMBER.id,1) || _loc2_ > 1 && checkCostAndRemainingTimeForCatapultResourceType(_loc3_,ResourceType.STONE.id,2) || _loc2_ > 2 && checkCostAndRemainingTimeForCatapultResourceType(_loc3_,ResourceType.MIGHT.id,3))
         {
            _loc4_ = true;
         }
         return _loc4_;
      }
      
      private function checkCostAndRemainingTimeForCatapultResourceType(param1:Array, param2:int, param3:int) : Boolean
      {
         var _loc5_:Number = (domainInfo.getCatapults()[param3] as CatapultTypeDIO).resourceCosts[0][0].resourceAmount;
         var _loc4_:Boolean = _loc5_ <= param1[param2];
         return _loc4_ && (userInfo.catapultActivationRemainingTimes[param3] == null || (userInfo.catapultActivationRemainingTimes[param3] as CatapultTimeDTO).catapultTime <= 0);
      }
   }
}

