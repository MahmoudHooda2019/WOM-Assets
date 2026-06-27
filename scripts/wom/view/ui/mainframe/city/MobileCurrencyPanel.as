package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.starling.FlatteningSprite;
   import peak.starling.InflatedBoundsImage;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCurrencyPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var rpBackground:DisplayObject;
      
      protected var goldBackground:DisplayObject;
      
      protected var goldIcon:DisplayObject;
      
      protected var goldTextField:MPTextField;
      
      protected var _addGoldButton:MPRigidButton;
      
      protected var _rpIcon:InflatedBoundsImage;
      
      protected var _rpTextField:MPTextField;
      
      protected var _animatedGoldAmount:int;
      
      protected var _animatedRpAmount:int;
      
      private var _helpView:Boolean;
      
      private var _remainingHelps:Array;
      
      public function MobileCurrencyPanel(param1:Boolean = false)
      {
         super();
         _helpView = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:int = 0;
         goldBackground = assetRepository.getDisplayObject("BackgroundYellowPanel");
         goldBackground.width = 137;
         goldBackground.height = 45;
         addChild(goldBackground);
         goldIcon = assetRepository.getDisplayObject("IconGoldM");
         addChild(goldIcon);
         goldTextField = new MobileCaptionTextField();
         goldTextField.width = 67;
         goldTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         goldTextField.text = "";
         addChild(goldTextField);
         _addGoldButton = new MPRigidButton("IconGreenAdd","IconGreenAddHover");
         _addGoldButton.setPaddings(110,20,20,10);
         addChild(_addGoldButton);
         rpBackground = assetRepository.getDisplayObject("BackgroundYellowPanel");
         rpBackground.width = _helpView ? 280 : 107;
         rpBackground.height = 45;
         addChild(rpBackground);
         _rpIcon = assetRepository.getDisplayObject("IconRPM") as InflatedBoundsImage;
         _rpIcon.setPaddings(20,rpBackground.width,2,5);
         addChild(_rpIcon);
         _rpTextField = new MobileCaptionTextField();
         _rpTextField.width = 65;
         _rpTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         _rpTextField.text = "";
         _rpTextField.touchable = false;
         addChild(_rpTextField);
         _remainingHelps = [];
         _loc1_ = 0;
         while(_loc1_ < 4 && _helpView)
         {
            _remainingHelps[_loc1_] = assetRepository.getDisplayObject("IconRPEmpty");
            _remainingHelps[_loc1_].touchable = false;
            addChild(_remainingHelps[_loc1_]);
            _loc1_++;
         }
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         MobileAlignmentUtil.alignAccordingToPositionOf(rpBackground,goldBackground,goldBackground.width - rpBackground.width,50);
         MobileAlignmentUtil.alignAccordingToPositionOf(goldIcon,goldBackground,-11,-1);
         MobileAlignmentUtil.alignAccordingToPositionOf(goldTextField,goldBackground,30,12);
         MobileAlignmentUtil.alignAccordingToPositionOf(_addGoldButton,goldBackground,101,6);
         MobileAlignmentUtil.alignAccordingToPositionOf(_rpIcon,rpBackground,rpBackground.width - 118,-1);
         MobileAlignmentUtil.alignAccordingToPositionOf(_rpTextField,rpBackground,rpBackground.width - 82,12);
         _loc2_ = 0;
         while(_loc2_ < _remainingHelps.length)
         {
            _loc1_ = _remainingHelps[_loc2_];
            if(_loc2_ == 0)
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,rpBackground,12,6);
            }
            else
            {
               MobileAlignmentUtil.alignAccordingToPositionOf(_loc1_,_remainingHelps[_loc2_ - 1],36,0);
            }
            MobileAlignmentUtil.alignMiddleYAxisOf(_loc1_,rpBackground);
            _loc2_++;
         }
      }
      
      public function updateWithHelpCount(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:DisplayObject = null;
         unflattenParent();
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            removeChild(_remainingHelps[_loc3_]);
            _loc2_ = assetRepository.getDisplayObject(_loc3_ < param1 ? "IconRPM" : "IconRPEmpty");
            _loc2_.scaleX = _loc2_.scaleY = 0.7;
            _remainingHelps[_loc3_] = _loc2_;
            addChild(_remainingHelps[_loc3_]);
            _loc3_++;
         }
         drawLayout();
         flattenParent();
      }
      
      public function updateWithScreenType(param1:Boolean) : void
      {
         if(!param1)
         {
            rpBackground.visible = _rpIcon.visible = _rpTextField.visible = false;
         }
         else
         {
            rpBackground.visible = _rpIcon.visible = _rpTextField.visible = true;
         }
      }
      
      public function updateWithRpAmount(param1:int) : void
      {
         unflattenParent();
         var _loc2_:Tween = new Tween(this,0.4);
         _loc2_.onUpdate = showRpAmount;
         _loc2_.animate("animatedRpAmount",param1);
         _loc2_.onComplete = onTweenComplete;
         Starling.juggler.add(_loc2_);
         _rpTextField.text = NumberUtil.format(param1);
         drawLayout();
      }
      
      public function updateWithGoldAmount(param1:int, param2:Boolean) : void
      {
         unflattenParent();
         var _loc3_:Tween = new Tween(this,0.4);
         _loc3_.onUpdate = showGoldAmount;
         _loc3_.onComplete = onTweenComplete;
         _loc3_.animate("animatedGoldAmount",param1);
         Starling.juggler.add(_loc3_);
         goldTextField.text = NumberUtil.numberFormat(param1,0,false,false);
         _addGoldButton.visible = param2;
      }
      
      private function onTweenComplete() : void
      {
         flattenParent();
      }
      
      private function flattenParent() : void
      {
         if(parent && parent.stage)
         {
            (parent as FlatteningSprite).flatten();
         }
      }
      
      private function unflattenParent() : void
      {
         if(parent && parent.stage)
         {
            (parent as FlatteningSprite).unflatten();
         }
      }
      
      protected function showGoldAmount() : void
      {
         goldTextField.text = NumberUtil.numberFormat(_animatedGoldAmount,0,false,false);
      }
      
      private function showRpAmount() : void
      {
         _rpTextField.text = NumberUtil.format(_animatedRpAmount);
      }
      
      public function get animatedGoldAmount() : int
      {
         return _animatedGoldAmount;
      }
      
      public function set animatedGoldAmount(param1:int) : void
      {
         _animatedGoldAmount = param1;
      }
      
      public function get animatedRpAmount() : int
      {
         return _animatedRpAmount;
      }
      
      public function set animatedRpAmount(param1:int) : void
      {
         _animatedRpAmount = param1;
      }
      
      public function get visibleWidth() : int
      {
         return goldBackground.width;
      }
      
      public function get rpTextField() : MPTextField
      {
         return _rpTextField;
      }
      
      public function get rpIcon() : DisplayObject
      {
         return _rpIcon;
      }
      
      public function get addGoldButton() : MPButton
      {
         return _addGoldButton;
      }
      
      public function get helpView() : Boolean
      {
         return _helpView;
      }
   }
}

