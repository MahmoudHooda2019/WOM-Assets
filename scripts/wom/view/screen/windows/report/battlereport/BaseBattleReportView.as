package wom.view.screen.windows.report.battlereport
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class BaseBattleReportView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _occurrenceTime:String;
      
      private var _desc:String;
      
      private var _textColor:int;
      
      private var _occurrenceTimeAlreadyCalculated:Boolean;
      
      protected var _background:Sprite;
      
      private var _timeTextField:TextField;
      
      private var _descTextField:TextField;
      
      public function BaseBattleReportView(param1:String, param2:String, param3:int, param4:Boolean = false)
      {
         super();
         _occurrenceTime = param1;
         _desc = param2;
         _textColor = param3;
         _occurrenceTimeAlreadyCalculated = param4;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         _background = assetRepository.getDisplayObject("BackgroundLight");
         _background.width = 502;
         _background.height = 31;
         addChild(_background);
         _timeTextField = new WomTextField();
         _timeTextField.defaultTextFormat = Languages.activeLanguageId == "ar" ? WomTextFormats.FONT_SIZE_18 : WomTextFormats.RIGHT_18;
         _timeTextField.width = 75;
         _timeTextField.height = 21;
         addChild(_timeTextField);
         var _temp_3:*;
         var _loc1_:String;
         var _loc2_:String;
         _timeTextField.text = _occurrenceTimeAlreadyCalculated ? _occurrenceTime : (_temp_3 = "ui.windows.battlereport.occurrencetime",_loc1_ = _occurrenceTime,_loc2_ = _temp_3,peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_));
         _descTextField = new WomTextField();
         _descTextField.defaultTextFormat = Languages.activeLanguageId == "ar" ? WomTextFormats.RIGHT_18 : WomTextFormats.FONT_SIZE_18;
         _descTextField.multiline = true;
         _descTextField.wordWrap = true;
         _descTextField.textColor = _textColor;
         _descTextField.autoSize = "left";
         _descTextField.width = 400;
         addChild(_descTextField);
         _descTextField.text = _desc;
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(Languages.activeLanguageId == "ar")
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_timeTextField,_background,420);
            AlignmentUtil.alignLeftOf(_descTextField,_timeTextField,2);
         }
         else
         {
            AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_timeTextField,_background,3);
            AlignmentUtil.alignRightOf(_descTextField,_timeTextField,2);
         }
      }
   }
}

