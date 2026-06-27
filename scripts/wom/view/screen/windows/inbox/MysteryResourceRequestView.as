package wom.view.screen.windows.inbox
{
   import flash.display.DisplayObject;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.friend.request.MysteryResourceRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class MysteryResourceRequestView extends BaseRequestView
   {
      
      private var _mysteryResourceRequest:MysteryResourceRequestInfo;
      
      private var _inventoryItemAsset:DisplayObject;
      
      public function MysteryResourceRequestView(param1:RequestInfo)
      {
         _mysteryResourceRequest = param1 as MysteryResourceRequestInfo;
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(_mysteryResourceRequest);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _inventoryItemAsset = assetRepository.getDisplayObject(_mysteryResourceRequest.partDIO.visual + "52");
         addChild(_inventoryItemAsset);
         var _temp_4:* = _titleTextField;
         var _temp_3:* = "ui.windows.inbox.requesttype." + _mysteryResourceRequest.type + ".title";
         var _temp_2:* = "domain.parts." + _mysteryResourceRequest.partDIO.id + ".name2";
         var _loc1_:String = _mysteryResourceRequest.bonusQuantity.i18nKey;
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_2;
         var _loc4_:* = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         var _loc5_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         hideAllAvatars();
         _otherFriendNamesTextField.visible = false;
         var _temp_2:* = friendNameTextField;
         var _temp_1:* = "domain.parts." + _mysteryResourceRequest.partDIO.id + ".name2";
         var _loc1_:String = _mysteryResourceRequest.bonusQuantity.i18nKey;
         var _loc2_:* = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _loc3_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_);
         AlignmentUtil.alignAccordingToPositionOf(_inventoryItemAsset,background,6,6);
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,63,7);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         super.drawLayout();
      }
      
      override public function updateFriendNameTextField(param1:String) : void
      {
      }
   }
}

