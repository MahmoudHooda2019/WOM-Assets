package wom.view.mediator.screen.windows.map
{
   import feathers.data.ListCollection;
   import flash.geom.Point;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.combat.StartAttackEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.MobileMapListSelectionToggleEvent;
   import wom.controller.event.ui.MobilePopUpWindowEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.dto.MapMemberInfo;
   import wom.model.game.MobileMapInfo;
   import wom.model.game.Profile;
   import wom.model.game.UserInfo;
   import wom.model.game.tutorial.TutorialListInfo;
   import wom.model.message.request.GetMapInfoRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.screen.popups.MobileClementineChangableActionPopUp;
   import wom.view.screen.windows.map.MobileMapListMemberRenderer;
   import wom.view.screen.windows.map.MobileMapListPanel;
   import wom.view.ui.common.MobileListHeaderView;
   
   public class MobileMapListPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileMapListPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var mobileMapInfo:MobileMapInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      public function MobileMapListPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         mapListeners();
         view.updateListAccordingToCheckBoxSelection(true);
         eventDispatcher.dispatchEvent(new OutgoingMessageEvent("outgoingMessage",new GetMapInfoRequest()));
      }
      
      private function mapListeners() : void
      {
         addContextListener("mobileMapMemberListUpdated",onListUpdated,ModelUpdateEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         addContextListener("getMapTownOptionsMenuPosition",onGetMapTownOptionsMenuPositionRequested,TutorialReferencePositionEvent);
         addContextListener("MobileMapListSelectionToggle",onCheckboxToggle,MobileMapListSelectionToggleEvent);
         eventMap.mapStarlingListener(view.memberList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.memberList,"rendererRemove",onRendererRemoved,Event);
         eventMap.mapStarlingListener(view.levelHeader,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.allianceHeader,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.nameHeader,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.bpHeader,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.historyHeader,"touch",onHeaderClicked,TouchEvent);
         eventMap.mapStarlingListener(view.diplomacyHeader,"touch",onHeaderClicked,TouchEvent);
      }
      
      private function onCheckboxToggle(param1:MobileMapListSelectionToggleEvent) : void
      {
         view.showAllSelected = param1.selected;
         view.updateListAccordingToCheckBoxSelection(true);
      }
      
      private function onGetMapTownOptionsMenuPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         var _loc4_:MapMemberInfo = null;
         var _loc3_:Profile = null;
         var _loc2_:Point = null;
         if(view.memberList && view.memberList.dataProvider && view.memberList.dataProvider.length > 0)
         {
            _loc4_ = view.memberList.dataProvider.getItemAt(0) as MapMemberInfo;
            if(_loc4_)
            {
               _loc3_ = TutorialListInfo.getProfileAccordingToTutorial(_loc4_.profile,userInfo.tutorialsInfo);
               if(_loc3_.isNpc && _loc3_.npcId == "NPC_D")
               {
                  view.memberList.horizontalScrollPolicy = "off";
                  view.memberList.verticalScrollPolicy = "off";
                  _loc2_ = view.memberList.localToGlobal(new Point(0,0));
                  dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,_loc2_,param1.additionalInfo));
               }
            }
         }
      }
      
      private function onListUpdated(param1:ModelUpdateEvent) : void
      {
         view.updateWithMembers(mobileMapInfo.mapMemberInfos,userInfo.tutorialsInfo);
         view.updateListAccordingToCheckBoxSelection(true);
         dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
      }
      
      private function onRendererAdded(param1:Event, param2:MobileMapListMemberRenderer) : void
      {
         param2.mapMemberInfo.visibleName = facebookAPIManager.getUserNameByProfile(param2.mapMemberInfo.profileAccordingToTutorial ? param2.mapMemberInfo.profileAccordingToTutorial : param2.mapMemberInfo.profile);
         param2.updateName();
         eventMap.mapStarlingListener(param2.enterButton,"triggered",onEnterCityClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileMapListMemberRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.enterButton,"triggered",onEnterCityClicked,Event);
      }
      
      private function onEnterCityClicked(param1:Event) : void
      {
         var _loc3_:Profile = null;
         var _loc2_:MobileMapListMemberRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            _loc3_ = _loc2_.mapMemberInfo.profile;
            userInfo.fromMap = true;
            if(userInfo.mandatoryTutorialCompleted)
            {
               if(_loc2_.mapMemberInfo.mandatoryTutorialCompleted)
               {
                  kontagentApi.trackUIEvent("war_menu","scout");
                  kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"visit_button"});
                  dispatch(new StartVisitEvent("startVisit",_loc3_,_loc3_.isNpc,true,true));
               }
               else
               {
                  var _temp_5:* = §§findproperty(MobilePopUpWindowEvent);
                  var _temp_4:* = "showSecondaryPopUpWindow";
                  var _temp_3:* = §§findproperty(MobileClementineChangableActionPopUp);
                  var _temp_2:* = 2;
                  var _temp_1:* = "";
                  var _loc4_:String = "m.ui.popups.visiterror.message.6";
                  dispatch(new MobilePopUpWindowEvent(_temp_4,new MobileClementineChangableActionPopUp(_temp_2,_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_))));
               }
            }
            else
            {
               kontagentApi.trackCustomEvent("MapAttack",{"subtype1":"attack_button"});
               kontagentApi.trackUIEvent("war_menu","attack");
               dispatch(new StartAttackEvent("startAttack",_loc3_,_loc3_.isNpc,false,true,true));
            }
         }
      }
      
      public function onHeaderClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(param1.currentTarget as DisplayObject,"ended");
         if(_loc2_)
         {
            if(param1.currentTarget && param1.currentTarget is MobileListHeaderView)
            {
               view.headerClicked(param1.currentTarget as MobileListHeaderView);
            }
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : MobileMapListMemberRenderer
      {
         var _loc3_:MobileMapListMemberRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is MobileMapListMemberRenderer)
         {
            _loc3_ = _loc2_.parent as MobileMapListMemberRenderer;
            if(_loc3_.mapMemberInfo)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc3_:ListCollection = null;
         var _loc5_:int = 0;
         var _loc2_:MapMemberInfo = null;
         var _loc4_:String = null;
         if(view.memberList && view.memberList.dataProvider)
         {
            _loc3_ = view.memberList.dataProvider;
            _loc5_ = 0;
            while(_loc5_ < _loc3_.data.length)
            {
               _loc2_ = _loc3_.data[_loc5_];
               _loc4_ = _loc2_.profile.mobileName ? _loc2_.profile.mobileName : facebookAPIManager.getUserNameByProfile(_loc2_.profileAccordingToTutorial ? _loc2_.profileAccordingToTutorial : _loc2_.profile);
               if(_loc4_ != _loc2_.visibleName)
               {
                  _loc2_.visibleName = _loc4_;
                  _loc3_.updateItemAt(_loc5_);
               }
               _loc5_++;
            }
         }
      }
   }
}

