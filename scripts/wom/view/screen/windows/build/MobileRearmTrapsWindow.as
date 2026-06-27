package wom.view.screen.windows.build
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.dto.ResourceAmountDTO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileResourceGroupView;
   import wom.view.ui.common.MobileResourceView;
   import wom.view.util.MobileGenericWindow;
   
   public class MobileRearmTrapsWindow extends MobileGenericWindow
   {
      
      public static const TRAPS_SILHOUTTE_ID:String = "RearmTraps";
      
      private const WINDOW_HEIGHT:int = 271;
      
      private const WINDOW_WIDTH:int = 791;
      
      private var _fireTrapDIO:BuildingTypeDIO;
      
      private var _buriedSpikesDIO:BuildingTypeDIO;
      
      private var _trapsSilhouette:DisplayObject;
      
      private var costsBackground:DisplayObject;
      
      private var costLabel:MPTextField;
      
      private var _costView:MobileResourceGroupView;
      
      private var _rearmWithResourcesButton:MobileWomButton;
      
      private var _rearmWithGoldButton:MobileWomButton;
      
      private var _resourcesSatisfied:Boolean = false;
      
      private var _totalResourceCosts:Vector.<ResourceAmountDTO>;
      
      private var _totalGoldCost:int;
      
      public function MobileRearmTrapsWindow(param1:BuildingTypeDIO, param2:BuildingTypeDIO, param3:int, param4:int, param5:Vector.<WindowEnumeration> = null)
      {
         super(791,271);
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
         var _loc1_:String = "ui.windows.rearm.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _trapsSilhouette = assetRepository.getDisplayObject("RearmTraps");
         addChild(_trapsSilhouette);
         costsBackground = assetRepository.getDisplayObject("MobileDarkBackground");
         costsBackground.width = 509;
         costsBackground.height = 115;
         addChild(costsBackground);
         costLabel = new MobileCaptionTextField();
         costLabel.textRendererProperties.textFormat = getCaptionTextFormat(19);
         var _temp_5:* = costLabel;
         var _loc2_:String = "ui.windows.build.cost";
         _temp_5.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(costLabel);
         _costView = new MobileResourceGroupView(true);
         addChild(_costView);
         _costView.updateWithResources(_totalResourceCosts);
         _rearmWithResourcesButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_8:* = _rearmWithResourcesButton;
         var _loc3_:String = "ui.windows.build.useresources";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _rearmWithResourcesButton.width = 318;
         addChild(_rearmWithResourcesButton);
         _rearmWithGoldButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_10:* = _rearmWithGoldButton;
         var _loc4_:String = "ui.windows.build.buildnow";
         _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _rearmWithGoldButton.defaultIcon = assetRepository.getDisplayObject("IconGoldL");
         _rearmWithGoldButton.rightLabel = _totalGoldCost.toString();
         _rearmWithGoldButton.width = 394;
         addChild(_rearmWithGoldButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(_trapsSilhouette,_background,5,63);
         MobileAlignmentUtil.alignAccordingToPositionOf(costsBackground,_background,219,63);
         MobileAlignmentUtil.alignAccordingToPositionOf(costLabel,costsBackground,22,-(costLabel.height >> 1));
         MobileAlignmentUtil.alignMiddleOf(_costView,costsBackground);
         MobileAlignmentUtil.alignAccordingToPositionOf(_rearmWithResourcesButton,_background,_background.width - _rearmWithResourcesButton.width - 7 - _rearmWithGoldButton.width >> 1,_background.height - (_rearmWithResourcesButton.height >> 1) - 6);
         MobileAlignmentUtil.alignRightOf(_rearmWithGoldButton,_rearmWithResourcesButton,7);
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
      
      public function get rearmWithResourcesButton() : MobileWomButton
      {
         return _rearmWithResourcesButton;
      }
      
      public function get rearmWithGoldButton() : MobileWomButton
      {
         return _rearmWithGoldButton;
      }
      
      public function get totalGoldCost() : int
      {
         return _totalGoldCost;
      }
      
      public function get trapsSilhouette() : DisplayObject
      {
         return _trapsSilhouette;
      }
      
      public function get resourcesSatisfied() : Boolean
      {
         return _resourcesSatisfied;
      }
      
      public function get totalResourceCosts() : Vector.<ResourceAmountDTO>
      {
         return _totalResourceCosts;
      }
   }
}

