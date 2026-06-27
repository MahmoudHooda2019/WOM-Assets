package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar15;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class BuildingTooltipProgressView extends Sprite
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
      
      public var timeTextField:WomTextField;
      
      public var clock:DisplayObject;
      
      public var progressBar:MaskedProgressBar;
      
      public var assetRepository:WomAssetRepository;
      
      public var remainingMilliseconds:Number;
      
      public var type:int;
      
      public function BuildingTooltipProgressView(param1:int, param2:WomAssetRepository)
      {
         super();
         this.type = param1;
         this.assetRepository = param2;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         timeTextField = new WomTextField();
         timeTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         timeTextField.autoSize = "left";
         addChild(timeTextField);
         timeTextField.text = "";
         if(type != 7)
         {
            progressBar = new ProgressBar15();
            progressBar.align = "center";
            progressBar.width = 180 - 70;
            addChild(progressBar);
         }
         clock = assetRepository.getDisplayObject("Clock45");
         clock.width *= 0.7;
         clock.height *= 0.7;
         addChild(clock);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         clock.x = 25;
         clock.y = 5;
         timeTextField.x = 180 - timeTextField.width >> 1;
         timeTextField.y = 33;
         if(type != 7)
         {
            progressBar.x = 40;
            progressBar.y = clock.y + (clock.height - 15 >> 1);
         }
         else
         {
            clock.x = 13;
            clock.y = 14;
            AlignmentUtil.alignRightOf(timeTextField,clock,2);
            timeTextField.y = clock.y + (clock.height - timeTextField.textHeight >> 1) - 2;
         }
      }
      
      public function updateWithData(param1:Number, param2:Number, param3:Number) : void
      {
         updatePartial(param3,false);
         progressBar.setProgress(clock.width / 2 * param2 / progressBar.width + param1 * (progressBar.width - clock.width / 2) / progressBar.width,param2);
         var _loc4_:int = param1 / param2 * 100;
         var _temp_2:* = progressBar;
         var _temp_1:* = "ui.common.percentage";
         var _loc5_:int = _loc4_;
         var _loc6_:String = _temp_1;
         _temp_2.progressText = peak.i18n.PText.INSTANCE.getText1(_loc6_,_loc5_);
         drawLayout();
      }
      
      public function updatePartial(param1:Number, param2:Boolean = true) : void
      {
         this.remainingMilliseconds = param1;
         var _temp_2:* = timeTextField;
         var _temp_1:* = I18N_MAP[type];
         var _loc3_:String = Languages.activeLanguageId == "ar" ? LocalizedDateTimeUtil.getUserFriendlyTime(param1) : DateTimeUtil.getFormattedTimeWithoutCroppingHours(param1);
         var _loc4_:* = _temp_1;
         _temp_2.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         if(param2)
         {
            drawLayout();
         }
      }
   }
}

