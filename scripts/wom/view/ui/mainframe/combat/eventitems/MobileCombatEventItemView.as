package wom.view.ui.mainframe.combat.eventitems
{
   import peak.component.mobile.MPButton;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.ui.common.MobileMercenaryButtonView;
   
   public class MobileCombatEventItemView extends MobileMercenaryButtonView
   {
      
      private var _used:Boolean;
      
      private var _amount:int;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var _shieldIcon:DisplayObject;
      
      private var _levelTextField:MobileCaptionTextField;
      
      public function MobileCombatEventItemView(param1:EventItemDIO, param2:int)
      {
         super(null);
         _eventItemDIO = param1;
         _amount = param2;
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         _mercButton.isToggle = true;
         _used = false;
         updateItemCount(_amount);
         _shieldIcon = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         _shieldIcon.touchable = false;
         _shieldIcon.visible = false;
         _shieldIcon.width *= 37 / _shieldIcon.width;
         _shieldIcon.height *= 37 / _shieldIcon.height;
         addChild(_shieldIcon);
         _levelTextField = new MobileCaptionTextField();
         _levelTextField.touchable = false;
         _levelTextField.visible = false;
         _levelTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(_levelTextField);
      }
      
      override public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleOf(_levelTextField,_shieldIcon);
         _levelTextField.x -= 1;
         _levelTextField.y += 2;
         super.drawLayout();
      }
      
      override protected function initMercPortrait() : void
      {
         _mercenaryPortrait = assetRepository.getDisplayObject(_eventItemDIO.assetName.substring(0,_eventItemDIO.assetName.length - 4) + "Portrait");
      }
      
      public function updateItemCount(param1:int) : void
      {
         _amount = param1;
         if(param1 >= 0)
         {
            selectionStatusText = param1.toString();
         }
         updateItemEnabling(param1 > 0);
      }
      
      public function updateSelection(param1:Boolean) : void
      {
         _mercButton.isSelected = param1;
         updateFilters();
      }
      
      public function updateItemUsed(param1:Boolean) : void
      {
         _used = param1;
         if(param1 && _selectionStatusTextField)
         {
            var _loc2_:String = "ui.mainframe.combat.eventitems.used";
            selectionStatusText = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         }
         updateItemEnabling(!param1);
      }
      
      public function updateItemEnabling(param1:Boolean) : void
      {
         _mercButton.isEnabled = param1;
         _mercButton.touchable = true;
         _mercButton.alpha = param1 ? 1 : 0.5;
      }
      
      public function updateFilters() : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _mercButton.isSelected;
      }
      
      public function get used() : Boolean
      {
         return _used;
      }
      
      public function get enabled() : Boolean
      {
         return _mercButton.isEnabled;
      }
      
      public function get background() : MPButton
      {
         return _mercButton;
      }
      
      public function get eventItemDIO() : EventItemDIO
      {
         return _eventItemDIO;
      }
      
      public function get shieldIcon() : DisplayObject
      {
         return _shieldIcon;
      }
      
      public function get levelTextField() : MobileCaptionTextField
      {
         return _levelTextField;
      }
   }
}

