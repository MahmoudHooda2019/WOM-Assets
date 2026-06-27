package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.game.friend.request.RequestInfo;
   import wom.model.game.friend.request.RewardRequestInfo;
   
   public class RewardRequestView extends BaseRequestView
   {
      
      private var _itemAsset:DisplayObject;
      
      public function RewardRequestView(param1:RequestInfo)
      {
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(param1);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _loc1_:RewardRequestInfo = _requests[0] as RewardRequestInfo;
         _itemAsset = assetRepository.getDisplayObject(_loc1_.subtype == 1 ? "GoldDouble" : "RP41");
         addChild(_itemAsset);
         updateTitleTextField();
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(_itemAsset,background,61,11);
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,118,13);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         AlignmentUtil.alignBelowOf(_otherFriendNamesTextField,_titleTextField,10);
         super.drawLayout();
      }
      
      public function get itemAsset() : DisplayObject
      {
         return _itemAsset;
      }
      
      private function updateTitleTextField(param1:String = "NPC_5") : void
      {
         var _loc2_:RewardRequestInfo = _requests[0] as RewardRequestInfo;
         var _temp_4:* = _titleTextField;
         var _temp_3:* = "ui.windows.inbox.requesttype." + _loc2_.type + ".title";
         var _temp_2:* = param1;
         var _temp_1:* = NumberUtil.numberFormat(_loc2_.amount,0);
         var _loc3_:String = "ui.windows.inbox.requesttype." + _loc2_.type + ".type." + _loc2_.subtype + ".name";
         var _loc4_:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _loc5_:String = _temp_1;
         var _loc6_:String = _temp_2;
         var _loc7_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText3(_loc7_,_loc6_,_loc5_,_loc4_);
      }
      
      override public function updateFriendNameTextField(param1:String) : void
      {
         updateTitleTextField(param1);
         super.updateFriendNameTextField(param1);
      }
   }
}

