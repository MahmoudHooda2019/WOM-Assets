package wom.view.ui.mainframe.city
{
   import peak.component.mobile.MPButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.starling.FlatteningSprite;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.MobileWomTextField;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   import wom.view.getWomTextFormat;
   import wom.view.util.LocalizedDateTimeUtil;
   
   public class MobileNPCAttackCountDownPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var background:DisplayObject;
      
      private var counterLabel:MPTextField;
      
      private var counterTextField:MPTextField;
      
      private var _engageButton:MPButton;
      
      public function MobileNPCAttackCountDownPanel()
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
         visible = false;
         background = assetRepository.getDisplayObject("MobileRedBackground");
         background.width = 383;
         background.height = 80;
         addChild(background);
         counterLabel = new MobileWomTextField();
         counterLabel.width = 162;
         counterLabel.textRendererProperties.textFormat = getWomTextFormat(21,"right",16777215);
         var _temp_5:* = counterLabel;
         var _temp_4:* = "ui.mainframe.city.attackcomesin";
         var _loc1_:String = "";
         var _loc2_:String = _temp_4;
         _temp_5.text = peak.i18n.PText.INSTANCE.getText1(_loc2_,_loc1_);
         addChild(counterLabel);
         counterTextField = new MobileCaptionTextField();
         counterTextField.width = 71;
         counterTextField.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(counterTextField);
         _engageButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Medium");
         _engageButton.width = 139;
         var _temp_8:* = _engageButton;
         var _loc3_:String = "ui.mainframe.city.engage";
         _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         addChild(_engageButton);
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(counterLabel,background,0,26);
         MobileAlignmentUtil.alignAccordingToPositionOf(counterTextField,background,165,28);
         MobileAlignmentUtil.alignAccordingToPositionOf(_engageButton,background,237,8);
      }
      
      public function updateRemainingDuration(param1:Number) : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:String = LocalizedDateTimeUtil.getUserFriendlyTime(param1);
         if(counterTextField.text != _loc2_ && parent is FlatteningSprite && parent.stage)
         {
            _loc3_ = true;
            (parent as FlatteningSprite).unflatten();
         }
         counterTextField.text = _loc2_;
         if(_loc3_)
         {
            (parent as FlatteningSprite).flatten();
         }
      }
      
      public function get engageButton() : MPButton
      {
         return _engageButton;
      }
   }
}

