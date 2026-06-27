package wom.view.mediator.screen.windows.report.attacklog.mobile
{
   import feathers.data.ListCollection;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.component.mobile.MPButton;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.AttackLogEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.visit.StartVisitEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.report.MobileAttackLog;
   import wom.model.game.window.WindowEnumeration;
   import wom.model.message.request.ReadAttackLogRequest;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.screen.windows.report.attacklog.mobile.MobileAttackLogPanel;
   import wom.view.screen.windows.report.attacklog.mobile.MobileAttackLogViewRenderer;
   
   public class MobileAttackLogPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileAttackLogPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobileAttackLogPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         if(view.attackLogsList == null)
         {
            injector.injectInto(view);
         }
         else
         {
            view.recreateAttackLogList();
         }
         eventMap.mapStarlingListener(view.attackLogsList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.attackLogsList,"rendererRemove",onRendererRemoved,Event);
         addContextListener("getBattleReport",onGetBattleReport,AttackLogEvent);
         addContextListener("platformUsersUpdated",onPlatformUsersUpdated,ModelUpdateEvent);
         updateWithAttackLogs();
      }
      
      private function onRendererAdded(param1:Event, param2:MobileAttackLogViewRenderer) : void
      {
         param2.attackLog.attackerName = facebookAPIManager.getUserNameByProfile(param2.attackLog.attacker);
         param2.attackLog.defenderName = facebookAPIManager.getUserNameByProfile(param2.attackLog.defender);
         param2.updateInfoText();
         eventMap.mapStarlingListener(param2.enterCityButton,"triggered",onEnterCityClicked,Event);
         eventMap.mapStarlingListener(param2.reportButton,"triggered",onReportButtonClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileAttackLogViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2.enterCityButton,"triggered",onEnterCityClicked,Event);
         eventMap.unmapStarlingListener(param2.reportButton,"triggered",onReportButtonClicked,Event);
      }
      
      private function onEnterCityClicked(param1:Event) : void
      {
         var _loc2_:MobileAttackLogViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
            dispatch(new StartVisitEvent("startVisit",_loc2_.opponent,_loc2_.opponent.isNpc,true));
         }
      }
      
      private function onReportButtonClicked(param1:Event) : void
      {
         var _loc2_:MobileAttackLogViewRenderer = checkRendererValidityForClickedButton(param1);
         if(_loc2_)
         {
            if(!_loc2_.attackLog.isRead)
            {
               dispatch(new OutgoingMessageEvent("outgoingMessage",new ReadAttackLogRequest(_loc2_.attackLog.id)));
            }
            dispatch(new AttackLogEvent("getBattleReport",_loc2_.attackLog));
         }
      }
      
      private function checkRendererValidityForClickedButton(param1:Event) : MobileAttackLogViewRenderer
      {
         var _loc3_:MobileAttackLogViewRenderer = null;
         var _loc2_:MPButton = param1.target as MPButton;
         if(_loc2_.parent && _loc2_.parent is MobileAttackLogViewRenderer)
         {
            _loc3_ = _loc2_.parent as MobileAttackLogViewRenderer;
            if(_loc3_.opponent && _loc3_.attackLog)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      private function updateWithAttackLogs() : void
      {
         if(view.attackLogsList)
         {
            view.attackLogsUpdated(userInfo.attackLogs);
            updateName();
         }
      }
      
      private function onGetBattleReport(param1:AttackLogEvent) : void
      {
         var _loc2_:Vector.<WindowEnumeration> = new Vector.<WindowEnumeration>(0);
         _loc2_.push(new WindowEnumeration(23,{"womview":view}));
         _loc2_.push(new WindowEnumeration(24,{
            "logId":param1.attackLog.id,
            "startInMillis":param1.attackLog.attackDurationInMillis,
            "afterAttack":false,
            "attacker":param1.attackLog.attacker,
            "defender":param1.attackLog.defender
         }));
         dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view,false,_loc2_));
      }
      
      private function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         updateName();
      }
      
      private function updateName() : void
      {
         var _loc2_:ListCollection = null;
         var _loc5_:int = 0;
         var _loc4_:MobileAttackLog = null;
         var _loc3_:String = null;
         var _loc1_:String = null;
         if(view.attackLogsList && view.attackLogsList.dataProvider)
         {
            _loc2_ = view.attackLogsList.dataProvider;
            _loc5_ = 0;
            while(_loc5_ < _loc2_.data.length)
            {
               _loc4_ = _loc2_.data[_loc5_];
               _loc3_ = _loc4_.attacker.mobileName ? _loc4_.attacker.mobileName : facebookAPIManager.getUserNameByProfile(_loc4_.attacker);
               _loc1_ = _loc4_.defender.mobileName ? _loc4_.defender.mobileName : facebookAPIManager.getUserNameByProfile(_loc4_.defender);
               if(_loc3_ != _loc4_.attackerName || _loc1_ != _loc4_.defenderName)
               {
                  _loc4_.attackerName = _loc3_;
                  _loc4_.defenderName = _loc1_;
                  _loc2_.updateItemAt(_loc5_);
               }
               _loc5_++;
            }
         }
      }
   }
}

