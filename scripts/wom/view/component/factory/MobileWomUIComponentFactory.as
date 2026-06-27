package wom.view.component.factory
{
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import flash.utils.Dictionary;
   import peak.component.mobile.MPBitmapFontTextFormat;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomCarousel;
   import wom.view.component.MobileWomTextInput;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.button.MobileWomMenuButton;
   import wom.view.component.progressbar.MobileNoBgProgressBar;
   import wom.view.component.progressbar.MobileWomProgressBar;
   import wom.view.getCaptionTextFormat;
   
   public class MobileWomUIComponentFactory
   {
      
      public static const HORIZONTAL:String = "horizontal";
      
      public static const VERTICAL:String = "vertical";
      
      public static const BEIGE:String = "Beige";
      
      public static const BLUE:String = "Blue";
      
      public static const DARK_BLUE:String = "DarkBlue";
      
      public static const BROWN:String = "Brown";
      
      public static const GRAY:String = "Gray";
      
      public static const GREEN:String = "Green";
      
      public static const ORANGE:String = "Orange";
      
      public static const RED:String = "Red";
      
      public static const WHITE:String = "White";
      
      public static const YELLOW:String = "Yellow";
      
      public static const MINI:String = "Mini";
      
      public static const SMALL:String = "Small";
      
      public static const MEDIUM:String = "Medium";
      
      public static const LARGE:String = "Large";
      
      public static const IRON:String = "Iron";
      
      public static const LUMBER:String = "Lumber";
      
      public static const MIGHT:String = "Might";
      
      public static const STONE:String = "Stone";
      
      public static const EXPERIENCE:String = "Experience";
      
      public static const RECRUITMENT_CHAMBER:String = "RecruitmentChamber";
      
      public static const CENTRAL_HIRING:String = "CentralHiring";
      
      public static const SIZE_15:String = "15";
      
      public static const SIZE_19:String = "19";
      
      public static const SIZE_26:String = "26";
      
      public static const SIZE_30:String = "30";
      
      public static const SIZE_36:String = "36";
      
      public static const SIZE_65:String = "65";
      
      protected static var progressSkinMap:Dictionary;
      
      private static var assetRepository:MobileWomAssetRepository;
      
      public function MobileWomUIComponentFactory()
      {
         super();
      }
      
      public static function init(param1:MobileWomAssetRepository) : void
      {
         assetRepository = param1;
         progressSkinMap = new Dictionary();
         initMobile();
      }
      
      private static function initWeb() : void
      {
         progressSkinMap["Iron"] = ["IronProgressBarSkin","ResourceBar",0];
         progressSkinMap["Lumber"] = ["LumberProgressBarSkin","ResourceBar",0];
         progressSkinMap["Might"] = ["MightProgressBarSkin","ResourceBar",0];
         progressSkinMap["Stone"] = ["StoneProgressBarSkin","ResourceBar",0];
         progressSkinMap["Experience"] = ["ExperienceProgressBarSkin","ExperienceBar",0];
         progressSkinMap["RecruitmentChamber"] = ["RecruitmentChamberProgressBarSkin","RecruitmentChamberProgressBarTrackSkin",1];
         progressSkinMap["CentralHiring"] = ["ProgressBar65Skin","TransparentBackground",2];
         progressSkinMap["15"] = ["ProgressBar15Skin","ProgressBar15TrackSkin",1];
         progressSkinMap["19"] = ["ProgressBar19Skin","ProgressBar19TrackSkin",2];
         progressSkinMap["26"] = ["ProgressBar26Skin","ProgressBar26TrackSkin",2];
         progressSkinMap["30"] = ["ProgressBar30Skin","ProgressBar30TrackSkin",2];
         progressSkinMap["36"] = ["ProgressBar36Skin","ProgressBar36TrackSkin",2];
         progressSkinMap["65"] = ["ProgressBar65Skin","ProgressBar65TrackSkin",2];
      }
      
      private static function initMobile() : void
      {
         progressSkinMap["Iron"] = ["ProgressBarIronSkin","ProgressBarResourceBackground",0,getCaptionTextFormat(21,"center"),58];
         progressSkinMap["Lumber"] = ["ProgressBarLumberSkin","ProgressBarResourceBackground",0,getCaptionTextFormat(21,"center"),66];
         progressSkinMap["Might"] = ["ProgressBarMightSkin","ProgressBarResourceBackground",0,getCaptionTextFormat(21,"center"),64];
         progressSkinMap["Stone"] = ["ProgressBarStoneSkin","ProgressBarResourceBackground",0,getCaptionTextFormat(21,"center"),64];
         progressSkinMap["Experience"] = ["ProgressBarExperienceSkin","ProgressBarResourceBackground",0,getCaptionTextFormat(21,"center")];
         progressSkinMap["RecruitmentChamber"] = ["ProgressBarMightSkin","ProgressBarResourceBackground",1,getCaptionTextFormat(21,"center")];
         progressSkinMap["CentralHiring"] = ["ProgressBar65Skin","TransparentBackground",2,getCaptionTextFormat(21,"center")];
         progressSkinMap["Blue"] = ["ProgressBarBlueSkin","ProgressBarBackground",1,getCaptionTextFormat(21,"center")];
         progressSkinMap["Green"] = ["ProgressBarGreenSkin","ProgressBarBackground",1,getCaptionTextFormat(21,"center")];
         progressSkinMap["Yellow"] = ["ProgressBarYellowSkin","ProgressBarBackground",1,getCaptionTextFormat(21,"center")];
      }
      
      public static function createCarousel(param1:String, param2:int, param3:int, param4:int) : MobileWomCarousel
      {
         var _loc5_:HorizontalLayout = null;
         var _loc7_:VerticalLayout = null;
         var _loc6_:MobileWomCarousel = new MobileWomCarousel();
         _loc6_.pageWidth = param3;
         _loc6_.pageHeight = param4;
         _loc6_.itemOffset = param2;
         if(param1 == "horizontal")
         {
            _loc5_ = new HorizontalLayout();
            _loc5_.paddingLeft = param2;
            _loc6_.layout = _loc5_;
         }
         else
         {
            _loc7_ = new VerticalLayout();
            _loc7_.paddingTop = param2;
            _loc6_.layout = _loc7_;
         }
         return _loc6_;
      }
      
      public static function createMobileColoredButton(param1:String, param2:String, param3:String = null, param4:String = null) : MobileWomButton
      {
         var _loc5_:MobileWomButton = new MobileWomButton("",param1,param2,determineTextFormat(param2),determineTextMargin(param2),param3,param4);
         _loc5_.iconOffsetY = -2;
         _loc5_.height = determineHeight(param2);
         return _loc5_;
      }
      
      public static function createMenuButton(param1:String, param2:String, param3:String, param4:int = 0, param5:int = 0, param6:String = null) : MobileWomMenuButton
      {
         var _loc7_:MobileWomMenuButton = new MobileWomMenuButton(param1,param2,determineMenuTextFormat(param2),param4,param5,param6);
         if(param3)
         {
            _loc7_.defaultIcon = assetRepository.getDisplayObject(param3);
         }
         _loc7_.height = determineMobileMenuHeight(param2);
         return _loc7_;
      }
      
      public static function createProgressBar(param1:String) : MobileWomProgressBar
      {
         var _loc3_:int = int(progressSkinMap[param1].length > 3 ? progressSkinMap[param1][4] : -1);
         return new MobileWomProgressBar(progressSkinMap[param1][1],progressSkinMap[param1][0],progressSkinMap[param1][2],progressSkinMap[param1][3],_loc3_);
      }
      
      public static function createNoBgProgressBar(param1:String) : MobileNoBgProgressBar
      {
         var _loc3_:int = int(progressSkinMap[param1].length > 3 ? progressSkinMap[param1][4] : -1);
         return new MobileNoBgProgressBar(progressSkinMap[param1][1],progressSkinMap[param1][0],progressSkinMap[param1][2],progressSkinMap[param1][3],_loc3_);
      }
      
      public static function createTextInput(param1:String = "") : MobileWomTextInput
      {
         return new MobileWomTextInput();
      }
      
      public static function addFlipTween(param1:Sprite, param2:Sprite, param3:Boolean, param4:Function, param5:Function = null) : Boolean
      {
         if(Starling.juggler.containsTweens(param1) || Starling.juggler.containsTweens(param2))
         {
            return param3;
         }
         param3 = !param3;
         var _loc6_:Tween = new Tween(param1,0.1);
         var _loc7_:Tween = new Tween(param2,0.1);
         if(param3)
         {
            param1.scaleX = 0.2;
            param1.x = param2.x + 2 * param1.width;
            param2.scaleX = 1;
            _loc6_.delay = 0.1;
            _loc6_.animate("scaleX",1);
            if(Boolean(param5))
            {
               _loc6_.onComplete = param5;
            }
            else
            {
               _loc6_.onComplete = restoreScales;
               _loc6_.onCompleteArgs = [param1,param2];
            }
            _loc6_.moveTo(param1.x - 2 * param1.width,param1.y);
            Starling.juggler.add(_loc6_);
            _loc7_.animate("scaleX",0.2);
            _loc7_.moveTo(param2.width * 0.4,param2.y);
            _loc7_.onComplete = param4;
            Starling.juggler.add(_loc7_);
         }
         else
         {
            param1.scaleX = 1;
            param2.scaleX = 0.2;
            param2.x = param1.x + 2 * param2.width;
            _loc6_.animate("scaleX",0.2);
            _loc6_.moveTo(param1.width * 0.4,param1.y);
            _loc6_.onComplete = param4;
            Starling.juggler.add(_loc6_);
            _loc7_.delay = 0.1;
            _loc7_.animate("scaleX",1);
            if(Boolean(param5))
            {
               _loc7_.onComplete = param5;
            }
            else
            {
               _loc7_.onComplete = restoreScales;
               _loc7_.onCompleteArgs = [param1,param2];
            }
            _loc7_.moveTo(param2.x - 2 * param2.width,param2.y);
            Starling.juggler.add(_loc7_);
         }
         return param3;
      }
      
      private static function restoreScales(param1:Sprite, param2:Sprite) : void
      {
         param1.x = param2.x = Math.min(param1.x,param2.x);
         param1.scaleX = param2.scaleX = 1;
      }
      
      private static function determineTextMargin(param1:String) : int
      {
         switch(param1)
         {
            case "Large":
               return -5;
            case "Medium":
               return -7;
            case "Small":
         }
         return -9;
      }
      
      private static function determineTextFormat(param1:String) : MPBitmapFontTextFormat
      {
         switch(param1)
         {
            case "Large":
               return getCaptionTextFormat(46);
            case "Medium":
               return getCaptionTextFormat(30);
            case "Small":
         }
         return getCaptionTextFormat(23);
      }
      
      private static function determineMenuTextFormat(param1:String) : MPBitmapFontTextFormat
      {
         switch(param1)
         {
            case "Large":
               return getCaptionTextFormat(30);
            case "Medium":
               return getCaptionTextFormat(23);
            case "Small":
               return getCaptionTextFormat(20);
            default:
               return getCaptionTextFormat(23);
         }
      }
      
      private static function determineHeight(param1:String) : int
      {
         return determineMobileHeight(param1);
      }
      
      private static function determineWebHeight(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case "Mini":
               _loc2_ = 21;
               break;
            case "Small":
               _loc2_ = 31;
               break;
            case "Medium":
               _loc2_ = 40;
               break;
            case "Large":
               _loc2_ = 60;
         }
         return _loc2_;
      }
      
      private static function determineMobileHeight(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case "Small":
               _loc2_ = 47;
               break;
            case "Medium":
               _loc2_ = 63;
               break;
            case "Large":
               _loc2_ = 93;
         }
         return _loc2_;
      }
      
      private static function determineMobileMenuHeight(param1:String) : int
      {
         var _loc2_:int = 0;
         switch(param1)
         {
            case "Small":
               _loc2_ = 71;
               break;
            case "Medium":
               _loc2_ = 92;
               break;
            case "Large":
               _loc2_ = 119;
         }
         return _loc2_;
      }
   }
}

