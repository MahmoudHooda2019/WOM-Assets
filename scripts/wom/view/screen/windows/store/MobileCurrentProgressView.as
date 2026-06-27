package wom.view.screen.windows.store
{
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import peak.util.NumberUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.getCaptionTextFormat;
   
   public class MobileCurrentProgressView extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var currentLabel:MobileCaptionTextField;
      
      private var icon:DisplayObject;
      
      private var currentText:MobileCaptionTextField;
      
      private var _isGold:Boolean;
      
      public function MobileCurrentProgressView(param1:Boolean)
      {
         super();
         this._isGold = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         currentLabel = new MobileCaptionTextField();
         currentLabel.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(currentLabel);
         var _loc1_:String;
         var _loc2_:String;
         currentLabel.text = isGold ? (_loc1_ = "ui.windows.store.currentbalance2",peak.i18n.PText.INSTANCE.getText0(_loc1_)) : (_loc2_ = "ui.windows.store.currentrp2",peak.i18n.PText.INSTANCE.getText0(_loc2_));
         icon = assetRepository.getDisplayObject(isGold ? "IconGoldM" : "IconRPM");
         addChild(icon);
         currentText = new MobileCaptionTextField();
         currentText.textRendererProperties.textFormat = getCaptionTextFormat(21);
         addChild(currentText);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         currentLabel.x = 0;
         currentLabel.y = 16;
         MobileAlignmentUtil.alignRightWithYMarginOf(icon,currentLabel,-16,7);
         MobileAlignmentUtil.alignRightWithYMarginOf(currentText,icon,16,4);
      }
      
      public function update(param1:Number) : void
      {
         currentText.text = NumberUtil.numberFormat(param1,0,false,false);
      }
      
      public function get isGold() : Boolean
      {
         return _isGold;
      }
   }
}

