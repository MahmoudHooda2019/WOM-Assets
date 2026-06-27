package wom.view.ui.common
{
   import com.greensock.TweenMax;
   import com.greensock.easing.Linear;
   import peak.display.View;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileLightAnimationView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _animationAsset1:DisplayObject;
      
      private var _animationAsset2:DisplayObject;
      
      private var _bigAsset:Boolean = false;
      
      public function MobileLightAnimationView(param1:Boolean = true)
      {
         super();
         _bigAsset = param1;
      }
      
      public static function toRad(param1:Number) : Number
      {
         return param1 / 180 * 3.141592653589793;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _animationAsset1 = assetRepository.getDisplayObject("LightAnimation");
         addChild(_animationAsset1);
         _animationAsset2 = assetRepository.getDisplayObject("LightAnimation");
         addChild(_animationAsset2);
         _animationAsset2.scaleX = -1;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _animationAsset1.x = -_animationAsset1.width;
         _animationAsset1.y = -(_animationAsset1.height >> 1);
         _animationAsset2.x = _animationAsset2.width - 0.25;
         _animationAsset2.y = -(_animationAsset2.height >> 1);
      }
      
      public function get animationAsset1() : DisplayObject
      {
         return _animationAsset1;
      }
      
      public function get animationAsset2() : DisplayObject
      {
         return _animationAsset2;
      }
      
      public function rotate(param1:Object = null, param2:Object = null, param3:Object = null) : void
      {
         if(param1 == null)
         {
            param1 = 5;
         }
         if(param2 == null)
         {
            param2 = 360;
         }
         if(param3 == null)
         {
            param3 = false;
         }
         param2 = toRad(Number(param2));
         var _loc4_:Object = {
            "rotation":param2,
            "ease":Linear.easeNone
         };
         if(param3)
         {
            _loc4_.onComplete = hide;
         }
         TweenMax.to(this,Number(param1),_loc4_);
      }
      
      private function hide() : void
      {
         this.visible = false;
      }
   }
}

