package wom.view.screen.windows.inbox.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.game.friend.request.GiftRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.game.inventory.InventoryItemCategory;
   import wom.model.game.inventory.ResourceQuantityType;
   
   public class MobileGiftRequestView extends MobileBaseRequestView
   {
      
      private var _inventoryItemAsset:DisplayObject;
      
      public function MobileGiftRequestView(param1:Vector.<RequestInfo>)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         var _loc2_:int = 0;
         super.initLayout();
         _inventoryItemAsset = assetRepository.getDisplayObject((_requests[0] as GiftRequestInfo).partDIO.visual);
         _inventoryItemAsset.scaleX = _inventoryItemAsset.scaleY = 0.3;
         addChild(_inventoryItemAsset);
         var _loc1_:Array = [];
         _loc2_ = 1;
         while(_loc2_ < _requests.length)
         {
            otherFriendProfiles[_requests[_loc2_].friendProfile.gameId] = _requests[_loc2_].friendProfile;
            _loc1_.push(_requests[_loc2_].friendProfile.gameId);
            super.loadImage(_requests[_loc2_].friendProfile);
            _loc2_++;
         }
         var _temp_3:* = _otherFriendNamesTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".otherfriends";
         var _loc4_:String = _loc1_.join(", ");
         var _loc5_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         var _loc6_:String;
         var _loc7_:String;
         _actionButton.label = (_requests[0] as GiftRequestInfo).thankYou ? (_loc6_ = "ui.windows.inbox.request.accept",peak.i18n.PText.INSTANCE.getText0(_loc6_)) : (_loc7_ = "ui.windows.inbox.request.acceptandsend",peak.i18n.PText.INSTANCE.getText0(_loc7_));
         drawLayout();
      }
      
      public function updateTextFields() : void
      {
         var _loc1_:String = null;
         if((_requests[0] as GiftRequestInfo).thankYou)
         {
            var _temp_1:* = _titleTextField;
            var _loc2_:String = "ui.windows.inbox.requesttype." + _requests[0].type + ".titlethankyou";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         }
         else if(InventoryItemCategory.resourceInventoryItems.indexOf((_requests[0] as GiftRequestInfo).partDIO.id) > -1)
         {
            var _loc3_:String = ResourceQuantityType.determineResourceQuantityType((_requests[0] as GiftRequestInfo).resourceGiftBonusPercent).i18nKey;
            _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            var _temp_4:* = _titleTextField;
            var _temp_3:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".title";
            var _temp_2:* = "domain.parts." + (_requests[0] as GiftRequestInfo).partDIO.id + ".name2";
            var _loc4_:String = _loc1_;
            var _loc5_:String = _temp_2;
            var _loc6_:* = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
            var _loc7_:String = _temp_3;
            _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         }
         else
         {
            var _temp_6:* = _titleTextField;
            var _temp_5:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".title";
            var _loc8_:String = "domain.parts." + (_requests[0] as GiftRequestInfo).partDIO.id + ".name2";
            var _loc9_:* = peak.i18n.PText.INSTANCE.getText0(_loc8_);
            var _loc10_:String = _temp_5;
            _temp_6.text = peak.i18n.PText.INSTANCE.getText1(_loc10_,_loc9_);
         }
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

