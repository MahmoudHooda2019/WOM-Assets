package wom.controller.command.user
{
   import peak.i18n.PText;
   import wom.controller.PCommand;
   import wom.controller.event.ExternalInterfaceEvent;
   import wom.controller.event.ui.UserNotificationEvent;
   import wom.model.domain.DomainInfo;
   import wom.model.domain.domaininfoobject.PartTypeDIO;
   import wom.model.game.UserInfo;
   import wom.model.game.inventory.ResourceQuantityType;
   import wom.model.game.viral.UserNotification;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.util.FriendUtil;
   
   public class RetrieveSendRequestResponseCommand extends PCommand
   {
      
      [Inject]
      public var event:ExternalInterfaceEvent;
      
      [Inject]
      public var domainInfo:DomainInfo;
      
      [Inject]
      public var userInfo:UserInfo;
      
      [Inject]
      public var facebookAPIManager:FacebookAPIManager;
      
      public function RetrieveSendRequestResponseCommand()
      {
         super();
      }
      
      override public function execute() : void
      {
         var _loc5_:int = 0;
         var _loc1_:String = null;
         var _loc7_:int = 0;
         var _loc4_:PartTypeDIO = null;
         var _loc3_:int = 0;
         var _loc2_:String = null;
         var _loc6_:Object = event.response;
         if(_loc6_ != null && "type" in _loc6_ && "subtype" in _loc6_ && "to" in _loc6_ && _loc6_.to && _loc6_.to.length > 0)
         {
            switch((_loc5_ = int(_loc6_.type)) - 1)
            {
               case 0:
               case 10:
                  _loc1_ = "IconRequestFriends";
                  if(_loc6_.to.length == 1)
                  {
                     var _temp_14:* = §§findproperty(UserNotificationEvent);
                     var _temp_13:* = "userNotificationEventShow";
                     var _temp_12:* = §§findproperty(UserNotification);
                     var _temp_11:* = 1;
                     var _temp_10:* = 0;
                     var _temp_9:* = _loc1_;
                     var _temp_8:* = "ui.request.success.single";
                     var _loc8_:String = getFriendName(_loc6_);
                     var _loc9_:String = _temp_8;
                     dispatch(new UserNotificationEvent(_temp_13,new UserNotification(_temp_11,_temp_10,_temp_9,peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_))));
                  }
                  else
                  {
                     var _temp_22:* = §§findproperty(UserNotificationEvent);
                     var _temp_21:* = "userNotificationEventShow";
                     var _temp_20:* = §§findproperty(UserNotification);
                     var _temp_19:* = 1;
                     var _temp_18:* = 0;
                     var _temp_17:* = _loc1_;
                     var _temp_16:* = "ui.request.success.plural";
                     var _loc10_:* = _loc6_.to.length;
                     var _loc11_:String = _temp_16;
                     dispatch(new UserNotificationEvent(_temp_21,new UserNotification(_temp_19,_temp_18,_temp_17,peak.i18n.PText.INSTANCE.getText1(_loc11_,_loc10_))));
                  }
                  break;
               case 1:
                  _loc7_ = int(_loc6_.subtype);
                  _loc4_ = domainInfo.getPart(_loc7_);
                  if(_loc4_ != null)
                  {
                     _loc1_ = _loc4_.visual;
                     if(_loc6_.to.length == 1)
                     {
                        var _temp_31:* = §§findproperty(UserNotificationEvent);
                        var _temp_30:* = "userNotificationEventShow";
                        var _temp_29:* = §§findproperty(UserNotification);
                        var _temp_28:* = 2;
                        var _temp_27:* = 0;
                        var _temp_26:* = _loc1_;
                        var _temp_25:* = "ui.request.success.single";
                        var _loc12_:String = getFriendName(_loc6_);
                        var _loc13_:String = _temp_25;
                        dispatch(new UserNotificationEvent(_temp_30,new UserNotification(_temp_28,_temp_27,_temp_26,peak.i18n.PText.INSTANCE.getText1(_loc13_,_loc12_))));
                     }
                     else
                     {
                        var _temp_39:* = §§findproperty(UserNotificationEvent);
                        var _temp_38:* = "userNotificationEventShow";
                        var _temp_37:* = §§findproperty(UserNotification);
                        var _temp_36:* = 2;
                        var _temp_35:* = 0;
                        var _temp_34:* = _loc1_;
                        var _temp_33:* = "ui.request.success.plural";
                        var _loc14_:* = _loc6_.to.length;
                        var _loc15_:String = _temp_33;
                        dispatch(new UserNotificationEvent(_temp_38,new UserNotification(_temp_36,_temp_35,_temp_34,peak.i18n.PText.INSTANCE.getText1(_loc15_,_loc14_))));
                     }
                  }
                  break;
               case 2:
                  if("extra" in _loc6_)
                  {
                     _loc7_ = int(String(_loc6_.subtype).substr(0,3));
                     _loc4_ = domainInfo.getPart(_loc7_);
                     if(_loc4_ != null)
                     {
                        _loc3_ = int(_loc6_.extra);
                        var _temp_42:*;
                        var _loc16_:String;
                        var _loc17_:*;
                        var _loc18_:String;
                        var _loc19_:String;
                        _loc2_ = _loc3_ > 0 ? (_temp_42 = "domain.parts." + _loc7_ + ".name2",_loc16_ = ResourceQuantityType.determineResourceQuantityType(_loc3_).i18nKey,_loc17_ = peak.i18n.PText.INSTANCE.getText0(_loc16_),_loc18_ = _temp_42,peak.i18n.PText.INSTANCE.getText1(_loc18_,_loc17_)) : (_loc19_ = "domain.parts." + _loc7_ + ".name2",peak.i18n.PText.INSTANCE.getText0(_loc19_));
                        _loc1_ = _loc4_.visual;
                        if(_loc6_.to.length == 1)
                        {
                           var _temp_50:* = §§findproperty(UserNotificationEvent);
                           var _temp_49:* = "userNotificationEventShow";
                           var _temp_48:* = §§findproperty(UserNotification);
                           var _temp_47:* = 6;
                           var _temp_46:* = 0;
                           var _temp_45:* = _loc1_;
                           var _temp_44:* = "ui.request.gift.success.single";
                           var _temp_43:* = _loc2_;
                           var _loc20_:String = getFriendName(_loc6_);
                           var _loc21_:String = _temp_43;
                           var _loc22_:String = _temp_44;
                           dispatch(new UserNotificationEvent(_temp_49,new UserNotification(_temp_47,_temp_46,_temp_45,peak.i18n.PText.INSTANCE.getText2(_loc22_,_loc21_,_loc20_))));
                           break;
                        }
                        var _temp_59:* = §§findproperty(UserNotificationEvent);
                        var _temp_58:* = "userNotificationEventShow";
                        var _temp_57:* = §§findproperty(UserNotification);
                        var _temp_56:* = 6;
                        var _temp_55:* = 0;
                        var _temp_54:* = _loc1_;
                        var _temp_53:* = "ui.request.gift.success.plural";
                        var _temp_52:* = _loc2_;
                        var _loc23_:* = _loc6_.to.length;
                        var _loc24_:String = _temp_52;
                        var _loc25_:String = _temp_53;
                        dispatch(new UserNotificationEvent(_temp_58,new UserNotification(_temp_56,_temp_55,_temp_54,peak.i18n.PText.INSTANCE.getText2(_loc25_,_loc24_,_loc23_))));
                     }
                  }
            }
         }
      }
      
      private function getFriendName(param1:Object) : String
      {
         return facebookAPIManager.getUserNameByProfile(FriendUtil.getProfile(param1.to[0]),false);
      }
   }
}

