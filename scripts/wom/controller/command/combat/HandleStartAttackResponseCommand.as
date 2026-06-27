package wom.controller.command.combat
{
   import flash.utils.getTimer;
   import peak.logging.log;
   import wom.controller.command.city.CityLoaderCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.platform.PlatformUserEvent;
   import wom.controller.event.ui.ActionSelectEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.model.component.enum.ActionType;
   import wom.model.game.AttackInfo;
   import wom.model.game.Profile;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.CatapultTimeUtil;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.friend.ProfileIdPair;
   import wom.model.message.response.StartAttackResponse;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   
   public class HandleStartAttackResponseCommand extends CityLoaderCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function HandleStartAttackResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc1_:StartAttackResponse = messageReceivedEvent.message as StartAttackResponse;
         if(_loc1_.resultCode == 0)
         {
            if(userInfo.fromMap)
            {
               kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"attack_success"});
            }
            _loc3_ = _loc1_.city && !(userInfo.gameMode == GameModeType.VISIT && visitInfo.landlord.isNpc && visitInfo.landlord.npcId == _loc1_.defender.npcId);
            if(_loc3_)
            {
               if(userInfo.currentScreen != WomScreenType.LOADING)
               {
                  dispatch(new ActivateScreenEvent("activate",WomScreenType.LOADING));
               }
               gameRootHolder.init();
               coreManager.setFactories();
            }
            visitInfo.reset();
            attackInfo.reset();
            attackInfo.guid = _loc1_.guid;
            attackInfo.defender = _loc1_.defender;
            attackInfo.attacker = userInfo.profile;
            attackInfo.attackStartTime = getTimer();
            attackInfo.attackEndTime = attackInfo.attackStartTime + 420000;
            attackInfo.attackEndTimeExtended = false;
            attackInfo.isQuickAttack = _loc1_.isQuickAttack;
            attackInfo.isAttackOngoing = true;
            attackInfo.seedNumber = _loc1_.seedNumber;
            attackInfo.bpGainEnabled = _loc1_.bpGainEnabled;
            attackInfo.isTournamentAttack = _loc1_.isTournamentAttack;
            _loc2_ = false;
            if(userInfo.gameMode == GameModeType.VISIT && city.spyEnabled)
            {
               _loc2_ = true;
            }
            userInfo.catapultActivationRemainingTimes = CatapultTimeUtil.calculateCatapultRemainingTimes(userInfo.catapultActivationRemainingTimes,_loc1_.lastCatapultFiredTimes);
            userInfo.gameMode = GameModeType.ATTACK;
            dispatch(new GameModeChangedEvent("gameModeChange"));
            if(_loc1_.beastHealth != -1 && attackInfo.beast)
            {
               attackInfo.beast.healthPoints = _loc1_.beastHealth;
            }
            if(_loc3_)
            {
               attackInfo.combatItemEffects = _loc1_.city.combatItemEffects;
               loadCity(_loc1_.city,attackInfo.barracksSpaceModifier,attackInfo.unitArmorModifier,attackInfo.unitSpeedModifier,attackInfo.unitDamageModifier);
            }
            else
            {
               dispatch(new ModelUpdateEvent("cityLoaded"));
            }
            city.spyEnabled = _loc2_;
            if(_loc2_)
            {
               coreManager.startSpying();
            }
            coreManager.startBattle();
            if(attackInfo.isQuickAttack || attackInfo.isTournamentAttack)
            {
               getUserInfo(attackInfo.defender);
            }
            dispatch(new ActionSelectEvent("actionSelect",ActionType.ARROW));
            dispatch(new ModelUpdateEvent("storeItemEffectsUpdated"));
            dispatch(new ModelUpdateEvent("spyStatusChange"));
         }
         else
         {
            log(WomLoggerContexts.GAME,"Attack Failed : " + _loc1_.resultMessage);
            dispatch(new ActivateScreenEvent("activatePreviousScreen"));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAlreadyUnderAttackPopUp(_loc1_.resultCode,false),0,null,null,false,userInfo.delayPopups));
         }
      }
      
      private function getUserInfo(param1:Profile) : void
      {
         var _loc2_:Vector.<ProfileIdPair> = new Vector.<ProfileIdPair>();
         _loc2_.push(new ProfileIdPair(param1.platformId,param1.avatar));
         dispatch(new PlatformUserEvent("getPlatformUserInfo",_loc2_));
      }
   }
}

