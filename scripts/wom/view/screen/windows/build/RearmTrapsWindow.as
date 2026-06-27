package wom.view.screen.windows.build
{
   import fl.controls.Button;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.component.button.colored.WomGreenLargeButton;
   import wom.view.ui.common.OrView;
   import wom.view.ui.common.ResourceGroupView;
   import wom.view.ui.common.ResourceView;
   import wom.view.util.GenericWindow;
   
   public class RearmTrapsWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 716;
      
      private static const WINDOW_HEIGHT:int = 200;
      
      public static const FIRE_TRAP_SILHOUTTE_ID:String = "B40Silhouette";
      
      public static const BURIED_SPIKES_SILHOUTTE_ID:String = "B39Silhouette";
      
      private var _fireTrapDIO:BuildingTypeDIO;
      
      private var _buriedSpikesDIO:BuildingTypeDIO;
      
      private var _fireTrapSilhouette:DisplayObject;
      
      private var _buriedSpikesSilhouette:DisplayObject;
      
      private var costsBackground:DisplayObject;
      
      private var costLabel:TextField;
      
      private var _costView:ResourceGroupView;
      
      private var _rearmWithResourcesButton:Button;
      
      private var _rearmWithGoldButton:WomButton;
      
      private var orIcon:DisplayObject;
      
      private var _resourcesSatisfied:Boolean = false;
      
      private var _totalResourceCosts:Vector.<ResourceAmountDTO>;
      
      private var _totalGoldCost:int;
      
      public function RearmTrapsWindow(param1:BuildingTypeDIO, param2:BuildingTypeDIO, param3:int, param4:int, param5:Vector.<WindowEnumeration> = null)
      {
         super(716,200,param5);
         _fireTrapDIO = param1;
         _buriedSpikesDIO = param2;
         calculateTotalCosts(param3,param4);
      }
      
      private function calculateTotalCosts(param1:int, param2:int) : void
      {
         _totalResourceCosts = new Vector.<ResourceAmountDTO>();
         var _loc3_:Dictionary = new Dictionary();
         for each(var _loc4_ in _fireTrapDIO.resourceCosts[0])
         {
            _loc3_[_loc4_.resourceType] = _loc4_.resourceAmount * param1;
         }
         for each(_loc4_ in _buriedSpikesDIO.resourceCosts[0])
         {
            _loc3_[_loc4_.resourceType] += _loc4_.resourceAmount * param2;
         }
         for(var _loc5_ in _loc3_)
         {
            _totalResourceCosts.push(new ResourceAmountDTO(int(_loc5_),_loc3_[_loc5_]));
         }
         _totalGoldCost = StoreUtil.buildingPriceWithRequirementsVector(_totalResourceCosts,0);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         _fireTrapSilhouette = assetRepository.getDisplayObject("B40Silhouette");
         _buriedSpikesSilhouette = assetRepository.getDisplayObject("B39Silhouette");
         addChild(_fireTrapSilhouette);
         addChild(_buriedSpikesSilhouette);
         var _loc1_:String = "ui.windows.rearm.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _rearmWithResourcesButton = new WomBlueLargeButton();
         var _temp_5:* = _rearmWithResourcesButton;
         var _loc2_:String = "ui.windows.build.useresources";
         _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _rearmWithResourcesButton.width = 210;
         addChild(_rearmWithResourcesButton);
         _rearmWithGoldButton = new WomGreenLargeButton();
         var _temp_7:* = _rearmWithGoldButton;
         var _loc3_:String = "ui.windows.build.buildnow";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _rearmWithGoldButton.setStyle("icon",assetRepository.getDisplayObject("Gold"));
         _rearmWithGoldButton.rightLabel = _totalGoldCost.toString();
         _rearmWithGoldButton.width = 300;
         addChild(_rearmWithGoldButton);
         orIcon = new OrView();
         addChild(orIcon);
         costLabel = new CaptionTextField();
         costLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         var _temp_10:* = costLabel;
         var _loc4_:String = "ui.windows.build.cost";
         _temp_10.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(costLabel);
         _costView = new ResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_totalResourceCosts);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
         costsBackground = assetRepository.getDisplayObject("BackgroundLight");
         costsBackground.width = 500;
         costsBackground.height = 108;
         costsBackground.x = 171;
         costsBackground.y = 51;
         addChild(costsBackground);
      }
      
      public function drawLayout() : void
      {
         _buriedSpikesSilhouette.scaleX = _buriedSpikesSilhouette.scaleY = 0.8;
         _fireTrapSilhouette.scaleX = _fireTrapSilhouette.scaleY = 0.8;
         _rearmWithResourcesButton.enabled = _resourcesSatisfied;
         _buriedSpikesSilhouette.x = 100 - _buriedSpikesSilhouette.width;
         _buriedSpikesSilhouette.y = 175 - _buriedSpikesSilhouette.height;
         AlignmentUtil.alignAccordingToPositionOf(_fireTrapSilhouette,_buriedSpikesSilhouette,80,-25);
         AlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,20,-10);
         AlignmentUtil.alignAccordingToPositionOf(_costView,costsBackground,(costsBackground.width - _costView.width) / 2 << 0,17);
         _rearmWithResourcesButton.x = 96;
         _rearmWithResourcesButton.y = 200 - _rearmWithResourcesButton.height / 2 << 0;
         AlignmentUtil.alignRightOf(_rearmWithGoldButton,_rearmWithResourcesButton,18);
         AlignmentUtil.alignRightWithYMarginOf(orIcon,_rearmWithResourcesButton,11,-11);
      }
      
      public function updateWithResources(param1:Array) : void
      {
         var _loc6_:int = 0;
         var _loc5_:ResourceAmountDTO = null;
         var _loc4_:Boolean = false;
         var _loc3_:Boolean = true;
         _loc6_ = 0;
         while(_loc6_ < _totalResourceCosts.length)
         {
            _loc5_ = _totalResourceCosts[_loc6_];
            _loc4_ = param1[_loc5_.resourceType] >= _loc5_.resourceAmount;
            if(_loc3_)
            {
               _loc3_ = _loc4_;
            }
            for each(var _loc2_ in _costView.resourceViews)
            {
               if(_loc2_.resourceId == _loc5_.resourceType)
               {
                  _loc2_.updateTextFormat(!_loc4_);
               }
            }
            _loc6_++;
         }
         _resourcesSatisfied = _loc3_;
         drawLayout();
      }
      
      public function get rearmWithResourcesButton() : Button
      {
         return _rearmWithResourcesButton;
      }
      
      public function get fireTrapSilhouette() : DisplayObject
      {
         return _fireTrapSilhouette;
      }
      
      public function get buriedSpikesSilhouette() : DisplayObject
      {
         return _buriedSpikesSilhouette;
      }
      
      public function get totalGoldCost() : int
      {
         return _totalGoldCost;
      }
      
      public function get rearmWithGoldButton() : Button
      {
         return _rearmWithGoldButton;
      }
   }
}

