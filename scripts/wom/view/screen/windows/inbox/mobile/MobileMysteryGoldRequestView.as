package wom.view.screen.windows.inbox.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.game.friend.request.MysteryGoldRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class MobileMysteryGoldRequestView extends MobileBaseRequestView
   {
      
      private var _mysteryGoldRequest:MysteryGoldRequestInfo;
      
      private var _goldAsset:DisplayObject;
      
      public function MobileMysteryGoldRequestView(param1:RequestInfo)
      {
         _mysteryGoldRequest = param1 as MysteryGoldRequestInfo;
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(_mysteryGoldRequest);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _goldAsset = assetRepository.getDisplayObject("IconGoldL");
         addChild(_goldAsset);
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype." + _mysteryGoldRequest.type + ".title";
         var _loc1_:String = NumberUtil.numberFormat(_mysteryGoldRequest.amount,0);
         var _loc2_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         hideAllAvatars();
         _otherFriendNamesTextField.visible = false;
         var _temp_2:* = friendNameTextField;
         var _temp_1:* = "ui.windows.gold.gold";
         var _loc1_:String = NumberUtil.numberFormat(_mysteryGoldRequest.amount,0);
         var _loc2_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         MobileAlignmentUtil.alignAccordingToPositionOf(_goldAsset,background,30,30);
         MobileAlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,128,30);
         MobileAlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         super.drawLayout();
      }
      
      override public function updateFriendNameTextField(param1:String) : void
      {
      }
   }
}

