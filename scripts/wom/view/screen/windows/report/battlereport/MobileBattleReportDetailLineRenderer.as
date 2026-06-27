package wom.view.screen.windows.report.battlereport
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPItemRenderer;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   
   public class MobileBattleReportDetailLineRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      private var _assetRepository:MobileWomAssetRepository;
      
      private var _timeTextField:MobileWomTextField;
      
      private var _descTextField:MobileWomTextField;
      
      private var _dataObject:Object;
      
      private var _occurrenceTimeAlreadyCalculated:Boolean;
      
      private var _background:DisplayObject;
      
      private var _icon:DisplayObject;
      
      public function MobileBattleReportDetailLineRenderer(param1:MobileWomAssetRepository, param2:Boolean = false)
      {
         super();
         _assetRepository = param1;
         _occurrenceTimeAlreadyCalculated = param2;
         _background = param1.getDisplayObject("MobileBeigeBackground");
         _background.width = 546;
         _background.height = 50;
         addChild(_background);
         _timeTextField = new MobileWomTextField();
         _timeTextField.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getWomTextFormat(19,"right") : getWomTextFormat(19);
         _timeTextField.width = 75;
         _timeTextField.height = 21;
         addChild(_timeTextField);
         _descTextField = new MobileWomTextField();
         _descTextField.textRendererProperties.wordWrap = true;
         _descTextField.width = 400;
         addChild(_descTextField);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         var _loc1_:int = 0;
         if(Languages.activeLanguageId == "ar")
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_timeTextField,_background,_background.width - _timeTextField.width - 20);
            _loc1_ = 20;
            if(_icon)
            {
               MobileAlignmentUtil.alignLeftOf(_icon,_timeTextField,_loc1_);
               _loc1_ += _icon.width + 20;
            }
            MobileAlignmentUtil.alignLeftOf(_descTextField,_timeTextField,_loc1_);
         }
         else
         {
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_timeTextField,_background,20);
            _loc1_ = 100;
            if(_icon)
            {
               MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_icon,_background,_loc1_);
               _loc1_ += _icon.width + 20;
            }
            MobileAlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_descTextField,_background,_loc1_);
         }
      }
      
      override public function set data(param1:Object) : void
      {
         clear();
         if(param1)
         {
            _dataObject = param1;
            if(param1.hasOwnProperty("occurrenceTimeAlreadyCalculated"))
            {
               _occurrenceTimeAlreadyCalculated = param1.occurrenceTimeAlreadyCalculated;
            }
            else
            {
               _occurrenceTimeAlreadyCalculated = false;
            }
            _descTextField.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getWomTextFormat(19,"right",param1.color) : getWomTextFormat(19,"left",param1.color);
            _descTextField.text = param1.desc;
            var _temp_4:*;
            var _loc2_:*;
            var _loc3_:String;
            _timeTextField.text = _occurrenceTimeAlreadyCalculated ? param1.occurenceTime : (_temp_4 = "ui.windows.battlereport.occurrencetime",_loc2_ = param1.occurenceTime,_loc3_ = _temp_4,peak.i18n.PText.INSTANCE.getText1(_loc3_,_loc2_));
            if(param1.hasOwnProperty("icon"))
            {
               _icon = _assetRepository.getDisplayObject(param1.icon);
               if(param1.hasOwnProperty("iconScale"))
               {
                  _icon.scaleX = _icon.scaleY = param1.iconScale;
               }
               addChild(_icon);
            }
            drawLayout();
            _descTextField.validate();
            _timeTextField.validate();
         }
      }
      
      private function clear() : void
      {
         if(getChildIndex(_icon) != -1)
         {
            removeChild(_icon);
            _icon = null;
         }
      }
      
      override public function get data() : Object
      {
         return _dataObject;
      }
   }
}

