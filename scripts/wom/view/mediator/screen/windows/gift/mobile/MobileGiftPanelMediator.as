package wom.view.mediator.screen.windows.gift.mobile
{
   import flash.utils.Dictionary;
   import org.robotlegs.core.IInjector;
   import org.robotlegs.mvcs.StarlingMediator;
   import peak.i18n.PText;
   import starling.events.Event;
   import wom.controller.event.friend.GetSelectFriendsWindowEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.ui.MobileCloseContainerOfDisplayObjectEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.game.CityStatusInfo;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.BlockedFriendInfo;
   import wom.model.game.inventory.InventoryItemDTO;
   import wom.view.screen.windows.gift.mobile.MobileGiftItemViewRenderer;
   import wom.view.screen.windows.gift.mobile.MobileGiftPanel;
   
   public class MobileGiftPanelMediator extends StarlingMediator
   {
      
      [Inject]
      public var view:MobileGiftPanel;
      
      [Inject]
      public var injector:IInjector;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var city:CityStatusInfo;
      
      public function MobileGiftPanelMediator()
      {
         super();
      }
      
      override public function onRegister() : void
      {
         injector.injectInto(view);
         eventMap.mapStarlingListener(view.giftItemViewsList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.giftItemViewsList,"rendererRemove",onRendererRemoved,Event);
         retrieveGifts();
      }
      
      private function onRendererAdded(param1:Event, param2:MobileGiftItemViewRenderer) : void
      {
         eventMap.mapStarlingListener(param2,"triggered",onRendererClicked,Event);
      }
      
      private function onRendererRemoved(param1:Event, param2:MobileGiftItemViewRenderer) : void
      {
         eventMap.unmapStarlingListener(param2,"triggered",onRendererClicked,Event);
      }
      
      private function onRendererClicked(param1:Event) : void
      {
         var _loc3_:* = undefined;
         var _loc5_:Dictionary = null;
         var _loc6_:MobileGiftItemViewRenderer = MobileGiftItemViewRenderer(param1.currentTarget);
         var _loc2_:InventoryItemDTO = InventoryItemDTO(_loc6_.data);
         if(view.friendProfile != null)
         {
            _loc3_ = userInfo.blockedFriendsMap[3];
            if(_loc3_ == null)
            {
               _loc3_ = new Vector.<BlockedFriendInfo>();
            }
            for each(var _loc4_ in _loc3_)
            {
               if(view.friendProfile.gameId != null && view.friendProfile.gameId == _loc4_.profile.gameId || view.friendProfile.platformId == _loc4_.profile.platformId)
               {
                  var _temp_9:* = §§findproperty(MobileUINotificationEvent);
                  var _temp_8:* = "mobileUINotificationEventShow";
                  var _loc9_:String = "ui.popups.actionnotpossible.type.87";
                  dispatch(new MobileUINotificationEvent(_temp_8,peak.i18n.PText.INSTANCE.getText0(_loc9_)));
                  return;
               }
            }
            _loc5_ = new Dictionary();
            _loc5_[view.friendProfile.platformId] = view.friendProfile;
            dispatch(new MobileFacebookConnectionEvent("sendFacebookRequest",{
               "requestType":3,
               "toDict":_loc5_,
               "subType":_loc2_.id
            }));
         }
         else
         {
            dispatch(new MobileCloseContainerOfDisplayObjectEvent("close",view));
            dispatch(new GetSelectFriendsWindowEvent("getSelectFriendsWindow",3,_loc2_.id));
         }
      }
      
      private function retrieveGifts() : void
      {
         view.update(InventoryItemDTO.retrieveGifts(domainInfo,userInfo,city));
      }
   }
}

