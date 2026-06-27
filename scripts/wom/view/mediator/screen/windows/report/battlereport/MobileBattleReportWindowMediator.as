package wom.view.mediator.screen.windows.report.battlereport
{
   import flash.geom.Point;
   import peak.i18n.PText;
   import peak.resource.SoundPlayer;
   import starling.events.Event;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.report.AttackLog;
   import wom.model.game.report.battlereport.BattleReport;
   import wom.model.message.request.GetBattleReportRequest;
   import wom.model.mobile.MobileConnectionServiceInfo;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportDetailView;
   import wom.view.screen.windows.report.battlereport.MobileBattleReportWindow;
   
   public class MobileBattleReportWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileBattleReportWindow;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var soundPlayer:SoundPlayer;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var facebookApiManager:FacebookAPIManager;
      
      [Inject]
      public var mobileConnectionServiceInfo:MobileConnectionServiceInfo;
      
      public function MobileBattleReportWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("battleReportUpdated",onBattleReportUpdated,ModelUpdateEvent);
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         eventMap.mapStarlingListener(view.actionButton,"triggered",onBackButtonClicked,Event);
         eventMap.mapStarlingListener(view.infoButton,"triggered",onInfoButtonClicked,Event);
         var _loc2_:AttackLog = null;
         if(view.attackLogId in userInfo.battleReports)
         {
            for each(var _loc1_ in userInfo.attackLogs)
            {
               if(_loc1_.id == view.attackLogId)
               {
                  _loc2_ = _loc1_;
                  break;
               }
            }
            battleReportUpdated(userInfo.battleReports[view.attackLogId],_loc2_);
         }
         else
         {
            dispatch(new OutgoingMessageEvent("outgoingMessage",new GetBattleReportRequest(view.attackLogId)));
         }
         if(view.afterAttack)
         {
            soundPlayer.playSfxById("VictorySplashScreen");
         }
         checkActionButtonLabel();
      }
      
      private function checkActionButtonLabel() : void
      {
         if(!userInfo.mandatoryTutorialCompleted)
         {
            var _temp_1:* = view.actionButton;
            var _loc1_:String = "tutorial.done";
            _temp_1.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         }
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.actionButton.localToGlobal(new Point()),param1.additionalInfo,view.actionButton));
      }
      
      private function onBattleReportUpdated(param1:ModelUpdateEvent) : void
      {
         var _loc3_:AttackLog = null;
         for each(var _loc2_ in userInfo.attackLogs)
         {
            if(_loc2_.id == view.attackLogId)
            {
               _loc3_ = _loc2_;
               break;
            }
         }
         battleReportUpdated(userInfo.battleReports[view.attackLogId],_loc3_);
      }
      
      private function battleReportUpdated(param1:BattleReport, param2:AttackLog) : void
      {
         view.battleReportUpdated(param1,param2,facebookApiManager.getUserNameByProfile(param2.attacker,!param2.attacker.isNpc),facebookApiManager.getUserNameByProfile(param2.defender,!param2.defender.isNpc),userInfo.profile.gameId == param2.attacker.gameId);
      }
      
      private function onBackButtonClicked(param1:Event) : void
      {
         if(userInfo.mandatoryTutorialCompleted)
         {
            dispatch(new MobileFacebookConnectionEvent("uploadScreenshot",view.generateCaps()));
         }
         closeWindow();
      }
      
      public function onInfoButtonClicked() : void
      {
         if(!view.reportDetailView)
         {
            view.reportDetailView = new MobileBattleReportDetailView();
            view.addChildAt(view.reportDetailView,view.getChildIndex(view.infoButton) - 1);
            view.reportDetailView.visible = !view.isReportGeneralViewVisible;
            view.reportDetailView.battleReportUpdated(view.battleReport,view.attackStartInMillis,domainInfo);
            view.drawLayout();
         }
         view.isReportGeneralViewVisible = MobileWomUIComponentFactory.addFlipTween(view.reportGeneralView,view.reportDetailView,view.isReportGeneralViewVisible,view.toggleViews);
      }
   }
}

