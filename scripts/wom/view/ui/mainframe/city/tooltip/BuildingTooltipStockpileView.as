package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.i18n.PText;
   import peak.util.NumberUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar15;
   
   public class BuildingTooltipStockpileView extends Sprite
   {
      
      public var capacityTextField:WomTextField;
      
      public var resourceImage:DisplayObject;
      
      public var progressBar:MaskedProgressBar;
      
      private var _spyEnabled:Boolean;
      
      public var assetRepository:WomAssetRepository;
      
      public function BuildingTooltipStockpileView(param1:WomAssetRepository, param2:Boolean)
      {
         super();
         this.assetRepository = param1;
         _spyEnabled = param2;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         capacityTextField = new WomTextField();
         capacityTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         capacityTextField.autoSize = "left";
         var _temp_2:*;
         var _temp_3:*;
         var _loc1_:int;
         var _loc2_:String;
         var _loc3_:int;
         var _loc4_:String;
         capacityTextField.text = !_spyEnabled ? (_temp_2 = "ui.mainframe.city.tooltip.harvestable2",_loc1_ = 0,_loc2_ = _temp_2,peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_)) : (_temp_3 = "ui.mainframe.city.tooltip.instock2",_loc3_ = 0,_loc4_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_));
         addChild(capacityTextField);
         progressBar = new ProgressBar15();
         progressBar.align = "center";
         progressBar.width = 180 - 70;
         addChild(progressBar);
         resourceImage = assetRepository.getDisplayObject("ResourceBasketTooltip");
         resourceImage.width *= 0.7;
         resourceImage.height *= 0.7;
         addChild(resourceImage);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         resourceImage.x = 25;
         resourceImage.y = 5;
         progressBar.x = 40;
         progressBar.y = resourceImage.y + (resourceImage.height - 15 >> 1);
         capacityTextField.x = 180 - capacityTextField.width >> 1;
         capacityTextField.y = 33;
      }
      
      public function updateWithData(param1:Number, param2:Number, param3:Number) : void
      {
         var _temp_1:*;
         var _temp_2:*;
         var _loc4_:String;
         var _loc5_:String;
         var _loc6_:String;
         var _loc7_:String;
         capacityTextField.text = !_spyEnabled ? (_temp_1 = "ui.mainframe.city.tooltip.harvestable2",_loc4_ = NumberUtil.format(param3),_loc5_ = _temp_1,peak.i18n.PText.INSTANCE.getText1(_loc5_,_loc4_)) : (_temp_2 = "ui.mainframe.city.tooltip.instock2",_loc6_ = NumberUtil.format(param2),_loc7_ = _temp_2,peak.i18n.PText.INSTANCE.getText1(_loc7_,_loc6_));
         progressBar.setProgress(param2,param1);
         var _temp_5:* = progressBar;
         var _temp_3:* = "ui.common.percentage";
         var _loc8_:String = Math.ceil(param2 / param1 * 100).toString();
         var _loc9_:String = _temp_3;
         var _temp_4:* = peak.i18n.PText.INSTANCE.getText1(_loc9_,_loc8_) + " ";
         var _loc10_:String = "ui.mainframe.city.tooltip.full";
         _temp_5.progressText = _temp_4 + peak.i18n.PText.INSTANCE.getText0(_loc10_);
         drawLayout();
      }
   }
}

