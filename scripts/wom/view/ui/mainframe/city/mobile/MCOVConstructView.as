package wom.view.ui.mainframe.city.mobile
{
   import peak.i18n.PText;
   import starling.display.DisplayObject;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MCOVConstructView extends MobileConstructableOptionsView
   {
      
      protected var _finishNowButton:MobileCondenseButtonView;
      
      protected var _cut30Button:MobileCondenseButtonView;
      
      public function MCOVConstructView(param1:int)
      {
         super(param1);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         var _temp_2:* = §§findproperty(MobileCondenseButtonView);
         var _temp_1:* = null;
         var _loc1_:String = "ui.windows.constructionsite.finishnowbutton";
         _finishNowButton = new MobileCondenseButtonView(_temp_1,peak.i18n.PText.INSTANCE.getText0(_loc1_),"","IconGoldS",1,0.8,"Yellow");
         addChild(_finishNowButton);
         var _temp_5:* = §§findproperty(MobileCondenseButtonView);
         var _temp_4:* = null;
         var _loc2_:String = "ui.mainframe.city.mobile.cut30min";
         _cut30Button = new MobileCondenseButtonView(_temp_4,peak.i18n.PText.INSTANCE.getText0(_loc2_),"30","IconRPS",1,0.8,"Yellow");
         addChild(_cut30Button);
      }
      
      override protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         var _loc1_:Vector.<DisplayObject> = super.getActiveButtonList();
         _loc1_.push(_finishNowButton);
         _loc1_.push(_cut30Button);
         return _loc1_;
      }
      
      public function get finishNowButton() : MobileCondenseButtonView
      {
         return _finishNowButton;
      }
      
      public function get cut30Button() : MobileCondenseButtonView
      {
         return _cut30Button;
      }
   }
}

