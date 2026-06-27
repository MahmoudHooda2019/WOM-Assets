package wom.view.screen.windows.event
{
   import fl.controls.ProgressBar;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.game.event.EventStoreItemInfo;
   import wom.model.game.window.WindowEnumeration;
   
   public class CatapultEventStoreItemWindow extends BaseEventStoreItemWindow
   {
      
      private var durationLabel:TextField;
      
      private var durationTextField:TextField;
      
      private var durationProgressBar:ProgressBar;
      
      private var damageLabel:TextField;
      
      private var damageTextField:TextField;
      
      private var damageProgressBar:ProgressBar;
      
      private var rangeLabel:TextField;
      
      private var rangeTextField:TextField;
      
      private var rangeProgressBar:ProgressBar;
      
      public function CatapultEventStoreItemWindow(param1:EventStoreItemInfo, param2:Vector.<WindowEnumeration> = null)
      {
         super(param1,param2);
      }
      
      override protected function initWindowLayout() : void
      {
         super.initWindowLayout();
         damageLabel = createLabel("damage");
         durationLabel = createLabel("duration");
         rangeLabel = createLabel("range");
         durationProgressBar = createProgressBar();
         damageProgressBar = createProgressBar();
         rangeProgressBar = createProgressBar();
         durationTextField = createProgressBarTextField();
         damageTextField = createProgressBarTextField();
         rangeTextField = createProgressBarTextField();
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(durationLabel,itemDetailsBackground,0,177);
         AlignmentUtil.alignBelowOf(damageLabel,durationLabel,13);
         AlignmentUtil.alignBelowOf(rangeLabel,damageLabel,13);
         AlignmentUtil.alignRightWithYMarginOf(durationProgressBar,durationLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(damageProgressBar,damageLabel,-4,10);
         AlignmentUtil.alignRightWithYMarginOf(rangeProgressBar,rangeLabel,-4,10);
         AlignmentUtil.alignRightOf(durationTextField,durationLabel,17);
         AlignmentUtil.alignRightOf(damageTextField,damageLabel,17);
         AlignmentUtil.alignRightOf(rangeTextField,rangeLabel,17);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unlockButton,_background,_windowHeight - (_unlockButton.height >> 1));
      }
      
      public function updateWithCatapultInfo(param1:int, param2:int, param3:int, param4:int) : void
      {
         durationProgressBar.setProgress(100,100);
         damageProgressBar.setProgress(100,100);
         rangeProgressBar.setProgress(100,100);
         durationTextField.text = param1 + "";
         damageTextField.text = param2 + "";
         rangeTextField.text = param3 + "";
         if(param4 == 6)
         {
            var _temp_1:* = damageLabel;
            var _loc5_:String = "ui.windows.eventstore.heal";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc5_);
         }
         else
         {
            var _temp_2:* = damageLabel;
            var _loc6_:String = "ui.windows.eventstore.damage";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
         }
         drawLayout();
      }
   }
}

