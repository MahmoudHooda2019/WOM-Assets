package wom.view.ui.mainframe.city.mobile
{
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileConstructableOptionsView extends Sprite implements View
   {
      
      protected static const MIN_HEIGHT:int = 115;
      
      protected static const BUTTON_MARGIN:int = 10;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      protected var background:DisplayObject;
      
      protected var levelIcon:DisplayObject;
      
      protected var infoView:DisplayObject;
      
      protected var levelTextField:MPTextField;
      
      protected var buildingNameTextField:MPTextField;
      
      protected var _instanceId:int;
      
      public function MobileConstructableOptionsView(param1:int)
      {
         super();
         _instanceId = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("BackgroundProtection");
         background.width = 500;
         background.height = 115;
         background.alpha = 0.7;
         addChild(background);
         levelIcon = assetRepository.getDisplayObject("IconLevelM");
         addChild(levelIcon);
         levelTextField = new MobileCaptionTextField();
         levelTextField.width = levelIcon.width;
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         addChild(levelTextField);
         buildingNameTextField = new MobileCaptionTextField();
         buildingNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(buildingNameTextField);
      }
      
      public function drawLayout() : void
      {
         background.height = 115 + (infoView ? infoView.height + 5 : 0);
         if(infoView)
         {
            infoView.x = background.width - infoView.width >> 1;
            infoView.y = 32;
         }
         var _loc1_:int = -1;
         levelIcon.y = -levelIcon.height >> 1;
         levelIcon.x = background.width - (levelIcon.width + buildingNameTextField.width + _loc1_) >> 1;
         MobileAlignmentUtil.alignAccordingToPositionOf(levelTextField,levelIcon,(levelIcon.width - levelTextField.width >> 1) - 3,(levelIcon.height - levelTextField.height >> 1) + 6);
         MobileAlignmentUtil.alignRightOf(buildingNameTextField,levelTextField,_loc1_);
         if(!drawButtonList())
         {
            if(infoView)
            {
               infoView.y = background.height - infoView.height >> 1;
            }
         }
      }
      
      protected function getActiveButtonList() : Vector.<DisplayObject>
      {
         return new Vector.<DisplayObject>();
      }
      
      protected function drawButtonList() : Boolean
      {
         var _loc4_:Vector.<DisplayObject> = getActiveButtonList();
         var _loc1_:int = 0;
         for each(var _loc2_ in _loc4_)
         {
            if(_loc2_.visible)
            {
               _loc1_ += _loc2_.width + 10;
            }
         }
         _loc1_ = _loc1_ > 0 ? _loc1_ - 10 : 0;
         var _loc6_:int = background.width - _loc1_ >> 1;
         var _loc5_:int = background.height - 80;
         var _loc3_:Boolean = false;
         for each(_loc2_ in _loc4_)
         {
            if(_loc2_.visible)
            {
               _loc2_.x = _loc6_;
               _loc2_.y = _loc5_;
               _loc6_ += _loc2_.width + 10;
               _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      public function get instanceId() : int
      {
         return _instanceId;
      }
      
      public function updateLevelAndName(param1:int, param2:String) : void
      {
         levelTextField.text = param1 + "";
         buildingNameTextField.text = param2;
         drawLayout();
      }
      
      public function addInfoView(param1:DisplayObject) : void
      {
         if(this.infoView)
         {
            removeChild(this.infoView);
            this.infoView = null;
         }
         if(param1)
         {
            this.infoView = param1;
            addChild(param1);
         }
         drawLayout();
      }
      
      public function get visibleHeight() : int
      {
         return background.height;
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
   }
}

