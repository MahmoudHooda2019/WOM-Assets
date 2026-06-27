package wom.view.ui.mainframe.city.tooltip.mobile
{
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.domain.domaininfoobject.BuildingSpecificInfoType;
   import wom.model.domain.domaininfoobject.BuildingTypeDIO;
   import wom.model.game.building.BuildingInfo;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.tooltip.MobileBaseTooltipView;
   
   public class MobileBaseBuildingTooltipView extends MobileBaseTooltipView
   {
      
      private var spyIcon:DisplayObject;
      
      private var levelIcon:DisplayObject;
      
      private var levelTextField:MobileCaptionTextField;
      
      private var buildingNameTextField:MobileCaptionTextField;
      
      private var headerSprite:Sprite;
      
      private var _buildingInfoView:Sprite = createBuildingInfoView();
      
      private var _buildingInfo:BuildingInfo;
      
      private var _buildingTypeDIO:BuildingTypeDIO;
      
      public function MobileBaseBuildingTooltipView(param1:BuildingInfo, param2:BuildingTypeDIO)
      {
         _buildingInfo = param1;
         _buildingTypeDIO = param2;
         if(!_buildingInfoView)
         {
            _viewHeight = 88;
         }
         super(_viewWidth,_viewHeight,false);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         spyIcon = assetRepository.getDisplayObject("IconSpyM");
         addChild(spyIcon);
         headerSprite = new Sprite();
         addChild(headerSprite);
         levelIcon = assetRepository.getDisplayObject("IconLevelM");
         headerSprite.addChild(levelIcon);
         levelTextField = new MobileCaptionTextField();
         levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(30);
         headerSprite.addChild(levelTextField);
         levelTextField.text = "" + _buildingInfo.level;
         buildingNameTextField = new MobileCaptionTextField();
         buildingNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(23);
         headerSprite.addChild(buildingNameTextField);
         var _temp_6:* = buildingNameTextField;
         var _loc1_:String = "domain.building." + _buildingInfo.buildingTypeId + ".name";
         _temp_6.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         if(_buildingInfoView)
         {
            addChild(_buildingInfoView);
         }
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(spyIcon,_bg,-spyIcon.height >> 1);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelTextField,levelIcon,(levelIcon.width - levelTextField.width >> 1) - 2,13);
         MobileAlignmentUtil.alignAccordingToPositionOf(buildingNameTextField,levelIcon,levelIcon.width + 2,16);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(headerSprite,_bg,18);
         if(_buildingInfoView)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_buildingInfoView,_bg,80);
         }
      }
      
      private function createBuildingInfoView() : Sprite
      {
         var _loc1_:String = null;
         var _loc3_:* = null;
         _viewWidth = 286;
         var _loc2_:int = 0;
         if(_buildingTypeDIO.id == 39 || _buildingTypeDIO.id == 40)
         {
            _viewHeight = 157;
            return new MobileBuildingTooltipWithOneProgressInfoView(0,_buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGE.id],true);
         }
         if(_buildingTypeDIO.kind.id == 26)
         {
            _viewHeight = 157;
            return new MobileBuildingTooltipWithOneProgressInfoView(1,_buildingTypeDIO.healthPointsPerLevel[_buildingInfo.level == 0 ? 0 : _buildingInfo.level - 1],true);
         }
         if(_buildingTypeDIO.id == 45)
         {
            _viewHeight = 240;
            _loc2_ = _buildingInfo.level > 0 ? _buildingInfo.level - 1 : 0;
            return new MobileBuildingTooltipBeastCannonInfoView(_buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][_loc2_],_buildingTypeDIO.healthPointsPerLevel[_loc2_],_buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.BEAST_CANNON_MAX_AMMUNITION.id],true);
         }
         if(_buildingTypeDIO.kind.id == 28)
         {
            _viewHeight = 200;
            _loc2_ = _buildingInfo.level > 0 ? _buildingInfo.level - 1 : 0;
            return new MobileBuildingTooltipDefenseInfoView(_buildingTypeDIO.buildingSpecificInfo[BuildingSpecificInfoType.DAMAGES_PER_SHOT_PER_LEVEL.id][_loc2_],_buildingTypeDIO.healthPointsPerLevel[_loc2_],true);
         }
         if(_buildingTypeDIO.kind.id == 11 || _buildingTypeDIO.kind.id == 12)
         {
            _viewHeight = 174;
            switch(_buildingInfo.buildingTypeId - 11)
            {
               case 0:
                  _loc1_ = "ResourceIconLumber";
                  break;
               case 1:
                  _loc1_ = "ResourceIconMight";
                  break;
               case 2:
                  _loc1_ = "ResourceIconStone";
                  break;
               case 3:
                  _loc1_ = "ResourceIconIron";
                  break;
               case 4:
                  _loc1_ = "ResourceIconLumber";
            }
            return new MobileBuildingTooltipProductionProgressInfoView(_loc1_,_buildingInfo,_buildingTypeDIO,true);
         }
         if(_buildingTypeDIO.id == 23)
         {
            _viewHeight = 174;
            return new MobileBuildingTooltipCatapultInfoView(_buildingInfo.level);
         }
         if(_buildingInfo.buildingTypeId == 19 || _buildingInfo.buildingTypeId == 43 || _buildingInfo.buildingTypeId == 37 || _buildingInfo.buildingTypeId == 38)
         {
            _viewHeight = 174;
            return new MobileBuildingTooltipHousingInfoView(0,_buildingInfo,true);
         }
         if(_buildingInfo.buildingTypeId == 10)
         {
            _viewHeight = 174;
            return new MobileBuildingTooltipProductionProgressInfoView("IconGoldM",_buildingInfo,_buildingTypeDIO,true);
         }
         if(_buildingInfo.buildingTypeId == 29)
         {
            _viewHeight = 124;
            return new MobileBuildingTooltipBeastCaveInfoView(true);
         }
         return null;
      }
   }
}

