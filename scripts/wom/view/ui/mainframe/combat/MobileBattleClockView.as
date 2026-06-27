package wom.view.ui.mainframe.combat
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.i18n.lang.Languages;
   import peak.util.DateTimeUtil;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileBattleClockView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var clock:DisplayObject;
      
      private var header:MobileCaptionTextField;
      
      private var timer1:MobileCaptionTextField;
      
      private var timer2:MobileCaptionTextField;
      
      private var timer3:MobileCaptionTextField;
      
      private var timer4:MobileCaptionTextField;
      
      private var separator:MobileCaptionTextField;
      
      public function MobileBattleClockView()
      {
         super();
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         drawBackground();
         clock = assetRepository.getDisplayObject("IconTimerM");
         clock.width = clock.height = 30;
         addChild(clock);
         header = new MobileCaptionTextField();
         header.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(header);
         timer1 = createAndAddDecimalTextField();
         timer2 = createAndAddDecimalTextField();
         timer3 = createAndAddDecimalTextField();
         timer4 = createAndAddDecimalTextField();
         separator = createAndAddDecimalTextField(":");
      }
      
      private function drawBackground() : void
      {
         var _loc2_:int = 0;
         var _loc1_:DisplayObject = null;
         background = assetRepository.getDisplayObject("BackgroundTransparentProtectionPanel");
         background.width = 133;
         addChild(background);
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = assetRepository.getDisplayObject("BackgroundCombatCount");
            addChild(_loc1_);
            _loc1_.x = 19 * _loc2_ + 43 + (_loc2_ >= 2 ? 6 : 0);
            _loc1_.y = 8;
            _loc2_++;
         }
      }
      
      private function createAndAddDecimalTextField(param1:String = "") : MobileCaptionTextField
      {
         var _loc2_:MobileCaptionTextField = new MobileCaptionTextField();
         _loc2_.textRendererProperties.textFormat = getCaptionTextFormat(21,"center");
         _loc2_.width = 19;
         _loc2_.height = 20;
         addChild(_loc2_);
         _loc2_.text = param1;
         return _loc2_;
      }
      
      public function drawLayout() : void
      {
         clock.x = 8;
         clock.y = 3;
         if(Languages.activeLanguageId == "ar")
         {
            MobileAlignmentUtil.alignRightOf(header,background,3);
         }
         else
         {
            MobileAlignmentUtil.alignLeftOf(header,background,8);
         }
         header.y = 10;
         MobileAlignmentUtil.alignAccordingToPositionOf(separator,background,72,13);
         timer1.x = 41;
         timer1.y = 13;
         MobileAlignmentUtil.alignRightOf(timer2,timer1,0);
         MobileAlignmentUtil.alignRightOf(timer3,timer2,6);
         MobileAlignmentUtil.alignRightOf(timer4,timer3,0);
      }
      
      public function updateInformation(param1:Boolean, param2:Number) : void
      {
         var _loc5_:String;
         var _loc6_:String;
         header.text = param1 ? (_loc5_ = "ui.mainframe.combat.attackendsin",peak.i18n.PText.INSTANCE.getText0(_loc5_)) : (_loc6_ = "ui.mainframe.combat.deploymentendsin",peak.i18n.PText.INSTANCE.getText0(_loc6_));
         var _loc3_:String = DateTimeUtil.leftPad(DateTimeUtil.getMinutes(param2),2);
         var _loc4_:String = DateTimeUtil.leftPad(DateTimeUtil.getSeconds(param2) % 60,2);
         timer1.text = _loc3_.charAt(0);
         timer2.text = _loc3_.charAt(1);
         timer3.text = _loc4_.charAt(0);
         timer4.text = _loc4_.charAt(1);
         drawLayout();
      }
      
      public function get visibleWidth() : int
      {
         return background.width;
      }
   }
}

