package wom.view.screen.windows.inbox
{
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.friend.request.RequestInfo;
   
   public class WorkerStaffRequestView extends BaseRequestView
   {
      
      public function WorkerStaffRequestView(param1:RequestInfo)
      {
         var _loc2_:Vector.<RequestInfo> = new Vector.<RequestInfo>();
         _loc2_.push(param1);
         super(_loc2_);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_1:* = _titleTextField;
         var _loc1_:String = "ui.windows.inbox.requesttype." + _requests[0].type + ".title";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         drawLayout();
      }
      
      override public function drawLayout() : void
      {
         AlignmentUtil.alignAccordingToPositionOf(friendNameTextField,background,63,7);
         AlignmentUtil.alignBelowOf(_titleTextField,friendNameTextField,0);
         AlignmentUtil.alignBelowOf(_otherFriendNamesTextField,_titleTextField,0);
         super.drawLayout();
      }
   }
}

