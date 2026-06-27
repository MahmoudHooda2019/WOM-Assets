package wom.view.screen.windows.blacksmith
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import wom.model.domain.domaininfoobject.EventItemDIO;
   import wom.model.game.event.EventItemType;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.util.BaseWindowPanel;
   
   public class EventItemInfoPanel extends BaseWindowPanel
   {
      
      private static const WIDTH:int = 287;
      
      private static const HEIGHT:int = 203;
      
      private var eventItemAsset:DisplayObject;
      
      private var _eventItemDIO:EventItemDIO;
      
      private var eventItemNameLabel:CaptionTextField;
      
      private var eventItemDescriptionTextField:WomTextField;
      
      private var _shieldIcon:DisplayObject;
      
      private var _currentLevelTextField:TextField;
      
      private var eventItemDetailsView:BaseEventItemDetailsView;
      
      public function EventItemInfoPanel()
      {
         super(287,203);
      }
      
      override public function initLayout() : void
      {
         super.initLayout();
         if(_eventItemDIO != null)
         {
            eventItemAsset = assetRepository.getDisplayObject(_eventItemDIO.assetName + "Medium");
            eventItemAsset.width = 99;
            eventItemAsset.height = 99;
            addChild(eventItemAsset);
         }
         eventItemNameLabel = new CaptionTextField(WomTextFormats.LIGHT_BROWN_FILTER);
         eventItemNameLabel.defaultTextFormat = WomTextFormats.FONT_SIZE_16;
         eventItemNameLabel.autoSize = "left";
         addChild(eventItemNameLabel);
         eventItemDescriptionTextField = new WomTextField();
         eventItemDescriptionTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_16_SHORT_LEADING;
         eventItemDescriptionTextField.defaultTextFormat.leading = -2;
         eventItemDescriptionTextField.multiline = true;
         eventItemDescriptionTextField.wordWrap = true;
         eventItemDescriptionTextField.width = 160;
         eventItemDescriptionTextField.height = 73;
         addChild(eventItemDescriptionTextField);
         _shieldIcon = assetRepository.getDisplayObject("MercenaryLevel41Px");
         addChild(_shieldIcon);
         _currentLevelTextField = new CaptionTextField();
         _currentLevelTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_30;
         _currentLevelTextField.autoSize = "left";
         addChild(_currentLevelTextField);
      }
      
      override public function drawLayout() : void
      {
         super.drawLayout();
         AlignmentUtil.alignAccordingToPositionOf(eventItemNameLabel,bg,116,-2);
         AlignmentUtil.alignBelowOf(eventItemDescriptionTextField,eventItemNameLabel,3);
         if(eventItemDetailsView != null)
         {
            AlignmentUtil.alignAccordingToPositionOf(eventItemDetailsView,bg,0,110);
         }
         AlignmentUtil.alignAccordingToPositionOf(_shieldIcon,bg,-20,-14);
         AlignmentUtil.alignAccordingToPositionOf(_currentLevelTextField,_shieldIcon,17,1);
      }
      
      public function updateInfoPanel(param1:EventItemDIO, param2:UnitTypeInfo) : void
      {
         _eventItemDIO = param1;
         if(eventItemAsset != null)
         {
            if(contains(eventItemAsset))
            {
               removeChild(eventItemAsset);
            }
         }
         eventItemAsset = assetRepository.getDisplayObject(_eventItemDIO.assetName + "Medium");
         eventItemAsset.width = 99;
         eventItemAsset.height = 99;
         addChild(eventItemAsset);
         var _temp_3:* = eventItemNameLabel;
         var _loc3_:String = "ui.windows.store.items." + _eventItemDIO.id + ".name";
         _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         var _temp_4:* = eventItemDescriptionTextField;
         var _loc4_:String = "ui.windows.blacksmith.items." + _eventItemDIO.id + ".desc";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         if(param2)
         {
            _currentLevelTextField.text = param2.currentLevel + "";
         }
         if(_shieldIcon && contains(_shieldIcon))
         {
            setChildIndex(_shieldIcon,numChildren - 1);
         }
         if(_currentLevelTextField && contains(_currentLevelTextField))
         {
            setChildIndex(_currentLevelTextField,numChildren - 1);
         }
         _shieldIcon.visible = _currentLevelTextField.visible = _eventItemDIO.itemType == EventItemType.MERCENARY.id;
         updateDetails(_eventItemDIO);
      }
      
      private function updateDetails(param1:EventItemDIO) : void
      {
         if(eventItemDetailsView != null)
         {
            if(contains(eventItemDetailsView))
            {
               removeChild(eventItemDetailsView);
            }
         }
         switch(param1.itemType)
         {
            case EventItemType.MERCENARY.id:
               eventItemDetailsView = new UnitEventItemDetailsView(param1);
               break;
            case EventItemType.CATAPULT.id:
               eventItemDetailsView = new CatapultEventItemDetailsView(param1);
         }
         addChild(eventItemDetailsView);
         drawLayout();
      }
      
      override protected function get backgroundAssetId() : String
      {
         return "TransparentAsset";
      }
   }
}

