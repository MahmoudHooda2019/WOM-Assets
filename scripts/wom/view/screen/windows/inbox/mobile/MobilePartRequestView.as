package wom.view.screen.windows.inbox.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.friend.request.PartRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class MobilePartRequestView extends MobileBaseRequestView
   {
      
      private var _inventoryItemAsset:DisplayObject;
      
      public function MobilePartRequestView(param1:Vector.<RequestInfo>)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         var _loc2_:int = 0;
         super.initLayout();
         _inventoryItemAsset = assetRepository.getDisplayObject((_requests[0] as PartRequestInfo).partDIO.visual);
         _inventoryItemAsset.scaleX = _inventoryItemAsset.scaleY = 0.3;
         addChild(_inventoryItemAsset);
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".title." + _requests[0].state;
         var _loc4_:String = "domain.parts." + (_requests[0] as PartRequestInfo).partDIO.id + ".name2";
         var _loc5_:* = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc6_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ < _requests.length)
         {
            otherFriendProfiles[_requests[_loc2_].friendProfile.gameId] = _requests[_loc2_].friendProfile;
            _loc1_.push(_requests[_loc2_].friendProfile.gameId);
            super.loadImage(_requests[_loc2_].friendProfile);
            _loc2_++;
         }
         var _temp_5:* = _otherFriendNamesTextField;
         var _temp_4:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".otherfriends";
         var _loc7_:String = _loc1_.join(", ");
         var _loc8_:String = _temp_4;
         _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc8_,_loc7_);
         var _loc9_:String;
         var _loc10_:String;
         _actionButton.label = _requests[0].state == "sent" ? (_loc9_ = "ui.windows.inbox.request.send",peak.i18n.PText.INSTANCE.getText0(_loc9_)) : (_loc10_ = "ui.windows.inbox.request.accept",peak.i18n.PText.INSTANCE.getText0(_loc10_));
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_inventoryItemAsset,background,128,30);
         MobileAlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,200,30);
         MobileAlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         MobileAlignmentUtil.alignBelowOf(_otherFriendNamesTextField,_titleTextField,10);
         super.drawLayout();
      }
      
      public function updateOtherFriendNames() : void
      {
         var _loc2_:Object = null;
         var _loc3_:Array = [];
         for(var _loc1_ in otherFriendProfiles)
         {
            _loc2_ = otherFriendProfiles[_loc1_];
            _loc3_.push(_loc2_ is String ? _loc2_ : _loc1_);
         }
         var _temp_2:* = _otherFriendNamesTextField;
         var _temp_1:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".otherfriends";
         var _loc6_:String = _loc3_.join(", ");
         var _loc7_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         drawLayout();
      }
      
      public function get inventoryItemAsset() : DisplayObject
      {
         return _inventoryItemAsset;
      }
   }
}

