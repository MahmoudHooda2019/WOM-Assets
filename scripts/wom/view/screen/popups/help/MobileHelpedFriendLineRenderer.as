package wom.view.screen.popups.help
{
   import feathers.controls.renderers.IListItemRenderer;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import peak.component.mobile.MPItemRenderer;
   import peak.component.mobile.MPTextField;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import wom.controller.event.ModelUpdateEvent;
   import wom.model.game.Profile;
   import wom.model.game.help.HelpInfo;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.service.facebook.FacebookAPIManager;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   
   public class MobileHelpedFriendLineRenderer extends MPItemRenderer implements IListItemRenderer
   {
      
      protected var _assetRepository:MobileWomAssetRepository;
      
      protected var _facebookAPIManager:FacebookAPIManager;
      
      protected var _helper:Profile;
      
      protected var _helps:Vector.<HelpInfo>;
      
      protected var _background:DisplayObject;
      
      protected var _nameIcon:DisplayObject;
      
      protected var _nameCaption:MobileCaptionTextField;
      
      protected var _helpInfo:HelpInfo;
      
      private var _dataObject:Object;
      
      public function MobileHelpedFriendLineRenderer(param1:MobileWomAssetRepository, param2:FacebookAPIManager)
      {
         super();
         _assetRepository = param1;
         _facebookAPIManager = param2;
         _helpInfo = null;
         _background = param1.getDisplayObject("MobileBeigeBackground");
         _background.width = 480;
         _background.height = 75;
         addChild(_background);
         _nameIcon = param1.getDisplayObject("IconRPL");
         addChild(_nameIcon);
         _nameCaption = new MobileCaptionTextField();
         _nameCaption.textRendererProperties.textFormat = getCaptionTextFormat(33);
         addChild(_nameCaption);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _nameCaption.validate();
         _background.y = 40;
         MobileAlignmentUtil.alignAccordingToPositionOf(_nameIcon,_background,15,-(_nameIcon.height / 2) + 3);
         MobileAlignmentUtil.alignAccordingToPositionOf(_nameCaption,_background,22 + _nameIcon.width,-(_nameCaption.height / 2) + 5);
      }
      
      override public function set data(param1:Object) : void
      {
         var _loc2_:int = 0;
         if(param1)
         {
            _dataObject = param1;
            _helper = param1.helper;
            platformUsersUpdated();
            _helps = param1.helps;
            drawLayout();
            _loc2_ = 80;
            _loc2_ = populateHelpViews(_loc2_);
            _loc2_ += 39;
            _background.height = _loc2_ - 40;
            height = _loc2_;
         }
      }
      
      protected function populateHelpViews(param1:int) : int
      {
         var _loc2_:DisplayObject = null;
         var _loc4_:MPTextField = null;
         for each(var _loc3_ in _helps)
         {
            _helpInfo = _loc3_;
            _loc2_ = _assetRepository.getDisplayObject("SymbolTickDisable");
            addChild(_loc2_);
            _loc4_ = new MobileWomTextField();
            _loc4_.textRendererProperties.textFormat = Languages.activeLanguageId == "ar" ? getWomTextFormat(17,"right") : getWomTextFormat(25);
            _loc4_.width = 400;
            _loc4_.textRendererProperties.wordWrap = true;
            addChild(_loc4_);
            _loc4_.text = determineDescription();
            MobileAlignmentUtil.alignAccordingToPositionOf(_loc2_,_background,25,0);
            _loc2_.y = param1;
            MobileAlignmentUtil.alignRightOf(_loc4_,_loc2_,12);
            _loc4_.validate();
            param1 += Math.max(_loc2_.height,_loc4_.height) + 5;
         }
         return param1;
      }
      
      override public function get data() : Object
      {
         return _dataObject;
      }
      
      protected function determineDescription() : String
      {
         var _loc1_:String = "";
         switch(_helpInfo.helpType - 1)
         {
            case 0:
               var _temp_3:* = "ui.popups.helpedfriend.type.1.desc";
               var _temp_2:* = NumberUtil.numberFormat(_helpInfo.bankedResources.resourceAmount,2,false,false);
               var _loc2_:String = "ui.popups.helpedfriend.type.1.resource." + _helpInfo.bankedResources.resourceType;
               var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc2_);
               var _loc3_:String = "domain.building." + _helpInfo.buildingTypeId + ".name";
               var _loc4_:* = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               var _loc5_:* = _temp_1;
               var _loc6_:String = _temp_2;
               var _loc7_:String = _temp_3;
               _loc1_ = peak.i18n.PText.INSTANCE.getText3(_loc7_,_loc6_,_loc5_,_loc4_);
               break;
            case 1:
               var _temp_5:* = "ui.popups.helpedfriend.type.2";
               var _temp_4:* = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_helpInfo.durationReductionInMillis);
               var _loc8_:String = "domain.building." + _helpInfo.buildingTypeId + ".name";
               var _loc9_:* = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               var _loc10_:String = _temp_4;
               var _loc11_:String = _temp_5;
               _loc1_ = peak.i18n.PText.INSTANCE.getText2(_loc11_,_loc10_,_loc9_);
               break;
            case 2:
               var _temp_7:* = "ui.popups.helpedfriend.type.3";
               var _temp_6:* = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_helpInfo.durationReductionInMillis);
               var _loc12_:String = "domain.building." + _helpInfo.buildingTypeId + ".name";
               var _loc13_:* = peak.i18n.PText.INSTANCE.getText0(_loc12_);
               var _loc14_:String = _temp_6;
               var _loc15_:String = _temp_7;
               _loc1_ = peak.i18n.PText.INSTANCE.getText2(_loc15_,_loc14_,_loc13_);
               break;
            case 3:
               var _temp_9:* = "ui.popups.helpedfriend.type.4";
               var _temp_8:* = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_helpInfo.durationReductionInMillis);
               var _loc16_:String = "domain.building." + _helpInfo.buildingTypeId + ".name";
               var _loc17_:* = peak.i18n.PText.INSTANCE.getText0(_loc16_);
               var _loc18_:String = _temp_8;
               var _loc19_:String = _temp_9;
               _loc1_ = peak.i18n.PText.INSTANCE.getText2(_loc19_,_loc18_,_loc17_);
               break;
            case 4:
               var _temp_10:* = "ui.popups.helpedfriend.type.5";
               var _loc20_:String = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_helpInfo.durationReductionInMillis);
               var _loc21_:String = _temp_10;
               _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc21_,_loc20_);
               break;
            case 5:
               var _temp_11:* = "ui.popups.helpedfriend.type.6";
               var _loc22_:String = DateTimeUtil.getFormattedTimeWithoutCroppingHours(_helpInfo.durationReductionInMillis);
               var _loc23_:String = _temp_11;
               _loc1_ = peak.i18n.PText.INSTANCE.getText1(_loc23_,_loc22_);
         }
         return _loc1_;
      }
      
      public function onPlatformUsersUpdated(param1:ModelUpdateEvent) : void
      {
         platformUsersUpdated();
      }
      
      protected function platformUsersUpdated() : void
      {
         _nameCaption.text = _facebookAPIManager.getUserNameByProfile(_helper,false);
         _nameCaption.validate();
      }
   }
}

