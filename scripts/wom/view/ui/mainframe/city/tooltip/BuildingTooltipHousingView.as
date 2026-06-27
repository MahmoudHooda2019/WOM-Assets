package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar15;
   
   public class BuildingTooltipHousingView extends Sprite
   {
      
      public static const BARRACKS:int = 0;
      
      public static const WATCH_POST:int = 1;
      
      public static const ALLIANCE_BARRACKS:int = 2;
      
      public static const FRIEND_WATCH_POST:int = 3;
      
      public var capacitylabel:WomTextField;
      
      public var unitImage:DisplayObject;
      
      public var progressBar:MaskedProgressBar;
      
      public var assetRepository:WomAssetRepository;
      
      public var housingType:int;
      
      public function BuildingTooltipHousingView(param1:int, param2:WomAssetRepository)
      {
         super();
         this.housingType = param1;
         this.assetRepository = param2;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         capacitylabel = new WomTextField();
         capacitylabel.defaultTextFormat = WomTextFormats.CENTER_16;
         capacitylabel.width = 180;
         var _temp_2:* = capacitylabel;
         var _loc1_:String = "ui.mainframe.city.tooltip.capacity";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         addChild(capacitylabel);
         progressBar = new ProgressBar15();
         progressBar.align = "center";
         progressBar.width = 180 - 70;
         addChild(progressBar);
         unitImage = assetRepository.getDisplayObject("MercTooltipHead");
         unitImage.width *= 0.7;
         unitImage.height *= 0.7;
         addChild(unitImage);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         unitImage.x = 25;
         unitImage.y = 0;
         progressBar.x = 40;
         progressBar.y = unitImage.y + (unitImage.height - progressBar.height) / 2 - 3;
         AlignmentUtil.alignAccordingToPositionOf(capacitylabel,progressBar,0,-15);
         capacitylabel.x = 0;
      }
      
      public function updateWithData(param1:int, param2:int) : void
      {
         progressBar.setProgress(unitImage.width / 2 * param2 / progressBar.width + param1 * (progressBar.width - unitImage.width / 2) / progressBar.width,param2);
         progressBar.progressText = param1 + " / " + param2;
      }
   }
}

