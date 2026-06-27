package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MCOVWorkView extends MCOVEnterView
   {
      
      private var _boostButton:MobileWomButton;
      
      private var _finishNowButton:MobileCondenseButtonView;
      
      private var _cut30Button:MobileCondenseButtonView;
      
      public function MCOVWorkView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _boostButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Medium");
         _boostButton.width = 145;
         var _temp_2:* = _boostButton;
         var _loc1_:String = "ui.mainframe.city.mobile.boost";
         _temp_2.rightLabel = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _boostButton.defaultIcon = assetRepository.getDisplayObject("IconStoreM");
         addChild(_boostButton);
         var _temp_4:* = §§findproperty(MobileCondenseButtonView);
         var _temp_3:* = null;
         var _loc2_:String = "ui.windows.constructionsite.finishnowbutton";
         _finishNowButton = new MobileCondenseButtonView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),"","IconGoldS",1,0.8,"Yellow");
         addChild(_finishNowButton);
         var _temp_7:* = §§findproperty(MobileCondenseButtonView);
         var _temp_6:* = null;
         var _loc3_:String = "ui.mainframe.city.mobile.cut30min";
         _cut30Button = new MobileCondenseButtonView(_temp_6,peak.i18n.PText.INSTANCE.getText0(_loc3_),"30","IconRPS",1,0.8,"Yellow");
         addChild(_cut30Button);
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_boostButton);
         _loc1_.push(_finishNowButton);
         _loc1_.push(_cut30Button);
         return _loc1_;
      }
      
      public function determineWorkButtonsStatus(param1:Boolean, param2:Boolean) : void
      {
         _boostButton.visible = param1;
         _cut30Button.visible = param2;
         drawLayout();
      }
      
      public function get finishNowButton() : MobileCondenseButtonView
      {
         return _finishNowButton;
      }
      
      public function get cut30Button() : MobileCondenseButtonView
      {
         return _cut30Button;
      }
      
      public function get boostButton() : MobileWomButton
      {
         return _boostButton;
      }
   }
}

