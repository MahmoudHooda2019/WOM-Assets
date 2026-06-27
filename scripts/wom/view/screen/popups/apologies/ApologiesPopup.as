package wom.view.screen.popups.apologies
{
   import fl.controls.Button;
   import peak.i18n.PText;
   import peak.resource.asset.display.AssetDisplayObject;
   import peak.util.AlignmentUtil;
   import wom.view.component.button.colored.WomBlueLargeButton;
   import wom.view.ui.common.SpeechBubbleView;
   import wom.view.util.GenericWindow;
   
   public class ApologiesPopup extends GenericWindow
   {
      
      private static const WINDOW_WIDTH:int = 586;
      
      private static const WINDOW_HEIGHT:int = 306;
      
      public static const CANT_MOVE_UNDER_CONSTRUCTION:int = 0;
      
      public static const CANT_UPGRADE_WHILE_UNDER_CONSTRUCTION:int = 2;
      
      public static const CANT_UPGRADE_LIMBO_STATE:int = 3;
      
      public static const CANT_RECYCLE_WHILE_UNDER_CONSTRUCTION:int = 4;
      
      public static const CANT_RECYCLE_TYPE:int = 5;
      
      public static const CANT_MOVE_DAMAGED:int = 6;
      
      public static const CANT_UPGRADE_DAMAGED:int = 7;
      
      public static const CANT_ENTER_DAMAGED:int = 8;
      
      public static const CANT_RECYCLE_MERCENARIES_WILL_BE_HOMELESS:int = 9;
      
      public static const CANT_ATTACK_WITHOUT_ASSEMBLY_AREA:int = 10;
      
      public static const CANT_RECYCLE_BEAST_INSIDE:int = 11;
      
      public static const CANT_QUICK_ATTACK_BEFORE_5:int = 12;
      
      private var type:int;
      
      private var _workerTiredAsset:AssetDisplayObject;
      
      private var speechBubble:SpeechBubbleView;
      
      private var _okButton:Button;
      
      public function ApologiesPopup(param1:int, param2:int = 586, param3:int = 306)
      {
         super(param2,param3);
         this.type = param1;
      }
      
      override protected function initLayout() : void
      {
         super.initLayout();
         var _loc2_:String = "ui.popups.apologies.header";
         setHeader(peak.i18n.PText.INSTANCE.getText0(_loc2_));
         _workerTiredAsset = assetRepository.getDisplayObject("WorkerTired");
         addChild(_workerTiredAsset);
         _okButton = new WomBlueLargeButton();
         _okButton.width = 260;
         var _loc1_:String = "";
         switch(type)
         {
            case 0:
               var _loc3_:String = "ui.popups.apologies.cantmoveunderconstruction";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc3_);
               var _temp_4:* = _okButton;
               var _loc4_:String = "ui.popups.apologies.damnyou";
               _temp_4.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
               break;
            case 2:
               var _loc5_:String = "ui.popups.apologies.cantupgradewhileunderconstruction";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc5_);
               var _temp_5:* = _okButton;
               var _loc6_:String = "ui.popups.apologies.damnyou";
               _temp_5.label = peak.i18n.PText.INSTANCE.getText0(_loc6_);
               break;
            case 3:
               var _loc7_:String = "ui.popups.apologies.cantupgradelimbostate";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc7_);
               var _temp_6:* = _okButton;
               var _loc8_:String = "ui.popups.apologies.getoutofmysight";
               _temp_6.label = peak.i18n.PText.INSTANCE.getText0(_loc8_);
               break;
            case 4:
               var _loc9_:String = "ui.popups.apologies.cantrecyclewhileunderconstruction";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc9_);
               var _temp_7:* = _okButton;
               var _loc10_:String = "ui.popups.apologies.damnyou";
               _temp_7.label = peak.i18n.PText.INSTANCE.getText0(_loc10_);
               break;
            case 5:
               var _loc11_:String = "ui.popups.apologies.cantrecycletype";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc11_);
               var _temp_8:* = _okButton;
               var _loc12_:String = "ui.popups.apologies.getoutofmysight";
               _temp_8.label = peak.i18n.PText.INSTANCE.getText0(_loc12_);
               break;
            case 6:
               var _loc13_:String = "ui.popups.apologies.cantmovedamaged";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc13_);
               var _temp_9:* = _okButton;
               var _loc14_:String = "ui.popups.apologies.damnyou";
               _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc14_);
               break;
            case 7:
               var _loc15_:String = "ui.popups.apologies.cantupgradedamaged";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc15_);
               var _temp_10:* = _okButton;
               var _loc16_:String = "ui.popups.apologies.getoutofmysight";
               _temp_10.label = peak.i18n.PText.INSTANCE.getText0(_loc16_);
               break;
            case 8:
               var _loc17_:String = "ui.popups.apologies.cantenterdamaged";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc17_);
               var _temp_11:* = _okButton;
               var _loc18_:String = "ui.popups.apologies.damnyou";
               _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc18_);
               break;
            case 9:
               var _loc19_:String = "ui.popups.apologies.cantrecyclemercenarieswillbehomeless";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc19_);
               var _temp_12:* = _okButton;
               var _loc20_:String = "ui.popups.apologies.getoutofmysight";
               _temp_12.label = peak.i18n.PText.INSTANCE.getText0(_loc20_);
               break;
            case 10:
               var _loc21_:String = "ui.popups.apologies.cantattackwithoutassemblyarea";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc21_);
               var _temp_13:* = _okButton;
               var _loc22_:String = "ui.popups.apologies.damnyou";
               _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc22_);
               break;
            case 11:
               var _loc23_:String = "ui.popups.apologies.cantrecyclebeastinside";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc23_);
               var _temp_14:* = _okButton;
               var _loc24_:String = "ui.popups.apologies.getoutofmysight";
               _temp_14.label = peak.i18n.PText.INSTANCE.getText0(_loc24_);
               break;
            case 12:
               var _loc25_:String = "ui.popups.apologies.lockedfeature";
               setHeader(peak.i18n.PText.INSTANCE.getText0(_loc25_));
               var _loc26_:String = "ui.popups.apologies.cantquickattackbefore5";
               _loc1_ = peak.i18n.PText.INSTANCE.getText0(_loc26_);
               var _temp_16:* = _okButton;
               var _loc27_:String = "ui.popups.apologies.getoutofmysight";
               _temp_16.label = peak.i18n.PText.INSTANCE.getText0(_loc27_);
         }
         speechBubble = new SpeechBubbleView(_windowWidth - 255,_loc1_);
         addChild(speechBubble);
         addChild(_okButton);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         _workerTiredAsset.x = -92;
         _workerTiredAsset.y = -20;
         AlignmentUtil.alignAccordingToPositionOf(speechBubble,_background,218,0);
         AlignmentUtil.alignMiddleYAxisOf(speechBubble,_background);
         speechBubble.y -= _okButton.height / 8 >> 0;
         _okButton.x = 586 - _okButton.width >> 1;
         _okButton.y = 306 - _okButton.height / 2 << 0;
      }
      
      public function get workerTiredAsset() : AssetDisplayObject
      {
         return _workerTiredAsset;
      }
      
      public function get okButton() : Button
      {
         return _okButton;
      }
   }
}

