package wom.view.mediator.ui.tutorial.mobile
{
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.logging.LoggerContexts;
   import peak.logging.log;
   import peak.network.ClientEvent;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import wom.controller.command.util.DictionaryUtil;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.KeepAliveEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.WindowCreationEvent;
   import wom.controller.event.mobile.MobileCanvasDeployHandEvent;
   import wom.controller.event.tutorial.TutorialEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.tutorial.TutorialVisibleItemsEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.ui.TownOptionsMenuEvent;
   import wom.model.component.CoreManager;
   import wom.model.component.WomGameRoot;
   import wom.model.component.entity.gamesprite.Building;
   import wom.model.component.enum.CanvasMode;
   import wom.model.dto.TaskDTO;
   import wom.model.game.AttackInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.MobileMapInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.VisitInfo;
   import wom.model.game.WomGameRootHolder;
   import wom.model.game.WomScreenType;
   import wom.model.game.attack.GameModeType;
   import wom.model.game.building.BuildMenuCategory;
   import wom.model.game.building.BuildingInfo;
   import wom.model.game.building.BuildingInfoUtil;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.job.BuildingUpgradeJob;
   import wom.model.game.quest.QuestInfo;
   import wom.model.game.quest.QuestUtil;
   import wom.model.game.tutorial.TutorialActivationState;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.model.game.unit.UnitInfo;
   import wom.model.game.unit.UnitInfoUtil;
   import wom.model.game.unit.UnitStatusType;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.ForwardNPCAttackRequest;
   import wom.model.message.request.ProgressTutorialStepRequest;
   import wom.model.message.request.UpgradeBuildingRequest;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.screen.popups.MobileAnyoneHomePopUp;
   import wom.view.screen.popups.MobileDidYouKnowPopUp;
   import wom.view.screen.popups.MobileDisconnectPopUp;
   import wom.view.screen.popups.apologies.MobileActionNotPossiblePopup;
   import wom.view.screen.popups.facebook.MobileFBGetGoldPopUp;
   import wom.view.screen.popups.quest.MobileQuestCompletedPopup;
   import wom.view.screen.popups.repair.MobileRepairPopUp;
   import wom.view.screen.popups.resource.MobileBoostConfirmationPopUp;
   import wom.view.screen.popups.unit.MobileRecruitmentCompletedPopUp;
   import wom.view.screen.windows.activate.MobileActivateBuildingWindow;
   import wom.view.screen.windows.build.MobileBuildCategoryPanel;
   import wom.view.screen.windows.build.MobileBuildShowcaseWindow;
   import wom.view.screen.windows.build.MobileConstructBuildingWindow;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsWindow;
   import wom.view.screen.windows.hiringquarters.MobileHiringQuartersWindow;
   import wom.view.screen.windows.inbox.mobile.MobileInboxWindow;
   import wom.view.screen.windows.map.MobileMapListWindow;
   import wom.view.screen.windows.quest.MobileQuestDetailWindow;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportWindow;
   import wom.view.screen.windows.store.MobileStoreWindow;
   import wom.view.screen.windows.upgrade.MobileUpgradeWindow;
   import wom.view.ui.tutorial.mobile.MobileDeployHandView;
   import wom.view.ui.tutorial.mobile.MobileTutorialLayer;
   
   public class MobileTutorialLayerMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileTutorialLayer;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var coreManager:CoreManager;
      
      [Inject]
      public var gameRootHolder:WomGameRootHolder;
      
      [Inject]
      public var attackInfo:AttackInfo;
      
      [Inject]
      public var visitInfo:VisitInfo;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      [Inject]
      public var mobileMapInfo:MobileMapInfo;
      
      public function MobileTutorialLayerMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         view.updateTutorialsInfo(userInfo.tutorialsInfo);
         addContextListener("tutorialsUpdated",onTutorialsUpdated,TutorialEvent);
         addContextListener("mandatoryTutorialsCompletionChanged",onMandatoryTutorialsCompletionChanged,TutorialEvent);
      }
      
      private function enableListeners() : void
      {
         view.visible = true;
         addContextListener("showPopUpWindow",onPopUpShown,MobilePopUpWindowEvent);
         addContextListener("showSecondaryPopUpWindow",onPopUpShown,MobilePopUpWindowEvent);
         addContextListener("connectionLost",onConnectionLost,ClientEvent);
         addContextListener("getCenterOfCityPosition",onCenterOfCityPosition,TutorialReferencePositionEvent);
         addContextListener("getBuildingPosition",onBuildingPosition,TutorialReferencePositionEvent);
         addContextListener("getBuildingProgressBarPosition",onBuildingProgressBarPosition,TutorialReferencePositionEvent);
         addContextListener("positionReady",onReferencePositionReady,TutorialReferencePositionEvent);
         addContextListener("tabBarIndexChanged",onTrigger,TutorialTriggerEvent);
         addContextListener("defaultActionTriggered",onTrigger,TutorialTriggerEvent);
         addContextListener("startBuild",onStartBuild,TutorialTriggerEvent);
         addContextListener("showTownOptionsMenu",onShowTownOptionsMenu,TownOptionsMenuEvent);
         addContextListener("getTopRightPosition",onTopRightPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getBottomLeftPosition",onBottomLeftPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getBottomRightPosition",onBottomRightPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getCenterOfScreenPosition",onCenterOfScreenPositionRequested,TutorialReferencePositionEvent);
      }
      
      private function disableListeners() : void
      {
         view.visible = true;
         removeContextListener("showPopUpWindow",onPopUpShown,MobilePopUpWindowEvent);
         removeContextListener("showSecondaryPopUpWindow",onPopUpShown,MobilePopUpWindowEvent);
         removeContextListener("connectionLost",onConnectionLost,ClientEvent);
         removeContextListener("getCenterOfCityPosition",onCenterOfCityPosition,TutorialReferencePositionEvent);
         removeContextListener("getBuildingPosition",onBuildingPosition,TutorialReferencePositionEvent);
         removeContextListener("getBuildingProgressBarPosition",onBuildingProgressBarPosition,TutorialReferencePositionEvent);
         removeContextListener("positionReady",onReferencePositionReady,TutorialReferencePositionEvent);
         removeContextListener("tabBarIndexChanged",onTrigger,TutorialTriggerEvent);
         removeContextListener("defaultActionTriggered",onTrigger,TutorialTriggerEvent);
         removeContextListener("startBuild",onStartBuild,TutorialTriggerEvent);
         removeContextListener("showTownOptionsMenu",onShowTownOptionsMenu,TownOptionsMenuEvent);
         removeContextListener("getTopRightPosition",onTopRightPositionRequested,TutorialReferencePositionEvent);
         removeContextListener("getBottomLeftPosition",onBottomLeftPositionRequested,TutorialReferencePositionEvent);
         removeContextListener("getBottomRightPosition",onBottomRightPositionRequested,TutorialReferencePositionEvent);
         removeContextListener("getCenterOfScreenPosition",onCenterOfScreenPositionRequested,TutorialReferencePositionEvent);
      }
      
      private function checkTriggers() : void
      {
         var _loc2_:Object = null;
         var _loc3_:TutorialActivationState = null;
         var _loc1_:TutorialInfo = null;
         if(userInfo.tutorialsInfo.enabled)
         {
            if(userInfo.currentScreen == WomScreenType.LOADING)
            {
               deactivateTutorialWindow();
               return;
            }
            _loc2_ = userInfo.tutorialsInfo.additionalInfo.lastOpenedPopup;
            if(_loc2_ is MobileAnyoneHomePopUp || _loc2_ is MobileDidYouKnowPopUp || _loc2_ is MobileDisconnectPopUp || _loc2_ is MobileInboxWindow)
            {
               deactivateTutorialWindow();
               return;
            }
            _loc1_ = null;
            _loc3_ = checkTutorialArchersTower();
            if(_loc3_.enabled)
            {
               _loc1_ = userInfo.tutorialsInfo.tutorials["twr"];
            }
            else
            {
               _loc3_ = checkTutorialNpcDefense();
               if(_loc3_.enabled)
               {
                  _loc1_ = userInfo.tutorialsInfo.tutorials["def"];
               }
               else
               {
                  _loc3_ = checkTutorialNpcRevenge();
                  if(_loc3_.enabled)
                  {
                     _loc1_ = userInfo.tutorialsInfo.tutorials["rev"];
                  }
                  else
                  {
                     _loc3_ = checkTutorialLumberBlade();
                     if(_loc3_.enabled)
                     {
                        _loc1_ = userInfo.tutorialsInfo.tutorials["lmb"];
                     }
                     else
                     {
                        _loc3_ = checkTutorialExtraWorker();
                        if(_loc3_.enabled)
                        {
                           _loc1_ = userInfo.tutorialsInfo.tutorials["wor"];
                        }
                        else
                        {
                           _loc3_ = checkTutorialHiringQuarters();
                           if(_loc3_.enabled)
                           {
                              _loc1_ = userInfo.tutorialsInfo.tutorials["hq"];
                           }
                           else
                           {
                              _loc3_ = checkTutorialHireBedouinBrutes();
                              if(_loc3_.enabled)
                              {
                                 _loc1_ = userInfo.tutorialsInfo.tutorials["bed"];
                              }
                              else
                              {
                                 _loc3_ = checkTutorialProtectionFlag();
                                 if(_loc3_.enabled)
                                 {
                                    _loc1_ = userInfo.tutorialsInfo.tutorials["flg"];
                                 }
                                 else
                                 {
                                    _loc3_ = checkTutorialHelpThorzain();
                                    if(_loc3_.enabled)
                                    {
                                       _loc1_ = userInfo.tutorialsInfo.tutorials["hlp"];
                                    }
                                    else
                                    {
                                       _loc3_ = checkTutorialRPExplanationTypeStore();
                                       if(_loc3_.enabled)
                                       {
                                          _loc1_ = userInfo.tutorialsInfo.tutorials["rp_s"];
                                       }
                                       else
                                       {
                                          _loc3_ = checkTutorialRPExplanationTypeGainRP();
                                          if(_loc3_.enabled)
                                          {
                                             _loc1_ = userInfo.tutorialsInfo.tutorials["rp_g"];
                                          }
                                          else
                                          {
                                             _loc3_ = checkTutorialFirstAttack();
                                             if(_loc3_.enabled)
                                             {
                                                _loc1_ = userInfo.tutorialsInfo.tutorials["fa"];
                                             }
                                             else
                                             {
                                                _loc3_ = checkTutorialFirstRepair();
                                                if(_loc3_.enabled)
                                                {
                                                   _loc1_ = userInfo.tutorialsInfo.tutorials["fr"];
                                                }
                                                else
                                                {
                                                   _loc3_ = checkTutorialResourceFull();
                                                   if(_loc3_.enabled)
                                                   {
                                                      _loc1_ = userInfo.tutorialsInfo.tutorials["rf"];
                                                   }
                                                   else
                                                   {
                                                      _loc3_ = checkTutorialUnitRecruited("fl");
                                                      if(_loc3_.enabled)
                                                      {
                                                         _loc1_ = userInfo.tutorialsInfo.tutorials["fl"];
                                                      }
                                                      else
                                                      {
                                                         _loc3_ = checkTutorialExplainPartFromActivateBuilding();
                                                         if(_loc3_.enabled)
                                                         {
                                                            _loc1_ = userInfo.tutorialsInfo.tutorials["ep_ab"];
                                                         }
                                                         else
                                                         {
                                                            _loc3_ = checkTutorialExplainMaps();
                                                            if(_loc3_.enabled)
                                                            {
                                                               _loc1_ = userInfo.tutorialsInfo.tutorials["em"];
                                                            }
                                                            else
                                                            {
                                                               _loc3_ = checkTutorialFirstPvP();
                                                               if(_loc3_.enabled)
                                                               {
                                                                  _loc1_ = userInfo.tutorialsInfo.tutorials["fpvp"];
                                                               }
                                                               else
                                                               {
                                                                  _loc3_ = checkTutorialUnitRecruited("ft");
                                                                  if(_loc3_.enabled)
                                                                  {
                                                                     _loc1_ = userInfo.tutorialsInfo.tutorials["ft"];
                                                                  }
                                                               }
                                                            }
                                                         }
                                                      }
                                                   }
                                                }
                                             }
                                          }
                                       }
                                    }
                                 }
                              }
                           }
                        }
                     }
                  }
               }
            }
            if(_loc1_ != null && _loc3_.activated)
            {
               activateTutorialWindow(_loc1_);
            }
            else
            {
               deactivateTutorialWindow();
            }
         }
      }
      
      private function checkTutorialArchersTower() : TutorialActivationState
      {
         var _loc6_:Object = null;
         var _loc9_:int = 0;
         var _loc1_:int = 0;
         var _loc4_:Dictionary = null;
         var _loc7_:MobileBuildShowcaseWindow = null;
         var _loc2_:BuildingInfo = null;
         var _loc8_:TutorialActivationState = new TutorialActivationState();
         var _loc3_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc5_:TutorialInfo = "twr" in _loc3_.tutorials ? _loc3_.tutorials["twr"] : null;
         if(_loc5_ != null && !_loc5_.isCompleted)
         {
            view.currentTutorial = _loc5_;
            if(!_loc5_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc8_.activated = false;
               }
               else
               {
                  _loc6_ = _loc3_.additionalInfo.lastOpenedPopup;
                  _loc9_ = int(_loc5_.states[0].additionalInfo["questId"]);
                  _loc1_ = int(_loc5_.states[2].additionalInfo["buildingTypeId"]);
                  _loc4_ = new Dictionary();
                  _loc4_["cityUiLayer"] = [1,3,4,6];
                  if(_loc9_ in userInfo.claimedQuestIds)
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc5_.tutorialId + " QUEST: " + _loc9_);
                     coreManager.clearMobileTutorialArrowByTypeId(_loc1_);
                     _loc5_.currentStateIndex = 7;
                     completeTutorialState();
                  }
                  if(_loc5_.currentStateIndex == 0)
                  {
                     coreManager.centerToBuildingByTypeId(10,120,-30);
                     if(_loc6_ != null)
                     {
                        _loc8_.activated = false;
                     }
                  }
                  if(_loc5_.currentStateIndex == 1)
                  {
                     _loc4_["menuPanel"] = [1];
                     dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc4_));
                     coreManager.centerToBuildingByTypeId(10,120,-30);
                     if(_loc6_ != null)
                     {
                        if(_loc6_ is MobileBuildShowcaseWindow)
                        {
                           _loc7_ = _loc6_ as MobileBuildShowcaseWindow;
                           if(_loc7_.activePanel != null && _loc7_.activePanel is MobileBuildCategoryPanel && (_loc7_.activePanel as MobileBuildCategoryPanel).category == BuildMenuCategory.DEFENSIVE)
                           {
                              completeTutorialState();
                           }
                           else
                           {
                              dispatch(new TutorialTriggerEvent("changeTabBarIndex",_loc5_.states[1].additionalInfo));
                           }
                        }
                        else
                        {
                           _loc8_.activated = false;
                        }
                     }
                  }
                  else
                  {
                     _loc4_["menuPanel"] = [];
                     dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc4_));
                  }
                  if(_loc5_.currentStateIndex == 2)
                  {
                     if(_loc6_ == null)
                     {
                        _loc8_.activated = false;
                     }
                     else if(_loc6_ is MobileConstructBuildingWindow)
                     {
                        completeTutorialState();
                     }
                     else if(!(_loc6_ is MobileBuildShowcaseWindow))
                     {
                        _loc8_.activated = false;
                     }
                  }
                  if(_loc5_.currentStateIndex == 3)
                  {
                     if(_loc5_.states[3].additionalInfo["buildingTypeId"] == _loc1_)
                     {
                        completeTutorialState();
                     }
                     else if(_loc6_ != null && !(_loc6_ is MobileConstructBuildingWindow))
                     {
                        _loc8_.activated = false;
                     }
                  }
                  _loc2_ = null;
                  if(_loc5_.currentStateIndex == 4)
                  {
                     _loc2_ = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,_loc1_);
                     if(_loc2_ != null)
                     {
                        _loc5_.states[5].additionalInfo["buildingInstanceId"] = _loc2_.instanceId;
                        DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
                        userInfo.tutorialsInfo.interactableBuildingInstanceIds[_loc2_.instanceId] = true;
                        coreManager.drawMobileTutorialArrowByTypeId(_loc1_,0,60);
                        completeTutorialState();
                     }
                     else if(gameRootHolder.gameRoot.canvasMode != CanvasMode.BUILD)
                     {
                        _loc8_.activated = false;
                     }
                  }
                  if(!_loc5_.isCompleted && _loc5_.currentStateIndex >= 5 && _loc5_.currentStateIndex <= 7)
                  {
                     _loc2_ = BuildingInfoUtil.getBuildingByBuildingInstanceId(city.buildings,_loc5_.states[5].additionalInfo["buildingInstanceId"]);
                     if(_loc2_ != null && _loc2_.level > 0)
                     {
                        coreManager.clearMobileTutorialArrowByTypeId(_loc1_);
                        _loc5_.currentStateIndex = 7;
                        completeTutorialState();
                     }
                  }
                  if(_loc5_.currentStateIndex == 5)
                  {
                     coreManager.panToBuildingByTypeId(31,251,-150);
                  }
               }
            }
            if(!_loc5_.isCompleted)
            {
               _loc8_.enabled = true;
            }
         }
         return _loc8_;
      }
      
      private function checkTutorialNpcDefense() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc5_:int = 0;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "def" in _loc1_.tutorials ? _loc1_.tutorials["def"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            view.currentTutorial = _loc2_;
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            _loc5_ = int(_loc2_.states[0].additionalInfo["questId"]);
            if(_loc2_.currentStateIndex == 0)
            {
               if(_loc5_ in userInfo.claimedQuestIds)
               {
                  log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc2_.tutorialId + " QUEST: " + _loc5_);
                  _loc2_.currentStateIndex = 1;
                  completeTutorialState();
               }
               else if(checkQuestExistAndNotCompleted(_loc5_))
               {
                  if(_loc3_ != null)
                  {
                     _loc4_.activated = false;
                  }
               }
               else
               {
                  _loc4_.activated = false;
               }
            }
            if(_loc2_.currentStateIndex == 1 && _loc5_ in userInfo.claimedQuestIds)
            {
               completeTutorialState();
            }
            if(!_loc2_.isCompleted)
            {
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialNpcRevenge() : TutorialActivationState
      {
         var _loc10_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc5_:Dictionary = null;
         var _loc8_:Object = null;
         var _loc3_:int = 0;
         var _loc11_:int = 0;
         var _loc9_:TutorialActivationState = new TutorialActivationState();
         var _loc4_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc7_:TutorialInfo = "rev" in _loc4_.tutorials ? _loc4_.tutorials["rev"] : null;
         if(_loc7_ != null && !_loc7_.isCompleted)
         {
            view.currentTutorial = _loc7_;
            if(_loc7_.currentStateIndex < 3 && userInfo.gameMode != GameModeType.NORMAL)
            {
               _loc9_.activated = false;
            }
            else
            {
               _loc8_ = _loc4_.additionalInfo.lastOpenedPopup;
               if(_loc7_.currentStateIndex == 0)
               {
                  _loc10_ = int(_loc7_.states[0].additionalInfo["questId"]);
                  if(checkQuestExistAndNotCompleted(_loc10_))
                  {
                     _loc6_ = UnitInfoUtil.getAmountOfUnits(city.units,_loc7_.states[5].additionalInfo["unitTypeId"]);
                     if(_loc6_ >= _loc7_.states[5].additionalInfo["amountOfUnits"])
                     {
                        completeTutorialState();
                     }
                     else
                     {
                        _loc9_.activated = false;
                     }
                  }
                  else
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 1)
               {
                  _loc5_ = new Dictionary();
                  _loc5_["cityUiLayer"] = [1,3,4,6];
                  _loc5_["menuPanel"] = [3];
                  dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc5_));
                  _loc6_ = UnitInfoUtil.getAmountOfUnits(city.units,_loc7_.states[5].additionalInfo["unitTypeId"]);
                  if(_loc6_ != _loc7_.states[5].additionalInfo["amountOfUnits"])
                  {
                     _loc7_.currentStateIndex = 9;
                     completeTutorialState();
                  }
                  else if(_loc8_ is MobileMapListWindow)
                  {
                     completeTutorialState();
                  }
                  else if(_loc8_ != null)
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 2)
               {
                  _loc7_.states[2].additionalInfo["mapMemberOptionsMenu"] = true;
                  completeTutorialState();
               }
               if(_loc7_.currentStateIndex == 3)
               {
                  if(userInfo.gameMode == GameModeType.ATTACK)
                  {
                     completeTutorialState();
                  }
                  else if(_loc8_ == null || !(_loc8_ is MobileMapListWindow))
                  {
                     delete _loc7_.states[2].additionalInfo["mapMemberOptionsMenu"];
                     _loc7_.currentStateIndex = 1;
                     _loc9_.activated = false;
                  }
                  else if(!mobileMapInfo || !mobileMapInfo.mapMemberInfos || DictionaryUtil.lengthOf(mobileMapInfo.mapMemberInfos) <= 0)
                  {
                     _loc9_.activated = false;
                  }
               }
               if(!_loc7_.isCompleted && _loc7_.currentStateIndex >= 4 && _loc7_.currentStateIndex <= 7)
               {
                  if(attackInfo.attackEnded)
                  {
                     _loc7_.currentStateIndex = 7;
                     completeTutorialState();
                  }
               }
               if(_loc7_.currentStateIndex == 4)
               {
                  if(!("progress" in _loc7_.states[4].additionalInfo))
                  {
                     _loc7_.states[4].additionalInfo["progress"] = true;
                     coreManager.centerToBuildingByTypeId(10,-100,-40);
                  }
                  if(_loc8_ != null)
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 5)
               {
                  _loc3_ = 0;
                  _loc2_ = int(_loc7_.states[5].additionalInfo["unitTypeId"]);
                  for each(_loc1_ in attackInfo.units)
                  {
                     if(_loc1_.typeId == _loc2_ && _loc1_.status == UnitStatusType.DEPLOYING)
                     {
                        _loc3_++;
                     }
                  }
                  if(_loc3_ >= _loc7_.states[5].additionalInfo["amountOfUnits"])
                  {
                     completeTutorialState();
                  }
                  else if(_loc8_ != null)
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 6)
               {
                  dispatch(new MobileCanvasDeployHandEvent("showCanvasDeployHand",new MobileDeployHandView()));
                  _loc11_ = 0;
                  _loc2_ = int(_loc7_.states[5].additionalInfo["unitTypeId"]);
                  for each(_loc1_ in attackInfo.units)
                  {
                     if(_loc1_.typeId == _loc2_ && _loc1_.status == UnitStatusType.ATTACKING)
                     {
                        _loc11_++;
                     }
                  }
                  if(_loc11_ >= _loc7_.states[5].additionalInfo["amountOfUnits"])
                  {
                     dispatch(new MobileCanvasDeployHandEvent("hideCanvasDeployHand"));
                     completeTutorialState();
                  }
                  else if(_loc8_ != null)
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 7)
               {
                  if("progress" in _loc7_.states[7].additionalInfo)
                  {
                     if(_loc7_.states[7].additionalInfo["progress"] > _loc7_.states[7].additionalInfo["targetVal"])
                     {
                        completeTutorialState();
                     }
                     else if(_loc7_.states[7].additionalInfo["progress"] < _loc7_.states[7].additionalInfo["targetVal"])
                     {
                        _loc9_.activated = false;
                     }
                  }
                  else
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.states[0].additionalInfo["questId"] in userInfo.claimedQuestIds)
               {
                  if(_loc7_.currentStateIndex <= 7)
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc7_.tutorialId + " QUEST: " + _loc10_);
                     _loc7_.currentStateIndex = 9;
                     completeTutorialState();
                  }
                  else if(!("progress" in _loc7_.states[9].additionalInfo))
                  {
                     _loc7_.states[9].additionalInfo["progress"] = true;
                  }
               }
               if(_loc7_.currentStateIndex == 8)
               {
                  if("popUpShown" in _loc7_.states[8].additionalInfo)
                  {
                     if(_loc8_ == null)
                     {
                        completeTutorialState();
                     }
                     else if(!(_loc8_ is MobileBattleReportWindow))
                     {
                        _loc9_.activated = false;
                     }
                  }
                  else if(_loc8_ is MobileBattleReportWindow)
                  {
                     _loc7_.states[8].additionalInfo["popUpShown"] = true;
                  }
                  else
                  {
                     _loc9_.activated = false;
                  }
               }
               if(_loc7_.currentStateIndex == 9)
               {
                  if("progress" in _loc7_.states[9].additionalInfo && _loc7_.states[9].additionalInfo["progress"])
                  {
                     completeTutorialState();
                  }
               }
            }
            if(!_loc7_.isCompleted)
            {
               _loc9_.enabled = true;
            }
         }
         return _loc9_;
      }
      
      private function completeTutorialHiringQuarters(param1:TutorialInfo, param2:int) : void
      {
         coreManager.clearMobileTutorialArrowByTypeId(param2);
         gameRootHolder.gameRoot.mobileUnselect();
         param1.currentStateIndex = 9;
         completeTutorialState();
      }
      
      private function checkTutorialHiringQuarters() : TutorialActivationState
      {
         var _loc14_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:QuestInfo = null;
         var _loc13_:TaskDTO = null;
         var _loc10_:Dictionary = null;
         var _loc11_:Object = null;
         var _loc8_:BuildingInfo = null;
         var _loc7_:Boolean = false;
         var _loc12_:MobileBuildShowcaseWindow = null;
         var _loc5_:WomGameRoot = null;
         var _loc1_:int = 0;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc9_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc3_:TutorialInfo = "hq" in _loc9_.tutorials ? _loc9_.tutorials["hq"] : null;
         if(_loc3_ != null && !_loc3_.isCompleted)
         {
            view.currentTutorial = _loc3_;
            _loc14_ = int(_loc3_.states[1].additionalInfo["questId"]);
            _loc2_ = int(_loc3_.states[4].additionalInfo["buildingTypeId"]);
            if(_loc14_ in userInfo.claimedQuestIds)
            {
               log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc3_.tutorialId + " QUEST: " + _loc14_ + " TYPE:1");
               completeTutorialHiringQuarters(_loc3_,_loc2_);
            }
            else
            {
               _loc6_ = QuestUtil.getQuest(userInfo.quests,_loc14_);
               if(_loc6_ != null)
               {
                  _loc13_ = QuestUtil.getTask(_loc6_.tasks,_loc3_.states[1].additionalInfo["taskId"]);
                  if(_loc13_ != null && (_loc13_.completed || _loc13_.skipped))
                  {
                     log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc3_.tutorialId + " QUEST: " + _loc14_ + " TYPE:2");
                     completeTutorialHiringQuarters(_loc3_,_loc2_);
                  }
               }
            }
            if(!_loc3_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc4_.activated = false;
               }
               else
               {
                  _loc10_ = new Dictionary();
                  _loc10_["cityUiLayer"] = [1,3,4,6];
                  _loc11_ = _loc9_.additionalInfo.lastOpenedPopup;
                  _loc8_ = null;
                  if(_loc3_.currentStateIndex >= 0 && _loc3_.currentStateIndex <= 6)
                  {
                     _loc8_ = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,_loc2_);
                     if(_loc8_ != null)
                     {
                        _loc3_.states[7].additionalInfo["buildingInstanceId"] = _loc8_.instanceId;
                        _loc3_.currentStateIndex = 6;
                        completeTutorialState();
                     }
                  }
                  if(_loc3_.currentStateIndex == 0)
                  {
                     completeTutorialState();
                  }
                  if(_loc3_.currentStateIndex == 1)
                  {
                     _loc10_["menuPanel"] = [5];
                     dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc10_));
                     _loc7_ = checkQuestExistAndNotCompleted(_loc14_);
                     if(_loc7_)
                     {
                        if(_loc11_ != null)
                        {
                           if(_loc11_ is MobileQuestDetailWindow)
                           {
                              completeTutorialState();
                           }
                           else
                           {
                              _loc4_.activated = false;
                           }
                        }
                     }
                     else
                     {
                        _loc4_.activated = false;
                     }
                  }
                  else
                  {
                     _loc10_["menuPanel"] = [];
                     dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc10_));
                  }
                  if(_loc3_.currentStateIndex == 2)
                  {
                     if(_loc11_ == null)
                     {
                        _loc4_.activated = false;
                     }
                     else if(_loc11_ is MobileBuildShowcaseWindow)
                     {
                        completeTutorialState();
                     }
                     else if(!(_loc11_ is MobileQuestDetailWindow))
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 3)
                  {
                     if(_loc11_ == null || !(_loc11_ is MobileBuildShowcaseWindow))
                     {
                        _loc4_.activated = false;
                     }
                     else
                     {
                        _loc12_ = _loc11_ as MobileBuildShowcaseWindow;
                        if(_loc12_.activePanel != null && _loc12_.activePanel is MobileBuildCategoryPanel && (_loc12_.activePanel as MobileBuildCategoryPanel).category == BuildMenuCategory.FUNCTIONAL)
                        {
                           completeTutorialState();
                        }
                     }
                  }
                  if(_loc3_.currentStateIndex == 4)
                  {
                     if(_loc11_ == null)
                     {
                        _loc4_.activated = false;
                     }
                     else if(_loc11_ is MobileConstructBuildingWindow)
                     {
                        completeTutorialState();
                     }
                     else if(!(_loc11_ is MobileBuildShowcaseWindow))
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 5)
                  {
                     if(_loc3_.states[5].additionalInfo["buildingTypeId"] == _loc2_)
                     {
                        completeTutorialState();
                     }
                     else if(_loc11_ != null && !(_loc11_ is MobileConstructBuildingWindow))
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 6)
                  {
                     coreManager.panToBuildingByTypeId(20,-76,-160);
                     if(gameRootHolder.gameRoot.canvasMode != CanvasMode.BUILD)
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(!_loc3_.isCompleted && _loc3_.currentStateIndex >= 7 && _loc3_.currentStateIndex <= 9)
                  {
                     _loc8_ = BuildingInfoUtil.getBuildingByBuildingInstanceId(city.buildings,_loc3_.states[7].additionalInfo["buildingInstanceId"]);
                     if(_loc8_ != null && _loc8_.level > 0)
                     {
                        completeTutorialHiringQuarters(_loc3_,_loc2_);
                     }
                  }
                  if(_loc3_.currentStateIndex == 7)
                  {
                     _loc5_ = gameRootHolder.gameRoot;
                     _loc1_ = int(_loc3_.states[7].additionalInfo["buildingInstanceId"]);
                     DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
                     DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingInstanceIds);
                     userInfo.tutorialsInfo.interactableBuildingInstanceIds[_loc1_] = true;
                     coreManager.panToBuildingByTypeId(20,-77,-160);
                     coreManager.drawMobileTutorialArrowByTypeId(_loc2_,0,60);
                     if(!_loc5_)
                     {
                        _loc4_.activated = false;
                     }
                     else if(_loc5_.canvasMode == CanvasMode.MOBILE_SELECT && _loc5_.mobileSelectedInstanceId == _loc1_)
                     {
                        coreManager.clearMobileTutorialArrowByTypeId(_loc2_);
                        completeTutorialState();
                     }
                     else if(_loc5_.canvasMode != CanvasMode.NORMAL || _loc11_ != null)
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 8 && _loc11_ != null)
                  {
                     if(_loc11_ is MobileBoostConfirmationPopUp)
                     {
                        completeTutorialState();
                     }
                     else
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 9 && (_loc11_ == null || !(_loc11_ is MobileBoostConfirmationPopUp)))
                  {
                     _loc4_.activated = false;
                  }
               }
            }
            if(!_loc3_.isCompleted)
            {
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialHireBedouinBrutes() : TutorialActivationState
      {
         var _loc7_:int = 0;
         var _loc2_:Dictionary = null;
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc3_:TutorialInfo = "bed" in _loc1_.tutorials ? _loc1_.tutorials["bed"] : null;
         if(_loc3_ != null && !_loc3_.isCompleted)
         {
            view.currentTutorial = _loc3_;
            _loc7_ = int(_loc3_.states[0].additionalInfo["questId"]);
            if(_loc7_ in userInfo.claimedQuestIds)
            {
               log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc3_.tutorialId + " QUEST: " + _loc7_);
               coreManager.clearMobileTutorialArrowByTypeId(20);
               _loc3_.currentStateIndex = 3;
               completeTutorialState();
            }
            if(!_loc3_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc6_.activated = false;
               }
               else
               {
                  _loc2_ = new Dictionary();
                  _loc2_["cityUiLayer"] = [1,3,4,6];
                  _loc2_["menuPanel"] = [];
                  dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc2_));
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingInstanceIds);
                  userInfo.tutorialsInfo.interactableBuildingTypeIds[20] = true;
                  coreManager.panToBuildingByTypeId(20,-78,-160);
                  _loc4_ = _loc1_.additionalInfo.lastOpenedPopup;
                  if(_loc3_.currentStateIndex == 0)
                  {
                     coreManager.drawMobileTutorialArrowByTypeId(20,0,60);
                     if(checkQuestExistAndNotCompleted(_loc7_))
                     {
                        if(_loc4_ != null)
                        {
                           if(_loc4_ is MobileHiringQuartersWindow)
                           {
                              coreManager.clearMobileTutorialArrowByTypeId(20);
                              completeTutorialState();
                           }
                           else
                           {
                              _loc6_.activated = false;
                           }
                        }
                     }
                     else
                     {
                        _loc6_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 1)
                  {
                     if("progress" in _loc3_.states[1].additionalInfo && _loc3_.states[1].additionalInfo["progress"] >= _loc3_.states[1].additionalInfo["amountOfUnits"])
                     {
                        completeTutorialState();
                     }
                     else if(_loc4_ == null || !(_loc4_ is MobileHiringQuartersWindow))
                     {
                        _loc6_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 2)
                  {
                     if(checkQuestExistAndCompleted(_loc7_))
                     {
                        completeTutorialState();
                        dispatch(new MobilePopUpWindowEvent("closeTopPopUpWindow",null));
                     }
                     else
                     {
                        if(_loc4_ == null && !("progress" in _loc3_.states[2].additionalInfo))
                        {
                           _loc3_.states[2].additionalInfo["progress"] = true;
                           dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(8,{})));
                        }
                        _loc5_ = _loc1_.additionalInfo.lastOpenedSecondaryPopup;
                        if(!(_loc4_ is MobileHiringQuartersWindow) || _loc5_ != null)
                        {
                           _loc6_.activated = false;
                        }
                     }
                  }
                  if(_loc3_.currentStateIndex == 3)
                  {
                     if("progress" in _loc3_.states[3].additionalInfo)
                     {
                        if(_loc4_ == null)
                        {
                           completeTutorialState();
                        }
                        else if(!(_loc4_ is MobileQuestCompletedPopup) || (_loc4_ as MobileQuestCompletedPopup).questInfo.questId != _loc3_.states[0].additionalInfo["questId"])
                        {
                           _loc6_.activated = false;
                        }
                     }
                     else if(_loc4_ is MobileQuestCompletedPopup && (_loc4_ as MobileQuestCompletedPopup).questInfo.questId == _loc3_.states[0].additionalInfo["questId"])
                     {
                        _loc3_.states[3].additionalInfo["progress"] = true;
                     }
                     else
                     {
                        _loc6_.activated = false;
                     }
                  }
               }
            }
            if(!_loc3_.isCompleted)
            {
               _loc6_.enabled = true;
            }
         }
         return _loc6_;
      }
      
      private function checkTutorialLumberBlade() : TutorialActivationState
      {
         var _loc14_:int = 0;
         var _loc3_:int = 0;
         var _loc8_:Object = null;
         var _loc10_:Object = null;
         var _loc6_:Dictionary = null;
         var _loc13_:QuestInfo = null;
         var _loc9_:TaskDTO = null;
         var _loc12_:WomGameRoot = null;
         var _loc4_:BuildingInfo = null;
         var _loc1_:Boolean = false;
         var _loc11_:TutorialActivationState = new TutorialActivationState();
         var _loc5_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc7_:TutorialInfo = "lmb" in _loc5_.tutorials ? _loc5_.tutorials["lmb"] : null;
         if(_loc7_ != null && !_loc7_.isCompleted)
         {
            view.currentTutorial = _loc7_;
            _loc14_ = int(_loc7_.states[0].additionalInfo["questId"]);
            _loc3_ = int(_loc7_.states[1].additionalInfo["buildingTypeId"]);
            if(_loc14_ in userInfo.claimedQuestIds)
            {
               log(LoggerContexts.INFRASTRUCTURE,"SKIP_TUTORIAL ID: " + _loc7_.tutorialId + " QUEST: " + _loc14_);
               coreManager.clearMobileTutorialArrowByTypeId(_loc3_);
               _loc7_.currentStateIndex = 9;
               completeTutorialState();
            }
            if(!_loc7_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc11_.activated = false;
               }
               else
               {
                  _loc8_ = _loc5_.additionalInfo.lastOpenedPopup;
                  _loc10_ = _loc5_.additionalInfo.lastOpenedSecondaryPopup;
                  _loc6_ = new Dictionary();
                  _loc6_["cityUiLayer"] = [1,3,4];
                  _loc6_["menuPanel"] = [];
                  dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc6_));
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingInstanceIds);
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
                  userInfo.tutorialsInfo.interactableBuildingTypeIds[_loc3_] = true;
                  if(_loc7_.currentStateIndex == 0)
                  {
                     if(checkQuestExistAndNotCompleted(_loc14_))
                     {
                        completeTutorialState();
                     }
                     else
                     {
                        _loc11_.activated = false;
                     }
                  }
                  if(_loc7_.currentStateIndex == 1)
                  {
                     coreManager.centerToBuildingByTypeId(10,150,-160);
                     coreManager.drawMobileTutorialArrowByTypeId(_loc3_,0,60);
                     _loc13_ = QuestUtil.getQuest(userInfo.quests,_loc14_);
                     if(_loc13_ != null)
                     {
                        _loc9_ = QuestUtil.getTask(_loc13_.tasks,_loc7_.states[1].additionalInfo["taskId"]);
                        if(_loc9_ != null && (_loc9_.completed || _loc9_.skipped))
                        {
                           coreManager.clearMobileTutorialArrowByTypeId(_loc3_);
                           completeTutorialState();
                        }
                     }
                     if(_loc8_ != null || _loc10_ != null)
                     {
                        _loc11_.activated = false;
                     }
                  }
                  if(_loc7_.currentStateIndex == 2)
                  {
                     completeTutorialState();
                  }
                  _loc12_ = gameRootHolder.gameRoot;
                  if(_loc7_.currentStateIndex == 3)
                  {
                     coreManager.centerToBuildingByTypeId(10,150,-160);
                     coreManager.drawMobileTutorialArrowByTypeId(_loc3_,0,60);
                     userInfo.tutorialsInfo.additionalInfo.autoSelectCommand = true;
                     if(!_loc12_)
                     {
                        _loc11_.activated = false;
                     }
                     else if(_loc12_.canvasMode == CanvasMode.MOBILE_SELECT && _loc12_.mobileSelectedInstanceId in _loc12_.buildings && (_loc12_.buildings[_loc12_.mobileSelectedInstanceId] as Building).data.buildingTypeDIO.id == _loc3_)
                     {
                        coreManager.clearMobileTutorialArrowByTypeId(_loc3_);
                        userInfo.tutorialsInfo.additionalInfo.autoSelectCommand = false;
                        completeTutorialState();
                     }
                     else if(_loc12_.canvasMode != CanvasMode.NORMAL || _loc8_ != null)
                     {
                        _loc11_.activated = false;
                     }
                  }
                  if(_loc7_.currentStateIndex == 4)
                  {
                     if(_loc8_ is MobileUpgradeWindow && (_loc8_ as MobileUpgradeWindow).type == 2)
                     {
                        completeTutorialState();
                     }
                     else if(!_loc12_ || _loc12_.canvasMode != CanvasMode.MOBILE_SELECT || !(_loc12_.mobileSelectedInstanceId in _loc12_.buildings) || (_loc12_.buildings[_loc12_.mobileSelectedInstanceId] as Building).data.buildingTypeDIO.id != _loc3_ || _loc8_ != null)
                     {
                        _loc11_.activated = false;
                     }
                  }
                  _loc4_ = null;
                  if(!_loc7_.isCompleted && _loc7_.currentStateIndex >= 5 && _loc7_.currentStateIndex <= 9)
                  {
                     _loc4_ = BuildingInfoUtil.getBuildingByBuildingTypeId(city.buildings,_loc7_.states[1].additionalInfo["buildingTypeId"]);
                     if(_loc4_ != null && _loc4_.level > 1)
                     {
                        coreManager.clearMobileTutorialArrowByTypeId(_loc3_);
                        _loc7_.currentStateIndex = 9;
                        completeTutorialState();
                     }
                  }
                  if(_loc7_.currentStateIndex == 5)
                  {
                     if(_loc4_ == null)
                     {
                        _loc11_.activated = false;
                     }
                     else if(!("progress" in _loc7_.states[5].additionalInfo))
                     {
                        _loc7_.states[5].additionalInfo["progress"] = false;
                        addContextListener("outgoingMessage",onOutgoingMessage,OutgoingMessageEvent);
                     }
                     else if(_loc7_.states[5].additionalInfo["progress"])
                     {
                        delete _loc7_.states[5].additionalInfo["progress"];
                        completeTutorialState();
                     }
                     else if(_loc8_ == null || !(_loc8_ is MobileUpgradeWindow && (_loc8_ as MobileUpgradeWindow).type == 2))
                     {
                        _loc11_.activated = false;
                     }
                  }
                  if(_loc7_.currentStateIndex == 6)
                  {
                     _loc1_ = false;
                     for each(var _loc2_ in city.buildingUpgradeJobs)
                     {
                        if(_loc2_.instanceId == _loc4_.instanceId)
                        {
                           _loc1_ = true;
                           break;
                        }
                     }
                     if(_loc1_)
                     {
                        completeTutorialState();
                     }
                  }
                  if(_loc7_.currentStateIndex == 7)
                  {
                     coreManager.centerToBuildingByTypeId(10,150,-160);
                     coreManager.drawMobileTutorialArrowByTypeId(_loc3_,0,60);
                     if(_loc8_ != null)
                     {
                        _loc11_.activated = false;
                     }
                  }
               }
            }
            if(!_loc7_.isCompleted)
            {
               _loc11_.enabled = true;
            }
         }
         return _loc11_;
      }
      
      private function checkTutorialExtraWorker() : TutorialActivationState
      {
         var _loc2_:Dictionary = null;
         var _loc7_:int = 0;
         var _loc4_:Object = null;
         var _loc6_:Boolean = false;
         var _loc5_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc3_:TutorialInfo = "wor" in _loc1_.tutorials ? _loc1_.tutorials["wor"] : null;
         if(_loc3_ != null && !_loc3_.isCompleted)
         {
            view.currentTutorial = _loc3_;
            if(!_loc3_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc5_.activated = false;
               }
               else
               {
                  _loc2_ = new Dictionary();
                  _loc2_["cityUiLayer"] = [1,3,4,5];
                  _loc2_["menuPanel"] = [];
                  dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc2_));
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
                  DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingInstanceIds);
                  userInfo.tutorialsInfo.interactableBuildingInstanceIds[-1] = true;
                  _loc7_ = int(_loc3_.states[0].additionalInfo["questId"]);
                  if(_loc7_ in userInfo.claimedQuestIds)
                  {
                     _loc3_.currentStateIndex = 1;
                     completeTutorialState();
                  }
                  _loc4_ = _loc1_.additionalInfo.lastOpenedPopup;
                  if(_loc3_.currentStateIndex == 0)
                  {
                     _loc6_ = checkQuestExistAndNotCompleted(_loc7_);
                     if(_loc6_)
                     {
                        if(_loc4_ != null)
                        {
                           if(_loc4_ is MobileStoreWindow)
                           {
                              completeTutorialState();
                           }
                           else
                           {
                              _loc5_.activated = false;
                           }
                        }
                     }
                     else
                     {
                        _loc5_.activated = false;
                     }
                  }
                  if(_loc3_.currentStateIndex == 1 && !(_loc4_ is MobileStoreWindow))
                  {
                     _loc5_.activated = false;
                  }
               }
            }
            if(!_loc3_.isCompleted)
            {
               _loc5_.enabled = true;
            }
         }
         return _loc5_;
      }
      
      private function checkTutorialProtectionFlag() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "flg" in _loc1_.tutorials ? _loc1_.tutorials["flg"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            view.currentTutorial = _loc2_;
            if(!_loc2_.isCompleted)
            {
               if(userInfo.gameMode != GameModeType.NORMAL)
               {
                  _loc4_.activated = false;
               }
               else
               {
                  _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
                  if(_loc2_.currentStateIndex == 0)
                  {
                     if(mobileConnectionServiceInfo.isConnectedWithFacebook())
                     {
                        if("progress" in _loc2_.states[0].additionalInfo)
                        {
                           if(_loc2_.states[0].additionalInfo["progress"])
                           {
                              if(_loc3_ == null)
                              {
                                 _loc2_.currentStateIndex = 1;
                              }
                              else if("progress" in _loc2_.states[1].additionalInfo && _loc2_.states[1].additionalInfo["progress"] > 0)
                              {
                                 completeTutorialState();
                              }
                              else if(_loc3_ == null || !(_loc3_ is MobileSelectFriendsWindow))
                              {
                                 _loc4_.activated = false;
                              }
                           }
                           else if(_loc3_ is MobileSelectFriendsWindow)
                           {
                              _loc2_.states[0].additionalInfo["progress"] = true;
                           }
                           else
                           {
                              _loc4_.activated = false;
                           }
                        }
                        else
                        {
                           if(_loc3_ == null)
                           {
                              _loc2_.states[0].additionalInfo["progress"] = false;
                              dispatch(new WindowCreationEvent("createWindow",new WindowEnumeration(19,{})));
                           }
                           _loc4_.activated = false;
                        }
                     }
                     else
                     {
                        completeTutorialState();
                     }
                  }
                  if(_loc2_.currentStateIndex == 1)
                  {
                     if(mobileConnectionServiceInfo.isConnectedWithFacebook())
                     {
                        if(_loc3_ == null)
                        {
                           completeTutorialState();
                        }
                        else if("progress" in _loc2_.states[1].additionalInfo && _loc2_.states[1].additionalInfo["progress"] == 0)
                        {
                           _loc2_.currentStateIndex = 0;
                        }
                     }
                     else
                     {
                        completeTutorialState();
                     }
                  }
                  if(_loc2_.currentStateIndex == 2)
                  {
                     if(!("startTimer" in _loc2_.states[2].additionalInfo))
                     {
                        addContextListener("tick",onTick,GameTickEvent);
                     }
                     if("startTimer" in _loc2_.states[2].additionalInfo && getTimer() - _loc2_.states[2].additionalInfo["startTimer"] >= _loc2_.states[2].additionalInfo["waitMiliseconds"])
                     {
                        removeContextListener("tick",onTick,GameTickEvent);
                        completeTutorialState();
                     }
                     else if(_loc3_ != null)
                     {
                        _loc4_.activated = false;
                     }
                  }
                  if(_loc2_.currentStateIndex == 3)
                  {
                     removeContextListener("tick",onTick,GameTickEvent);
                     if(_loc3_ != null)
                     {
                        _loc4_.activated = false;
                     }
                  }
               }
            }
            if(!_loc2_.isCompleted)
            {
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialHelpThorzain() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "hlp" in _loc1_.tutorials ? _loc1_.tutorials["hlp"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            if(userInfo.gameMode == GameModeType.VISIT && visitInfo != null && visitInfo.landlord.gameId == _loc2_.states[0].additionalInfo["mapMemberId"])
            {
               view.currentTutorial = _loc2_;
               _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
               if(_loc3_ != null)
               {
                  _loc4_.activated = false;
               }
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialRPExplanationTypeStore() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc5_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "rp_s" in _loc1_.tutorials ? _loc1_.tutorials["rp_s"] : null;
         var _loc4_:TutorialInfo = "rp_g" in _loc1_.tutorials ? _loc1_.tutorials["rp_g"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted && (_loc4_ == null || !_loc4_.isCompleted))
         {
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            if(_loc3_ != null && _loc3_ is MobileStoreWindow)
            {
               view.currentTutorial = _loc2_;
               _loc5_.enabled = true;
            }
         }
         return _loc5_;
      }
      
      private function checkTutorialRPExplanationTypeGainRP() : TutorialActivationState
      {
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "rp_g" in _loc1_.tutorials ? _loc1_.tutorials["rp_g"] : null;
         var _loc3_:TutorialInfo = "rp_s" in _loc1_.tutorials ? _loc1_.tutorials["rp_s"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted && (_loc3_ == null || !_loc3_.isCompleted))
         {
            if(userInfo.reconPoints > 0 && userInfo.gameMode == GameModeType.NORMAL && userInfo.currentScreen == WomScreenType.CITY && _loc1_.additionalInfo.lastOpenedPopup == null)
            {
               view.currentTutorial = _loc2_;
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialFirstAttack() : TutorialActivationState
      {
         var _loc3_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "fa" in _loc1_.tutorials ? _loc1_.tutorials["fa"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            if(userInfo.gameMode == GameModeType.ATTACK && userInfo.currentScreen == WomScreenType.CITY && _loc1_.additionalInfo.lastOpenedPopup == null)
            {
               view.currentTutorial = _loc2_;
               _loc3_.enabled = true;
            }
         }
         return _loc3_;
      }
      
      private function checkTutorialFirstRepair() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "fr" in _loc1_.tutorials ? _loc1_.tutorials["fr"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            if(_loc2_.currentStateIndex == 0 && _loc3_ != null && _loc3_ is MobileRepairPopUp)
            {
               view.currentTutorial = _loc2_;
               completeTutorialState();
            }
            if(_loc2_.currentStateIndex == 1 && (_loc3_ == null || _loc3_ is MobileRepairPopUp))
            {
               view.currentTutorial = _loc2_;
               if(_loc3_ == null)
               {
                  completeTutorialState();
               }
               if(!_loc2_.isCompleted)
               {
                  _loc4_.enabled = true;
               }
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialResourceFull() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "rf" in _loc1_.tutorials ? _loc1_.tutorials["rf"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            _loc3_ = _loc1_.additionalInfo.lastOpenedSecondaryPopup;
            if(_loc2_.currentStateIndex == 0 && _loc3_ != null && _loc3_ is MobileActionNotPossiblePopup && (_loc3_ as MobileActionNotPossiblePopup).type == 79)
            {
               view.currentTutorial = _loc2_;
               completeTutorialState();
            }
            if(_loc2_.currentStateIndex == 1 && (_loc3_ == null || _loc3_ is MobileActionNotPossiblePopup && (_loc3_ as MobileActionNotPossiblePopup).type == 79))
            {
               view.currentTutorial = _loc2_;
               if(_loc3_ == null)
               {
                  completeTutorialState();
               }
               if(!_loc2_.isCompleted)
               {
                  _loc4_.enabled = true;
               }
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialUnitRecruited(param1:String) : TutorialActivationState
      {
         var _loc4_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:TutorialActivationState = new TutorialActivationState();
         var _loc2_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc3_:TutorialInfo = param1 in _loc2_.tutorials ? _loc2_.tutorials[param1] : null;
         if(_loc3_ != null && !_loc3_.isCompleted)
         {
            _loc4_ = _loc2_.additionalInfo.lastOpenedPopup;
            _loc5_ = _loc3_.states[0].additionalInfo["unitTypeIds"];
            if(_loc3_.currentStateIndex == 0 && _loc4_ != null && _loc4_ is MobileRecruitmentCompletedPopUp && "ut_" + (_loc4_ as MobileRecruitmentCompletedPopUp).unitTypeDIO.id in _loc5_)
            {
               view.currentTutorial = _loc3_;
               completeTutorialState();
            }
            if(_loc3_.currentStateIndex == 1 && (_loc4_ == null || _loc4_ is MobileRecruitmentCompletedPopUp && "ut_" + (_loc4_ as MobileRecruitmentCompletedPopUp).unitTypeDIO.id in _loc5_))
            {
               view.currentTutorial = _loc3_;
               if(_loc4_ == null)
               {
                  completeTutorialState();
               }
               if(!_loc3_.isCompleted)
               {
                  _loc6_.enabled = true;
               }
            }
         }
         return _loc6_;
      }
      
      private function checkTutorialExplainPartFromActivateBuilding() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc5_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "ep_ab" in _loc1_.tutorials ? _loc1_.tutorials["ep_ab"] : null;
         var _loc4_:TutorialInfo = "ep_hw" in _loc1_.tutorials ? _loc1_.tutorials["ep_hw"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted && (_loc4_ == null || !_loc4_.isCompleted))
         {
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            if(_loc3_ != null && _loc3_ is MobileActivateBuildingWindow)
            {
               view.currentTutorial = _loc2_;
               _loc5_.enabled = true;
            }
         }
         return _loc5_;
      }
      
      private function checkTutorialExplainMaps() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "em" in _loc1_.tutorials ? _loc1_.tutorials["em"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            view.currentTutorial = _loc2_;
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            if(_loc2_.currentStateIndex == 0)
            {
               if("progress" in _loc2_.states[0].additionalInfo)
               {
                  if(_loc3_ == null)
                  {
                     completeTutorialState();
                  }
               }
               else if(_loc3_ != null && _loc3_ is MobileMapListWindow)
               {
                  _loc2_.states[0].additionalInfo["progress"] = true;
                  dispatch(new TutorialTriggerEvent("showAllMapMembers"));
               }
               else
               {
                  _loc4_.activated = false;
               }
            }
            if(_loc2_.currentStateIndex == 1)
            {
               if("progress" in _loc2_.states[1].additionalInfo)
               {
                  if(_loc3_ == null)
                  {
                     completeTutorialState();
                  }
               }
               else if(_loc3_ != null && _loc3_ is MobileMapListWindow)
               {
                  _loc2_.states[1].additionalInfo["progress"] = true;
               }
               else
               {
                  _loc4_.activated = false;
               }
            }
            if(!_loc2_.isCompleted && _loc4_.activated)
            {
               _loc4_.enabled = true;
            }
         }
         return _loc4_;
      }
      
      private function checkTutorialFirstPvP() : TutorialActivationState
      {
         var _loc3_:Object = null;
         var _loc5_:MobileBattleReportWindow = null;
         var _loc4_:TutorialActivationState = new TutorialActivationState();
         var _loc1_:TutorialListInfo = userInfo.tutorialsInfo;
         var _loc2_:TutorialInfo = "fpvp" in _loc1_.tutorials ? _loc1_.tutorials["fpvp"] : null;
         if(_loc2_ != null && !_loc2_.isCompleted)
         {
            _loc3_ = _loc1_.additionalInfo.lastOpenedPopup;
            if(_loc2_.currentStateIndex == 0 && _loc3_ != null && _loc3_ is MobileBattleReportWindow)
            {
               _loc5_ = _loc3_ as MobileBattleReportWindow;
               if(_loc5_.attacker.gameId == userInfo.profile.gameId && !_loc5_.defender.isNpc)
               {
                  view.currentTutorial = _loc2_;
                  completeTutorialState();
               }
            }
            if(_loc2_.currentStateIndex == 1)
            {
               view.currentTutorial = _loc2_;
               if(_loc3_ == null || !(_loc3_ is MobileBattleReportWindow))
               {
                  completeTutorialState();
               }
               if(!_loc2_.isCompleted)
               {
                  _loc4_.enabled = true;
               }
            }
         }
         return _loc4_;
      }
      
      private function checkQuestExistAndNotCompleted(param1:int) : Boolean
      {
         var _loc2_:QuestInfo = QuestUtil.getQuest(userInfo.quests,param1);
         return _loc2_ != null && !_loc2_.completed;
      }
      
      private function checkQuestExistAndCompleted(param1:int) : Boolean
      {
         var _loc2_:QuestInfo = QuestUtil.getQuest(userInfo.quests,param1);
         return _loc2_ != null && _loc2_.completed;
      }
      
      private function onConnectionLost(param1:ClientEvent) : void
      {
         disableListeners();
      }
      
      private function onTutorialsUpdated(param1:TutorialEvent) : void
      {
         if(userInfo.tutorialsInfo.enabled)
         {
            enableListeners();
            checkTriggers();
         }
         else
         {
            disableListeners();
         }
      }
      
      private function onPopUpShown(param1:MobilePopUpWindowEvent) : void
      {
         checkTriggers();
      }
      
      private function onTrigger(param1:TutorialTriggerEvent) : void
      {
         checkTriggers();
      }
      
      private function activateTutorialWindow(param1:TutorialInfo) : void
      {
         view.updateWithTutorialInfo(param1);
         eventMap.mapStarlingListener(view.tutorialWindow.doneButton,"triggered",doneButtonClicked,Event);
         view.drawLayout();
      }
      
      private function deactivateTutorialWindow() : void
      {
         if(view.currentState != null)
         {
            view.currentState = null;
            eventMap.unmapStarlingListener(view.tutorialWindow.doneButton,"triggered",doneButtonClicked,Event);
            checkTriggers();
         }
         view.drawLayout();
      }
      
      private function doneButtonClicked(param1:Event) : void
      {
         completeTutorialState();
         deactivateTutorialWindow();
      }
      
      private function completeTutorialState() : void
      {
         var _loc1_:Dictionary = null;
         var _loc2_:Boolean = false;
         checkTutorialQuest20();
         var _loc4_:TutorialInfo = view.currentTutorial;
         var _loc3_:TutorialState = view.currentTutorial.currentStateIndex < view.currentTutorial.states.length ? view.currentTutorial.states[view.currentTutorial.currentStateIndex] : null;
         if(_loc3_ != null)
         {
            if(_loc3_.id != "-1")
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new ProgressTutorialStepRequest(userInfo.abModeTutorial == TutorialListInfo.DEFAULT_AB_MODE ? _loc3_.id : _loc3_.id + userInfo.abModeTutorial.id,2,"questId" in _loc4_.states[0].additionalInfo ? _loc4_.states[0].additionalInfo["questId"] : -1,"T" + (userInfo.abModeTutorial == TutorialListInfo.DEFAULT_AB_MODE ? _loc3_.id : _loc3_.id + userInfo.abModeTutorial.id))));
            }
            _loc2_ = _loc3_.persistAfterCompletion;
         }
         view.currentTutorial.currentStateIndex++;
         if(view.currentTutorial.currentStateIndex >= view.currentTutorial.states.length)
         {
            view.currentTutorial.isCompleted = true;
         }
         if(_loc3_ != null)
         {
            if(_loc3_.id == "42")
            {
               dispatch(new TutorialEvent("setMandatoryTutorialsCompleted"));
               inboxInfo.inboxMode = 2;
               dispatch(new TutorialEvent("mandatoryTutorialsCompleted"));
               dispatch(new TutorialEvent("mandatoryTutorialsCompletionChanged"));
               _loc1_ = new Dictionary();
               _loc1_["cityUiLayer"] = [0];
               _loc1_["menuPanel"] = [0];
               dispatch(new TutorialVisibleItemsEvent("updateVisibleOfTutorialItems",_loc1_));
               DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingTypeIds);
               DictionaryUtil.clear(userInfo.tutorialsInfo.interactableBuildingInstanceIds);
               dispatch(new ModelUpdateEvent("resourcesUpdated"));
               dispatch(new ModelUpdateEvent("goldAmountUpdated"));
               coreManager.buildCityExpansionSigns();
            }
            if(_loc3_.id == "44")
            {
               if(!mobileConnectionServiceInfo.isConnectedWithFacebook())
               {
                  dispatch(new MobilePopUpWindowEvent("showPopUpWindow",new MobileFBGetGoldPopUp(true)));
               }
            }
         }
         if(view.currentTutorial.isCompleted)
         {
            if(view.currentTutorial.nextTutorialId != null)
            {
               _loc4_ = userInfo.tutorialsInfo.tutorials[view.currentTutorial.nextTutorialId];
               _loc3_ = _loc4_.states[0];
            }
            else
            {
               _loc3_ = null;
            }
         }
         else
         {
            _loc3_ = view.currentTutorial.currentStateIndex < view.currentTutorial.states.length ? view.currentTutorial.states[view.currentTutorial.currentStateIndex] : null;
         }
         if(_loc3_ != null && _loc3_.id != "-1")
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ProgressTutorialStepRequest(userInfo.abModeTutorial == TutorialListInfo.DEFAULT_AB_MODE ? _loc3_.id : _loc3_.id + userInfo.abModeTutorial.id,1,"questId" in _loc4_.states[0].additionalInfo ? _loc4_.states[0].additionalInfo["questId"] : -1,"T" + (userInfo.abModeTutorial == TutorialListInfo.DEFAULT_AB_MODE ? _loc3_.id : _loc3_.id + userInfo.abModeTutorial.id))));
         }
         if(view.currentTutorial.isCompleted || _loc2_)
         {
            dispatch(new TutorialEvent("saveTutorialsToServer",view.currentTutorial.tutorialId));
         }
         if(view.currentTutorial.isCompleted)
         {
            checkTriggers();
         }
      }
      
      private function checkTutorialQuest20() : void
      {
         if(view.currentTutorial != null && view.currentTutorial.tutorialId == "def" && view.currentTutorial.currentStateIndex == 0)
         {
            userInfo.canReceiveNPCAttacks = true;
            dispatch(new OutgoingMessageEvent("outgoingMessage",new ForwardNPCAttackRequest(300)));
         }
      }
      
      private function onReferencePositionReady(param1:TutorialReferencePositionEvent) : void
      {
         if(param1.objectToBeAligned == 2)
         {
            view.updateWithAlignmentReferencePosition(param1.position,DisplayObject(param1.displayObject));
         }
         else if(param1.objectToBeAligned == 1)
         {
            view.tutorialWindow.updateWithAlignmentReferencePosition(param1.position);
         }
      }
      
      private function onStartBuild(param1:TutorialTriggerEvent) : void
      {
         if("buildingTypeId" in param1.additionalInfo && view.currentState != null)
         {
            view.currentState.additionalInfo["buildingTypeId"] = param1.additionalInfo["buildingTypeId"];
         }
         checkTriggers();
      }
      
      private function onCenterOfCityPosition(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,coreManager.getCenterOfCityPosition()));
      }
      
      private function onBuildingPosition(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:Point = null;
         if("buildingInstanceId" in param1.additionalInfo)
         {
            _loc2_ = coreManager.getBuildingPositionByInstanceId(param1.additionalInfo["buildingInstanceId"]);
         }
         else if("buildingTypeId" in param1.additionalInfo)
         {
            _loc2_ = coreManager.getBuildingPositionByTypeId(param1.additionalInfo["buildingTypeId"]);
         }
         if(_loc2_ != null)
         {
            dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_));
         }
      }
      
      private function onBuildingProgressBarPosition(param1:TutorialReferencePositionEvent) : void
      {
         var _loc2_:Point = coreManager.getBuildingProgressBarPosition(param1.additionalInfo["buildingInstanceId"]);
         if(_loc2_ != null)
         {
            dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_));
         }
      }
      
      private function onShowTownOptionsMenu(param1:TownOptionsMenuEvent) : void
      {
         if(view.currentState != null && param1.mapTileData.mapMemberInfo.profile.isNpc && "mapMemberId" in view.currentState.additionalInfo && view.currentState.additionalInfo["mapMemberId"] == param1.mapTileData.mapMemberInfo.profile.npcId)
         {
            view.currentState.additionalInfo["mapMemberOptionsMenu"] = true;
            checkTriggers();
         }
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         var _loc2_:int = 0;
         if(view.currentState != null && "waitMiliseconds" in view.currentState.additionalInfo)
         {
            if(!("startTimer" in view.currentState.additionalInfo))
            {
               view.currentState.additionalInfo["startTimer"] = getTimer();
            }
            _loc2_ = getTimer();
            if(_loc2_ - view.currentState.additionalInfo["startTimer"] >= view.currentState.additionalInfo["waitMiliseconds"])
            {
               removeContextListener("tick",onTick,GameTickEvent);
               checkTriggers();
            }
         }
      }
      
      private function onTooltipShown(param1:TutorialTriggerEvent) : void
      {
         if(view.currentState != null && "amountOfTooltips" in view.currentState.additionalInfo)
         {
            if(!("progress" in view.currentState.additionalInfo))
            {
               view.currentState.additionalInfo["progress"] = 0;
            }
            var _loc2_:String = "progress";
            var _loc3_:Number = view.currentState.additionalInfo[_loc2_] + 1;
            view.currentState.additionalInfo[_loc2_] = _loc3_;
            dispatch(new TutorialEvent("saveTutorialsToServer",view.currentTutorial.tutorialId));
            checkTriggers();
         }
      }
      
      private function onTopRightPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,new Point(view.visibleWidth,0)));
      }
      
      private function onBottomLeftPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,new Point(0,view.visibleHeight)));
      }
      
      private function onBottomRightPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,new Point(view.visibleWidth,view.visibleHeight)));
      }
      
      private function onCenterOfScreenPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,new Point(view.visibleWidth >> 1,view.visibleHeight >> 1)));
      }
      
      private function onKeepAlive(param1:TimerEvent) : void
      {
         dispatch(new KeepAliveEvent("keepAlive"));
      }
      
      private function onMandatoryTutorialsCompletionChanged(param1:TutorialEvent) : void
      {
         view.keepAliveTimer.removeEventListener("timer",onKeepAlive);
         if(userInfo.mandatoryTutorialCompleted)
         {
            view.keepAliveTimer.stop();
            log(LoggerContexts.INFRASTRUCTURE,"Tutorial keep alive timer stopped");
         }
         else
         {
            view.keepAliveTimer.addEventListener("timer",onKeepAlive);
            view.keepAliveTimer.start();
            log(LoggerContexts.INFRASTRUCTURE,"Tutorial keep alive timer stated");
         }
      }
      
      private function onOutgoingMessage(param1:OutgoingMessageEvent) : void
      {
         var _loc2_:TutorialInfo = null;
         var _loc3_:TutorialState = null;
         if(param1.message is UpgradeBuildingRequest)
         {
            _loc2_ = "lmb" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["lmb"] : null;
            if(_loc2_ != null)
            {
               removeContextListener("outgoingMessage",onOutgoingMessage,OutgoingMessageEvent);
               _loc3_ = _loc2_.states[_loc2_.states[0].additionalInfo["stateIndexSendRequest"]];
               _loc3_.additionalInfo["progress"] = true;
               checkTriggers();
            }
         }
      }
   }
}

