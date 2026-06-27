package wom.view.ui
{
   import feathers.controls.Label;
   import flash.utils.setTimeout;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Quad;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.Environment;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileLoadingLayer extends Sprite
   {
      
      public static const MIN_SCREEN_WIDTH:int = 760;
      
      public static const MIN_SCREEN_HEIGHT:int = 620;
      
      private static const RADIUS:int = 450;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var loadingLabel:Label;
      
      private var _visibleWidth:int;
      
      private var _visibleHeight:int;
      
      private var container:Sprite;
      
      private var quad:Quad;
      
      private var map:DisplayObject;
      
      private var _hourglass:DisplayObject;
      
      private var manuelAuth:Boolean;
      
      private var _ongoingShowAnimation:Boolean;
      
      private var clementine:DisplayObject;
      
      private var yellowBg:DisplayObject;
      
      private var beigeBg:DisplayObject;
      
      public function MobileLoadingLayer(param1:Boolean = false)
      {
         super();
         this.manuelAuth = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      protected function initLayout() : void
      {
         quad = new Quad(Environment.starling.stage.stageWidth,Environment.starling.stage.stageHeight,0);
         addChild(quad);
         container = new Sprite();
         container.pivotX = quad.width >> 1;
         container.pivotY = quad.height >> 1;
         addChild(container);
         clementine = assetRepository.getDisplayObject("MPose7Right");
         container.addChild(clementine);
         yellowBg = assetRepository.getDisplayObject("BackgroundYellowPanel");
         yellowBg.width = 375;
         yellowBg.height = 103;
         container.addChild(yellowBg);
         beigeBg = assetRepository.getDisplayObject("MobileBeigeBackground");
         beigeBg.width = 405;
         beigeBg.height = 85;
         container.addChild(beigeBg);
         map = assetRepository.getDisplayObject("IconMapGuide");
         container.addChild(map);
         _hourglass = assetRepository.getDisplayObject("IconHourglass");
         container.addChild(_hourglass);
         loadingLabel = new MobileCaptionTextField();
         loadingLabel.width = 405;
         loadingLabel.textRendererProperties.textFormat = getCaptionTextFormat(46,"center");
         var _loc1_:String;
         loadingLabel.text = manuelAuth ? "User data loading..." : (_loc1_ = "ui.mainframe.cityloading.loading",peak.i18n.PText.INSTANCE.getText0(_loc1_));
         container.addChild(loadingLabel);
      }
      
      private function drawLayout() : void
      {
         clementine.x = 59;
         yellowBg.x = 15;
         yellowBg.y = 217;
         beigeBg.y = 226;
         map.x = 161;
         map.y = 120;
         MobileAlignmentUtil.alignAccordingToPositionOf(_hourglass,map,-13,21);
         MobileAlignmentUtil.alignAccordingToPositionOf(loadingLabel,beigeBg,0,20);
         container.pivotX = container.width >> 1;
         container.pivotY = container.height >> 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(container,quad,quad.width >> 1,quad.height >> 1);
      }
      
      public function resizeScreen() : void
      {
         drawLayout();
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
      
      public function get hourglass() : DisplayObject
      {
         return _hourglass;
      }
      
      public function show(param1:Function) : void
      {
         if(_ongoingShowAnimation)
         {
            return;
         }
         visible = true;
         _ongoingShowAnimation = true;
         quad.alpha = 0;
         var _loc3_:Tween = new Tween(quad,0.2);
         _loc3_.animate("alpha",1);
         Starling.juggler.add(_loc3_);
         container.scaleX = 0;
         container.scaleY = 0;
         var _loc2_:Tween = new Tween(container,0.4);
         _loc2_.animate("scaleX",1);
         _loc2_.animate("scaleY",1);
         _loc2_.onComplete = onShowTweenComplete;
         _loc2_.onCompleteArgs = [param1];
         _loc2_.transition = "easeOutBounce";
         Starling.juggler.add(_loc2_);
      }
      
      private function onShowTweenComplete(param1:Function) : void
      {
         _ongoingShowAnimation = false;
         setTimeout(dispatchShowComplete,30);
         if(Boolean(param1))
         {
            param1();
         }
      }
      
      private function dispatchShowComplete() : void
      {
         dispatchEvent(new Event("change"));
      }
      
      public function hide() : void
      {
         quad.alpha = 1;
         var _loc1_:Tween = new Tween(quad,0.2);
         _loc1_.animate("alpha",0);
         _loc1_.onComplete = onHideTweenComplete;
         Starling.juggler.add(_loc1_);
         container.scaleX = 1;
         container.scaleY = 1;
         var _loc2_:Tween = new Tween(container,0.1);
         _loc2_.animate("scaleX",0);
         _loc2_.animate("scaleY",0);
         Starling.juggler.add(_loc2_);
      }
      
      private function onHideTweenComplete() : void
      {
         visible = false;
      }
      
      public function get ongoingShowAnimation() : Boolean
      {
         return _ongoingShowAnimation;
      }
   }
}

