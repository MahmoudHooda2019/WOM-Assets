package wom.view.mediator.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.message.request.FreezeBeastRequest;
   import wom.view.ui.mainframe.city.mobile.MCOVBeastKeeperView;
   
   public class MCOVBeastKeeperViewMediator extends MCOVEnterViewMediator
   {
      
      [Inject]
      public var beastKeeperView:MCOVBeastKeeperView;
      
      public function MCOVBeastKeeperViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         beastKeeperView.beastExists = city.beast != null;
         super.onRegister();
         eventMap.mapStarlingListener(beastKeeperView.caveBeastButton,"triggered",onCaveBeastButtonClicked);
      }
      
      private function onCaveBeastButtonClicked(param1:Event) : void
      {
         if(!city.beast)
         {
            return;
         }
         var _loc3_:BeastTypeDIO = domainInfo.getBeast(city.beast.typeId);
         var _loc2_:int = int(city.beast.bonusStage > 0 ? _loc3_.healthPointsPerStage[city.beast.bonusStage - 1] : _loc3_.healthPointsPerLevel[city.beast.level - 1]);
         if(city.beast.healthPoints < _loc2_)
         {
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc4_:String = "ui.popups.actionnotpossible.type.9";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc4_)));
            return;
         }
         cancelSelection();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new FreezeBeastRequest()));
      }
   }
}

