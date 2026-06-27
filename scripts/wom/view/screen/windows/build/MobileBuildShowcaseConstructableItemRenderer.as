package wom.view.screen.windows.build
{
   import feathers.controls.renderers.IListItemRenderer;
   import flash.geom.Point;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildMenuDecorationCategory;
   import wom.model.game.building.BuildingTypeInfo;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileIconLabelViewExtra;
   
   public class MobileBuildShowcaseConstructableItemRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private static const WIDTH:int = 280;
      
      private static const HEIGHT:int = 260;
      
      protected var assetRepository:MobileWomAssetRepository;
      
      protected var background:DisplayObject;
      
      protected var _constructAsset:DisplayObject;
      
      private var _tickAsset:DisplayObject;
      
      protected var constructableNameHeader:MPTextField;
      
      protected var countTextField:MPTextField;
      
      protected var decorationPriceIconLabelView:MobileIconLabelViewExtra;
      
      private var _isDecoration:Boolean;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      private var _buildingTypeInfo:BuildingTypeInfo;
      
      private var _decorationVariationInfo:DecorationVariationInfo;
      
      private var _exclamation:DisplayObject;
      
      private var value:Object;
      
      public function MobileBuildShowcaseConstructableItemRenderer(param1:MobileWomAssetRepository, param2:Boolean = false)
      {
         super();
         this.assetRepository = param1;
         _isDecoration = param2;
         background = param1.getDisplayObject("MobileBeigeBackground");
         background.width = 280;
         background.height = 260 - (_isDecoration ? 22 : 0);
         addChild(background);
         constructableNameHeader = new MobileCaptionTextField();
         constructableNameHeader.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         constructableNameHeader.textRendererProperties.wordWrap = true;
         constructableNameHeader.width = background.width - 20;
         constructableNameHeader.height = 30;
         addChild(constructableNameHeader);
         if(!_isDecoration)
         {
            countTextField = new MobileCaptionTextField();
            countTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
            countTextField.width = background.width;
            countTextField.height = 30;
            addChild(countTextField);
            _tickAsset = param1.getDisplayObject("SymbolTickApproved");
            addChild(_tickAsset);
            _exclamation = param1.getDisplayObject("IconInfoHover");
            addChild(_exclamation);
         }
      }
      
      public function drawLayout() : void
      {
         constructableNameHeader.x = 10;
         constructableNameHeader.y = 20;
         MobileAlignmentUtil.alignMiddleOf(_constructAsset,background);
         if(_isDecoration)
         {
            if(decorationPriceIconLabelView)
            {
               decorationPriceIconLabelView.y = background.height - 60;
               MobileAlignmentUtil.alignMiddleXAxisOf(decorationPriceIconLabelView,background);
            }
            _constructAsset.x += _decorationVariationInfo.dio.mobileUIOffset.x;
            _constructAsset.y += _decorationVariationInfo.dio.mobileUIOffset.y;
         }
         else
         {
            countTextField.y = background.height - 45;
            if(_tickAsset)
            {
               MobileAlignmentUtil.alignMiddleOf(_tickAsset,background);
            }
            if(_exclamation)
            {
               MobileAlignmentUtil.alignMiddleOf(_exclamation,background);
            }
            _constructAsset.x += _buildingTypeDIO.mobileUIOffset.x;
            _constructAsset.y += _buildingTypeDIO.mobileUIOffset.y;
         }
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc2_:Number = NaN;
         this.value = param1;
         if(param1)
         {
            if(_isDecoration)
            {
               _decorationVariationInfo = param1.decorationVariationInfo as DecorationVariationInfo;
               if(_constructAsset)
               {
                  removeChild(_constructAsset);
               }
               if(_decorationVariationInfo.dio.buildMenuDecorationCategory == BuildMenuDecorationCategory.FLAGS)
               {
                  _constructAsset = new MobileFlagSilhouette(_decorationVariationInfo);
               }
               else
               {
                  _constructAsset = assetRepository.getDisplayObject(_decorationVariationInfo.dio.visual + (_decorationVariationInfo.kind ? _decorationVariationInfo.kind : ""));
               }
               _constructAsset.scaleX = _constructAsset.scaleY = 1.5;
               addChildAt(_constructAsset,getChildIndex(constructableNameHeader));
               if(decorationPriceIconLabelView)
               {
                  removeChild(decorationPriceIconLabelView);
               }
               decorationPriceIconLabelView = new MobileIconLabelViewExtra(_decorationVariationInfo.dio.buyWithGold ? "IconGoldS" : "IconRPS",_decorationVariationInfo.dio.buyPrice + "");
               decorationPriceIconLabelView.textSize = 30;
               decorationPriceIconLabelView.textAlign = "left";
               decorationPriceIconLabelView.iconAlign = "left";
               decorationPriceIconLabelView.textMarginFromIconX = 25;
               decorationPriceIconLabelView.textMarginFromIconY = 8;
               addChild(decorationPriceIconLabelView);
               decorationPriceIconLabelView.drawLayout();
            }
            else
            {
               _buildingTypeDIO = param1.dio as BuildingTypeDIO;
               _buildingTypeInfo = param1.typeInfo as BuildingTypeInfo;
               if(_constructAsset)
               {
                  removeChild(_constructAsset);
               }
               _constructAsset = new MobileBuildingSilhouette(_buildingTypeDIO.id,1,new Point(50,50),new Point(280 - 40,260 - 40));
               addChildAt(_constructAsset,getChildIndex(constructableNameHeader));
               countTextField.text = _buildingTypeInfo.currentInstanceCount + "/" + _buildingTypeInfo.maxInstanceCount;
               _loc3_ = !(_buildingTypeInfo.currentInstanceCount < _buildingTypeDIO.maxInstances || _buildingTypeDIO.multibuild && _buildingTypeInfo.currentInstanceCount < _buildingTypeDIO.multipleInstancePrerequisites[_buildingTypeDIO.multipleInstancePrerequisites.length - 1].maxInstances);
               _loc4_ = _buildingTypeInfo.currentInstanceCount == _buildingTypeInfo.maxInstanceCount;
               if(!_loc3_)
               {
                  _tickAsset.visible = false;
                  if(_loc4_)
                  {
                     _exclamation.visible = true;
                     _loc2_ = 0.3;
                  }
                  else
                  {
                     _loc2_ = 1;
                     _exclamation.visible = false;
                  }
               }
               else
               {
                  _tickAsset.visible = true;
                  _exclamation.visible = false;
                  _loc2_ = 0.3;
               }
               _constructAsset.alpha = countTextField.alpha = constructableNameHeader.alpha = _constructAsset.alpha = _loc2_;
            }
            constructableNameHeader.text = getConstructName();
            drawLayout();
         }
      }
      
      override public function get data() : Object
      {
         return value;
      }
      
      protected function getConstructName() : String
      {
         if(_isDecoration)
         {
            var _loc1_:String = "domain.decoration." + _decorationVariationInfo.dio.id + (_decorationVariationInfo.kind ? "." + _decorationVariationInfo.kind : "") + ".name";
            return peak.i18n.PText.INSTANCE.getText0(_loc1_);
         }
         var _loc2_:String = "domain.building." + _buildingTypeDIO.id + ".name";
         return peak.i18n.PText.INSTANCE.getText0(_loc2_);
      }
      
      public function get buildingTypeDIO() : BuildingTypeDIO
      {
         return _buildingTypeDIO;
      }
      
      public function get buildingTypeInfo() : BuildingTypeInfo
      {
         return _buildingTypeInfo;
      }
      
      public function get decorationVariationInfo() : DecorationVariationInfo
      {
         return _decorationVariationInfo;
      }
   }
}

