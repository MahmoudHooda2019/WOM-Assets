package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.Profile;
   import wom.model.game.friend.request.InviteFromInboxRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class InviteFromInboxRequestView extends BaseRequestView
   {
      
      private var _request:InviteFromInboxRequestInfo;
      
      private var _inventoryItemAsset:DisplayObject;
      
      public function InviteFromInboxRequestView(param1:RequestInfo)
      {
         _request = param1 as InviteFromInboxRequestInfo;
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(_request);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         var _loc1_:Profile = null;
         var _loc3_:int = 0;
         super.initLayout();
         _inventoryItemAsset = assetRepository.getDisplayObject(_request.partDIO.visual + "52");
         addChild(_inventoryItemAsset);
         var _temp_2:* = _titleTextField;
         var _loc4_:String = "ui.windows.inbox.requesttype." + _request.type + ".title";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         var _loc2_:Array = [];
         _loc3_ = 1;
         while(_loc3_ < _request.nonPlayingFriends.length)
         {
            _loc1_ = _request.nonPlayingFriends[_loc3_];
            otherFriendProfiles[_loc1_.platformId] = _loc1_;
            _loc2_.push(_loc1_.platformId);
            super.loadImage(_loc1_);
            _loc3_++;
         }
         var _temp_4:* = _otherFriendNamesTextField;
         var _temp_3:* = "ui.windows.inbox.requesttype." + _request.type + ".otherfriends";
         var _loc5_:String = _loc2_.join(", ");
         var _loc6_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         var _temp_5:* = _actionButton;
         var _loc7_:String = "ui.windows.inbox.request.send";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc7_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         _otherFriendNamesTextField.visible = true;
         AlignmentUtil.alignAccordingToPositionOf(_inventoryItemAsset,background,61,11);
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,110,13);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         AlignmentUtil.alignBelowOf(_otherFriendNamesTextField,_titleTextField,10);
      }
      
      public function updateOtherFriendNames() : void
      {
         var _loc1_:Object = null;
         var _loc3_:Array = [];
         for(var _loc2_ in otherFriendProfiles)
         {
            _loc1_ = otherFriendProfiles[_loc2_];
            _loc3_.push(_loc1_ is String ? _loc1_ : _loc2_);
         }
         var _temp_2:* = _otherFriendNamesTextField;
         var _temp_1:* = "ui.windows.inbox.requesttype." + _request.type + ".otherfriends";
         var _loc6_:String = _loc3_.join(", ");
         var _loc7_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_);
         drawLayout();
      }
      
      public function get inventoryItemAsset() : DisplayObject
      {
         return _inventoryItemAsset;
      }
      
      public function get request() : InviteFromInboxRequestInfo
      {
         return _request;
      }
   }
}

