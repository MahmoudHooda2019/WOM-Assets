package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileTooltipInfoView extends Sprite implements View
   {
      
      public static const WIDTH:int = 140;
      
      public static const HEIGHT:int = 22;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var image:DisplayObject;
      
      private var infoTextField:MobileWomTextField;
      
      private var imageId:String;
      
      private var infoText:String;
      
      private var _bgHeight:int;
      
      private var _bgWidth:int;
      
      private var _spyMood:Boolean;
      
      public function MobileTooltipInfoView(param1:String, param2:String, param3:int = 140, param4:int = 22, param5:Boolean = false)
      {
         super();
         this.imageId = param1;
         this.infoText = param2;
         _bgWidth = param3;
         _bgHeight = param4;
         _spyMood = param5;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("ProgressBarYellowSkin");
         background.width = _bgWidth;
         background.height = _bgHeight;
         addChild(background);
         image = assetRepository.getDisplayObject(imageId);
         addChild(image);
         infoTextField = new MobileCaptionTextField();
         infoTextField.width = background.width - 15;
         infoTextField.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         addChild(infoTextField);
         infoTextField.text = infoText;
      }
      
      public function drawLayout() : void
      {
         if(_spyMood)
         {
            background.x = 15;
            infoTextField.x = (background.width - infoTextField.width >> 1) + 15;
            infoTextField.y = 8;
         }
         else
         {
            image.x = background.x - (image.width >> 1) + 3;
            MobileAlignmentUtil.alignMiddleOf(infoTextField,background);
         }
         image.y = image.height - background.height >> 1;
      }
      
      override public function get width() : Number
      {
         if(_spyMood)
         {
            return _bgWidth + 15;
         }
         return super.width;
      }
   }
}

