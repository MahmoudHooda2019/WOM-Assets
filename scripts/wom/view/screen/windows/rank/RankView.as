package wom.view.screen.windows.rank
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.text.TextField;
   import peak.display.View;
   import peak.util.AlignmentUtil;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   
   public class RankView extends Sprite implements View
   {
      
      private static const WIDTH:int = 55;
      
      private static const HEIGHT:int = 52;
      
      [Inject]
      public var assetRepository:WomAssetRepository;
      
      private var _rank:int;
      
      private var _rankTextField:TextField;
      
      private var _rankAsset:DisplayObject;
      
      public function RankView(param1:int)
      {
         super();
         _rank = param1;
      }
      
      [PostConstruct]
      public function init() : void
      {
         initLayout();
      }
      
      public function initLayout() : void
      {
         var _loc1_:String = null;
         _rankTextField = new CaptionTextField(WomTextFormats.BLACK_FILTER);
         if(_rank <= 50)
         {
            _rankTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_36;
            if(_rank <= 3)
            {
               _loc1_ = _rank == 1 ? "LeaderBoardBordered" : (_rank == 2 ? "LeaderBoardSilver" : "LeaderBoardBronze");
               _rankAsset = assetRepository.getDisplayObject(_loc1_);
               addChild(_rankAsset);
            }
         }
         else
         {
            _rankTextField.defaultTextFormat = WomTextFormats.FONT_SIZE_24;
         }
         _rankTextField.autoSize = "left";
         addChild(_rankTextField);
         _rankTextField.text = String(_rank);
         drawLayout();
      }
      
      public function drawLayout() : void
      {
         if(_rank <= 3)
         {
            AlignmentUtil.alignMiddleXAxisAndHeightAccordingToPositionOf(_rankTextField,_rankAsset,0);
         }
      }
   }
}

