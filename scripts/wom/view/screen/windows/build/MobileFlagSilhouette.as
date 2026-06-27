package wom.view.screen.windows.build
{
   import starling.display.DisplayObject;
   import starling.display.Image;
   import starling.display.Sprite;
   import wom.model.game.building.DecorationVariationInfo;
   import wom.model.resource.MobileWomAssetRepository;
   
   public class MobileFlagSilhouette extends Sprite
   {
      
      [Inject]
      public var assetRepository:MobileWomAssetRepository;
      
      private var decorationVariationInfo:DecorationVariationInfo;
      
      public var allianceId:String = null;
      
      public function MobileFlagSilhouette(param1:DecorationVariationInfo)
      {
         super();
         this.decorationVariationInfo = param1;
      }
      
      [PostConstruct]
      public function construct() : void
      {
         var _loc6_:DisplayObject = null;
         var _loc3_:DisplayObject = null;
         var _loc2_:* = 0;
         var _loc5_:* = 0;
         var _loc4_:int = 0;
         var _loc1_:Image = null;
         if(decorationVariationInfo.dio.id == 114)
         {
            _loc6_ = assetRepository.getDisplayObject("FlagFabric" + decorationVariationInfo.kind);
            _loc6_.x = 1;
            _loc6_.y = 15;
            addChild(_loc6_);
            _loc3_ = assetRepository.getDisplayObject("FlagPole");
            addChild(_loc3_);
         }
         else
         {
            if(decorationVariationInfo.dio.id != 115)
            {
               throw Error("Unknown decoration type for flag view");
            }
            _loc2_ = uint(allianceId.substring(0,allianceId.indexOf("x")));
            _loc5_ = uint(allianceId.substring(allianceId.indexOf("x") + 1,allianceId.lastIndexOf("x")));
            _loc4_ = int(allianceId.substring(allianceId.lastIndexOf("x") + 1));
            _loc6_ = new Image(assetRepository.getTexture("FlagEmpty"));
            _loc6_.x = 1;
            _loc6_.y = 15;
            (_loc6_ as Image).color = _loc2_;
            addChild(_loc6_);
            if(_loc4_ != 0)
            {
               _loc1_ = new Image(assetRepository.getTexture("FlagIcon" + _loc4_));
               _loc1_.x = 1;
               _loc1_.y = 15;
               _loc1_.color = _loc5_;
               addChild(_loc1_);
            }
            _loc3_ = assetRepository.getDisplayObject("FlagPole");
            addChild(_loc3_);
         }
      }
   }
}

