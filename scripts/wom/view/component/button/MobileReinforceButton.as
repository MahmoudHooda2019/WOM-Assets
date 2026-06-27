package wom.view.component.button
{
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   
   public class MobileReinforceButton extends MobileWomButton
   {
      
      public static var TYPE_REINFORCE:int = 0;
      
      public static var TYPE_SUPPORT:int = 1;
      
      private var reinforceProgressBar:MobileWomProgressBar;
      
      private var reinforceTextField:MPTextField;
      
      private var _type:int;
      
      public function MobileReinforceButton(param1:int, param2:String)
      {
         var _loc3_:String = null;
         super("",param2,"Medium",getCaptionTextFormat(25),-5);
         _type = param1;
         if(param1 == TYPE_REINFORCE)
         {
            this.width = 162;
            var _loc4_:String = "ui.windows.alliance.members.action.reinforce";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         }
         else if(param1 == TYPE_SUPPORT)
         {
            this.width = 140;
            var _loc5_:String = "ui.mainframe.city.friend.support";
            _loc3_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         reinforceProgressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         reinforceProgressBar.width = width - 10;
         reinforceProgressBar.height = 20;
         reinforceProgressBar.minimum = 0;
         addChild(reinforceProgressBar);
         reinforceTextField = new MobileCaptionTextField();
         reinforceTextField.textRendererProperties.textFormat = getCaptionTextFormat(25,"center");
         reinforceTextField.width = width;
         addChild(reinforceTextField);
         reinforceTextField.text = _loc3_;
         drawLayout();
      }
      
      public function set maximum(param1:int) : void
      {
         reinforceProgressBar.maximum = param1;
      }
      
      public function set value(param1:int) : void
      {
         reinforceProgressBar.value = param1;
      }
      
      protected function drawLayout() : void
      {
         reinforceTextField.y = 5;
         reinforceProgressBar.x = width - reinforceProgressBar.width >> 1;
         reinforceProgressBar.y = 30;
      }
      
      public function set text(param1:String) : void
      {
         reinforceTextField.text = param1;
         drawLayout();
      }
   }
}

