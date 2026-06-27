package wom.view.mediator.screen.windows.recycle
{
   import starling.events.Event;
   import wom.controller.event.OutgoingMessageEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.building.DecorationInfo;
   import wom.model.message.request.RecycleBuildingRequest;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.recycle.MobileRecycleDecorationWindow;
   
   public class MobileRecycleDecorationWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileRecycleDecorationWindow;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      public function MobileRecycleDecorationWindowMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         for each(var _loc1_ in city.decorations)
         {
            if(_loc1_.instanceId == view.instanceId)
            {
               view.decorationInfo = _loc1_;
               view.decorationDIO = domainInfo.getDecoration(_loc1_.decorationTypeId);
               break;
            }
         }
         super.onRegister();
         eventMap.mapStarlingListener(view.recycleButton,"triggered",onRecycleButtonClicked,Event);
      }
      
      private function onRecycleButtonClicked(param1:Event) : void
      {
         closeWindow();
         dispatch(new OutgoingMessageEvent("outgoingMessage",new RecycleBuildingRequest(view.instanceId)));
      }
   }
}

