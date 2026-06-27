package wom.view.screen.windows.inbox
{
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.model.game.friend.request.PartRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class PartRequestView extends BaseRequestView
   {
      
      private var _inventoryItemAsset:AssetDisplayObject;
      
      public function PartRequestView(param1:Vector.<RequestInfo>)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         var _loc2_:int = 0;
         super.initLayout();
         _inventoryItemAsset = assetRepository.getDisplayObject((_requests[0] as PartRequestInfo).partDIO.visual + "52");
         addChild(_inventoryItemAsset);
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype." + _requests[0].type + ".title." + _requests[0].state;
         var _loc3_:String = "domain.parts." + (_requests[0] as PartRequestInfo).partDIO.id + ".name2";
         var _loc4_:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc5_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
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
         var _loc6_:String = _loc1_.join(", ");
         var _loc7_:String = _temp_4;
         _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         var _loc8_:String;
         var _loc9_:String;
         _actionButton.label = _requests[0].state == "sent" ? (_loc8_ = "ui.windows.inbox.request.send",peak.i18n.PText.INSTANCE.getText0(_loc8_)) : (_loc9_ = "ui.windows.inbox.request.accept",peak.i18n.PText.INSTANCE.getText0(_loc9_));
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_inventoryItemAsset,background,61,11);
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,118,13);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         AlignmentUtil.alignBelowOf(_otherFriendNamesTextField,_titleTextField,10);
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
      
      public function get inventoryItemAsset() : AssetDisplayObject
      {
         return _inventoryItemAsset;
      }
   }
}

