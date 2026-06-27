package wom.view.mediator.ui.mainframe.city
{
   import feathers.events.FeathersEventType;
   import flash.events.TimerEvent;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   import wom.controller.command.util.SwearFilter;
   import wom.controller.event.GameTickEvent;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.chat.ChatClientEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.game.UserInfo;
   import wom.model.game.alliance.AllianceInfo;
   import wom.model.game.chat.ChatMessageType;
   import wom.model.message.request.SendAllianceChatMessageRequest;
   import wom.model.message.request.SendWorldChatMessageRequest;
   import wom.service.kontagent.WomKontagentApi;
   import wom.view.ui.mainframe.city.chat.MobileChatPanel;
   
   public class MobileChatPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileChatPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var allianceInfo:AllianceInfo;
      
      [Inject]
      public var kontagentApi:WomKontagentApi;
      
      [Inject]
      public var swearFilter:SwearFilter;
      
      public function MobileChatPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.panelBackground,"touch",onOpenBackgroundClicked,TouchEvent);
         eventMap.mapStarlingListener(view.expandButton,"touch",onUpIconClicked,TouchEvent);
         eventMap.mapStarlingListener(view.collapseButton,"touch",onDownIconClicked,TouchEvent);
         eventMap.mapStarlingListener(view.sendButton,"touch",onSendButtonClicked,TouchEvent);
         eventMap.mapStarlingListener(view.chatInput,"enter",onCommandEntered,FeathersEventType);
         eventMap.mapListener(view.banTimer,"timer",onBanTimerTick,TimerEvent);
         eventMap.mapStarlingListener(view.tabBar,"change",onTabChanged,Event);
         addContextListener("tick",onTick,GameTickEvent);
         addContextListener("userBanned",onUserBanned,ChatClientEvent);
         addContextListener("allianceSummaryUpdated",onAllianceSummaryUpdated,ModelUpdateEvent);
         updateWithAllianceInfo();
         closeChatPanel();
      }
      
      private function onAllianceSummaryUpdated(param1:ModelUpdateEvent) : void
      {
         updateWithAllianceInfo();
         if(allianceInfo.myAllianceSummary == null)
         {
            view.tabBar.selectedIndex = 0;
            view.activateWorldChatPanel();
         }
      }
      
      private function updateWithAllianceInfo() : void
      {
         view.updateWithAllianceInfo(allianceInfo.myAllianceSummary);
      }
      
      private function onUserBanned(param1:ChatClientEvent) : void
      {
         removeContextListener("tick",onTick,GameTickEvent);
         addContextListener("tick",onTick,GameTickEvent);
      }
      
      protected function onTabChanged(param1:Event) : void
      {
         switch(view.tabBar.selectedIndex)
         {
            case 0:
               onWorldTabClicked(param1);
               break;
            case 1:
               onAllianceTabClicked(param1);
         }
         view.setFocusOnChatInput();
      }
      
      private function onAllianceTabClicked(param1:Event) : void
      {
         if(allianceInfo.myAllianceSummary != null)
         {
            updateWithAllianceInfo();
            view.activateAllianceChatPanel();
         }
         else
         {
            var _temp_3:* = _eventDispatcher;
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "m.ui.mainframe.city.chat.alliancerequired";
            _temp_3.dispatchEvent(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
            view.tabBar.selectedIndex = 0;
            view.activateWorldChatPanel();
         }
      }
      
      private function onWorldTabClicked(param1:Event) : void
      {
         updateWithAllianceInfo();
         view.activateWorldChatPanel();
      }
      
      private function onTick(param1:GameTickEvent) : void
      {
         if(userInfo.chatBanDuration <= 0)
         {
            removeContextListener("tick",onTick,GameTickEvent);
         }
         view.updateServerBanField(userInfo.chatBanDuration);
      }
      
      private function onOpenBackgroundClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.panelBackground,"ended");
         if(_loc2_)
         {
            if(view.isOpen)
            {
               collapseView();
            }
            else
            {
               expandView();
            }
         }
      }
      
      private function onCommandEntered(param1:FeathersEventType) : void
      {
         sendChatMessage();
      }
      
      private function sendChatMessage() : void
      {
         if(!view.isOpen)
         {
            view.expand();
         }
         var _loc2_:String = view.chatInput.text;
         view.chatInput.text = "";
         if(_loc2_ == "")
         {
            return;
         }
         if(!view.checkFloodForMessage(_loc2_))
         {
            if(view.checkFilterForMessage(_loc2_,swearFilter))
            {
            }
         }
         var _loc1_:ChatMessageType = view.activePanel.chatMessageType;
         if(_loc1_ == ChatMessageType.WORLD)
         {
            dispatch(new OutgoingMessageEvent("outgoingChatMessage",new SendWorldChatMessageRequest(_loc2_)));
         }
         else if(_loc1_ == ChatMessageType.ALLIANCE)
         {
            dispatch(new OutgoingMessageEvent("outgoingChatMessage",new SendAllianceChatMessageRequest(_loc2_)));
         }
      }
      
      public function closeChatPanel() : void
      {
         collapseView();
      }
      
      private function collapseView() : void
      {
         view.collapse();
      }
      
      private function onBanTimerTick(param1:TimerEvent) : void
      {
         view.onBanTimerTick();
      }
      
      public function openChatPanel() : void
      {
         kontagentApi.trackUIEvent("chat");
         expandView();
      }
      
      private function expandView() : void
      {
         view.expand();
      }
      
      private function onSendButtonClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.sendButton,"ended");
         if(_loc2_)
         {
            sendChatMessage();
         }
      }
      
      private function onUpIconClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.expandButton,"ended");
         if(_loc2_)
         {
            openChatPanel();
         }
      }
      
      private function onDownIconClicked(param1:TouchEvent) : void
      {
         var _loc2_:Touch = param1.getTouch(view.collapseButton,"ended");
         if(_loc2_)
         {
            closeChatPanel();
         }
      }
   }
}

