package wom.view.mediator.screen.windows.friends.mobile
{
   import feathers.data.ListCollection;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.NumberUtil;
   import starling.events.Event;
   import wom.controller.command.util.DictionaryUtil;
   import wom.controller.event.ModelUpdateEvent;
   import wom.controller.event.mobile.MobileExternalInterfaceEvent;
   import wom.controller.event.mobile.MobileFacebookConnectionEvent;
   import wom.controller.event.tutorial.TutorialReferencePositionEvent;
   import wom.controller.event.tutorial.TutorialTriggerEvent;
   import wom.controller.event.ui.MobileUINotificationEvent;
   import wom.model.configuration.WomDocumentConfiguration;
   import wom.model.game.UserInfo;
   import wom.model.game.friend.FriendInfo;
   import wom.model.game.tutorial.TutorialInfo;
   import wom.model.game.tutorial.TutorialState;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.mediator.util.MobileGenericWindowMediator;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsItemRenderer;
   import wom.view.screen.windows.friends.mobile.MobileSelectFriendsWindow;
   import wom.view.util.FriendUtil;
   import wom.view.util.SearchTextInputUtil;
   
   public class MobileSelectFriendsWindowMediator extends MobileGenericWindowMediator
   {
      
      [Inject]
      public var view:MobileSelectFriendsWindow;
      
      [Inject]
      public var documentConfiguration:WomDocumentConfiguration;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function MobileSelectFriendsWindowMediator()
      {
         super();
      }
      
      private static function getUpdatedFriends(param1:Vector.<FriendInfo>, param2:Dictionary) : Vector.<FriendInfo>
      {
         var _loc3_:Vector.<FriendInfo> = new Vector.<FriendInfo>();
         for each(var _loc4_ in param1)
         {
            if(!(_loc4_.profile.toString() in param2))
            {
               _loc3_.push(_loc4_);
            }
         }
         return _loc3_.sort(FriendUtil.friendsCompare);
      }
      
      override public function onRegister() : void
      {
         super.onRegister();
         addContextListener("getMandatoryActionButtonPosition",onMandatoryActionButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("getSecondaryActionButtonPosition",onSecondaryActionButtonPositionRequested,TutorialReferencePositionEvent);
         addContextListener("invitableFriendsUpdated",onInvitableFriendsUpdated,ModelUpdateEvent);
         eventMap.mapStarlingListener(view.friendsList,"rendererAdd",onRendererAdded,Event);
         eventMap.mapStarlingListener(view.friendsList,"change",onFriendsListChanged,Event);
         eventMap.mapStarlingListener(view.selectAllButton,"triggered",onSelectAllButtonClicked,Event);
         eventMap.mapStarlingListener(view.sendButton,"triggered",onSendButtonClicked,Event);
         eventMap.mapStarlingListener(view.searchTextInput,"change",onSearchTextInputChanged,Event);
         if(view.requestType == 4)
         {
            if(documentConfiguration.invitableFriends.length <= 0)
            {
               dispatch(new MobileExternalInterfaceEvent("retrieveInvitableFriends"));
            }
            else
            {
               updateInvitableFriends();
            }
         }
         else
         {
            updateFriends();
         }
      }
      
      private function onMandatoryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.sendButton.localToGlobal(new Point()),param1.additionalInfo,view.sendButton));
      }
      
      private function onSecondaryActionButtonPositionRequested(param1:TutorialReferencePositionEvent) : void
      {
         dispatch(new TutorialReferencePositionEvent("positionReady",param1.objectToBeAligned,view.selectAllButton.localToGlobal(new Point()),param1.additionalInfo,view.selectAllButton));
      }
      
      private function onRendererAdded(param1:Event, param2:MobileSelectFriendsItemRenderer) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         if(param2.friendInfo)
         {
            _loc3_ = param2.friendInfo.name;
            _loc4_ = facebookAPIManager.getUserNameByProfile(param2.friendInfo.profile);
            if(_loc4_ != _loc3_)
            {
               param2.friendInfo.name = _loc4_;
            }
            param2.updateUserNameTextField(_loc4_);
         }
      }
      
      private function onFriendsListChanged(param1:Event) : void
      {
         if(view.friendsList.selectedIndices.length > 50)
         {
            while(view.friendsList.selectedIndices.length > 50)
            {
               view.friendsList.selectedIndices.pop();
            }
            var _temp_2:* = §§findproperty(MobileUINotificationEvent);
            var _temp_1:* = "mobileUINotificationEventShow";
            var _loc2_:String = "m.ui.windows.friends.select.maxselectable";
            dispatch(new MobileUINotificationEvent(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc2_)));
         }
         view.updateSelectedAmountTextField();
      }
      
      private function updateFriends() : void
      {
         var _loc1_:Vector.<FriendInfo> = documentConfiguration.friends;
         var _loc2_:Dictionary = FriendUtil.getBlockedFriendsMap(view.requestType,documentConfiguration,userInfo);
         view.update(getUpdatedFriends(_loc1_,_loc2_));
      }
      
      private function updateInvitableFriends() : void
      {
         var _loc1_:Vector.<FriendInfo> = documentConfiguration.invitableFriends;
         var _loc2_:Dictionary = FriendUtil.getBlockedFriendsMap(view.requestType,documentConfiguration,userInfo);
         view.update(getUpdatedFriends(_loc1_,_loc2_));
      }
      
      private function onInvitableFriendsUpdated(param1:ModelUpdateEvent) : void
      {
         if(view.requestType == 4)
         {
            updateInvitableFriends();
         }
      }
      
      private function onSendButtonClicked(param1:Event) : void
      {
         if(view.friendsList.selectedIndices.length <= 0)
         {
            dispatch(new MobileUINotificationEvent("mobileUINotificationEventShow","SELECT FRIENDS FIRST"));
            return;
         }
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc2_ in view.friendsList.selectedItems)
         {
            if(_loc2_.profile.platformId != null)
            {
               _loc3_[_loc2_.profile.platformId] = _loc2_.profile;
            }
         }
         if(DictionaryUtil.lengthOf(_loc3_) <= 0)
         {
            dispatch(new MobileUINotificationEvent("mobileUINotificationEventShow","SELECT FRIENDS FIRST"));
            return;
         }
         dispatch(new MobileFacebookConnectionEvent("sendFacebookRequest",{
            "requestType":view.requestType,
            "toDict":_loc3_,
            "subType":view.subType
         }));
         closeWindow();
      }
      
      private function onSelectAllButtonClicked(param1:Event) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = undefined;
         var _loc3_:int = 0;
         var _loc2_:int = view.friendsList.dataProvider.length;
         var _loc4_:Vector.<int> = new Vector.<int>();
         if(_loc2_ > 50)
         {
            _loc5_ = new Vector.<int>();
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc5_.push(_loc6_);
               _loc6_++;
            }
            _loc6_ = 0;
            while(_loc6_ < 50)
            {
               _loc3_ = NumberUtil.randomIntRange(0,_loc5_.length - 1);
               _loc4_.push(_loc5_[_loc3_]);
               _loc5_.splice(_loc3_,1);
               _loc6_++;
            }
         }
         else
         {
            _loc6_ = 0;
            while(_loc6_ < _loc2_)
            {
               _loc4_.push(_loc6_);
               _loc6_++;
            }
         }
         view.friendsList.selectedIndices = _loc4_;
         checkTutorial();
      }
      
      private function checkTutorial() : void
      {
         var _loc1_:TutorialInfo = null;
         var _loc2_:TutorialState = null;
         if(userInfo.tutorialsInfo.enabled)
         {
            _loc1_ = "flg" in userInfo.tutorialsInfo.tutorials ? userInfo.tutorialsInfo.tutorials["flg"] : null;
            if(_loc1_ != null && !_loc1_.isCompleted)
            {
               _loc2_ = _loc1_.states[_loc1_.states[0].additionalInfo["stateIndexSelectFriends"]];
               _loc2_.additionalInfo["progress"] = view.friendsList.selectedIndices.length;
               dispatch(new TutorialTriggerEvent("defaultActionTriggered"));
            }
         }
      }
      
      private function searchTextInputChanged() : void
      {
         var _loc2_:ListCollection = null;
         var _loc5_:Boolean = false;
         var _loc4_:* = null;
         var _loc1_:int = 0;
         var _loc3_:Array = SearchTextInputUtil.populateKeywords(view.searchTextInput.text);
         if(_loc3_.length > 0)
         {
            _loc2_ = view.friendsList.dataProvider;
            _loc1_ = 0;
            while(_loc2_.length > _loc1_)
            {
               _loc5_ = true;
               for each(_loc4_ in _loc3_)
               {
                  if((_loc2_.getItemAt(_loc1_) as FriendInfo).searchAttr.indexOf(_loc4_) < 0)
                  {
                     view.hiddenFriends.addItem(_loc2_.removeItemAt(_loc1_));
                     _loc5_ = false;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc1_++;
               }
            }
            _loc1_ = 0;
            while(view.hiddenFriends.length > _loc1_)
            {
               _loc5_ = true;
               for each(_loc4_ in _loc3_)
               {
                  if((view.hiddenFriends.getItemAt(_loc1_) as FriendInfo).searchAttr.indexOf(_loc4_) < 0)
                  {
                     _loc1_++;
                     _loc5_ = false;
                     break;
                  }
               }
               if(_loc5_)
               {
                  _loc2_.addItem(view.hiddenFriends.removeItemAt(_loc1_));
               }
            }
         }
         else
         {
            while(view.hiddenFriends.length > 0)
            {
               _loc2_.addItem(view.hiddenFriends.removeItemAt(0));
            }
         }
      }
      
      private function onSearchTextInputChanged(param1:Event) : void
      {
         searchTextInputChanged();
      }
   }
}

