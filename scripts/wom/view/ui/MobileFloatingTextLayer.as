package wom.view.ui
{
   import com.greensock.TweenLite;
   import peak.i18n.PText;
   import starling.display.Sprite;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileFloatingTextLayer extends Sprite
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var _titleTextField:MobileCaptionTextField;
      
      private var _descriptionTextField:MobileCaptionTextField;
      
      private var eventItemsInfoShownBefore:Boolean;
      
      private var _fadeOutSprite:Sprite;
      
      public function MobileFloatingTextLayer()
      {
         super();
         touchable = false;
         _visibleWidth = 760;
         _visibleHeight = 620;
         eventItemsInfoShownBefore = false;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _fadeOutSprite = new Sprite();
         addChild(_fadeOutSprite);
         _titleTextField = new MobileCaptionTextField();
         _titleTextField.isEnabled = false;
         _titleTextField.width = 760;
         _titleTextField.textRendererProperties.textFormat = getCaptionTextFormat(50,"center",15016227);
         _titleTextField.textRendererProperties.wordWrap = true;
         _fadeOutSprite.addChild(_titleTextField);
         _descriptionTextField = new MobileCaptionTextField();
         _descriptionTextField.isEnabled = false;
         _descriptionTextField.width = 760;
         _descriptionTextField.textRendererProperties.textFormat = getCaptionTextFormat(50,"center",15016227);
         _descriptionTextField.textRendererProperties.wordWrap = true;
         _fadeOutSprite.addChild(_descriptionTextField);
         drawLayout();
      }
      
      private function drawLayout() : void
      {
         var _loc1_:int = _titleTextField.height + _descriptionTextField.height + 12;
         _titleTextField.y = _visibleHeight - _loc1_ >> 1;
         _descriptionTextField.y = _titleTextField.text && _titleTextField.text.length > 0 ? _titleTextField.y + 47 : _titleTextField.y;
         _titleTextField.x = _visibleWidth - _titleTextField.width >> 1;
         _descriptionTextField.x = _visibleWidth - _descriptionTextField.width >> 1;
      }
      
      public function showSpyInformation() : void
      {
         var _temp_1:* = _titleTextField;
         var _loc1_:String = "ui.mainframe.combat.spymodeon.title";
         _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         var _temp_2:* = _descriptionTextField;
         var _loc2_:String = "ui.mainframe.combat.spymodeon.desc";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         drawLayout();
         fadeOut();
      }
      
      public function showNotification(param1:String, param2:Number) : void
      {
         TweenLite.killTweensOf(_fadeOutSprite);
         _titleTextField.text = "";
         _descriptionTextField.text = param1;
         drawLayout();
         fadeOut(param2);
      }
      
      private function fadeOut(param1:Number = 2) : void
      {
         _fadeOutSprite.alpha = 1;
         TweenLite.to(_fadeOutSprite,1,{
            "delay":param1,
            "alpha":0
         });
      }
      
      public function resizeLayer(param1:int, param2:int) : void
      {
         visibleWidth = param1;
         visibleHeight = param2;
         drawLayout();
      }
      
      public function showEventItemsInformation() : void
      {
         if(!eventItemsInfoShownBefore)
         {
            eventItemsInfoShownBefore = true;
            var _temp_2:* = _titleTextField;
            var _loc1_:String = "ui.floatingtext.eventitems.title";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
            var _temp_3:* = _descriptionTextField;
            var _loc2_:String = "ui.floatingtext.eventitems.desc";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            drawLayout();
            fadeOut();
         }
      }
      
      public function resetEventItemsShownStatus() : void
      {
         eventItemsInfoShownBefore = false;
      }
      
      public function get visibleWidth() : int
      {
         return _visibleWidth < 760 ? 760 : _visibleWidth;
      }
      
      public function get visibleHeight() : int
      {
         return _visibleHeight < 620 ? 620 : _visibleHeight;
      }
      
      public function set visibleWidth(param1:int) : void
      {
         _visibleWidth = param1;
      }
      
      public function set visibleHeight(param1:int) : void
      {
         _visibleHeight = param1;
      }
      
      public function get fadeOutSprite() : Sprite
      {
         return _fadeOutSprite;
      }
   }
}

