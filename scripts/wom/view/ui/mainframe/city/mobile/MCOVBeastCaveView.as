package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MCOVBeastCaveView extends MCOVEnterView
   {
      
      private var _healBeastButton:MobileCondenseButtonView;
      
      private var _instantEvolveButton:MobileCondenseButtonView;
      
      private var _beastExists:Boolean;
      
      public function MCOVBeastCaveView(param1:int, param2:Boolean = false, param3:Object = null)
      {
         super(param1,param2,param3);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = §§findproperty(MobileCondenseButtonView);
         var _temp_1:* = null;
         var _loc1_:String = "ui.windows.beast.cave.beast.heal";
         _healBeastButton = new MobileCondenseButtonView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),"","IconGoldS",1,0.8,"Yellow","Gray");
         _healBeastButton.visible = _beastExists;
         addChild(_healBeastButton);
         var _temp_5:* = §§findproperty(MobileCondenseButtonView);
         var _temp_4:* = null;
         var _loc2_:String = "ui.windows.beast.cave.evolution.instantevolve";
         _instantEvolveButton = new MobileCondenseButtonView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),"","IconGoldS",1,0.8,"Yellow");
         _instantEvolveButton.visible = _beastExists;
         addChild(_instantEvolveButton);
         _instantEvolveButton.button.width = 154;
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_healBeastButton);
         _loc1_.push(_instantEvolveButton);
         return _loc1_;
      }
      
      public function get healBeastButton() : MobileCondenseButtonView
      {
         return _healBeastButton;
      }
      
      public function get instantEvolveButton() : MobileCondenseButtonView
      {
         return _instantEvolveButton;
      }
      
      public function get beastExists() : Boolean
      {
         return _beastExists;
      }
      
      public function set beastExists(param1:Boolean) : void
      {
         _beastExists = param1;
      }
      
      public function toggleHealButton(param1:int = 0) : void
      {
         _healBeastButton.updateSubIconLabel(param1 <= 0 ? null : "IconGoldS",param1 <= 0 ? null : param1.toString());
         _healBeastButton.isEnabled = param1 > 0;
      }
   }
}

