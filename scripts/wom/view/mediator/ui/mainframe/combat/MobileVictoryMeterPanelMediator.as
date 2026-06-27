package wom.view.mediator.ui.mainframe.combat
{
   import flash.geom.Point;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.GameModeChangedEvent;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.MobileTooltipEvent;
   import wom.controller.event.ui.MobileVictoryMeterEvent;
   import wom.controller.event.ui.VictoryMeterEvent;
   import wom.model.component.enum.ELOStarType;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.experience.ExperienceUtil;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.view.ui.mainframe.combat.MobileBattlePointsSmallStarView;
   import wom.view.ui.mainframe.combat.MobileVictoryMeterPanel;
   import wom.view.ui.tooltip.MobileVictoryTooltipView;
   
   public class MobileVictoryMeterPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileVictoryMeterPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      public function MobileVictoryMeterPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         addContextListener("gameModeChange",onGameModeChange,GameModeChangedEvent);
         if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.VISIT)
         {
            addViewListener("starGained",onStarGained,MobileVictoryMeterEvent);
            addContextListener("cityCenterDestroyed",onCityCenterDestroyed,VictoryMeterEvent);
            addContextListener("tick",onTick,GameTickEvent);
            addContextListener("cityLoaded",onCityLoaded,ModelUpdateEvent);
         }
         addContextListener("getBattleProgressBarPosition",onBattleProgressBarPositionRequested,TutorialReferencePositionEvent);
         eventMap.mapStarlingListener(view,"touch",onTab,TouchEvent);
         addContextListener("mobileTooltipEventClose",onTooltipClosed,MobileTooltipEvent);
      }
      
      private function onCityCenterDestroyed(param1:VictoryMeterEvent) : void
      {
         var _loc2_:Boolean = userInfo.gameMode == GameModeType.ATTACK ? attackInfo.defender.isNpc : visitInfo.landlord.isNpc;
         if(_loc2_)
         {
            view.animateStarGain();
            view.drawLayout();
         }
      }
      
      private function onStarGained(param1:MobileVictoryMeterEvent) : void
      {
         soundPlayer.playSfxById("VictorySplashScreen");
         checkTutorial();
      }
      
      private function checkTutorial() : void
      {
         var _loc2_:TutorialInfo = null;
         var _loc3_:TutorialState = null;
         var _loc1_:* = 0;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc2_ = "rev" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["rev"] : null;
            if(_loc2_ != null && !_loc2_.isCompleted)
            {
               _loc3_ = _loc2_.states[_loc2_.states[0].additionalInfo["stateIndexExplainBattleProgress"]];
               if("targetVal" in _loc3_.additionalInfo)
               {
                  _loc1_ = 0;
                  for each(var _loc4_ in view.starViews)
                  {
                     if(_loc4_.starType == ELOStarType.POSITIVE)
                     {
                        _loc1_++;
                     }
                  }
                  _loc3_.additionalInfo["progress"] = _loc1_;
                  dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
               }
            }
         }
      }
      
      private function onGameModeChange(param1:GameModeChangedEvent) : void
      {
         if(userInfo.gameMode == GameModeType.ATTACK || userInfo.gameMode == GameModeType.VISIT)
         {
            addContextListener("tick",onTick,GameTickEvent);
            addContextListener("cityLoaded",onCityLoaded,ModelUpdateEvent);
            addContextListener("cityCenterDestroyed",onCityCenterDestroyed,VictoryMeterEvent);
         }
         else
         {
            removeContextListener("tick",onTick,GameTickEvent);
            removeContextListener("cityLoaded",onCityLoaded,ModelUpdateEvent);
            removeContextListener("cityCenterDestroyed",onCityCenterDestroyed,VictoryMeterEvent);
         }
      }
      
      private function checkIsNpcAccordingToTutorial(param1:Profile) : Boolean
      {
         var _loc2_:Profile = TutorialListInfo.getProfileAccordingToTutorial(param1,userInfo.tutorialsInfo);
         if(_loc2_.npcId == "NPC_D")
         {
            return false;
         }
         return _loc2_.isNpc;
      }
      
      private function onCityLoaded(param1:ModelUpdateEvent) : void
      {
         calculateTotalCityHP();
         view.initialCityHP = calculateCurrentCityHP();
         var _loc4_:Boolean = userInfo.gameMode == GameModeType.ATTACK;
         var _loc9_:Boolean = _loc4_ ? checkIsNpcAccordingToTutorial(attackInfo.defender) : visitInfo.landlord.isNpc;
         view.tooltipContainer.visible = !_loc9_;
         dispatch(new VictoryMeterEvent("visibilityChanged"));
         var _loc2_:Boolean = _loc4_ ? attackInfo.defender.gameId in documentConfiguration.womFriends : visitInfo.isFriend;
         var _loc3_:Boolean = (_loc4_ ? attackInfo.defender.isNpc : visitInfo.landlord.isNpc) || _loc2_;
         var _loc10_:Boolean = _loc4_ ? !attackInfo.bpGainEnabled : !visitInfo.bpGainEnabled;
         view.updateVictoryMeter(view.initialCityHP,userInfo.battlePoints,city.ownerBattlePoints,_loc3_,_loc4_,_loc9_,_loc10_);
         var _loc5_:int = ExperienceUtil.calculateLevelOfExperience(userInfo.experiencePoints);
         var _loc8_:int = 0;
         var _loc7_:Array = null;
         var _loc6_:Boolean = userInfo.battlePoints > documentConfiguration.ultimateBpThreshold || city.ownerBattlePoints > documentConfiguration.ultimateBpThreshold;
         var _loc11_:Number = documentConfiguration.maxKValue;
         if(attackInfo.isTournamentAttack)
         {
            _loc11_ = documentConfiguration.tournamentKValue;
         }
         else if(_loc6_)
         {
            _loc11_ = documentConfiguration.minKValue;
         }
         else if(_loc5_ < 30)
         {
            _loc11_ = documentConfiguration.medKValue;
         }
         else
         {
            _loc11_ = documentConfiguration.maxKValue;
         }
         if(_loc9_)
         {
            _loc8_ = 0;
         }
         else if(_loc6_ || attackInfo.isTournamentAttack)
         {
            _loc8_ = 4;
            _loc7_ = [25,65,85];
         }
         else if(_loc5_ <= 32)
         {
            _loc8_ = Math.max(0,_loc5_ - city.ownerLevel);
         }
         else
         {
            _loc8_ = Math.max(0,32 - city.ownerLevel);
         }
         if(_loc8_ > 4)
         {
            _loc8_ = 4;
         }
         view.setDamageThresholds(_loc8_,_loc11_,_loc7_);
      }
      
      private function calculateTotalCityHP() : void
      {
         var _loc3_:BuildingTypeDIO = null;
         var _loc2_:Number = 0;
         for each(var _loc1_ in city.buildings)
         {
            if(_loc1_.buildingTypeId != 41 && _loc1_.buildingTypeId != 29)
            {
               _loc3_ = domainInfo.getBuilding(_loc1_.buildingTypeId);
               _loc2_ += _loc3_.healthPointsPerLevel[Math.max(0,_loc1_.level - 1)];
            }
         }
         view.totalCityHP = _loc2_;
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc4_:Boolean = userInfo.gameMode == GameModeType.ATTACK;
         if(_loc4_ && attackInfo.defender == null || userInfo.gameMode == GameModeType.VISIT && visitInfo.landlord == null)
         {
            return;
         }
         var _loc5_:Boolean = _loc4_ ? checkIsNpcAccordingToTutorial(attackInfo.defender) : visitInfo.landlord.isNpc;
         var _loc2_:Boolean = _loc4_ ? attackInfo.defender.gameId in documentConfiguration.womFriends : visitInfo.isFriend;
         var _loc3_:Boolean = (_loc4_ ? attackInfo.defender.isNpc : visitInfo.landlord.isNpc) || _loc2_;
         var _loc6_:Number = _loc4_ ? attackInfo.totalCatapultDamageDone : 0;
         view.updateVictoryMeter(calculateCurrentCityHP(),userInfo.battlePoints,city.ownerBattlePoints,_loc3_,_loc4_,_loc5_,_loc4_ ? !attackInfo.bpGainEnabled : !visitInfo.bpGainEnabled,_loc6_);
      }
      
      private function calculateCurrentCityHP() : Number
      {
         var _loc1_:BuildingInfo = null;
         var _loc3_:int = 0;
         var _loc4_:Vector.<BuildingInfo> = city.buildings;
         var _loc2_:Number = 0;
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc1_ = _loc4_[_loc3_];
            if(_loc1_.buildingTypeId != 41 && _loc1_.buildingTypeId != 29)
            {
               _loc2_ += Math.max(0,_loc1_.healthPoint);
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function onBattleProgressBarPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.localToGlobal(new Point())));
      }
      
      private function onTab(param1:Event) : void
      {
         var _loc11_:Boolean = false;
         var _loc13_:MobileVictoryTooltipView = null;
         var _loc10_:Boolean = false;
         var _loc3_:MobileBattlePointsSmallStarView = null;
         var _loc2_:int = 0;
         var _loc6_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc5_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Touch = (param1 as TouchEvent).getTouch(view,"ended");
         if(_loc9_)
         {
            _loc11_ = param1.target as Object is MobileBattlePointsSmallStarView;
            _loc10_ = userInfo.gameMode == GameModeType.ATTACK;
            if(_loc11_)
            {
               _loc3_ = param1.target as Object as MobileBattlePointsSmallStarView;
               _loc2_ = view.starViews.indexOf(_loc3_);
               view.touchedStarIndex = _loc2_;
               _loc6_ = _loc10_ ? attackInfo.defender.gameId in documentConfiguration.womFriends : visitInfo.isFriend;
               _loc7_ = (_loc10_ ? attackInfo.defender.isNpc : visitInfo.landlord.isNpc) || _loc6_;
               _loc12_ = _loc10_ ? !attackInfo.bpGainEnabled : !visitInfo.bpGainEnabled;
               _loc13_ = new MobileVictoryTooltipView(1);
               dispatch(new MobileTooltipEvent("mobileTooltipEventShow",_loc13_,view.x + _loc3_.x - (285 - _loc3_.width >> 1),view.y + view.visibleHeight()));
               _loc13_.updateWithData(view.performanceArray[_loc2_ == 0 ? 0 : int(_loc2_ / 3) + 1],view.calculateBPGain((_loc2_ == 0 ? 0 : int(_loc2_ / 3) + 1) + 1,userInfo.battlePoints,city.ownerBattlePoints),_loc7_,_loc12_);
               view.tooltip = _loc13_;
            }
            else
            {
               view.touchedStarIndex = -1;
               _loc5_ = _loc10_ ? attackInfo.totalCatapultDamageDone : 0;
               _loc4_ = (view.initialCityHP - calculateCurrentCityHP() - _loc5_) / view.totalCityHP * 100;
               _loc8_ = (view.totalCityHP + _loc5_ - view.initialCityHP) / view.totalCityHP * 100;
               _loc13_ = new MobileVictoryTooltipView(2);
               dispatch(new MobileTooltipEvent("mobileTooltipEventShow",_loc13_,view.x + (view.visibleWidth - 285 >> 1),view.y + view.visibleHeight()));
               _loc13_.updateWithData(_loc4_,_loc8_);
               view.tooltip = _loc13_;
            }
         }
      }
      
      private function onTooltipClosed(param1:MobileTooltipEvent) : void
      {
         view.tooltip = null;
         view.touchedStarIndex = -1;
      }
   }
}

