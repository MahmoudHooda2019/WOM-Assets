package wom.model.component.operations
{
   import flash.display.BitmapData;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import peak.resource.AssetRepository;
   import wom.model.component.attribute.data.MapTileData;
   import wom.model.game.alliance.AllianceSummaryInfo;
   import wom.model.game.alliance.coa.CoatOfArmsInfo;
   import wom.model.resource.WomAssetRepository;
   import wom.view.component.CaptionTextField;
   import wom.view.component.WomTextFormats;
   import wom.view.screen.windows.alliance.coa.TokenView;
   
   public class MapAssetOpearator
   {
      
      private static var mapLevel:Dictionary = new Dictionary();
      
      private static var mapToken:Dictionary = new Dictionary();
      
      public function MapAssetOpearator()
      {
         super();
      }
      
      public static function getMapLevel(param1:MapTileData, param2:AssetRepository) : BitmapData
      {
         var _loc7_:BitmapData = null;
         var _loc4_:CaptionTextField = null;
         var _loc5_:Matrix = null;
         var _loc6_:int = param1.mapMemberInfo.isAttackable() ? 1000 : 0;
         var _loc3_:BitmapData = mapLevel[_loc6_ + param1.mapMemberInfo.level];
         if(!_loc3_)
         {
            _loc3_ = new BitmapData(28,26,true,0);
            _loc7_ = param2.getBitmapAssetReference(param1.mapMemberInfo.isAttackable() ? "Level" : "LowLevel").bitmapAsset.bitmapData;
            if(_loc7_)
            {
               _loc3_.copyPixels(_loc7_,_loc7_.rect,new Point(),null,null,true);
            }
            _loc4_ = new CaptionTextField(param1.mapMemberInfo.isAttackable() ? WomTextFormats.BLUE_FILTER : WomTextFormats.DEFAULT_FILTER);
            _loc4_.width = 28;
            _loc4_.height = 26;
            _loc4_.defaultTextFormat = WomTextFormats.CENTER_16;
            _loc5_ = new Matrix();
            _loc5_.translate(0,5);
            _loc4_.text = param1.mapMemberInfo.level + "";
            _loc3_.draw(_loc4_,_loc5_);
            mapLevel[_loc6_ + param1.mapMemberInfo.level] = _loc3_;
         }
         return _loc3_;
      }
      
      public static function getMapToken(param1:MapTileData, param2:AssetRepository) : BitmapData
      {
         var _loc6_:TokenView = null;
         var _loc3_:AllianceSummaryInfo = param1.mapMemberInfo.alliance;
         var _loc8_:CoatOfArmsInfo = _loc3_ ? _loc3_.coaInfo : null;
         var _loc7_:int = _loc3_ ? _loc8_.patternColorA.id * 1000 : 0;
         var _loc5_:int = int(_loc3_ ? _loc8_.patternColorB.id : 0);
         var _loc4_:BitmapData = mapToken[_loc7_ + _loc5_];
         if(!_loc4_)
         {
            _loc4_ = new BitmapData(15,17,true,0);
            if(_loc3_)
            {
               _loc6_ = new TokenView(param2 as WomAssetRepository);
               _loc6_.updateWithCoatOfArmsInfo(param1.mapMemberInfo.alliance.coaInfo);
               _loc4_.draw(_loc6_);
            }
            mapToken[_loc7_ + _loc5_] = _loc4_;
         }
         return _loc4_;
      }
      
      public static function getMapNameField(param1:MapTileData, param2:String) : BitmapData
      {
         var _loc5_:CaptionTextField = new CaptionTextField(!param1.mapMemberInfo.isEventNpc && param1.mapMemberInfo.profile.isNpc ? WomTextFormats.RED_FILTER : (param1.mapMemberInfo.isAttackable() ? WomTextFormats.BLUE_FILTER : WomTextFormats.DEFAULT_FILTER));
         _loc5_.autoSize = "left";
         _loc5_.wordWrap = true;
         _loc5_.width = 73;
         _loc5_.defaultTextFormat = WomTextFormats.CENTER_14;
         _loc5_.text = param2;
         _loc5_.alpha = param1.mapMemberInfo.isAttackable() ? 1 : 0.5;
         var _loc3_:BitmapData = new BitmapData(73,_loc5_.textHeight + 4,true,0);
         var _loc4_:Matrix = new Matrix();
         _loc4_.translate(0,0);
         _loc3_.draw(_loc5_,_loc4_);
         return _loc3_;
      }
   }
}

