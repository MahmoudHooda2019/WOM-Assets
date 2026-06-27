package wom.view.screen.windows.beastcannon
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import peak.i18n.PText;
   import peak.util.AlignmentUtil;
   import peak.util.NumberUtil;
   import wom.model.dto.BeastCannonInfoDTO;
   import wom.model.game.store.StoreUtil;
   import wom.model.game.window.WindowEnumeration;
   import wom.view.component.WomTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.component.button.WomButton;
   import wom.view.component.button.colored.WomGreenMediumButton;
   import wom.view.component.progressbar.MaskedProgressBar;
   import wom.view.component.progressbar.ProgressBar26;
   import wom.view.util.GenericWindow;
   
   public class BeastCannonRechargeWindow extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 452;
      
      private static const WINDOW_HEIGHT:int = 276;
      
      public static const BEAST_CANNON_SILHOUETTE_ID:String = "B45Silhouette";
      
      private var _beastCannonSilhouette:DisplayObject;
      
      private var descriptionTF:TextField;
      
      private var remainingDurationTF:TextField;
      
      private var _rechargeButton:WomButton;
      
      public var progressBar:MaskedProgressBar;
      
      public function BeastCannonRechargeWindow(param1:Vector.<WindowEnumeration> = null)
      {
         super(452,276,param1);
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc1_:String = "ui.windows.beastcannon.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc1_));
         _beastCannonSilhouette = assetRepository.getDisplayObject("B45Silhouette");
         addChild(_beastCannonSilhouette);
         descriptionTF = new WomTextField();
         descriptionTF.multiline = true;
         descriptionTF.wordWrap = true;
         descriptionTF.autoSize = "left";
         descriptionTF.width = 320;
         descriptionTF.defaultTextFormat = WomTextFormats.CENTER_18;
         var _temp_4:* = descriptionTF;
         var _loc2_:String = "ui.windows.beastcannon.description";
         _temp_4.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         addChild(descriptionTF);
         remainingDurationTF = new WomTextField();
         remainingDurationTF.defaultTextFormat = WomTextFormats.CENTER_24;
         remainingDurationTF.width = 80;
         remainingDurationTF.height = 20;
         addChild(remainingDurationTF);
         _rechargeButton = new WomGreenMediumButton();
         var _temp_7:* = _rechargeButton;
         var _loc3_:String = "ui.windows.beastcannon.recharge";
         _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _rechargeButton.setStyle("icon",assetRepository.getDisplayObject("Gold27"));
         _rechargeButton.width = 155;
         addChild(_rechargeButton);
         progressBar = new ProgressBar26();
         progressBar.align = "center";
         progressBar.width = 240;
         addChild(progressBar);
         drawLayout();
      }
      
      override protected function drawBackground() : void
      {
         super.drawBackground();
      }
      
      public function drawLayout() : void
      {
         _beastCannonSilhouette.x = 90 - _beastCannonSilhouette.width;
         _beastCannonSilhouette.y = 43;
         AlignmentUtil.alignAccordingToPositionOf(descriptionTF,_background,100,30);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(progressBar,descriptionTF,descriptionTF.height + 15);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(remainingDurationTF,progressBar,progressBar.height + 40);
         AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rechargeButton,progressBar,80);
      }
      
      public function get beastCannonSilhouette() : DisplayObject
      {
         return _beastCannonSilhouette;
      }
      
      public function updateWithData(param1:BeastCannonInfoDTO, param2:int) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         if(param1.remainingTimeToRecharge <= 0)
         {
            var _temp_1:* = remainingDurationTF;
            var _loc6_:String = "ui.windows.beastcannon.ready";
            _temp_1.text = peak.i18n.PText.INSTANCE.getText0(_loc6_);
            _rechargeButton.visible = false;
         }
         else
         {
            _loc4_ = param1.remainingTimeToRecharge / 1000;
            _loc3_ = _loc4_ / 60;
            _loc5_ = _loc3_ / 60;
            _loc4_ %= 60;
            _loc3_ %= 60;
            _loc5_ %= 24;
            remainingDurationTF.text = (_loc5_ < 10 ? "0" : "") + _loc5_ + ":" + ((_loc3_ < 10 ? "0" : "") + _loc3_ + ":") + ((_loc4_ < 10 ? "0" : "") + _loc4_);
            _rechargeButton.visible = true;
            _rechargeButton.rightLabel = goldCost(param2 - param1.ammoAmount).toString();
         }
         progressBar.setProgress(param1.ammoAmount,param2);
         progressBar.progressText = NumberUtil.format(param1.ammoAmount);
         drawLayout();
      }
      
      public function goldCost(param1:int) : int
      {
         return StoreUtil.beastCannonPrice(param1);
      }
      
      public function get rechargeButton() : WomButton
      {
         return _rechargeButton;
      }
   }
}

