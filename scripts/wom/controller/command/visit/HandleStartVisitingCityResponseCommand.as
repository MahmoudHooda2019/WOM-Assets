package wom.controller.command.visit
{
   import peak.logging.log;
   import wom.controller.command.city.CityLoaderCommand;
   import wom.controller.event.ActivateScreenEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.MessageReceivedEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.PopUpWindowEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.AttackInfo;
   import wom.model.game.DefaultVisitInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.friend.FriendInfo;
   import wom.model.message.response.StartVisitingCityResponse;
   import wom.service.kontagent.WomKontagentApi;
   import wom.service.logging.WomLoggerContexts;
   import wom.view.screen.popups.underattack.MobileAlreadyUnderAttackPopUp;
   import wom.view.screen.popups.visit.VisitCapacityReachedPopup;
   
   public class HandleStartVisitingCityResponseCommand extends CityLoaderCommand
   {
      
      [Inject]
      public var messageReceivedEvent:MessageReceivedEvent;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      public function HandleStartVisitingCityResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc5_:int = 0;
         var _loc1_:StartVisitingCityResponse = messageReceivedEvent.message as StartVisitingCityResponse;
         if(_loc1_.resultCode == 0)
         {
            if(userInfo.fromMap)
            {
               userInfo.fromMap = false;
               kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"visit_success"});
            }
            _loc2_ = false;
            if(!_loc1_.landlord.isNpc)
            {
               for each(var _loc4_ in documentConfiguration.friends)
               {
                  if(_loc4_.profile.gameId == _loc1_.landlord.gameId)
                  {
                     _loc2_ = true;
                     break;
                  }
               }
            }
            _loc3_ = (_loc2_ || _loc1_.landlord.isNpc && _loc1_.landlord.npcId == "NPC_5") && !visitInfo.isScout;
            visitInfo.guid = _loc1_.guid;
            visitInfo.landlord = _loc1_.landlord;
            visitInfo.isFriend = _loc2_;
            visitInfo.interactable = _loc1_.interactable;
            visitInfo.isOutOfReachForAttack = _loc1_.isOutOfReachForAttack;
            visitInfo.bpGainEnabled = _loc1_.bpGainEnabled;
            _loc5_ = int(visitInfo.landlord.gameId in userInfo.helpCountDictionary ? userInfo.helpCountDictionary[visitInfo.landlord.gameId] : 0);
            userInfo.helpCountDictionary[visitInfo.landlord.gameId] = _loc5_;
            visitInfo.remainingHelpCount = _loc3_ ? 4 - _loc5_ : 0;
            userInfo.gameMode = GameModeType.VISIT;
            dispatch(new GameModeChangedEvent("gameModeChange"));
            gameRootHolder.init();
            coreManager.setFactories();
            attackInfo.combatItemEffects = _loc1_.city.combatItemEffects;
            loadCity(_loc1_.city,attackInfo.barracksSpaceModifier,attackInfo.unitArmorModifier,attackInfo.unitSpeedModifier,attackInfo.unitDamageModifier);
            city.version = _loc1_.version;
            if(_loc3_)
            {
               coreManager.determineHelpableStatusOfBuildings();
               if(!(_loc1_.landlord.isNpc && _loc1_.landlord.npcId == "NPC_5") && userInfo.helpedUserCounts >= DefaultVisitInfo.MAX_VISIT_LIMIT && !(visitInfo.landlord.gameId in userInfo.helpCountDictionary && userInfo.helpCountDictionary[visitInfo.landlord.gameId] > 0))
               {
                  dispatch(new PopUpWindowEvent("showPopUpWindow",new VisitCapacityReachedPopup()));
               }
            }
            dispatch(new ModelUpdateEvent("spyStatusChange"));
         }
         else
         {
            log(WomLoggerContexts.GAME,"Visit Failed : " + _loc1_.resultMessage);
            dispatch(new ActivateScreenEvent("activatePreviousScreen"));
            dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileAlreadyUnderAttackPopUp(_loc1_.resultCode,true),0,null,null,false,userInfo.delayPopups));
         }
      }
   }
}

