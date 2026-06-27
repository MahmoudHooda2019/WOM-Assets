package wom.view.ui.mainframe.city
{
   import feathers.controls.Button;
   import flash.utils.Timer;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.starling.InflatedBoundsImage;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.resource.ResourceType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.tooltip.MobileResourceBarTooltipView;
   
   public class MobileResourceBar extends Sprite implements View
   {
      
      public static const ANIMATION_COMPLETED_EVENT:String = "AnimationCompletedEvent";
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var _resourceType:ResourceType;
      
      private var _icon:InflatedBoundsImage;
      
      protected var fullButton:Button;
      
      protected var fullBar:DisplayObject;
      
      protected var fullText:MPTextField;
      
      protected var _progressBar:MobileWomProgressBar;
      
      protected var _resourceAddButton:MPRigidButton;
      
      protected var _resourceDisabledButton:Button;
      
      protected var _resourceChangeTimer:Timer;
      
      protected var _combatMode:Boolean;
      
      protected var _map:Boolean;
      
      private var _ongoingAnimation:Boolean;
      
      protected var tween:Tween;
      
      protected var _resourceAmount:Number = -1;
      
      protected var _animatedAmount:int = -1;
      
      protected var _capacity:Number = -1;
      
      private var _tooltip:MobileResourceBarTooltipView;
      
      private var _addResourceAction:Function;
      
      public function MobileResourceBar(param1:ResourceType, param2:Boolean, param3:Function = null)
      {
         super();
         _resourceType = param1;
         _combatMode = param2;
         _addResourceAction = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         _resourceChangeTimer = new Timer(1500,1);
         initLayout();
      }
      
      public function initLayout() : void
      {
         _map = false;
         var _loc1_:String = "";
         var _loc3_:String = "";
         var _loc2_:int = 0;
         switch(_resourceType)
         {
            case ResourceType.IRON:
               _loc1_ = "ResourceIconIron";
               _loc3_ = "Iron";
               _loc2_ = 18;
               break;
            case ResourceType.LUMBER:
               _loc1_ = "ResourceIconLumber";
               _loc3_ = "Lumber";
               _loc2_ = 10;
               break;
            case ResourceType.MIGHT:
               _loc1_ = "ResourceIconMight";
               _loc3_ = "Might";
               _loc2_ = 12;
               break;
            case ResourceType.STONE:
               _loc1_ = "ResourceIconStone";
               _loc3_ = "Stone";
               _loc2_ = 12;
         }
         _progressBar = MobileWomUIComponentFactory.createProgressBar(_loc3_);
         _progressBar.width = 83;
         _progressBar.height = 27;
         _progressBar.minimum = 0;
         _progressBar.maximum = 100;
         _progressBar.textMarginX = _loc2_;
         _progressBar.touchable = false;
         addChild(_progressBar);
         fullBar = assetRepository.getDisplayObject("ProgressBarFullSkin");
         fullBar.width = 83;
         fullBar.height = 27;
         fullBar.visible = false;
         fullBar.touchable = false;
         addChild(fullBar);
         _icon = assetRepository.getDisplayObject(_loc1_) as InflatedBoundsImage;
         addChild(_icon);
         _icon.setPaddings(0,75,10,10);
         fullButton = new MPRigidButton("ButtonResourceFull","ButtonResourceFull");
         fullButton.visible = false;
         addChild(fullButton);
         fullText = new MobileCaptionTextField();
         fullText.textRendererProperties.textFormat = getCaptionTextFormat(21);
         var _temp_7:* = fullText;
         var _loc5_:String = "ui.mainframe.city.full";
         _temp_7.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         fullText.touchable = false;
         addChild(fullText);
         _resourceAddButton = new MPRigidButton("IconGreenAdd","IconGreenAddHover");
         _resourceAddButton.visible = !_map && !_combatMode;
         addChild(_resourceAddButton);
         _resourceDisabledButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _resourceDisabledButton.visible = _combatMode;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _progressBar.x = fullBar.x = 21;
         _progressBar.y = fullBar.y = 3;
         MobileAlignmentUtil.alignAccordingToPositionOf(_resourceAddButton,_progressBar,78,-1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_resourceDisabledButton,_progressBar,78,-1);
         fullButton.validate();
         MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(fullButton,fullBar,78);
         fullButton.y += 1;
         fullText.validate();
         MobileAlignmentUtil.alignMiddleOf(fullText,fullBar);
         fullText.x -= 2;
         fullText.y += 1;
      }
      
      public function updateWithResourceAmount(param1:Number, param2:int, param3:Boolean) : void
      {
         var _loc4_:Tween = null;
         _resourceAmount = param1;
         fullBar.visible = fullButton.visible = fullText.visible = _resourceAmount >= param2;
         _resourceDisabledButton.visible = _combatMode || _map && !fullBar.visible;
         _resourceAddButton.visible = param3 && !_map && !_combatMode && _resourceAmount < param2;
         _capacity = param2;
         if(_combatMode)
         {
            _progressBar.value = 100 * param1 / _capacity;
         }
         if(_animatedAmount != _resourceAmount)
         {
            _resourceChangeTimer.reset();
            if(!_ongoingAnimation)
            {
               _ongoingAnimation = true;
               tween = new Tween(this,0.3);
               tween.delay = 0.5;
               tween.scaleTo(1.08);
               tween.moveTo(this.x - this.width * 0.04,this.y - this.height * 0.04);
               tween.onComplete = onTweenComplete;
               Starling.juggler.add(tween);
            }
            else
            {
               _loc4_ = new Tween(this,0.3);
               _loc4_.onUpdate = showProgress;
               _loc4_.onComplete = onAmountTweenComplete;
               _loc4_.animate("animatedAmount",_resourceAmount);
               Starling.juggler.add(_loc4_);
            }
         }
      }
      
      public function updateScreenMode(param1:Boolean) : void
      {
      }
      
      private function showProgress() : void
      {
         _progressBar.label = NumberUtil.prettyFormat(animatedAmount);
         if(!_combatMode)
         {
            _progressBar.value = 100 * animatedAmount / _capacity;
         }
      }
      
      public function get resourceAddButton() : MPRigidButton
      {
         return _resourceAddButton;
      }
      
      public function get resourceType() : ResourceType
      {
         return _resourceType;
      }
      
      private function onTweenReverseComplete() : void
      {
         _ongoingAnimation = false;
         dispatchEventWith("AnimationCompletedEvent");
      }
      
      private function onTweenComplete() : void
      {
         var _loc1_:Tween = new Tween(this,0.3);
         _loc1_.onUpdate = showProgress;
         _loc1_.onComplete = onAmountTweenComplete;
         _loc1_.animate("animatedAmount",_resourceAmount);
         Starling.juggler.add(_loc1_);
      }
      
      public function reverseTween() : void
      {
         _progressBar.label = NumberUtil.prettyFormat(_resourceAmount);
         tween = new Tween(this,0.3);
         tween.delay = 0.5;
         tween.scaleTo(1);
         var _loc1_:Number = 0.9259259259259258;
         tween.moveTo(this.x + this.width * _loc1_ * 0.04,this.y + this.height * _loc1_ * 0.04);
         tween.onComplete = onTweenReverseComplete;
         Starling.juggler.add(tween);
      }
      
      private function onAmountTweenComplete() : void
      {
         _resourceChangeTimer.start();
      }
      
      public function get animatedAmount() : int
      {
         return _animatedAmount;
      }
      
      public function set animatedAmount(param1:int) : void
      {
         _animatedAmount = param1;
      }
      
      public function get resourceChangeTimer() : Timer
      {
         return _resourceChangeTimer;
      }
      
      public function get ongoingAnimation() : Boolean
      {
         return _ongoingAnimation;
      }
      
      public function get tooltip() : MobileResourceBarTooltipView
      {
         return _tooltip;
      }
      
      public function set tooltip(param1:MobileResourceBarTooltipView) : void
      {
         _tooltip = param1;
      }
      
      public function get icon() : InflatedBoundsImage
      {
         return _icon;
      }
      
      public function get addResourceAction() : Function
      {
         return _addResourceAction;
      }
   }
}

