package wom.view.screen.windows.recruitmentchamber
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.component.PButton;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import wom.model.domain.domaininfoobject.UnitTypeDIO;
   import wom.model.game.unit.UnitTypeInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   
   public class RecruitmentChamberMercenaryListView extends PButton
   {
      
      private static const LOCKED:int = 0;
      
      private static const UNLOCKING:int = 1;
      
      private static const UNLOCKED:int = 2;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _unitTypeDIO:UnitTypeDIO;
      
      private var _unitTypeInfo:UnitTypeInfo;
      
      private var _index:int;
      
      private var _state:int;
      
      private var unitNameTextField:TextField;
      
      private var checkIcon:DisplayObject;
      
      private var lockIcon:DisplayObject;
      
      private var clockIcon:DisplayObject;
      
      private var lockedStatusTextField:TextField;
      
      private var remainingTimeTextField:TextField;
      
      public function RecruitmentChamberMercenaryListView(param1:UnitTypeDIO, param2:int)
      {
         super();
         _unitTypeDIO = param1;
         _index = param2;
         _state = 0;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      protected function initLayout() : void
      {
         toggle = true;
         mouseChildren = false;
         var _loc3_:DisplayObject = assetRepository.getDisplayObject("RecruitmentChamber1LockedNormalBackground");
         _loc3_.width = 220;
         _loc3_.height = 47;
         var _loc2_:DisplayObject = assetRepository.getDisplayObject("RecruitmentChamber1LockedHoverBackground");
         _loc3_.width = 220;
         _loc3_.height = 47;
         var _loc1_:DisplayObject = assetRepository.getDisplayObject("RecruitmentChamber1LockedHoverBackground");
         _loc3_.width = 220;
         _loc3_.height = 47;
         setStyle("upSkin",_loc3_);
         setStyle("overSkin",_loc2_);
         setStyle("downSkin",_loc2_);
         setStyle("selectedUpSkin",_loc1_);
         setStyle("selectedOverSkin",_loc1_);
         setStyle("selectedDownSkin",_loc1_);
         unitNameTextField = new CaptionTextField();
         unitNameTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         unitNameTextField.height = 18;
         unitNameTextField.width = 200;
         var _temp_4:* = unitNameTextField;
         var _loc4_:String = "domain.units." + _unitTypeDIO.id + ".name";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         addChild(unitNameTextField);
         lockedStatusTextField = new WomTextField();
         lockedStatusTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         lockedStatusTextField.height = 18;
         lockedStatusTextField.width = 200;
         addChild(lockedStatusTextField);
         remainingTimeTextField = new WomTextField();
         remainingTimeTextField.defaultTextFormat = WomTextFormats.CENTER_14;
         remainingTimeTextField.width = 55;
         remainingTimeTextField.height = 16;
         remainingTimeTextField.visible = false;
         addChild(remainingTimeTextField);
         checkIcon = assetRepository.getDisplayObject("RecruitmentChamberCheckIcon");
         addChild(checkIcon);
         lockIcon = assetRepository.getDisplayObject("RecruitmentChamberLockIcon");
         addChild(lockIcon);
         clockIcon = assetRepository.getDisplayObject("RecruitmentChamberTimeIconSmall");
         addChild(clockIcon);
      }
      
      override protected function drawLayout() : void
      {
         super.drawLayout();
         background.width = 220;
         background.height = 47;
      }
      
      private function drawButtonLayout() : void
      {
         if(background)
         {
            background.width = 220;
         }
         unitNameTextField.x = 8;
         unitNameTextField.y = 6;
         lockedStatusTextField.y = 24;
         lockedStatusTextField.x = 9;
         if(_unitTypeInfo.recruited)
         {
            var _temp_1:* = lockedStatusTextField;
            var _loc1_:String = "ui.windows.recruitmentchamber.unlocked";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc1_);
            checkIcon.x = 185;
            checkIcon.y = 11;
            checkIcon.visible = true;
            lockIcon.visible = false;
            remainingTimeTextField.visible = clockIcon.visible = false;
         }
         else if(_unitTypeInfo.currentlyRecruiting)
         {
            var _temp_2:* = lockedStatusTextField;
            var _loc2_:String = "ui.windows.recruitmentchamber.unlocking";
            _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
            clockIcon.x = 185;
            clockIcon.y = 6;
            remainingTimeTextField.x = this.width - remainingTimeTextField.width - 8;
            remainingTimeTextField.y = 26;
            checkIcon.visible = false;
            lockIcon.visible = false;
            remainingTimeTextField.visible = clockIcon.visible = true;
         }
         else
         {
            var _temp_3:* = lockedStatusTextField;
            var _loc3_:String = "ui.windows.recruitmentchamber.locked";
            _temp_3.text = peak.i18n.PText.INSTANCE.getText0(_loc3_);
            lockIcon.x = 185;
            lockIcon.y = 10;
            checkIcon.visible = false;
            lockIcon.visible = true;
            remainingTimeTextField.visible = clockIcon.visible = false;
         }
      }
      
      public function updateUnit(param1:UnitTypeInfo) : void
      {
         _unitTypeInfo = param1;
         _state = _unitTypeInfo.recruited ? 2 : (_unitTypeInfo.currentlyRecruiting ? 1 : 0);
         updateButtonStyles();
         drawButtonLayout();
      }
      
      private function updateButtonStyles() : void
      {
         var _loc3_:String = "";
         var _loc2_:String = "";
         var _loc5_:String = "";
         switch(_state)
         {
            case 0:
               _loc3_ = "RecruitmentChamber1LockedNormalBackground";
               _loc2_ = "RecruitmentChamber1LockedHoverBackground";
               _loc5_ = "RecruitmentChamber1LockedSelectedBackground";
               break;
            case 1:
               _loc3_ = "RecruitmentChamber1UnLockingNormalBackground";
               _loc2_ = "RecruitmentChamber1UnLockingHoverBackground";
               _loc5_ = "RecruitmentChamber1UnLockingSelectedBackground";
               break;
            case 2:
               _loc3_ = "RecruitmentChamber1UnLockedNormalBackground";
               _loc2_ = "RecruitmentChamber1UnLockedHoverBackground";
               _loc5_ = "RecruitmentChamber1UnLockedSelectedBackground";
         }
         var _loc6_:DisplayObject = assetRepository.getDisplayObject(_loc3_);
         _loc6_.width = 220;
         _loc6_.height = 47;
         var _loc4_:DisplayObject = assetRepository.getDisplayObject(_loc2_);
         _loc6_.width = 220;
         _loc6_.height = 47;
         var _loc1_:DisplayObject = assetRepository.getDisplayObject(_loc5_);
         _loc6_.width = 220;
         _loc6_.height = 47;
         setStyle("upSkin",_loc6_);
         setStyle("overSkin",_loc4_);
         setStyle("downSkin",_loc4_);
         setStyle("selectedUpSkin",_loc1_);
         setStyle("selectedOverSkin",_loc1_);
         setStyle("selectedDownSkin",_loc1_);
      }
      
      public function get unitTypeDIO() : UnitTypeDIO
      {
         return _unitTypeDIO;
      }
      
      public function get unitTypeInfo() : UnitTypeInfo
      {
         return _unitTypeInfo;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function updateRemainingTime(param1:Number) : void
      {
         remainingTimeTextField.text = DateTimeUtil.getFormattedTime(param1);
         remainingTimeTextField.x = 220 - remainingTimeTextField.width - 5;
      }
   }
}

