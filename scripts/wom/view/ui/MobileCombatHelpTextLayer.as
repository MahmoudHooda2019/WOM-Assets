package wom.view.ui
{
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCombatHelpTextLayer extends Sprite
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _combatHelpTextField:MobileCaptionTextField;
      
      public function MobileCombatHelpTextLayer()
      {
         super();
         touchable = false;
         _visibleWidth = 760;
         _visibleHeight = 620;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _combatHelpTextField = new MobileCaptionTextField();
         _combatHelpTextField.isEnabled = false;
         _combatHelpTextField.width = 760;
         _combatHelpTextField.textRendererProperties.textFormat = getCaptionTextFormat(50,"center",15016227);
         _combatHelpTextField.textRendererProperties.wordWrap = true;
         addChild(_combatHelpTextField);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         _combatHelpTextField.y = _visibleHeight - 158 - _combatHelpTextField.height;
         _combatHelpTextField.x = _visibleWidth - _combatHelpTextField.width >> 1;
      }
      
      public function combatHelpTextUpdate(param1:Boolean, param2:String) : void
      {
         if(param1)
         {
            _combatHelpTextField.visible = true;
            if(param2 == "cityOutOfReachText")
            {
               var _temp_1:* = _combatHelpTextField;
               var _loc3_:String = "ui.floatingtext.combathelp.cityoutofreach";
               _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            }
            else if(param2 == "firstUnitDeployText")
            {
               var _temp_2:* = _combatHelpTextField;
               var _loc4_:String = "ui.floatingtext.combathelp.firstunitdeploy";
               _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
            }
            else if(param2 == "tapWarButtonText")
            {
               var _temp_3:* = _combatHelpTextField;
               var _loc5_:String = "ui.floatingtext.combathelp.tapwarbutton";
               _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
            }
            drawLayout();
         }
         else
         {
            _combatHelpTextField.visible = false;
            _combatHelpTextField.text = "";
            drawLayout();
         }
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function resizeLayer(param1:int, param2:int) : void
      {
         visibleWidth = param1;
         visibleHeight = param2;
         drawLayout();
      }
   }
}

