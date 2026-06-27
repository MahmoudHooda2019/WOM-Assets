package wom.view.ui.tutorial.mobile
{
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   import wom.model.resource.MobileWomAssetRepository;
   import wom.model.resource.asset.TutorialGirlAssetType;
   
   public class MobileTutorialGirlView extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var _bg:DisplayObject;
      
      private var _tutorialGirl:DisplayObject;
      
      private var _assetType:TutorialGirlAssetType;
      
      private var _flipped:Boolean;
      
      public function MobileTutorialGirlView(param1:TutorialGirlAssetType, param2:Boolean = false)
      {
         super();
         _assetType = param1;
         _flipped = param2;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      private function initLayout() : void
      {
         _bg = assetRepository.getDisplayObject("TutorialBackgroundM");
         addChild(_bg);
         _tutorialGirl = assetRepository.getDisplayObject("TutorialPose" + _assetType.id + "M");
         addChild(_tutorialGirl);
         if(_flipped)
         {
            _tutorialGirl.scaleX = -1;
         }
         switch(_assetType)
         {
            case TutorialGirlAssetType.POSE1:
               _tutorialGirl.x = _flipped ? 1 + _tutorialGirl.width : 60;
               _tutorialGirl.y = -18;
               break;
            case TutorialGirlAssetType.POSE2:
               _tutorialGirl.x = _flipped ? _tutorialGirl.width : 242;
               _tutorialGirl.y = -18;
               break;
            case TutorialGirlAssetType.POSE3:
               _tutorialGirl.x = _flipped ? 2 + _tutorialGirl.width : 223;
               _tutorialGirl.y = -18;
         }
      }
      
      public function get bg() : DisplayObject
      {
         return _bg;
      }
      
      public function get tutorialGirl() : DisplayObject
      {
         return _tutorialGirl;
      }
   }
}

