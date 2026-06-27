package wom.view.screen.windows.beast.keeper
{
   import peak.component.mobile.MPRigidButton;
   import peak.component.mobile.MPTextField;
   import peak.display.View;
   import peak.i18n.PText;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import starling.events.Event;
   import wom.model.domain.domaininfoobject.BeastTypeDIO;
   import wom.model.game.beast.BeastStatusType;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.MobileCaptionTextField;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   import wom.view.getCaptionTextFormat;
   
   public class MobileBeastKeeperItemView extends Sprite implements View
   {
      
      private static const WIDTH:int = 344;
      
      private static const HEIGHT:int = 502;
      
      private var background:DisplayObject;
      
      private var assetRepository:MobileWomAssetRepository;
      
      private var _beastDIO:BeastTypeDIO;
      
      private var _beastLevel:int;
      
      private var _beastStatusType:BeastStatusType;
      
      private var levelInfoTextField:MobileCaptionTextField;
      
      private var levelShield:DisplayObject;
      
      private var beastAsset:DisplayObject;
      
      private var chainAsset:DisplayObject;
      
      private var _beastNameTextField:MPTextField;
      
      private var _beastLevelTextField:MPTextField;
      
      private var _beastData:Object;
      
      private var lockIcon:DisplayObject;
      
      private var _caveButton:MobileWomButton;
      
      private var _unleashButton:MobileWomButton;
      
      private var _getButton:MobileWomButton;
      
      private var _raiseButton:MobileWomButton;
      
      private var _hintButton:MPRigidButton;
      
      public function MobileBeastKeeperItemView(param1:MobileWomAssetRepository)
      {
         super();
         this.assetRepository = param1;
         init();
      }
      
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         background = assetRepository.getDisplayObject("MobileBeigeBackground");
         background.width = 344;
         background.height = 502;
         background.y = 11;
         addChild(background);
         levelShield = assetRepository.getDisplayObject("IconLevelBeastMBordered");
         addChild(levelShield);
         levelInfoTextField = new MobileCaptionTextField();
         levelInfoTextField.textRendererProperties.textFormat = getCaptionTextFormat(27);
         addChild(levelInfoTextField);
         chainAsset = assetRepository.getDisplayObject("BeastChain");
         addChild(chainAsset);
         _beastNameTextField = new MobileCaptionTextField();
         _beastNameTextField.textRendererProperties.textFormat = getCaptionTextFormat(33,"center");
         _beastNameTextField.width = 344 - 80;
         addChild(_beastNameTextField);
         _beastLevelTextField = new MobileCaptionTextField();
         _beastLevelTextField.textRendererProperties.textFormat = getCaptionTextFormat(30,"center");
         _beastLevelTextField.width = 344 - 80;
         addChild(_beastLevelTextField);
         lockIcon = assetRepository.getDisplayObject("IconLockMBordered");
         lockIcon.visible = false;
         addChild(lockIcon);
         _caveButton = MobileWomUIComponentFactory.createMobileColoredButton("Yellow","Large");
         var _temp_9:* = _caveButton;
         var _loc1_:String = "ui.windows.beast.keeper.cavebutton";
         _temp_9.label = peak.i18n.PText.INSTANCE.getText0(_loc1_);
         _caveButton.width = 196;
         addChild(_caveButton);
         _unleashButton = MobileWomUIComponentFactory.createMobileColoredButton("Blue","Large");
         var _temp_11:* = _unleashButton;
         var _loc2_:String = "ui.windows.beast.keeper.unleashbutton";
         _temp_11.label = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         _unleashButton.width = 246;
         addChild(_unleashButton);
         _getButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_13:* = _getButton;
         var _loc3_:String = "ui.windows.beast.keeper.get";
         _temp_13.label = peak.i18n.PText.INSTANCE.getText0(_loc3_);
         _getButton.width = 170;
         addChild(_getButton);
         _raiseButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         var _temp_15:* = _raiseButton;
         var _loc4_:String = "ui.windows.beast.keeper.raise";
         _temp_15.label = peak.i18n.PText.INSTANCE.getText0(_loc4_);
         _raiseButton.width = 196;
         addChild(_raiseButton);
         _hintButton = new MPRigidButton("ButtonInfo","ButtonInfoHover");
         _hintButton.setPaddings(10,10,10,10);
         _hintButton.addEventListener("triggered",onHintButtonClicked);
         addChild(_hintButton);
         drawLayout();
      }
      
      private function setAllButtonsInvisible() : void
      {
         _caveButton.visible = _unleashButton.visible = _getButton.visible = _raiseButton.visible = false;
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignAccordingToPositionOf(levelShield,background,10,11);
         MobileAlignmentUtil.alignAccordingToPositionOf(levelInfoTextField,levelShield,20,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastNameTextField,background,-10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_beastLevelTextField,background,10);
         MobileAlignmentUtil.alignAccordingToPositionOf(_hintButton,background,295,10);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(chainAsset,background,95);
         MobileAlignmentUtil.alignMiddleOf(lockIcon,background);
      }
      
      public function updateBeastData(param1:Object) : void
      {
         this.data = param1;
         clearBeast();
         beastAsset = assetRepository.getDisplayObject(_beastDIO.assetName + _beastLevel);
         addChildAt(beastAsset,1);
         beastAsset.alpha = 1;
         if(_beastStatusType == BeastStatusType.IN_CAVE)
         {
            _caveButton.visible = true;
            chainAsset.visible = false;
            lockIcon.visible = false;
         }
         else if(_beastStatusType == BeastStatusType.IN_KEEPER)
         {
            _unleashButton.visible = true;
            chainAsset.visible = true;
            lockIcon.visible = false;
         }
         else
         {
            beastAsset.alpha = 0.5;
            if(beastDIO.unlocked)
            {
               _raiseButton.visible = true;
            }
            else
            {
               _getButton.visible = true;
            }
            chainAsset.visible = false;
            lockIcon.visible = true;
         }
         var _temp_2:* = _beastNameTextField;
         var _loc2_:String = "domain.beasts." + _beastDIO.id + ".name";
         _temp_2.text = peak.i18n.PText.INSTANCE.getText0(_loc2_);
         levelInfoTextField.text = _beastLevel.toString();
         var _temp_4:* = _beastLevelTextField;
         var _temp_3:* = "ui.windows.beast.keeper.level";
         var _loc3_:int = _beastLevel;
         var _loc4_:String = _temp_3;
         _temp_4.text = peak.i18n.PText.INSTANCE.getText1(_loc4_,_loc3_);
         MobileAlignmentUtil.alignMiddleOf(beastAsset,background);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_caveButton,background,502 - 65);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_unleashButton,background,502 - 65);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_raiseButton,background,502 - 65);
         MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_getButton,background,502 - 65);
         drawLayout();
      }
      
      private function clearBeast() : void
      {
         setAllButtonsInvisible();
         if(beastAsset)
         {
            if(contains(beastAsset))
            {
               removeChild(beastAsset);
            }
         }
      }
      
      public function get data() : Object
      {
         return _beastData;
      }
      
      public function set data(param1:Object) : void
      {
         if(param1)
         {
            _beastData = param1;
            _beastDIO = param1.beastDIO;
            _beastLevel = param1.beastLevel;
            _beastStatusType = param1.beastStatusType;
         }
      }
      
      private function onHintButtonClicked(param1:Event) : void
      {
         (this.parent as MobileBeastKeeperItemViewRenderer).onHintButtonClicked();
      }
      
      public function get beastStatusType() : BeastStatusType
      {
         return _beastStatusType;
      }
      
      public function get beastDIO() : BeastTypeDIO
      {
         return _beastDIO;
      }
      
      public function get caveButton() : MobileWomButton
      {
         return _caveButton;
      }
      
      public function get unleashButton() : MobileWomButton
      {
         return _unleashButton;
      }
      
      public function get getButton() : MobileWomButton
      {
         return _getButton;
      }
      
      public function get raiseButton() : MobileWomButton
      {
         return _raiseButton;
      }
   }
}

