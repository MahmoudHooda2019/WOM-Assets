package wom.view.ui.mainframe.city.tooltip.mobile
{
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.building.BuildingInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileBuildingTooltipProgressInfoView extends Sprite
   {
      
      public static const REPAIR:int = 0;
      
      public static const RECRUIT:int = 1;
      
      public static const HIRE:int = 2;
      
      public static const TRAIN:int = 3;
      
      public static const UPGRADE:int = 4;
      
      public static const FORTIFY:int = 5;
      
      public static const BUILD:int = 6;
      
      public static const CENTRAL_HIRE:int = 7;
      
      public static const I18N_MAP:Dictionary = new Dictionary();
      
      I18N_MAP[0] = "ui.mainframe.city.tooltip.repairedin2";
      I18N_MAP[1] = "ui.mainframe.city.tooltip.recruitedin2";
      I18N_MAP[2] = "ui.mainframe.city.tooltip.hiredin2";
      I18N_MAP[3] = "ui.mainframe.city.tooltip.trainedin2";
      I18N_MAP[4] = "ui.mainframe.city.tooltip.upgradedin2";
      I18N_MAP[5] = "ui.mainframe.city.tooltip.fortifiedin2";
      I18N_MAP[6] = "ui.mainframe.city.tooltip.builtin2";
      I18N_MAP[7] = "ui.mainframe.city.tooltip.hiredin2";
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      public var timeTextField:MobileWomTextField;
      
      public var clock:DisplayObject;
      
      public var progressBar:MobileWomProgressBar;
      
      public var remainingMilliseconds:Number;
      
      private var _type:int;
      
      private var _buildingInfo:BuildingInfo;
      
      public function MobileBuildingTooltipProgressInfoView(param1:int, param2:BuildingInfo)
      {
         super();
         this._type = param1;
         _buildingInfo = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         timeTextField = new MobileWomTextField();
         timeTextField.textRendererProperties.textFormat = getWomTextFormat(21,"right");
         timeTextField.width = 150;
         timeTextField.height = 24;
         addChild(timeTextField);
         timeTextField.text = "";
         if(_type != 7)
         {
            progressBar = MobileWomUIComponentFactory.createProgressBar("Yellow");
            progressBar.align = "center";
            progressBar.width = 150;
            addChild(progressBar);
         }
         clock = assetRepository.getDisplayObject("IconTimerM");
         addChild(clock);
      }
      
      public function drawLayout() : void
      {
         timeTextField.x = timeTextField.y = 0;
         if(_type != 7)
         {
            clock.y = 0;
            MobileAlignmentUtil.alignRightOf(clock,timeTextField,25);
            MobileAlignmentUtil.alignMiddleYAxisOf(timeTextField,clock);
            MobileAlignmentUtil.alignRightOf(progressBar,clock,-12);
            progressBar.y = 8;
         }
         else
         {
            timeTextField.x += clock.width;
            MobileAlignmentUtil.alignLeftOf(clock,timeTextField,10);
            clock.y -= 8;
            timeTextField.y += 4;
         }
      }
      
      public function updateWithData(param1:Number, param2:Number, param3:Number) : void
      {
         updatePartial(param3,false);
         progressBar.maximum = param2;
         progressBar.value = param1;
         var _loc4_:int = param1 / param2 * 100;
         var _temp_2:* = progressBar;
         var _temp_1:* = "ui.common.percentage";
         var _loc5_:int = _loc4_;
         var _loc6_:String = _temp_1;
         _temp_2.label = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         drawLayout();
      }
      
      public function updatePartial(param1:Number, param2:Boolean = true) : void
      {
         this.remainingMilliseconds = param1;
         var _temp_2:* = timeTextField;
         var _temp_1:* = I18N_MAP[_type];
         var _loc3_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(param1) : DateTimeUtil.getFormattedTimeWithoutCroppingHours(param1);
         var _loc4_:* = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         if(param2)
         {
            drawLayout();
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get buildingInfo() : BuildingInfo
      {
         return _buildingInfo;
      }
      
      override public function get height() : Number
      {
         if(_type != 7)
         {
            return 60;
         }
         return 40;
      }
   }
}

