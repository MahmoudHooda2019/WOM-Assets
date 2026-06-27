package wom.view.ui.mainframe.city.tooltip
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import peak.i18n.PText;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class BuildingTooltipHelpView extends Sprite
   {
      
      public static const HELP_BUILD:int = 0;
      
      public static const HELP_FORTIFY:int = 1;
      
      public static const HELP_UPGRADE:int = 2;
      
      public static const HELP_REPAIR:int = 3;
      
      public static const HELP_HARVEST:int = 4;
      
      public static const HELP_RECRUIT:int = 5;
      
      public static const HELP_TRAIN:int = 6;
      
      public static const HELP_WATCHPOST:int = 7;
      
      public var indicator:DisplayObject;
      
      public var nameText:CaptionTextField;
      
      public var helpText:WomTextField;
      
      public var assetRepository:WomAssetRepository;
      
      public var buildingName:String;
      
      public var helpType:int;
      
      public function BuildingTooltipHelpView(param1:String, param2:int, param3:WomAssetRepository)
      {
         super();
         this.helpType = param2;
         this.assetRepository = param3;
         this.buildingName = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
         updateTime(0);
      }
      
      public function initLayout() : void
      {
         nameText = new CaptionTextField(WomTextFormats.BLACK_FILTER_SOFT);
         nameText.defaultTextFormat = WomTextFormats.CENTER_18;
         nameText.width = 180;
         nameText.height = 20;
         nameText.text = buildingName;
         addChild(nameText);
         helpText = new WomTextField();
         helpText.defaultTextFormat = WomTextFormats.CENTER_14;
         helpText.width = 157.5;
         helpText.wordWrap = true;
         helpText.height = 40;
         addChild(helpText);
         switch(helpType)
         {
            case 0:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 1:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 2:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 3:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 4:
               indicator = assetRepository.getDisplayObject("HelpHarvest");
               break;
            case 5:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 6:
               indicator = assetRepository.getDisplayObject("HelpTime");
               break;
            case 7:
               indicator = assetRepository.getDisplayObject("HelpMercenaries");
         }
         addChild(indicator);
         drawLayout();
      }
      
      public function updateTime(param1:Number) : void
      {
         var _loc3_:int = param1 / 1000;
         var _loc2_:int = _loc3_ / 60;
         var _loc5_:int = _loc2_ / 60;
         _loc3_ %= 60;
         _loc2_ %= 60;
         var _loc4_:String = (_loc5_ < 10 ? "0" : "") + _loc5_ + ":" + ((_loc2_ < 10 ? "0" : "") + _loc2_ + ":") + ((_loc3_ < 10 ? "0" : "") + _loc3_);
         switch(helpType)
         {
            case 0:
               var _temp_3:* = helpText;
               var _temp_2:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc6_:String = "ui.mainframe.city.tooltip.helpbuild";
               var _temp_1:* = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               var _loc7_:String = _loc4_;
               var _loc8_:* = _temp_1;
               var _loc9_:String = _temp_2;
               _temp_3.text = peak.i18n.PText.INSTANCE.getText2(_loc9_,_loc8_,_loc7_);
               break;
            case 1:
               var _temp_6:* = helpText;
               var _temp_5:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc10_:String = "ui.mainframe.city.tooltip.helpfortify";
               var _temp_4:* = peak.i18n.PText.INSTANCE.getText0(_loc10_);
               var _loc11_:String = _loc4_;
               var _loc12_:* = _temp_4;
               var _loc13_:String = _temp_5;
               _temp_6.text = peak.i18n.PText.INSTANCE.getText2(_loc13_,_loc12_,_loc11_);
               break;
            case 2:
               var _temp_9:* = helpText;
               var _temp_8:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc14_:String = "ui.mainframe.city.tooltip.helpupgrade";
               var _temp_7:* = peak.i18n.PText.INSTANCE.getText0(_loc14_);
               var _loc15_:String = _loc4_;
               var _loc16_:* = _temp_7;
               var _loc17_:String = _temp_8;
               _temp_9.text = peak.i18n.PText.INSTANCE.getText2(_loc17_,_loc16_,_loc15_);
               break;
            case 3:
               var _temp_12:* = helpText;
               var _temp_11:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc18_:String = "ui.mainframe.city.tooltip.helprepair";
               var _temp_10:* = peak.i18n.PText.INSTANCE.getText0(_loc18_);
               var _loc19_:String = _loc4_;
               var _loc20_:* = _temp_10;
               var _loc21_:String = _temp_11;
               _temp_12.text = peak.i18n.PText.INSTANCE.getText2(_loc21_,_loc20_,_loc19_);
               break;
            case 4:
               var _temp_13:* = helpText;
               var _loc22_:String = "ui.mainframe.city.tooltip.helpharvest";
               _temp_13.text = peak.i18n.PText.INSTANCE.getText0(_loc22_);
               break;
            case 5:
               var _temp_16:* = helpText;
               var _temp_15:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc23_:String = "ui.mainframe.city.tooltip.helprecruit";
               var _temp_14:* = peak.i18n.PText.INSTANCE.getText0(_loc23_);
               var _loc24_:String = _loc4_;
               var _loc25_:* = _temp_14;
               var _loc26_:String = _temp_15;
               _temp_16.text = peak.i18n.PText.INSTANCE.getText2(_loc26_,_loc25_,_loc24_);
               break;
            case 6:
               var _temp_19:* = helpText;
               var _temp_18:* = "ui.mainframe.city.tooltip.helpgeneric";
               var _loc27_:String = "ui.mainframe.city.tooltip.helptrain";
               var _temp_17:* = peak.i18n.PText.INSTANCE.getText0(_loc27_);
               var _loc28_:String = _loc4_;
               var _loc29_:* = _temp_17;
               var _loc30_:String = _temp_18;
               _temp_19.text = peak.i18n.PText.INSTANCE.getText2(_loc30_,_loc29_,_loc28_);
               break;
            case 7:
               var _temp_20:* = helpText;
               var _loc31_:String = "ui.mainframe.city.tooltip.helpwatchpost";
               _temp_20.text = peak.i18n.PText.INSTANCE.getText0(_loc31_);
         }
      }
      
      public function drawLayout() : void
      {
         indicator.x = (180 - indicator.width) / 2;
         indicator.y = -indicator.height * 5 / 8;
         nameText.x = 0;
         nameText.y = 14;
         helpText.x = (180 - helpText.width) / 2;
         helpText.y = 36;
      }
   }
}

