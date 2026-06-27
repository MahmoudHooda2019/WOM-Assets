package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.building.BuildingInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getWomTextFormat;
   
   public class MobileBuildingTooltipHousingInfoView extends Sprite implements View
   {
      
      public static const BARRACKS:int = 0;
      
      public static const WATCH_POST:int = 1;
      
      public static const ALLIANCE_BARRACKS:int = 2;
      
      public static const FRIEND_WATCH_POST:int = 3;
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var capacitylabel:MobileWomTextField;
      
      private var unitImage:DisplayObject;
      
      private var progressBar:MobileWomProgressBar;
      
      private var _housingType:int;
      
      private var _buildingInfo:BuildingInfo;
      
      private var _spyMood:Boolean;
      
      public function MobileBuildingTooltipHousingInfoView(param1:int, param2:BuildingInfo, param3:Boolean = false)
      {
         super();
         _housingType = param1;
         _buildingInfo = param2;
         _spyMood = param3;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         capacitylabel = new MobileWomTextField();
         capacitylabel.textRendererProperties.textFormat = getWomTextFormat(21);
         capacitylabel.width = 75;
         addChild(capacitylabel);
         var _temp_2:* = capacitylabel;
         var _loc1_:String = "ui.mainframe.city.tooltip.capacity";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         progressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
         progressBar.width = 200;
         progressBar.height = 33;
         progressBar.align = "center";
         addChild(progressBar);
         unitImage = assetRepository.getDisplayObject("IconCapacity");
         addChild(unitImage);
      }
      
      public function drawLayout() : void
      {
         if(_spyMood)
         {
            progressBar.x = 15;
            progressBar.y = unitImage.height - progressBar.height >> 1;
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(capacitylabel,progressBar,40);
         }
         else
         {
            capacitylabel.y = 10;
            MobileAlignmentUtil.alignRightWithYMarginOf(unitImage,capacitylabel,-10,10);
            MobileAlignmentUtil.alignRightWithYMarginOf(progressBar,unitImage,4,-10);
         }
      }
      
      public function updateWithData(param1:int, param2:int) : void
      {
         progressBar.maximum = param2;
         progressBar.value = param1;
         progressBar.label = param1 + " / " + param2;
      }
      
      public function get housingType() : int
      {
         return _housingType;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      override public function get height() : Number
      {
         return 50;
      }
      
      override public function get width() : Number
      {
         if(_spyMood)
         {
            return progressBar.width;
         }
         return super.width;
      }
   }
}

