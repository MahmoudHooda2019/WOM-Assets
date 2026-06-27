package wom.view.ui
{
   import com.greensock.TweenMax;
   import peak.display.View;
   import peak.util.MobileAlignmentUtil;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.view.component.button.MobileWomButton;
   import wom.view.component.factory.MobileWomUIComponentFactory;
   
   public class MobileCanvasOptionsPanel extends Sprite implements View
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _okButton:MobileWomButton;
      
      private var _cancelButton:MobileWomButton;
      
      private var _mandatoryTutorialCompleted:Boolean;
      
      private var _tutorialArrow:DisplayObject;
      
      public function MobileCanvasOptionsPanel(param1:Boolean = true)
      {
         super();
         _mandatoryTutorialCompleted = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
         drawLayout();
      }
      
      public function initLayout() : void
      {
         _okButton = MobileWomUIComponentFactory.createMobileColoredButton("Green","Large");
         _okButton.defaultIcon = assetRepository.getDisplayObject("SymbolOK");
         _okButton.width = 90;
         addChild(_okButton);
         _cancelButton = MobileWomUIComponentFactory.createMobileColoredButton("Red","Large");
         _cancelButton.defaultIcon = assetRepository.getDisplayObject("SymbolClose");
         _cancelButton.width = 90;
         _cancelButton.isEnabled = _mandatoryTutorialCompleted;
         addChild(_cancelButton);
         if(!_mandatoryTutorialCompleted)
         {
            _tutorialArrow = assetRepository.getDisplayObject("TutorialArrowDownM");
            addChild(_tutorialArrow);
            TweenMax.to(_tutorialArrow,0.55,{
               "y":"-25",
               "repeat":-1,
               "yoyo":true,
               "overwrite":1
            });
         }
      }
      
      public function drawLayout() : void
      {
         MobileAlignmentUtil.alignRightOf(_okButton,_cancelButton,25);
         if(_tutorialArrow)
         {
            MobileAlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_tutorialArrow,_okButton,-_tutorialArrow.height);
         }
      }
      
      public function get okButton() : MobileWomButton
      {
         return _okButton;
      }
      
      public function get cancelButton() : MobileWomButton
      {
         return _cancelButton;
      }
   }
}

