package wom.view.screen.windows.catapult
{
   import flash.utils.Dictionary;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.game.store.StoreUtil;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileWomTextField;
   import wom.view.getWomTextFormat;
   import wom.view.ui.common.MobileCondenseButtonView;
   
   public class MobileCatapultElementRechargeView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _catapultId:int;
      
      private var _catapultAvailable:Boolean;
      
      private var _remainingDuration:Number;
      
      private var catapultTypeAsset:DisplayObject;
      
      private var remainingDurationTF:MPTextField;
      
      private var _rechargeButton:MobileCondenseButtonView;
      
      public function MobileCatapultElementRechargeView(param1:int, param2:Boolean)
      {
         super();
         _catapultId = param1;
         _catapultAvailable = param2;
         _remainingDuration = 0;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         catapultTypeAsset = createCatapultAsset();
         remainingDurationTF = new MobileWomTextField();
         remainingDurationTF.textRendererProperties.textFormat = getWomTextFormat(19);
         remainingDurationTF.width = 55;
         remainingDurationTF.height = 20;
         var _loc1_:String;
         remainingDurationTF.text = _catapultAvailable ? "" : (_loc1_ = "ui.mainframe.city.tooltip.catapultlocked",peak.i18n.PText.INSTANCE.getText0(_loc1_));
         addChild(remainingDurationTF);
         var _temp_4:* = §§findproperty(MobileCondenseButtonView);
         var _temp_3:* = null;
         var _loc2_:String = "ui.windows.catapult.recharge";
         _rechargeButton = new MobileCondenseButtonView(_temp_3,peak.i18n.PText.INSTANCE.getText0(_loc2_),"","IconGoldXS");
         addChild(_rechargeButton);
         _rechargeButton.width = 118;
         drawLayout();
      }
      
      private function createCatapultAsset() : DisplayObject
      {
         var _loc1_:String = "CatapultButtonLumber";
         if(_catapultId == 2)
         {
            _loc1_ = "CatapultButtonStone";
         }
         else if(_catapultId == 3)
         {
            _loc1_ = "CatapultButtonMight";
         }
         var _loc2_:DisplayObject = assetRepository.getDisplayObject(_loc1_);
         _loc2_.alpha = _catapultAvailable ? 1 : 0.5;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(remainingDurationTF,catapultTypeAsset,82);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rechargeButton,catapultTypeAsset,111);
      }
      
      public function updateAvailability(param1:Boolean) : void
      {
         if(_catapultAvailable != param1)
         {
            _catapultAvailable = param1;
            var _loc2_:String;
            var _loc3_:String;
            remainingDurationTF.text = _catapultAvailable ? (_loc2_ = "ui.windows.catapult.ready",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : (_loc3_ = "ui.mainframe.city.tooltip.catapultlocked",peak.i18n.PText.INSTANCE.getText0(_loc3_));
            catapultTypeAsset.alpha = _catapultAvailable ? 1 : 0.5;
            if(!_catapultAvailable)
            {
               _rechargeButton.visible = false;
            }
         }
      }
      
      public function updateDuration(param1:Dictionary) : void
      {
         _remainingDuration = param1[_catapultId].catapultTime;
         updateDurationRelatedFields();
      }
      
      private function updateDurationRelatedFields() : void
      {
         var _loc1_:String;
         var _loc2_:String;
         remainingDurationTF.text = !_catapultAvailable ? (_loc1_ = "ui.mainframe.city.tooltip.catapultlocked",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_remainingDuration == 0 ? (_loc2_ = "ui.windows.catapult.ready",peak.i18n.PText.INSTANCE.getText0(_loc2_)) : DateTimeUtil.getFormattedTime(_remainingDuration).substring(3,8));
         _rechargeButton.visible = !_catapultAvailable ? false : _remainingDuration != 0;
         if(_remainingDuration != 0)
         {
            _rechargeButton.subLabel = goldCost().toString();
         }
      }
      
      public function goldCost() : int
      {
         return Math.ceil(StoreUtil.resourcePrice(_remainingDuration / 10));
      }
      
      public function get catapultId() : int
      {
         return _catapultId;
      }
      
      public function get rechargeButton() : MobileCondenseButtonView
      {
         return _rechargeButton;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
   }
}

