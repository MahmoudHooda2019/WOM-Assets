package wom.view.screen.windows.inbox.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.model.game.friend.request.MysteryRpRequestInfo;
   import wom.model.game.friend.request.RequestInfo;
   
   public class MobileMysteryRpRequestView extends MobileBaseRequestView
   {
      
      private var _mysteryRpRequest:MysteryRpRequestInfo;
      
      private var _rpAsset:DisplayObject;
      
      public function MobileMysteryRpRequestView(param1:RequestInfo)
      {
         _mysteryRpRequest = param1 as MysteryRpRequestInfo;
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(_mysteryRpRequest);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _rpAsset = assetRepository.getDisplayObject("RP41");
         addChild(_rpAsset);
         var _temp_3:* = _titleTextField;
         var _temp_2:* = "ui.windows.inbox.requesttype." + _mysteryRpRequest.type + ".title";
         var _loc1_:String = NumberUtil.numberFormat(_mysteryRpRequest.amount,0);
         var _loc2_:String = _temp_2;
         _temp_3.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         hideAllAvatars();
         _otherFriendNamesTextField.visible = false;
         var _temp_2:* = friendNameTextField;
         var _temp_1:* = "ui.windows.inbox.requesttype." + _mysteryRpRequest.type + ".amount";
         var _loc1_:String = NumberUtil.numberFormat(_mysteryRpRequest.amount,0);
         var _loc2_:String = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         MobileAlignmentUtil.alignAccordingToPositionOf(_rpAsset,background,30,30);
         MobileAlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,128,30);
         MobileAlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         super.drawLayout();
      }
      
      override public function updateFriendNameTextField(param1:String) : void
      {
      }
   }
}

