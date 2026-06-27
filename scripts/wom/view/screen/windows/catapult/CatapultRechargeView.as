package wom.view.screen.windows.catapult
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.resource.AssetRepository;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import peak.util.DateTimeUtil;
   import wom.model.game.store.StoreUtil;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenMediumButton;
   
   public class CatapultRechargeView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:AssetRepository;
      
      private var _catapultId:int;
      
      private var _catapultAvailable:Boolean;
      
      private var _remainingDuration:Number;
      
      private var catapultTypeAsset:DisplayObject;
      
      private var remainingDurationTF:TextField;
      
      private var _rechargeButton:WomButton;
      
      public function CatapultRechargeView(param1:int, param2:Boolean)
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
         remainingDurationTF = new WomTextField();
         remainingDurationTF.defaultTextFormat = WomTextFormats.FONT_SIZE_18;
         remainingDurationTF.width = 55;
         remainingDurationTF.height = 20;
         var _loc1_:String;
         remainingDurationTF.text = _catapultAvailable ? "" : (_loc1_ = "ui.mainframe.city.tooltip.catapultlocked",peak.i18n.PText.INSTANCE.getText0(_loc1_));
         addChild(remainingDurationTF);
         _rechargeButton = new WomGreenMediumButton();
         var _temp_4:* = _rechargeButton;
         var _loc2_:String = "ui.windows.catapult.recharge";
         _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _rechargeButton.setStyle("icon",assetRepository.getDisplayObject("Gold27"));
         _rechargeButton.width = 155;
         addChild(_rechargeButton);
         drawLayout();
      }
      
      private function createCatapultAsset() : DisplayObject
      {
         var _loc1_:String = "CatapultLumber45";
         if(_catapultId == 2)
         {
            _loc1_ = "CatapultStone45";
         }
         else if(_catapultId == 3)
         {
            _loc1_ = "CatapultMight45";
         }
         var _loc2_:AssetDisplayObject = assetRepository.getDisplayObject(_loc1_);
         _loc2_.alpha = _catapultAvailable ? 1 : 0.5;
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function drawLayout() : void
      {
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(remainingDurationTF,catapultTypeAsset,48);
         AlignmentUtil.alignMiddleYAxisAndWidthAccordingToPositionOf(_rechargeButton,catapultTypeAsset,110);
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
            _rechargeButton.rightLabel = goldCost().toString();
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
      
      public function get rechargeButton() : WomButton
      {
         return _rechargeButton;
      }
      
      public function get remainingDuration() : Number
      {
         return _remainingDuration;
      }
   }
}

