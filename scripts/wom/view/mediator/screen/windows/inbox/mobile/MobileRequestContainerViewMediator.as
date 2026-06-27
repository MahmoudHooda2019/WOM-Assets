package wom.view.mediator.screen.windows.inbox.mobile
{
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import starling.events.Event;
   import wom.controller.event.friend.MobileRemoveRequestViewEvent;
   import wom.controller.event.inbox.InboxEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.model.game.friend.InboxInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.view.screen.windows.inbox.mobile.MobileBaseRequestView;
   import wom.view.screen.windows.inbox.mobile.MobileRequestContainerView;
   
   public class MobileRequestContainerViewMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileRequestContainerView;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var inboxInfo:InboxInfo;
      
      public function MobileRequestContainerViewMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         view.update(inboxInfo.requests[view.requestType],inboxInfo.counts[view.requestType]);
         addContextListener("removeRequestView",onRemoveRequestView,MobileRemoveRequestViewEvent);
         eventMap.mapStarlingListener(view.seeMoreRequestButton,"triggered",onSeeMoreRequestButtonClicked,Event);
      }
      
      private function onSeeMoreRequestButtonClicked(param1:Event) : void
      {
         var _loc3_:Number = NaN;
         var _loc2_:* = undefined;
         if(view.requestViews.length > 0)
         {
            _loc3_ = NaN;
            for each(var _loc5_ in view.requestViews)
            {
               _loc2_ = _loc5_.requests;
               if(_loc2_ != null && _loc2_.length > 0)
               {
                  for each(var _loc4_ in _loc2_)
                  {
                     if(!isNaN(_loc4_.id) && (isNaN(_loc3_) || _loc4_.id > _loc3_))
                     {
                        _loc3_ = _loc4_.id;
                     }
                  }
               }
            }
            if(!isNaN(_loc3_))
            {
               dispatch(new MobileExternalInterfaceEvent("retrieveRequests",{
                  "type":view.requestType,
                  "limit":20,
                  "offset":_loc3_
               }));
            }
         }
         else
         {
            dispatch(new MobileExternalInterfaceEvent("retrieveRequests",{
               "type":view.requestType,
               "limit":20
            }));
         }
      }
      
      private function onRemoveRequestView(param1:MobileRemoveRequestViewEvent) : void
      {
         var _loc3_:MobileBaseRequestView = null;
         var _loc4_:int = 0;
         if(view.contains(param1.view))
         {
            _loc3_ = param1.view;
            _loc4_ = int(_loc3_.requests.length);
            for each(var _loc2_ in _loc3_.requests)
            {
               removeRequest(_loc2_);
            }
            view.removeRequestView(_loc3_,_loc4_);
            dispatch(new InboxEvent("requestsLayoutUpdated"));
         }
      }
      
      private function removeRequest(param1:RequestInfo) : void
      {
         var _loc2_:* = undefined;
         if(view.requestType in inboxInfo.requests)
         {
            _loc2_ = inboxInfo.requests[view.requestType];
            for each(var _loc3_ in _loc2_)
            {
               for each(var _loc4_ in _loc3_)
               {
                  if(_loc4_.id == param1.id)
                  {
                     _loc3_.splice(_loc3_.indexOf(param1),1);
                     if(view.requestType in inboxInfo.counts)
                     {
                        inboxInfo.counts[view.requestType]--;
                     }
                     else
                     {
                        inboxInfo.counts[view.requestType] = 0;
                     }
                     break;
                  }
               }
               if(_loc3_.length <= 0)
               {
                  _loc2_.splice(_loc2_.indexOf(_loc3_),1);
                  break;
               }
            }
         }
      }
   }
}

