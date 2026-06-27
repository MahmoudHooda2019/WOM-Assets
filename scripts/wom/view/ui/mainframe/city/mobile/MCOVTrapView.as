package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MCOVTrapView extends MCOVIdleView
   {
      
      private var _rearmButton:MobileWomButton;
      
      private var _sellButton:MobileWomButton;
      
      private var _buildingInfo:BuildingInfo;
      
      public function MCOVTrapView(param1:int, param2:BuildingInfo)
      {
         super(param1);
         _buildingInfo = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _rearmButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _rearmButton.visible = _buildingInfo.healthPoint == 0;
         _rearmButton.width = 133;
         var _temp_2:* = _rearmButton;
         var _loc1_:String = "m.ui.mainframe.city.menupanel.rearm";
         _temp_2.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(_rearmButton);
         _sellButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _sellButton.width = 102;
         var _temp_4:* = _sellButton;
         var _loc2_:String = "m.ui.mainframe.city.menupanel.sell";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(_sellButton);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_rearmButton);
         _loc1_.push(_sellButton);
         return _loc1_;
      }
      
      public function get rearmButton() : MPButton
      {
         return _rearmButton;
      }
      
      public function get sellButton() : MobileWomButton
      {
         return _sellButton;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
   }
}

