package wom.view.ui.mainframe.city.mobile
{
   import starling.display.DisplayObject;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MCOVBeastCannonView extends MCOVIdleView
   {
      
      private var _rechargeButton:MobileCondenseButtonView;
      
      public function MCOVBeastCannonView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _rechargeButton = new MobileCondenseButtonView(null,"","","IconGoldXS",1,1,"Green","Gray");
         addChild(_rechargeButton);
         _rechargeButton.width = 150;
         _rechargeButton.subLabel = "0";
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc2_:Vector.<DisplayObject> = super.getActiveButtonList();
         var _loc1_:DisplayObject = _loc2_.pop();
         _loc2_.push(_rechargeButton);
         _loc2_.push(_loc1_);
         return _loc2_;
      }
      
      public function get rechargeButton() : MobileCondenseButtonView
      {
         return _rechargeButton;
      }
   }
}

